Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC V3 01/12] doc: Update settings-storage.txt
Date: Fri, 30 Nov 2012 15:46:55 +0100
Message-Id: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add missing Master key to LongTermKey group
---
 doc/settings-storage.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 3fdcb03..e7ba89d 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -181,6 +181,8 @@ Long term key) related to a remote device.
   Authenticated		Boolean		True if remote device has been
 					authenticated
 
+  Master		Boolean		True for master key
+
   EncSize		Integer		Encrypted size
 
   EDiv			Integer		Encrypted diversifier
-- 
1.7.9.5

