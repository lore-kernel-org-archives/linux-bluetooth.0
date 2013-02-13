Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH 1/2] doc: Fix device disconnect description
Date: Wed, 13 Feb 2013 22:45:38 +0100
Message-Id: <1360791939-28354-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Document what Disconnect() function actually does.
---
 doc/device-api.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 19d3fde..ec126e8 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -33,10 +33,12 @@ Methods		void Connect()
 
 		void Disconnect()
 
-			This method disconnects a specific remote device by
-			terminating the low-level ACL connection. The use of
-			this method should be restricted to administrator
-			use.
+			This method gracefully disconnects all connected
+			profiles and then terminates low-level ACL connection.
+
+			ACL connection will be terminated even if some profiles
+			were not disconnected properly e.g. due to misbehaving
+			device.
 
 			Possible errors: org.bluez.Error.NotConnected
 
-- 
1.8.1.2

