Return-Path: <cyrus@holtmann.org>
From: martin.xu@linux.intel.com
To: linux-bluetooth@vger.kernel.org
Cc: Martin Xu <martin.xu@linux.intel.com>
Subject: [PATCH v2] obex/session: Redefine session target property
Date: Wed, 17 Jul 2013 11:00:53 +0800
Message-Id: <1374030053-1305-1-git-send-email-martin.xu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Martin Xu <martin.xu@linux.intel.com>

The definition of Target should be the same with Target parameter
of CreateSession.

And add TargetUUID for the external profile that can't be shown from Target
---
 doc/obex-api.txt |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

 Changelog:
 v2: Add description why we need add TargetUUID property

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 22449c4..924df2f 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -68,7 +68,23 @@ Properties	string Source [readonly]
 
 		string Target [readonly]
 
-			Target UUID
+			The currently supported targets are the following:
+
+				"ftp"
+				"map"
+				"opp"
+				"pbap"
+				"sync"
+
+		string TargetUUID [readonly]
+
+			The UUID of target
+
+			TargetUUID is useful when the target is from
+			external profile and can't be exported from
+			Property Target
+
+			Opp doesn't have Target UUID, and is optional here
 
 		string Root [readonly]
 
-- 
1.7.10.4

