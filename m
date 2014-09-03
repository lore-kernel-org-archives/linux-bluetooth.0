Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 05/10] TODO: GATT read/write functions moved to shared/gatt-client.
Date: Wed,  3 Sep 2014 12:46:06 -0700
Message-Id: <1409773571-28417-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1409773571-28417-1-git-send-email-armansito@chromium.org>
References: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/TODO b/TODO
index be56f28..16de35b 100644
--- a/TODO
+++ b/TODO
@@ -145,13 +145,6 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C1
 
-- Merge functions from shared/gatt-helpers involving value reads and writes into
-  shared/gatt-client. These functions should accept an instance of
-  bt_gatt_client instead of taking a bt_att directly.
-
-  Priority: Medium
-  Complexity: C1
-
 - Properly handle indications from the "Service Changed" characteristic.
   shared/gatt-client should automatically rediscover all changed GATT services
   and notify the upper layer using a specially assigned handler.
-- 
2.1.0.rc2.206.gedb03e5

