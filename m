Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 8/8] TODO: Add item for gatt-db service callbacks.
Date: Tue,  2 Dec 2014 16:12:43 -0800
Message-Id: <1417565563-29239-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1417565563-29239-1-git-send-email-armansito@chromium.org>
References: <1417565563-29239-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added TODO items for adding gatt-db service added/removed callbacks.
---
 TODO | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/TODO b/TODO
index ca3779b..fbd3ad6 100644
--- a/TODO
+++ b/TODO
@@ -155,6 +155,12 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C4
 
+- Add service_added and service_removed callbacks to shared/gatt-db which should
+  get triggered via bt_gatt_service_set_active and when services get removed.
+
+  Priority: Medium
+  Complexity: C2
+
 - Implement the client portion of doc/gatt-api.txt using shared/gatt-client once
   plugin/profile code uses it.
 
-- 
2.2.0.rc0.207.ga3a616c

