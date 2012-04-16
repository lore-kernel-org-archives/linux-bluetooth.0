Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] Add sbc cap null case while GST AVDTP Signaling.
Date: Mon, 16 Apr 2012 11:59:59 +0900
Message-id: <1334545199-25012-1-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1334419155.16897.148.camel@aeonflux>
References: <1334419155.16897.148.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

Due to RF condition or headset malfunctioning, gst audio plug-in
could not get sbc(mandatory codec) information.
---
 audio/gstavdtpsink.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index b448d57..af04a56 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -1121,6 +1121,11 @@ static gboolean gst_avdtp_sink_update_caps(GstAvdtpSink *self)
 	sbc = (void *) gst_avdtp_find_caps(self, BT_A2DP_SBC_SINK);
 	mpeg = (void *) gst_avdtp_find_caps(self, BT_A2DP_MPEG12_SINK);
 
+	if (!sbc) {
+		GST_ERROR_OBJECT(self, "Failed to find mandatory SBC sink");
+		return FALSE;
+	}
+
 	sbc_structure = gst_avdtp_sink_parse_sbc_caps(self, sbc);
 	mpeg_structure = gst_avdtp_sink_parse_mpeg_caps(self, mpeg);
 
-- 
1.7.5.4

