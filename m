Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 03/13] test: Support human-friendly UUIDs in test-device
Date: Mon,  6 May 2013 10:43:20 +0200
Message-Id: <1367829810-8262-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Make use of the newly introduced helper function in bluezutils.py to
parse the command line UUID argument for "connect" and "disconnect"
operations.
---
 test/test-device | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/test-device b/test/test-device
index 3d7b852..b5f8f96 100755
--- a/test/test-device
+++ b/test/test-device
@@ -99,7 +99,7 @@ if (args[0] == "connect"):
 	else:
 		device = bluezutils.find_device(args[1], options.dev_id)
 		if (len(args) > 2):
-			device.ConnectProfile(args[2])
+			device.ConnectProfile(bluezutils.parse_uuid(args[2]))
 		else:
 			device.Connect()
 	sys.exit(0)
@@ -110,7 +110,7 @@ if (args[0] == "disconnect"):
 	else:
 		device = bluezutils.find_device(args[1], options.dev_id)
 		if (len(args) > 2):
-			device.DisconnectProfile(args[2])
+			device.DisconnectProfile(bluezutils.parse_uuid(args[2]))
 		else:
 			device.Disconnect()
 	sys.exit(0)
-- 
1.8.1.4

