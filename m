Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH] doc: Fix trivial typo in adapter-api
Date: Mon, 14 Jan 2013 08:44:41 +0100
Message-Id: <1358149481-3230-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
While checking the doc changes between 5.0 and 5.1, I came across this line which I believe is a typo.

 doc/adapter-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index cef6cbe..74d235a 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -88,7 +88,7 @@ Properties	string Address [readonly]
 			appropriate connectable state of the controller.
 
 			The value of this property is not persistent. After
-			restart of unplugging of the adapter it will reset
+			restart or unplugging of the adapter it will reset
 			back to false.
 
 		boolean Discoverable [readwrite]
-- 
1.7.11.7

