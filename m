Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH] doc: remove ListAdapters()
Date: Thu, 19 Jul 2012 10:05:21 -0300
Message-Id: <1342703121-19128-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 doc/manager-api.txt |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index d2c1caf..4e6653b 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -37,16 +37,6 @@ Methods		dict GetProperties()
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NoSuchAdapter
 
-		array{object} ListAdapters() {deprecated}
-
-			Returns list of adapter object paths under /org/bluez.
-			This method is deprecated, instead use the Adapters
-			Property to get the list of adapter object paths.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.Failed
-					 org.bluez.Error.OutOfMemory
-
 Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
-- 
1.7.10.4

