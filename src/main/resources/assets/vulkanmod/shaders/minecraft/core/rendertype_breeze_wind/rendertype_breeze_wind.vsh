#version 450


layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;
layout(location = 2) in vec2 UV0;
layout(location = 3) in ivec2 UV1;
layout(location = 4) in ivec2 UV2;
//layout(location = 5) in vec3 Normal;



//Reduce Vertex Attribute Fetch Overhead (VAF) (By removing unused vertex attributes)


layout(binding = 3) uniform sampler2D Sampler2;

layout(binding = 0) uniform UniformBufferObject {
    mat4 MVP;
    mat4 ModelViewMat;
    mat4 TextureMat;
};


layout(location = 0) out float vertexDistance;
layout(location = 1) out vec4 vertexColor;
layout(location = 2) out vec4 lightMapColor;
layout(location = 3) out vec2 texCoord0;

void main() {
    gl_Position = MVP * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = length((ModelViewMat * vec4(Position, 1.0)).xyz);
    lightMapColor = texelFetch(Sampler2, UV2 / 16, 0);
    vertexColor = Color * lightMapColor;

    texCoord0 = (TextureMat * vec4(UV0, 0.0, 1.0)).xy;
}
