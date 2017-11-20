Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] doc/device-api: Document behavior of Disconnect method with LE
Date: Mon, 20 Nov 2017 15:42:43 +0200
Message-Id: <20171120134244.24548-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If and LE device is disconnected using device.Device method it won't
be able to reconnect by itself.
---
 doc/device-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 13b28818e..ac5604f9c 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -52,6 +52,10 @@ Methods		void Connect()
 			This method can be also used to cancel a preceding
 			Connect call before a reply to it has been received.
 
+			When connected over LE bearer calling this method will
+			prevent incoming connections until Connect method is
+			called again.
+
 			Possible errors: org.bluez.Error.NotConnected
 
 		void ConnectProfile(string uuid)
-- 
2.13.6

