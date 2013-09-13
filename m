Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] obexd: Clarify the folder property of PushMessage
Date: Fri, 13 Sep 2013 11:23:32 +0200
Message-Id: <1379064212-30056-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1379064212-30056-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379064212-30056-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The folder property of PushMessages does not accept path information,
it allows only to request the messages to be added to a subfolder of the
current folder.
---
 doc/obex-api.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 28343f6..eda7cb9 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -638,8 +638,9 @@ Methods		void SetFolder(string name)
 			Transfer a message (in bMessage format) to the
 			remote device.
 
-			The message is transferred either to the given folder,
-			or to the current folder if folder is omitted.
+			The message is transferred either to the given
+			subfolder of the current folder, or to the current
+			folder if folder is empty.
 
 			Possible args: Transparent, Retry, Charset
 
-- 
1.8.3.4

