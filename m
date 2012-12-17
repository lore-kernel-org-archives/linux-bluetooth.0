Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/13] TODO: Mark convert storage to ini-file item as done
Date: Mon, 17 Dec 2012 16:09:54 +0100
Message-Id: <1355756994-18953-13-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/TODO b/TODO
index 5a70e40..f0e494f 100644
--- a/TODO
+++ b/TODO
@@ -60,11 +60,10 @@ BlueZ 5
 Priority/Complexity omitted as all items are required before 5.0 is
 released.
 
-- [pending] Convert storage to user per-remote device directories and
-  ini-file format
-
 Completed items:
 
+- Convert storage to user per-remote device directories and ini-file format
+
 - Don't install libbluetooth by default (put it behind a configure switch)
 
 - Switch plugins to standard D-Bus properties interface
-- 
1.7.9.5

