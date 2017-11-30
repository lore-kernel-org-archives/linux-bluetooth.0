Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Michal Hobot <michal.hobot@silvair.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: [PATCH BlueZ] Fix parsing composition data for custom models
Message-Id: <616ECE7C-5CD6-43DB-8B11-5F6A786DA61E@silvair.com>
Date: Thu, 30 Nov 2017 21:47:53 +0100
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Custom model ids consist of model id and vendor id. Instead, vendor id =
was used twice to build model id.
---
 mesh/node.c    | 2 +-
 mesh/prov-db.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 3c206dc36..b906754ae 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -432,7 +432,7 @@ bool node_parse_composition(struct mesh_node *node, =
uint8_t *data, uint16_t len)
 			len -=3D 2;
 		}
 		while (len >=3D 4 && v--) {
-			mod_id =3D get_le16(data);
+			mod_id =3D get_le16(data + 2);
 			vendor_id =3D get_le16(data);
 			mod_id |=3D (vendor_id << 16);
 			if (!node_set_model(node, ele->index, mod_id))
diff --git a/mesh/prov-db.c b/mesh/prov-db.c
index a012ef865..9add3f7c3 100644
--- a/mesh/prov-db.c
+++ b/mesh/prov-db.c
@@ -676,7 +676,7 @@ bool prov_db_add_node_composition(struct mesh_node =
*node, uint8_t *data,
 		}
=20
 		while (len >=3D 4 && v--) {
-			mod_id =3D get_le16(data);
+			mod_id =3D get_le16(data + 2);
 			vendor_id =3D get_le16(data);
 			mod_id |=3D (vendor_id << 16);
 			data +=3D 4;
--=20
2.13.6 (Apple Git-96)


