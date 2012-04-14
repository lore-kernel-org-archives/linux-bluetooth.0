Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Cc: hocheol.seo@samsung.com
Subject: [PATCH 1/1] Add sbc cap null case while GST AVDTP Signaling.
Date: Sat, 14 Apr 2012 15:05:56 +0900
Message-id: <1334383556-18480-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

Due to RF condition or headset malfunctioning, gst audio plug-in
could not get sbc(mandatory codec) information.
---
 audio/gstavdtpsink.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index b448d57..1d50914 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -1121,6 +1121,11 @@ static gboolean gst_avdtp_sink_update_caps(GstAvdtpSink *self)
 	sbc = (void *) gst_avdtp_find_caps(self, BT_A2DP_SBC_SINK);
 	mpeg = (void *) gst_avdtp_find_caps(self, BT_A2DP_MPEG12_SINK);
 
+	if(!sbc) {
+		GST_ERROR_OBJECT(self, "Failed to find sbc(mandatory codec)");
+		return FALSE;
+	}
+
 	sbc_structure = gst_avdtp_sink_parse_sbc_caps(self, sbc);
 	mpeg_structure = gst_avdtp_sink_parse_mpeg_caps(self, mpeg);
 
-- 
1.7.5.4

