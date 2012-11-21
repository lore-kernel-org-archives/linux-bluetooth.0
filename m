Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] doc: Update settings-storage.txt
Date: Wed, 21 Nov 2012 14:49:47 +0100
Message-Id: <1353505791-21134-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remote features are not available from user space,
so replace Features entry by SupportedTechnologies.

Device blocked should be saved in device info file.
---
 doc/settings-storage.txt |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 1174d44..3fdcb03 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -139,13 +139,16 @@ Long term key) related to a remote device.
   Class			String		Device class in hexadecimal,
 					i.e. 0x000000
 
-  Features		String		Bluetooth device features in
-					hexadecimal, i.e. 0x0000000000000000
+  SupportedTechnologies	List of		List of technologies supported by
+			strings		device, separated by ";"
+					Technologies can be BR/EDR or LE
 
   AddressType		String		An address can be "static" or "public"
 
   Trusted		Boolean		True if the remote device is trusted
 
+  Blocked		Boolean		True if the remote device is blocked
+
   Profiles		List of		List of profiles advertised by remote,
 			strings		in 128-bits UUID format, separated by
 					";"
-- 
1.7.9.5

