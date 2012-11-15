Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 03/16] manager: Extend FindAdapter with "default" pattern
Date: Thu, 15 Nov 2012 16:09:06 +0100
Message-Id: <1352992159-11559-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Extend the supported values in the given pattern in order to return the
default adapter if "default" is given.
---
 doc/manager-api.txt | 1 +
 src/manager.c       | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index 8497141..b0d534d 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -27,6 +27,7 @@ Object path	/
 			patterns are "hci0" or "00:11:22:33:44:55". Other
 			supported values are:
 				"any"
+				"default"
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.NoSuchAdapter
diff --git a/src/manager.c b/src/manager.c
index 3088dd9..79d049b 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -110,7 +110,9 @@ static DBusMessage *find_adapter(DBusConnection *conn,
 	} else if (!strncmp(pattern, "hci", 3) && strlen(pattern) >= 4) {
 		dev_id = atoi(pattern + 3);
 		adapter = manager_find_adapter_by_id(dev_id);
-	} else {
+	} else if (!strcmp(pattern, "default"))
+		adapter = manager_find_adapter_by_id(default_adapter_id);
+	else {
 		bdaddr_t bdaddr;
 		str2ba(pattern, &bdaddr);
 		adapter = manager_find_adapter(&bdaddr);
-- 
1.7.11.7

