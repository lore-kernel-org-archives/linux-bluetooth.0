Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Register the a2dp gst sink as marginal
Date: Wed,  1 Jul 2009 13:15:57 +0200
Message-Id: <1246446957-15477-2-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246446957-15477-1-git-send-email-filippo@esaurito.net>
References: <1246446957-15477-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Avoid taking over as default gst sink by registering as GST_RANK_MARGINAL
---
 audio/gsta2dpsink.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/gsta2dpsink.c b/audio/gsta2dpsink.c
index b6df119..0753f38 100644
--- a/audio/gsta2dpsink.c
+++ b/audio/gsta2dpsink.c
@@ -698,6 +698,6 @@ static void gst_a2dp_sink_init(GstA2dpSink *self,
 gboolean gst_a2dp_sink_plugin_init(GstPlugin *plugin)
 {
 	return gst_element_register(plugin, "a2dpsink",
-			GST_RANK_PRIMARY, GST_TYPE_A2DP_SINK);
+			GST_RANK_MARGINAL, GST_TYPE_A2DP_SINK);
 }
 
-- 
1.6.3.3

