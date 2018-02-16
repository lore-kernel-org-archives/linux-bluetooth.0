Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH 1/2] mesh: prov-db: Correct json database parsing
Date: Fri, 16 Feb 2018 07:20:00 -0500
Message-Id: <20180216122001.6923-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

    "composition": {
        "cid": "0002",
        "pid": "0010",
        "vid": "0001",
        "crpl": "000a",
        "features": {
            "relay": false,
            "proxy": true,
            "friend": false,
            "lowPower": false
        },
        "elements": [
            {
                "elementIndex": 0,
                "location": "0001",
                "models": ["0000", "0001", "1001"]
            }
        ]
    },
---
 mesh/prov-db.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mesh/prov-db.c b/mesh/prov-db.c
index 012705134..019b4e173 100644
--- a/mesh/prov-db.c
+++ b/mesh/prov-db.c
@@ -687,7 +687,7 @@ bool prov_db_add_node_composition(struct mesh_node *node, uint8_t *data,
 
 	put_uint16(jcomp, "cid", comp->cid);
 	put_uint16(jcomp, "pid", comp->pid);
-	put_uint16(jcomp, "vid", comp->pid);
+	put_uint16(jcomp, "vid", comp->vid);
 	put_uint16(jcomp, "crpl", comp->crpl);
 
 	jfeatures = json_object_new_object();
@@ -1286,6 +1286,7 @@ static bool parse_node_composition(struct mesh_node *node, json_object *jcomp)
 {
 	json_object *jvalue;
 	json_object *jelements;
+	json_object *jfeatures;
 	json_bool enable;
 	char *str;
 	struct mesh_node_composition comp;
@@ -1305,7 +1306,7 @@ static bool parse_node_composition(struct mesh_node *node, json_object *jcomp)
 
 	str = (char *)json_object_get_string(jvalue);
 
-	if (sscanf(str, "%04hx", &comp.vid) != 1)
+	if (sscanf(str, "%04hx", &comp.pid) != 1)
 		return false;
 
 	json_object_object_get_ex(jcomp, "vid", &jvalue);
@@ -1327,19 +1328,24 @@ static bool parse_node_composition(struct mesh_node *node, json_object *jcomp)
 		return false;
 
 	/* Extract features */
-	json_object_object_get_ex(jcomp, "relay", &jvalue);
+
+	json_object_object_get_ex(jcomp, "features", &jfeatures);
+	if (!jfeatures)
+		return false;
+
+	json_object_object_get_ex(jfeatures, "relay", &jvalue);
 	enable = json_object_get_boolean(jvalue);
 	comp.relay = (enable) ? true : false;
 
-	json_object_object_get_ex(jcomp, "proxy", &jvalue);
+	json_object_object_get_ex(jfeatures, "proxy", &jvalue);
 	enable = json_object_get_boolean(jvalue);
 	comp.proxy = (enable) ? true : false;
 
-	json_object_object_get_ex(jcomp, "friend", &jvalue);
+	json_object_object_get_ex(jfeatures, "friend", &jvalue);
 	enable = json_object_get_boolean(jvalue);
 	comp.friend = (enable) ? true : false;
 
-	json_object_object_get_ex(jcomp, "lowPower", &jvalue);
+	json_object_object_get_ex(jfeatures, "lowPower", &jvalue);
 	enable = json_object_get_boolean(jvalue);
 	comp.lpn = (enable) ? true : false;
 
-- 
2.14.1

