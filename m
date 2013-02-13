Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] doc: Clarify device connect description
Date: Wed, 13 Feb 2013 22:02:14 +0100
Message-Id: <1360789334-27802-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Describe behaviour when some profiles are already connected. Clarify
that it returns success if at least one profile was connected.
---
 doc/device-api.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 66c46e5..19d3fde 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -14,7 +14,12 @@ Methods		void Connect()
 			This is a generic method to connect any profiles
 			the remote device supports that can be connected
 			to and have been flagged as auto-connectable on
-			our side.
+			our side. If only subset of profiles is already
+			connected it will try to connect currently disconnected
+			ones.
+
+			If at least one profile was connected successfully this
+			method will indicate success.
 
 			Possible errors: org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
-- 
1.8.1.2

