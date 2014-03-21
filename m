Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/handsfree: Start codec selection if HF send AT+BAC while codec connection
Date: Fri, 21 Mar 2014 15:30:20 +0100
Message-Id: <1395412220-15852-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If AG receives AT+BAC in response to +BCS, refresh list of codecs
and start new codec connection. It is required in TC_AG_ACC_BV_11_I
PTS test case.
---
 android/handsfree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index c8e5f8a..95bc222 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1292,6 +1292,9 @@ static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 		hfp_gw_send_result(device.gw, HFP_RESULT_OK);
 
+		if (device.proposed_codec)
+			select_codec(0);
+
 		return;
 	case HFP_GW_CMD_TYPE_TEST:
 	case HFP_GW_CMD_TYPE_READ:
-- 
1.8.3.1

