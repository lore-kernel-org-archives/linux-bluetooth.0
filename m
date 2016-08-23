Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] doc/device-api: Document Connect behavior for dual-mode
Date: Tue, 23 Aug 2016 13:17:48 +0300
Message-Id: <1471947468-12696-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1471947468-12696-1-git-send-email-luiz.dentz@gmail.com>
References: <1471947468-12696-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Adds description of how Device1.Connect behave with dual-mode devices.
---
 doc/device-api.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 087efb9..3938539 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -21,6 +21,20 @@ Methods		void Connect()
 			If at least one profile was connected successfully this
 			method will indicate success.
 
+			For dual-mode devices only one bearer is connected at
+			time, the conditions are in the following order:
+
+				1. Connect the disconnected bearer if already
+				connected.
+
+				2. Connect first the bonded bearer. If no
+				bearers are bonded or both both skip and check
+				latest seen bearer.
+
+				3. Connect last seen bearer, in case the
+				timestamps are the same BR/EDR takes
+				precedence.
+
 			Possible errors: org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
-- 
2.7.4

