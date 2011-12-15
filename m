Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC] media: assertion to check that transport exists
Date: Thu, 15 Dec 2011 13:33:55 +0100
Message-Id: <1323952435-3244-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

>From my understanding, a transport should exist for any non-disconnected
gateway.

These assertions sometimes fail though. So I would like to clarify if
that's a consistent state in BlueZ or there is some bug.
---
 audio/media.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index a2ef437..c5fe3d9 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -28,6 +28,7 @@
 #endif
 
 #include <errno.h>
+#include <assert.h>
 
 #include <glib.h>
 #include <gdbus.h>
@@ -620,8 +621,10 @@ static void gateway_state_changed(struct audio_device *dev,
 					gateway_setconf_cb, dev, NULL);
 		break;
 	case GATEWAY_STATE_CONNECTED:
+		assert(endpoint->transport != NULL);
 		break;
 	case GATEWAY_STATE_PLAYING:
+		assert(endpoint->transport != NULL);
 		break;
 	}
 }
-- 
1.7.6.4

