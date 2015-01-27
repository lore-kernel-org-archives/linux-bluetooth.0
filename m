Return-Path: <cyrus@holtmann.org>
From: Jakub Sitnicki <jsitnicki@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Sitnicki <jsitnicki@gmail.com>
Subject: [PATCH 1/2] doc/device-api: Update possible errors for ConnectProfile
Date: Tue, 27 Jan 2015 08:49:36 +0100
Message-Id: <1422344977-26683-1-git-send-email-jsitnicki@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make API documentation reflect the current implementation.
---
 doc/device-api.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 86d8af8..4f5e1d9 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -46,9 +46,11 @@ Methods		void Connect()
 			device. The UUID provided is the remote service
 			UUID for the profile.
 
-			Possible errors: org.bluez.Error.DoesNotExist
-					 org.bluez.Error.AlreadyConnected
-					 org.bluez.Error.ConnectFailed
+			Possible errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotAvailable
+					 org.bluez.Error.NotReady
 
 		void DisconnectProfile(string uuid)
 
-- 
1.9.3

