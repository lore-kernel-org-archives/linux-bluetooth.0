Return-Path: <cyrus@holtmann.org>
From: David Stockwell <dstockwell@frequency-one.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] AVRCP: Eliminate dependency on sink for connect.
Date: Sat, 20 Aug 2011 17:49:05 -0500
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108201749.05948.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AVRCP: Eliminate dependency on sink for avrcp-connect.

Required for case where device connecting is an AVRCP-only
remote, without audio (sink) capability.

Signed-off-by: David Stockwell <dstockwell@frequency-one.com>
---
 audio/manager.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 6e583cf..0c69736 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -224,8 +224,21 @@ static void handle_uuid(const char *uuidstr, struct 
audio_device *device)
 		else
 			device->control = control_init(device, uuid16,
 							enabled.media_player);
-		if (device->sink && sink_is_active(device))
-			avrcp_connect(device);
+
+		/* Eliminate dependency on sink if plain remote (without Sink). */
+
+		if (device->sink) {
+			if (sink_is_active(device)) {
+				DBG("Connecting to AVRCP with active sink");
+				avrcp_connect(device);
+			} else {
+				DBG("Connecting to AVRCP with inactive sink");
+				avrcp_connect(device);
+			}
+		} else {
+			DBG("Connecting to AVRCP without sink");
+ 			avrcp_connect(device);
+		}
 		break;
 	default:
 		DBG("Unrecognized UUID: 0x%04X", uuid16);
-- 
1.7.3.4

