Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] obexd: Clarify the folder property of ListMessages
Date: Mon, 23 Sep 2013 11:24:28 +0200
Message-Id: <1379928269-14651-4-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1379928269-14651-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379928269-14651-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The folder property of ListMessages does not accept path information,
it allows only to request the messages of a subfolder of the current
folder.
---
 doc/obex-api.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 0a8e632..28343f6 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -538,7 +538,8 @@ Methods		void SetFolder(string name)
 		array{object, dict} ListMessages(string folder, dict filter)
 
 			Returns an array containing the messages found in the
-			given folder.
+			given subfolder of the current folder, or in the
+			current folder if folder is empty.
 
 			Possible Filters: Offset, MaxCount, SubjectLength, Fields,
 			Type, PeriodStart, PeriodEnd, Status, Recipient, Sender,
-- 
1.8.3.4

