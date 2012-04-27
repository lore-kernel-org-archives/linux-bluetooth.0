Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v1 1/5] audio: Fix gateway state check
Date: Fri, 27 Apr 2012 12:59:43 +0200
Message-Id: <1335524387-22831-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1335524387-22831-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335524387-22831-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Gateway should be considered active also if connecting or playing.

This could for example lead to manager_find_device() not returning a
device that is connecting, and thus the corresponding endpoint would
never be created in the Media API.
---
 audio/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index a9d35f9..ee1ade1 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -701,7 +701,7 @@ gboolean audio_device_is_active(struct audio_device *dev,
 				control_is_active(dev))
 		return TRUE;
 	else if (!strcmp(interface, AUDIO_GATEWAY_INTERFACE) && dev->gateway &&
-				gateway_is_connected(dev))
+				gateway_is_active(dev))
 		return TRUE;
 
 	return FALSE;
-- 
1.7.7.6

