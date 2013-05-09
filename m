Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH] doc: Document missing errors returned by the Device1 API.
Date: Thu,  9 May 2013 12:09:48 -0700
Message-Id: <1368126588-19304-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

There were two groups of missing error messages in the documentation:
* For org.bluez.Device1.DisconnectProfile:
  This method could certainly call btd_error_not_supported or
  btd_error_failed returning those errors.
* For org.bluez.Device1.Pair:
  The pairing process could certainly call new_authentication_return
  which can return (and actualy does) five other different errors.
---

Hi,
Those are just a few I found, but didn't check rigorously all the functions.
This is at least a progress.
Thanks!
Alex.


 doc/device-api.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 187f2bf..6201780 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -61,7 +61,9 @@ Methods		void Connect()
 			succeed.
 
 			Possible errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.Failed
 					 org.bluez.Error.NotConnected
+					 org.bluez.Error.NotSupported
 
 		void Pair()
 
@@ -83,6 +85,11 @@ Methods		void Connect()
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.Failed
+					 org.bluez.Error.AuthenticationCanceled
+					 org.bluez.Error.AuthenticationFailed
+					 org.bluez.Error.AuthenticationRejected
+					 org.bluez.Error.AuthenticationTimeout
+					 org.bluez.Error.ConnectionAttemptFailed
 
 		void CancelPairing()
 
-- 
1.8.2.1
