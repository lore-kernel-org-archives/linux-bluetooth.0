Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ 12/12] Update TODO for LE Advertising
Date: Thu, 12 Mar 2015 10:11:59 -0700
Message-Id: <1426180319-16509-13-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
References: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/TODO b/TODO
index 65e19ee..3bef10b 100644
--- a/TODO
+++ b/TODO
@@ -64,16 +64,17 @@ General
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
+- Advertising data. A MGMT interface is needed for setting LE Advertisement Data
+  and Scan Response data.  An adapter should be advertising whenever it is
+  appropriate to advertise, and it should be possible to determine what advertising
+  is occuring.
 
   Priority: Medium
   Complexity: C2
-- 
2.2.0.rc0.207.ga3a616c

