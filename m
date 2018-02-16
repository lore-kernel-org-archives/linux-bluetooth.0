Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH 2/2] mesh: node: Correct minor errors
Date: Fri, 16 Feb 2018 07:20:01 -0500
Message-Id: <20180216122001.6923-2-sbrown@cortland.com>
In-Reply-To: <20180216122001.6923-1-sbrown@cortland.com>
References: <20180216122001.6923-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Correct length computation in node_parse_composition()
Correct return value in node_set_model()
  An existing node is not an error
---
 mesh/node.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index fc8898c49..9ff741962 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -417,7 +417,7 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data, uint16_t len)
 
 		m = *data++;
 		v = *data++;
-		len -= 4;
+		len -= 2;
 
 		while (len >= 2 && m--) {
 			mod_id = get_le16(data);
@@ -691,7 +691,7 @@ bool node_set_model(struct mesh_node *node, uint8_t ele_idx, uint32_t id)
 	l = g_list_find_custom(ele->models, GUINT_TO_POINTER(id),
 				match_model_id);
 	if (l)
-		return false;
+		return true;
 
 	model = g_malloc0(sizeof(struct mesh_model));
 	if (!model)
-- 
2.14.1

