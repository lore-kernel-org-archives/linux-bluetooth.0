Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] android/tester: Add missing AVRCP cb_table entries
Date: Mon,  8 Dec 2014 11:35:04 +0100
Message-Id: <1418034908-1742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

cb_table should be filled simultaneously with expected bt_callbacks
enum. Without this, debug logs can cause errors.
---
 android/tester-main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index 33ef3ce..8f3bc3c 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -68,6 +68,14 @@ static struct {
 	DBG_CB(CB_A2DP_CONN_STATE),
 	DBG_CB(CB_A2DP_AUDIO_STATE),
 
+	/* AVRCP */
+	DBG_CB(CB_AVRCP_PLAY_STATUS_REQ),
+	DBG_CB(CB_AVRCP_PLAY_STATUS_RSP),
+	DBG_CB(CB_AVRCP_REG_NOTIF_REQ),
+	DBG_CB(CB_AVRCP_REG_NOTIF_RSP),
+	DBG_CB(CB_AVRCP_GET_ATTR_REQ),
+	DBG_CB(CB_AVRCP_GET_ATTR_RSP),
+
 	/* Gatt client */
 	DBG_CB(CB_GATTC_REGISTER_CLIENT),
 	DBG_CB(CB_GATTC_SCAN_RESULT),
-- 
1.9.3

