Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 8/8] doc/gatt-api.txt: Update error names
Date: Tue, 13 Jan 2015 19:31:07 -0800
Message-Id: <1421206267-26369-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1421206267-26369-1-git-send-email-armansito@chromium.org>
References: <1421206267-26369-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updated possible error names that can be returned from
ReadValue/WriteValue methods to match those currently returned from the
experimental implementation.
---
 doc/gatt-api.txt | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index f7125a2..bfeaf6d 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -75,9 +75,8 @@ Methods		array{byte} ReadValue()
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
-					 org.bluez.Error.ReadNotPermitted
+					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.NotAuthorized
-					 org.bluez.Error.NotPaired
 					 org.bluez.Error.NotSupported
 
 		void WriteValue(array{byte} value)
@@ -87,10 +86,9 @@ Methods		array{byte} ReadValue()
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
-					 org.bluez.Error.WriteNotPermitted
+					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.InvalidValueLength
 					 org.bluez.Error.NotAuthorized
-					 org.bluez.Error.NotPaired
 					 org.bluez.Error.NotSupported
 
 		void StartNotify()
@@ -175,9 +173,8 @@ Methods		array{byte} ReadValue()
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
-					 org.bluez.Error.ReadNotPermitted
+					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.NotAuthorized
-					 org.bluez.Error.NotPaired
 					 org.bluez.Error.NotSupported
 
 		void WriteValue(array{byte} value)
@@ -187,10 +184,9 @@ Methods		array{byte} ReadValue()
 
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
-					 org.bluez.Error.WriteNotPermitted
+					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.InvalidValueLength
 					 org.bluez.Error.NotAuthorized
-					 org.bluez.Error.NotPaired
 					 org.bluez.Error.NotSupported
 
 Properties	string UUID [read-only]
-- 
2.2.0.rc0.207.ga3a616c

