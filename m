Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] doc: Remove deprecated ListAdapters() method
Date: Thu, 19 Jul 2012 13:52:45 -0300
Message-Id: <1342716765-28912-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/manager-api.txt |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

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
1.7.8.6

