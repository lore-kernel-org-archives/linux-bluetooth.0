Return-Path: <cyrus@holtmann.org>
From: David Stockwell <dstockwell@frequency-one.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] For AVRCP Connect, eliminate dependency on sink
Date: Thu, 11 Aug 2011 09:15:43 -0500
Cc: lucas.demarchi@profusion.mobi, luiz.dentz@gmail.com,
	david_stockwell@att.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108110915.43536.dstockwell@frequency-one.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For AVRCP Connect, eliminate dependency on sink

Required for case where device connecting is only an AVRCP
remote, without audio (sink) capability.

Based on Release 4.96
---
 audio/manager.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 911af45..b3c8773 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -222,8 +222,21 @@ static void handle_uuid(const char *uuidstr, struct 
audio_device *device)
 			control_update(device, uuid16);
 		else
 			device->control = control_init(device, uuid16);
-		if (device->sink && sink_is_active(device))
+
+		/* Eliminate dependency on sink if remote without Sink. */
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
 			avrcp_connect(device);
+		}
 		break;
 	default:
 		DBG("Unrecognized UUID: 0x%04X", uuid16);
-- 
1.7.4.4

