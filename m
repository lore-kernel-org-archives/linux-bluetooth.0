Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 1/3] audio: fix omitting headset records if AG found
Date: Mon, 12 Mar 2012 16:56:37 +0100
Message-Id: <1331567799-1247-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331567799-1247-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331567799-1247-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

During pairing both records can be registered, when an incoming
connection is handled by the gateway server (hf_io_cb). In any case only
the AG record should be left, and thus the headset record must be either
omitted or removed.

Without this patch, both device->headset and device->gateway can be set.
The first point where this causes trouble is inside sco_server_cb, where
the state of the headset is checked (disconnected) and the incoming SCO
request is refused.
---
 audio/manager.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 68a0a56..ab97314 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -182,7 +182,9 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 	switch (uuid16) {
 	case HEADSET_SVCLASS_ID:
 		DBG("Found Headset record");
-		if (device->headset)
+		if (device->gateway)
+			DBG("Omitting record because Handsfree AG exists");
+		else if (device->headset)
 			headset_update(device, uuid16, uuidstr);
 		else
 			device->headset = headset_init(device, uuid16,
@@ -193,7 +195,9 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 		break;
 	case HANDSFREE_SVCLASS_ID:
 		DBG("Found Handsfree record");
-		if (device->headset)
+		if (device->gateway)
+			DBG("Omitting record because Handsfree AG exists");
+		else if (device->headset)
 			headset_update(device, uuid16, uuidstr);
 		else
 			device->headset = headset_init(device, uuid16,
@@ -201,8 +205,12 @@ static void handle_uuid(const char *uuidstr, struct audio_device *device)
 		break;
 	case HANDSFREE_AGW_SVCLASS_ID:
 		DBG("Found Handsfree AG record");
-		if (enabled.gateway && (device->gateway == NULL))
+		if (enabled.gateway && (device->gateway == NULL)) {
 			device->gateway = gateway_init(device);
+
+			if (device->headset != NULL)
+				headset_unregister(device);
+		}
 		break;
 	case AUDIO_SINK_SVCLASS_ID:
 		DBG("Found Audio Sink");
-- 
1.7.7.6

