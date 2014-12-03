Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 4/4] TODO: gatt-db service events added.
Date: Wed,  3 Dec 2014 11:32:28 -0800
Message-Id: <1417635148-32546-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1417635148-32546-1-git-send-email-armansito@chromium.org>
References: <1417635148-32546-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/TODO b/TODO
index e8b0ab1..ca3779b 100644
--- a/TODO
+++ b/TODO
@@ -155,13 +155,6 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C4
 
-- Add service_added and service_removed callbacks to shared/gatt-db which should
-  get triggered via bt_gatt_service_set_active and when services get add or
-  removed.
-
-  Priority: Medium
-  Complexity: C2
-
 - Implement the client portion of doc/gatt-api.txt using shared/gatt-client once
   plugin/profile code uses it.
 
-- 
2.2.0.rc0.207.ga3a616c

