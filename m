Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 14/14] shared/gatt: Fix searching descriptors
Date: Thu, 23 Oct 2014 12:15:37 +0200
Message-Id: <1414059337-12040-15-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Descriptor discovery range started from characteristic value handle + 1
and end with characteristic end handle. If characteristic value handle
is 0xffff, then discovery range was set to 0x0000-0xffff.
Found during PTS test case TC_GAD_CL_BV_03_C.
---
 src/shared/gatt-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 1c50d82..f884365 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -706,8 +706,8 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 	for (i = 0; i < chrc_count; i++) {
 		op->cur_chrc_index = i;
 		op->cur_chrc = chrcs + i;
-		desc_start = chrcs[i].chrc_external.value_handle + 1;
-		if (desc_start > chrcs[i].chrc_external.end_handle)
+		desc_start = chrcs[i].chrc_external.value_handle;
+		if (desc_start++ == chrcs[i].chrc_external.end_handle)
 			continue;
 
 		if (bt_gatt_discover_descriptors(client->att, desc_start,
-- 
1.9.3

