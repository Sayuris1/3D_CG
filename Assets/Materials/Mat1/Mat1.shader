Shader "Unlit/Mat1"
{
    // Are those uniforms ??
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            // Comes from mesh buffer
            // How to input from other buffers ??
            struct uniforms{
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            // varying
            // vert 2 frag, who tha fuck named this.
            // miss glsl already
            struct v2f {
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
                UNITY_FOG_COORDS(1)
                // Yeah this is just proj
                float4 vertex : SV_POSITION;
            };

            // Are those uniforms
            // WHERE THA FUCK ARE UNIFORMS
            uniform sampler2D _MainTex;

            // Then what is not uniform
            float4 _MainTex_ST;

            v2f vert (uniforms v) {
                v2f o;
                // Matrix multiply prob
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = v.normal;
                // Is this interpolation ?
                // prob not. WHAT IS TRANSFORM_TEX
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            // So no frag uniforms ??
            fixed4 frag (v2f i) : SV_Target {
                // sample the texture
                //fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                //UNITY_APPLY_FOG(i.fogCoord, col);
                // alpha not used
                // How to change the blend func
                return float4(i.normal.xyz, 0);
            }
            ENDCG
        }
    }
}
