Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/11] android/hal-ipc-api: Add Configuration command
Date: Mon, 15 Sep 2014 16:49:05 +0200
Message-Id: <1410792555-24765-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
References: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index f6e1680..e7dab3b 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -90,6 +90,9 @@ the socket and register both "bluetooth" and "socket" service modules. It is
 required to register "socket" service at the same time since the HAL module
 does not have its own init() function.
 
+It is possible to send Configure command before registering any services to
+customize stack. This step is optional.
+
 When new profiles are initiated, the get_profile_interface() callback
 will load the profile and during init() of the profile, it should register the
 specific service.
@@ -143,6 +146,19 @@ Core Service (ID 0)
 
 		In case of an error, the error response will be returned.
 
+	Opcode 0x03 - Configuration
+
+		Command parameters: Num options (1 octet)
+		                    Type # (1 octet)
+		                    Value # (92 octets)
+
+		Response parameters: <none>
+
+		Valid configure option types: 0x00 = Vendor
+		                              0x01 = Model
+		                              0x02 = Name
+
+		In case of an error, the error response will be returned.
 
 Bluetooth Core HAL (ID 1)
 =========================
-- 
1.9.3

