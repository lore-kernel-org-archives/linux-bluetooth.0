Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] TODO: Advertising management
Date: Tue, 19 Oct 2010 19:27:11 -0200
Message-Id: <1287523632-5966-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1287523632-5966-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1287523632-5966-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index d95932b..948d4d0 100644
--- a/TODO
+++ b/TODO
@@ -26,6 +26,20 @@ Low Energy
   Priority: Medium
   Complexity: C2
 
+- Advertising management. Adapter interface needs to be changed to manage
+  connection modes, adapter type and advertising policy. See Volume 3,
+  Part C, section 9.3. If Attribute Server is enabled the LE capable
+  adapter shall to start advertising. Further investigation is necessary
+  to define which connectable mode needs to be supported: Non-connectable,
+  directed connectable and undirected connectable. Basically, two connectable
+  scenarios shall be addressed:
+  1. GATT client is disconnected, but intends to become a Peripheral to
+     receive indications/notifications.
+  2. GATT server intends to accept connections.
+
+  Priority: Medium
+  Complexity: C2
+
 - Device Name Characteristic is a GAP characteristic for Low Energy. This
   characteristic shall be integrated/used in the discovery procedure. The
   ideia is to report the value of this characteristic using DeviceFound signals.
-- 
1.7.3.1

