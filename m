Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@gmail.com, Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH 1/3] dis: Fix attribute handle when initializing from db
Date: Fri, 24 Feb 2017 16:13:24 -0800
Message-Id: <1487981606-14150-2-git-send-email-juha.kuikka@synapse.com>
In-Reply-To: <1487981606-14150-1-git-send-email-juha.kuikka@synapse.com>
References: <1487981606-14150-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The handle field in struct bt_dis is initialized to the handle of the DIS gatt
service. It should be the value handle of the PNP ID characteristic.

This patch fixes the issue.
---
 profiles/deviceinfo/dis.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/profiles/deviceinfo/dis.c b/profiles/deviceinfo/dis.c
index 91ce26b..6126a77 100644
--- a/profiles/deviceinfo/dis.c
+++ b/profiles/deviceinfo/dis.c
@@ -90,6 +90,25 @@ static void dis_free(struct bt_dis *dis)
 	g_free(dis);
 }
 
+static void foreach_dis_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_dis *dis = user_data;
+	bt_uuid_t pnpid_uuid, uuid;
+	uint16_t value_handle;
+
+	/* Ignore if there are multiple instances */
+	if (dis->handle)
+		return;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle, NULL, NULL, &uuid))
+		return;
+
+	/* Find PNPID characteristic's value handle */
+	bt_string_to_uuid(&pnpid_uuid, PNPID_UUID);
+	if (bt_uuid_cmp(&pnpid_uuid, &uuid) == 0)
+		dis->handle = value_handle;
+}
+
 static void foreach_dis_service(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct bt_dis *dis = user_data;
@@ -98,7 +117,7 @@ static void foreach_dis_service(struct gatt_db_attribute *attr, void *user_data)
 	if (dis->handle)
 		return;
 
-	dis->handle = gatt_db_attribute_get_handle(attr);
+	gatt_db_service_foreach_char(attr, foreach_dis_char, dis);
 }
 
 struct bt_dis *bt_dis_new(struct gatt_db *db)
-- 
2.7.4

