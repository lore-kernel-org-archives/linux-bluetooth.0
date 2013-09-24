Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] obexd: Update Status property in map documentation
Date: Tue, 24 Sep 2013 16:16:04 +0200
Message-Id: <1380032167-6440-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1380032167-6440-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

For outgoing messages, the status field values are:
"delivery-success", "sending-success", "delivery-failure", "sending-failure"
---
 doc/obex-api.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index eda7cb9..c3f5243 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -598,10 +598,14 @@ Methods		void SetFolder(string name)
 
 				string Status:
 
-					Message reception status
+					Message status
 
-					Possible values: "complete",
-					"fractioned" and "notification"
+					Possible values for received messages:
+					"complete", "fractioned", "notification"
+
+					Possible values for sent messages:
+					"delivery-success", "sending-success",
+					"delivery-failure", "sending-failure"
 
 				uint64 AttachmentSize:
 
-- 
1.8.3.4

