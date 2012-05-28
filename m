Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH] attrib-server: allow SDP records for secondary GATT services
Date: Mon, 28 May 2012 23:45:48 +0300
Message-Id: <1338237948-6141-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It seems this is the correct way to discover such services that work
over BR/EDR (according to section 4.4 in the GATT specification).
---
 src/attrib-server.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index dd1bba4..6636192 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -257,8 +257,8 @@ static int attribute_cmp(gconstpointer a1, gconstpointer a2)
 	return attrib1->handle - attrib2->handle;
 }
 
-static struct attribute *find_primary_range(struct gatt_server *server,
-						uint16_t start, uint16_t *end)
+static struct attribute *find_svc_range(struct gatt_server *server,
+					uint16_t start, uint16_t *end)
 {
 	struct attribute *attrib;
 	guint h = start;
@@ -274,7 +274,8 @@ static struct attribute *find_primary_range(struct gatt_server *server,
 
 	attrib = l->data;
 
-	if (bt_uuid_cmp(&attrib->uuid, &prim_uuid) != 0)
+	if (bt_uuid_cmp(&attrib->uuid, &prim_uuid) != 0 &&
+			bt_uuid_cmp(&attrib->uuid, &snd_uuid) != 0)
 		return NULL;
 
 	*end = start;
@@ -301,7 +302,7 @@ static uint32_t attrib_create_sdp_new(struct gatt_server *server,
 	uuid_t svc, gap_uuid;
 	bdaddr_t addr;
 
-	a = find_primary_range(server, handle, &end);
+	a = find_svc_range(server, handle, &end);
 
 	if (a == NULL)
 		return 0;
-- 
1.7.9.5

