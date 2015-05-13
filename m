Return-Path: <cyrus@holtmann.org>
From: "nagaraj.dr" <nagaraj.dr@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: "nagaraj.dr" <nagaraj.dr@samsung.com>
Subject: [PATCH 1/1] shared/gatt-client: Fix the "Find Information req" error
Date: Wed, 13 May 2015 17:05:23 +0530
Message-id: <1431516923-9855-1-git-send-email-nagaraj.dr@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "nagaraj.dr" <nagaraj.dr@samsung.com>

characteristic descriptor is searched b/w the
characteristic "value_handle + 1" and
characteristic "end_handle" using "Find Information req"

if remote device had declared the characteristic value_handle
at 0XFFFF (which also means there is no characteristic descriptors),then
present code would make start_handle has 0X0000(because of 16 bit
integer overflow) for "Find Information req"

desc_start = chrc_data->value_handle + 1;

 Consequence:  Below request will be sent,
        ATT: Find Information req (0x04)
        start 0x0000, end 0xffff

        and below will be the proper response from the remote device
        ATT: Error (0x01)
        Error: Invalid handle (1)
        Find Information req (0x04) on handle 0x0000
---
 src/shared/gatt-client.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 7bc3b71..9b944ee 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -601,13 +601,13 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 							chrc_data->value_handle)
 			goto failed;
 
-		desc_start = chrc_data->value_handle + 1;
-
-		if (desc_start > chrc_data->end_handle) {
+		if (chrc_data->value_handle >= chrc_data->end_handle) {
 			free(chrc_data);
 			continue;
 		}
 
+		desc_start = chrc_data->value_handle + 1;
+
 		client->discovery_req = bt_gatt_discover_descriptors(
 							client->att, desc_start,
 							chrc_data->end_handle,
-- 
1.7.9.5

