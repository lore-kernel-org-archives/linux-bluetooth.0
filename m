Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ] AVDTP: Fix closing invalid FD on error
Date: Thu, 17 Nov 2011 13:29:06 -0400
Message-Id: <1321550946-8828-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In gst_avdtp_sink_start(), if bt_audio_service_open() failed, there was
an attempt to close an invalid file descriptor (through
bt_audio_service_close()).
---

NOTE:
gst_avdtp_sink_start() seems to be leaking "self" when it fails (even before
this patch). Can someone with better knowledge of audio/gstavdtpsink.c verify
this?


 audio/gstavdtpsink.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index dca9d67..c5392c5 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -1452,7 +1452,7 @@ static gboolean gst_avdtp_sink_start(GstBaseSink *basesink)
 		err = -errno;
 		GST_ERROR_OBJECT(self, "Cannot open connection to bt "
 			"audio service: %s %d", strerror(-err), -err);
-		goto failed;
+		return FALSE;
 	}
 
 	self->server = g_io_channel_unix_new(sk);
-- 
1.7.0.4

