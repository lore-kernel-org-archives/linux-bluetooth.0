Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Check if ATT is connected before creating requests
Date: Tue, 21 Nov 2017 12:53:21 +0200
Message-Id: <20171121105322.30008-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If ATT is not connected there is no point in creating a request since
that will likely fail at bt_att_send.
---
 src/shared/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index a34b00188..4b3f553f1 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -141,6 +141,9 @@ static struct request *request_create(struct bt_gatt_client *client)
 {
 	struct request *req;
 
+	if (!client->att)
+		return NULL;
+
 	req = new0(struct request, 1);
 
 	if (client->next_request_id < 1)
-- 
2.13.6

