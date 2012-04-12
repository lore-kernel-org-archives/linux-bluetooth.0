Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 15/19] audio: Fix newline before EOF
Date: Thu, 12 Apr 2012 20:33:06 +0530
Message-id: <1334243001-17016-16-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gsta2dpsink.c  |    1 -
 audio/gsta2dpsink.h  |    1 -
 audio/gstrtpsbcpay.c |    1 -
 audio/gstsbcdec.c    |    2 --
 audio/gstsbcenc.c    |    2 --
 audio/gstsbcparse.c  |    1 -
 audio/gstsbcutil.c   |    1 -
 audio/gstsbcutil.h   |    1 -
 8 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/audio/gsta2dpsink.c b/audio/gsta2dpsink.c
index 930d14e..c8f6346 100644
--- a/audio/gsta2dpsink.c
+++ b/audio/gsta2dpsink.c
@@ -727,4 +727,3 @@ gboolean gst_a2dp_sink_plugin_init(GstPlugin *plugin)
 	return gst_element_register(plugin, "a2dpsink",
 			GST_RANK_MARGINAL, GST_TYPE_A2DP_SINK);
 }
-
diff --git a/audio/gsta2dpsink.h b/audio/gsta2dpsink.h
index 5f96a3e..1a591b2 100644
--- a/audio/gsta2dpsink.h
+++ b/audio/gsta2dpsink.h
@@ -82,4 +82,3 @@ GstCaps *gst_a2dp_sink_get_device_caps(GstA2dpSink *self);
 G_END_DECLS
 
 #endif
-
diff --git a/audio/gstrtpsbcpay.c b/audio/gstrtpsbcpay.c
index 1159bfe..11aa733 100644
--- a/audio/gstrtpsbcpay.c
+++ b/audio/gstrtpsbcpay.c
@@ -349,4 +349,3 @@ gboolean gst_rtp_sbc_pay_plugin_init(GstPlugin *plugin)
 	return gst_element_register(plugin, "rtpsbcpay", GST_RANK_NONE,
 							GST_TYPE_RTP_SBC_PAY);
 }
-
diff --git a/audio/gstsbcdec.c b/audio/gstsbcdec.c
index 2e5cb0a..c52834e 100644
--- a/audio/gstsbcdec.c
+++ b/audio/gstsbcdec.c
@@ -219,5 +219,3 @@ gboolean gst_sbc_dec_plugin_init(GstPlugin *plugin)
 	return gst_element_register(plugin, "sbcdec", GST_RANK_PRIMARY,
 							GST_TYPE_SBC_DEC);
 }
-
-
diff --git a/audio/gstsbcenc.c b/audio/gstsbcenc.c
index d2de4ee..8948371 100644
--- a/audio/gstsbcenc.c
+++ b/audio/gstsbcenc.c
@@ -599,5 +599,3 @@ gboolean gst_sbc_enc_plugin_init(GstPlugin *plugin)
 	return gst_element_register(plugin, "sbcenc",
 			GST_RANK_NONE, GST_TYPE_SBC_ENC);
 }
-
-
diff --git a/audio/gstsbcparse.c b/audio/gstsbcparse.c
index a44b52c..bc4c0c7 100644
--- a/audio/gstsbcparse.c
+++ b/audio/gstsbcparse.c
@@ -217,4 +217,3 @@ gboolean gst_sbc_parse_plugin_init(GstPlugin *plugin)
 	return gst_element_register(plugin, "sbcparse", GST_RANK_NONE,
 							GST_TYPE_SBC_PARSE);
 }
-
diff --git a/audio/gstsbcutil.c b/audio/gstsbcutil.c
index ac5fcbf..f596b41 100644
--- a/audio/gstsbcutil.c
+++ b/audio/gstsbcutil.c
@@ -518,4 +518,3 @@ gboolean gst_sbc_util_fill_sbc_params(sbc_t *sbc, GstCaps *caps)
 
 	return TRUE;
 }
-
diff --git a/audio/gstsbcutil.h b/audio/gstsbcutil.h
index a7f84d5..5e47119 100644
--- a/audio/gstsbcutil.h
+++ b/audio/gstsbcutil.h
@@ -72,4 +72,3 @@ void gst_sbc_util_set_structure_string_param(GstStructure *structure,
 			GValue *value);
 
 gboolean gst_sbc_util_fill_sbc_params(sbc_t *sbc, GstCaps *caps);
-
-- 
1.7.4.1

