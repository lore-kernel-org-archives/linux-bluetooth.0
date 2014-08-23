Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 13/13] TODO: shared/gatt-client has been defined and discovery implemented
Date: Fri, 22 Aug 2014 17:47:47 -0700
Message-Id: <1408754867-13313-14-git-send-email-armansito@chromium.org>
In-Reply-To: <1408754867-13313-1-git-send-email-armansito@chromium.org>
References: <1408754867-13313-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/TODO b/TODO
index 39a1773..be56f28 100644
--- a/TODO
+++ b/TODO
@@ -145,22 +145,6 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C1
 
-- Introduce shared/gatt-client as a standalone client implementation that can
-  operate on a single instance of bt_att as the ATT protocol transport. The
-  basic API should include functions for reference counting, setting a handler
-  for util_debug, and a high-level abstraction for GATT services,
-  characteristics, and descriptors.
-
-  Priority: Medium
-  Complexity: C1
-
-- Implement attribute discovery for shared/gatt-client. All services,
-  characteristics, and descriptors should be discovered and cached during the
-  set up process, which should also involve the initial MTU exchange.
-
-  Priority: Medium
-  Complexity: C1
-
 - Merge functions from shared/gatt-helpers involving value reads and writes into
   shared/gatt-client. These functions should accept an instance of
   bt_gatt_client instead of taking a bt_att directly.
-- 
2.1.0.rc2.206.gedb03e5

