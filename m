Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] doc: Update settings-storage.txt
Date: Tue, 27 Nov 2012 09:49:47 +0100
Message-Id: <1354006193-7199-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Link key and Long term key for a device should be saved in
keys file under storage device directory
---
 doc/settings-storage.txt |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 3fdcb03..c0171e9 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -30,6 +30,7 @@ contains:
  - one directory per remote device, named by remote device address, which
    contains:
     - an info file
+    - a keys file
     - an attributes file containing attributes of remote LE services
 
 So the directory structure is:
@@ -42,9 +43,11 @@ So the directory structure is:
             ...
         ./<remote device address>/
             ./info
+            ./keys
             ./attributes
         ./<remote device address>/
             ./info
+            ./keys
             ./attributes
         ...
 
@@ -127,8 +130,8 @@ This general group contains:
 Info file format
 ================
 
-Info file may includes multiple groups (General, Device ID, Link key and
-Long term key) related to a remote device.
+Info file may includes multiple groups (General and Device ID) related to
+a remote device.
 
 [General] group contains:
 
@@ -165,6 +168,12 @@ Long term key) related to a remote device.
   Version		Integer		Device version
 
 
+Keys file format
+================
+
+Keys file may includes multiple groups (Link key and Long term key) related
+to a remote device.
+
 [LinkKey] group contains:
 
   Key			String		Key in hexadecimal format
-- 
1.7.9.5

