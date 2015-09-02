Return-Path: <cyrus@holtmann.org>
From: jonas.holmberg@axis.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] main.conf: Remove %h and %d from example Name
Date: Wed,  2 Sep 2015 12:07:44 +0200
Message-Id: <1441188464-18715-1-git-send-email-jonas.holmberg@axis.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jonas Holmberg <jonas.holmberg@axis.com>

%h and %d are no longer supported.
---
 src/main.conf | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/main.conf b/src/main.conf
index 11db383..6780d9a 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -1,10 +1,8 @@
 [General]
 
 # Default adaper name
-# %h - substituted for hostname
-# %d - substituted for adapter id
-# Defaults to 'BlueZ'
-#Name = %h-%d
+# Defaults to 'BlueZ X.YZ'
+#Name = BlueZ
 
 # Default device class. Only the major and minor device class bits are
 # considered. Defaults to '0x000000'.
-- 
2.4.6

