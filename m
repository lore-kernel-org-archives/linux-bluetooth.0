Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add device/intel repository
Date: Fri, 11 Oct 2013 13:37:28 +0300
Message-Id: <1381487848-24213-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In device/intel we need to disable blacklisting bluetooth kernel modules.

Change-Id: I84a742ad75035bf5d3238cd632fe875aa5f97143
---
 topics/local_manifest.xml |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/topics/local_manifest.xml b/topics/local_manifest.xml
index 360f5f5..3ad60c4 100644
--- a/topics/local_manifest.xml
+++ b/topics/local_manifest.xml
@@ -19,4 +19,8 @@
   <project path="bionic" name="android-bluez.bionic"
     remote="android-bluez" revision="master" />
 
+  <remove-project name="device/intel" />
+  <project path="device/intel" name="android-bluez.device-intel"
+    remote="android-bluez" revision="master" />
+
 </manifest>
-- 
1.7.10.4

