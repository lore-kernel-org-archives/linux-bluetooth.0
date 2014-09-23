Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 9/9] TODO: shared/gatt-client now handles Service Changed
Date: Tue, 23 Sep 2014 13:47:17 -0700
Message-Id: <1411505237-10932-10-git-send-email-armansito@chromium.org>
In-Reply-To: <1411505237-10932-1-git-send-email-armansito@chromium.org>
References: <1411505237-10932-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/TODO b/TODO
index 25faeb9..fe5ebe5 100644
--- a/TODO
+++ b/TODO
@@ -105,13 +105,6 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C1
 
-- Properly handle indications from the "Service Changed" characteristic.
-  shared/gatt-client should automatically rediscover all changed GATT services
-  and notify the upper layer using a specially assigned handler.
-
-  Priority: Medium
-  Complexity: C1
-
 - Introduce a handler interface to shared/gatt-client which can be used by the
   upper layer to determine when the link has been disconnected or an ATT
   protocol request times out.
-- 
2.1.0.rc2.206.gedb03e5

