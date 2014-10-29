Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android/handsfree: Be more strict on SLC creation
Date: Thu, 30 Oct 2014 00:07:33 +0100
Message-Id: <1414624053-24250-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1414624053-24250-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1414624053-24250-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of any issue during SLC creation lets just drop the link
---
 android/handsfree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index 595919a..c8d3c04 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1251,6 +1251,9 @@ static void at_cmd_cind(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	}
 
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
+
+	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
+		hfp_gw_disconnect(dev->gw);
 }
 
 static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
@@ -1280,6 +1283,9 @@ static void at_cmd_brsf(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	}
 
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
+
+	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
+		hfp_gw_disconnect(dev->gw);
 }
 
 static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
@@ -1319,6 +1325,9 @@ static void at_cmd_chld(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	}
 
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
+
+	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
+		hfp_gw_disconnect(dev->gw);
 }
 
 static struct hfp_codec *find_codec_by_type(struct hf_device *dev, uint8_t type)
@@ -1392,6 +1401,9 @@ static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 
 failed:
 	hfp_gw_send_result(dev->gw, HFP_RESULT_ERROR);
+
+	if (dev->state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED)
+		hfp_gw_disconnect(dev->gw);
 }
 
 static void register_slc_at(struct hf_device *dev)
-- 
1.8.4

