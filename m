Return-Path: <cyrus@holtmann.org>
From: Nagaraj D R <nagaraj.dr@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nagaraj D R <nagaraj.dr@samsung.com>
Subject: [PATCH v2 1/1] shared/gatt-client: Fix the "Find Information req" error
Date: Fri, 12 Jun 2015 12:09:39 +0530
Message-id: <1434091179-7578-1-git-send-email-nagaraj.dr@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In a particular case where remote device has the characteristic
declaration b/w 0XFFFE and 0XFFFF. i.e characteristic handle at
0XFFFE and value_handle at 0XFFFF, which implies there is no
characteristic descriptors associated.

Since present design search the descriptors b/w the characteristic_value
declaration and characteristic end handle, In the above stated case,
descriptor search handle will be initialized to 0X0000 (i.e by
incrementing characteristic value handle (0xffff) ). 0X0000 handle
is reserved handle, and also intention of searching descriptors will
not be achieved.

 Consequence:  Below request will be sent,
        ATT: Find Information req (0x04)
        start 0x0000, end 0xffff

        and below will be the proper response from the remote device
        ATT: Error (0x01)
        Error: Invalid handle (1)
        Find Information req (0x04) on handle 0x0000
---
 v1 -> Initial version.
 v2 -> incorporated Luiz comment about inline comment & commit msg changes.

 src/shared/gatt-client.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 7e9d550..0bd306c 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -601,12 +601,16 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 							chrc_data->value_handle)
 			goto failed;
 
-		desc_start = chrc_data->value_handle + 1;
-
-		if (desc_start > chrc_data->end_handle) {
+		/*
+		 * check for descriptors presence, before initializing the
+		 * desc_handle and avoid integer overflow during desc_handle
+		 * intialization.
+		 */
+		if (chrc_data->value_handle >= chrc_data->end_handle) {
 			free(chrc_data);
 			continue;
 		}
+		desc_start = chrc_data->value_handle + 1;
 
 		client->discovery_req = bt_gatt_discover_descriptors(
 							client->att, desc_start,
-- 
1.7.9.5

