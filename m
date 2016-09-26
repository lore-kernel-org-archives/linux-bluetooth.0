Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] tools/btattach: Update manual page
Date: Mon, 26 Sep 2016 17:08:10 +0200
Message-Id: <1474902490-6104-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Add ag6xx, nokia and mrvl protocols.
---
 tools/btattach.1 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/btattach.1 b/tools/btattach.1
index ffd653d..811a1a3 100644
--- a/tools/btattach.1
+++ b/tools/btattach.1
@@ -47,6 +47,12 @@ Supported values are:
 .B bcm
 .IP \(bu 2
 .B qca
+.IP \(bu 2
+.B ag6xx
+.IP \(bu 2
+.B nokia
+.IP \(bu 2
+.B mrvl
 .RE
 .TP
 .B \-R
-- 
1.9.1
