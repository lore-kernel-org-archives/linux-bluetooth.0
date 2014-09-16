Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] doc/obex-api: Mark DatabaseIdentifier as optional
Date: Tue, 16 Sep 2014 14:13:29 +0300
Message-Id: <1410866009-2417-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There is no need to declare DatabaseIdentifier in case it is invalid
since by omitting it should indicate GetVersion is not supported.
---
 doc/obex-api.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 31afc74..f80ef39 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -491,12 +491,10 @@ Properties	string Folder [readonly]
 
 			Current folder.
 
-		string DatabaseIdentifier [readonly]
+		string DatabaseIdentifier [readonly, optional]
 
 			128 bits persistent identifier.
 
-			Value '0' shall be considered as not supported.
-
 
 Synchronization hierarchy
 =========================
-- 
1.9.3

