Return-Path: <cyrus@holtmann.org>
From: martin.xu@linux.intel.com
To: linux-bluetooth@vger.kernel.org
Cc: Martin <martin.xu@linux.intel.com>
Subject: [PATCH] Obex/Session: Redefine session target property
Date: Mon, 15 Jul 2013 10:10:03 +0800
Message-Id: <1373854203-3338-1-git-send-email-martin.xu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Martin <martin.xu@linux.intel.com>

The definition of Target should be the same with Target parameter
of CreateSession.

And add TargetUUID to save the Obex service UUID
---
 doc/obex-api.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 22449c4..ad03690 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -67,7 +67,15 @@ Properties	string Source [readonly]
 			Bluetooth channel
 
 		string Target [readonly]
+			The currently supported targets are the following:
+
+				"ftp"
+				"map"
+				"opp"
+				"pbap"
+				"sync"
 
+		string TargetUUID [readonly]
 			Target UUID
 
 		string Root [readonly]
-- 
1.7.10.4

