Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 5/9] Fix RFCOMM disconnect on suspend request
Date: Mon, 22 Aug 2011 17:30:43 +0200
Message-Id: <1314027047-5476-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When pulseaudio release an audio stream, gateway.c disconnects
RFCOMM instead of disconnecting only SCO.
---
 audio/gateway.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 805b8cb..425ad16 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -811,7 +811,7 @@ int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t sco_cb,
 
 gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id)
 {
-	gateway_close(dev);
+	gateway_suspend_stream(dev);
 	return TRUE;
 }
 
-- 
1.7.1

