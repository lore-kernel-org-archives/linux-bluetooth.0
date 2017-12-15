Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1513343774.18172.44.camel@ewol.com>
Subject: [RFC] mesh: meshctl: Fix duplicate modelId's in json database
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 15 Dec 2017 06:16:14 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In parse_configuration_models(), it's not an issue whether the calls
succeed or fail. If the entries appear in the model object they are
processed, if not they aren't.

---

The calling sequence is

prov_db_node_set_model_pub()
  get_jmodel_obj()
    parse_configuration_models()
    
There seems to be a problem in parse_configuration_models(). In the
loop looking for the model that matches the target_id, if the first
model matches, the model object is returned and the function exits.

If the loop has to iterate, it next calls parse_bindings(). That
function checks if the binding already exists and because it
does, exits false with jmodel set to null.

The consequence is the addition of a second modelId object with the
same model id.

It's not clear why the function exits when it finds the model with the
matching model id and before calling parse_bindings(), etc. I'd think
that the test should go after those calls.

I'm still not sure I completely understand how all this works. It would
also seem that the parse_xxx() functions get called for models up to
the one that matches, but not after.

diff --git a/mesh/prov-db.c b/mesh/prov-db.c
index 04803a5c8..cc3bc8224 100644
--- a/mesh/prov-db.c
+++ b/mesh/prov-db.c
@@ -411,13 +411,10 @@ static bool parse_configuration_models(struct mesh_node *node, int ele_idx,
 		}
 
 		json_object_object_get_ex(jmodel, "bind", &jarray);
-		if (jarray && !parse_bindings(node, ele_idx, model_id, jarray))
-			return false;
+		parse_bindings(node, ele_idx, model_id, jarray);
 
 		json_object_object_get_ex(jmodel, "publish", &jvalue);
-
-		if (jvalue && !parse_model_pub(node, ele_idx, model_id, jvalue))
-			return false;
+		parse_model_pub(node, ele_idx, model_id, jvalue);
 	}
 
 	return true;

