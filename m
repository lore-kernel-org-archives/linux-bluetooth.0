Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH 2/2] doc: Remove CancelConnect function from device API
Date: Wed, 13 Feb 2013 22:45:39 +0100
Message-Id: <1360791939-28354-2-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1360791939-28354-1-git-send-email-szymon@janc.net.pl>
References: <1360791939-28354-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This method is not implemented and Disconnect can be used instead.
---
 doc/device-api.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index ec126e8..c79a46c 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -26,11 +26,6 @@ Methods		void Connect()
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.AlreadyConnected
 
-		void CancelConnect()
-
-			This method can be used to cancel a preceeding
-			Connect call before a reply to it has been received.
-
 		void Disconnect()
 
 			This method gracefully disconnects all connected
@@ -40,6 +35,9 @@ Methods		void Connect()
 			were not disconnected properly e.g. due to misbehaving
 			device.
 
+			This method can be also used to cancel a preceding
+			Connect call before a reply to it has been received.
+
 			Possible errors: org.bluez.Error.NotConnected
 
 		void ConnectProfile(string uuid)
-- 
1.8.1.2

