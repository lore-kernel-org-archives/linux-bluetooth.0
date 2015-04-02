Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v9 07/12] Update TODO for LE Advertising
Date: Thu,  2 Apr 2015 11:59:23 -0700
Message-Id: <1428001168-32822-8-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1428001168-32822-1-git-send-email-jamuraa@chromium.org>
References: <1428001168-32822-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/TODO b/TODO
index 65e19ee..2945392 100644
--- a/TODO
+++ b/TODO
@@ -64,16 +64,16 @@ General
 Low Energy
 ==========
 
-- Advertising management. Adapter interface needs to be changed to manage
-  connection modes, adapter type and advertising policy. See Volume 3,
-  Part C, section 9.3. If Attribute Server is enabled the LE capable
-  adapter shall to start advertising. Further investigation is necessary
-  to define which connectable mode needs to be supported: Non-connectable,
-  directed connectable and undirected connectable. Basically, two connectable
-  scenarios shall be addressed:
-  1. GATT client is disconnected, but intends to become a Peripheral to
-     receive indications/notifications.
-  2. GATT server intends to accept connections.
+- Connection modes. Adapter interface needs to be changed to manage
+  connection modes and adapter type. See Volume 3, Part C, section 9.3.
+  1. Mode management: Peripheral / Central
+
+  Priority: Medium
+  Complexity: C2
+
+- Advertising data. The D-Bus interface needs to be updated to enable setting
+  scan response data, and to read the advertising and scan response data which
+  has been broadcast from other LE devices.
 
   Priority: Medium
   Complexity: C2
-- 
2.2.0.rc0.207.ga3a616c

