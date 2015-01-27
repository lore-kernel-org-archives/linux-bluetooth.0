Return-Path: <cyrus@holtmann.org>
From: Jakub Sitnicki <jsitnicki@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Sitnicki <jsitnicki@gmail.com>
Subject: [PATCH 2/2] doc/device-api: Update possible errors for DisconnectProfile
Date: Tue, 27 Jan 2015 08:49:37 +0100
Message-Id: <1422344977-26683-2-git-send-email-jsitnicki@gmail.com>
In-Reply-To: <1422344977-26683-1-git-send-email-jsitnicki@gmail.com>
References: <1422344977-26683-1-git-send-email-jsitnicki@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make API documentation reflect the current implementation.
---
 doc/device-api.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 4f5e1d9..eec0024 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -62,9 +62,9 @@ Methods		void Connect()
 			as long as the profile is registered this will always
 			succeed.
 
-			Possible errors: org.bluez.Error.DoesNotExist
-					 org.bluez.Error.Failed
-					 org.bluez.Error.NotConnected
+			Possible errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NotSupported
 
 		void Pair()
-- 
1.9.3

