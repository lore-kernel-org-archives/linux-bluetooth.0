Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 10/10] TODO: tools/btgatt-client introduced
Date: Wed,  3 Sep 2014 12:46:11 -0700
Message-Id: <1409773571-28417-11-git-send-email-armansito@chromium.org>
In-Reply-To: <1409773571-28417-1-git-send-email-armansito@chromium.org>
References: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/TODO b/TODO
index 16de35b..5277e39 100644
--- a/TODO
+++ b/TODO
@@ -177,12 +177,6 @@ ATT/GATT (new shared stack)
   Priority: Low
   Complexity: C4
 
-- Introduce a new GATT client command-line tool to test and use a single
-  instance of bt_gatt_client.
-
-  Priority: Low
-  Complexity: C1
-
 - Move all daemon plugins and profiles that are GATT based to use
   shared/gatt-client instead of attrib/*. This is a complicated task that
   potentially needs a new plugin/profile probing interface and a lot of
-- 
2.1.0.rc2.206.gedb03e5

