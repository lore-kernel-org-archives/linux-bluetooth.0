Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 7/7] TODO: Reference counted notify functions implemented
Date: Tue,  9 Sep 2014 10:04:09 -0700
Message-Id: <1410282249-22004-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1410282249-22004-1-git-send-email-armansito@chromium.org>
References: <1410282249-22004-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/TODO b/TODO
index 5277e39..3530de4 100644
--- a/TODO
+++ b/TODO
@@ -152,16 +152,6 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C1
 
-- Define API functions in shared/gatt-client for enabling/disabling
-  characteristic handle-value notifications/indications on a reference counted
-  basis. Code that is no longer interested in notifications from a
-  characteristic should be able to unregister any callbacks without writing to
-  the "Client Characteristic Configuration" descriptor if there are others who
-  are still interested.
-
-  Priority: Medium
-  Complexity: C2
-
 - Introduce a handler interface to shared/gatt-client which can be used by the
   upper layer to determine when the link has been disconnected or an ATT
   protocol request times out.
-- 
2.1.0.rc2.206.gedb03e5

