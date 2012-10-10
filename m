Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 10/10] TODO: Add entry to remove storage convertion function
Date: Wed, 10 Oct 2012 18:23:31 +0200
Message-Id: <1349886211-18920-11-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1349886211-18920-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349886211-18920-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/TODO b/TODO
index 384d428..c6787cc 100644
--- a/TODO
+++ b/TODO
@@ -30,6 +30,12 @@ General
   Priority: Low
   Complexity: C1
 
+- Function in src/adapter.c to convert old storage files to new ini-file format
+  should be removed 6-8 months after first BlueZ 5 release.
+
+  Priority: Low
+  Complexity: C1
+
 BlueZ 5
 =======
 
-- 
1.7.9.5

