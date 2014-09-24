Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ] TODO: Add item to support included services in shared/gatt-client.
Date: Wed, 24 Sep 2014 11:25:30 -0700
Message-Id: <1411583130-23865-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/TODO b/TODO
index fe5ebe5..efaec11 100644
--- a/TODO
+++ b/TODO
@@ -112,6 +112,15 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C2
 
+- Support included services in shared/gatt-client. This requires helper
+  functions to be added to discover secondary services and include declarations
+  to shared/gatt-helpers. shared/gatt-client's attribute discovery procedure
+  needs to be extended to discover all secondary services and store include
+  declarations for all discovered services.
+
+  Priority: Low
+  Complexity: C2
+
 - Introduce long-term caching of attributes to shared/gatt-client, such that the
   services, characteristics, and descriptors obtained from a peripheral are
   remembered in the case of bonding. This may involve storing data about GATT
-- 
2.1.0.rc2.206.gedb03e5

