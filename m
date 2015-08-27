Return-Path: <cyrus@holtmann.org>
From: Will Wang <wiwang@mozilla.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Will Wang <wiwang@mozilla.com>
Subject: [PATCH 3/3] android/handsfree: Fix missing HFP WBS callback
Date: Thu, 27 Aug 2015 20:02:02 +0800
Message-Id: <1440676922-29249-4-git-send-email-wiwang@mozilla.com>
In-Reply-To: <1440676922-29249-1-git-send-email-wiwang@mozilla.com>
References: <1440676922-29249-1-git-send-email-wiwang@mozilla.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index f297926..919728e 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1067,6 +1067,7 @@ static void at_cmd_bcs(struct hfp_context *result, enum hfp_gw_cmd_type type,
 								void *user_data)
 {
 	struct hf_device *dev = user_data;
+	struct hal_ev_handsfree_wbs ev;
 	unsigned int val;
 
 	DBG("");
@@ -1085,6 +1086,13 @@ static void at_cmd_bcs(struct hfp_context *result, enum hfp_gw_cmd_type type,
 			break;
 		}
 
+		ev.wbs = val;
+		bdaddr2android(&dev->bdaddr, ev.bdaddr);
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+					HAL_EV_HANDSFREE_WBS, sizeof(ev), &ev);
+
+
 		dev->proposed_codec = 0;
 		dev->negotiated_codec = val;
 
-- 
1.9.1
