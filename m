Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] Print Vendor/Product/Version in hexadecimal
Date: Thu, 22 Sep 2011 18:51:50 +0300
Message-Id: <1316706712-17611-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1316706712-17611-1-git-send-email-luiz.dentz@gmail.com>
References: <1316706712-17611-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is how their are more commonly known.
---
 test/list-devices |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/test/list-devices b/test/list-devices
index 9120714..cb564be 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -67,6 +67,12 @@ for i in adapter_list:
 				print "        %s = %s" % (key, list)
 			elif (key == "Class"):
 				print "        %s = 0x%06x" % (key, value)
+			elif (key == "Vendor"):
+				print "        %s = 0x%04x" % (key, value)
+			elif (key == "Product"):
+				print "        %s = 0x%04x" % (key, value)
+			elif (key == "Version"):
+				print "        %s = 0x%04x" % (key, value)
 			else:
 				print "        %s = %s" % (key, value)
 
-- 
1.7.6.2

