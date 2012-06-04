Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 01/15] client: Make transfer filename optional
Date: Mon,  4 Jun 2012 11:37:44 +0200
Message-Id: <1338802678-7009-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The property might not exist for certain transfers, typically when they
have been initiated internally.
---
 client/transfer.c  |    4 +++-
 doc/client-api.txt |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 14006ef..e7852e1 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -104,7 +104,9 @@ static DBusMessage *obc_transfer_get_properties(DBusConnection *connection,
 
 	obex_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING, &transfer->name);
 	obex_dbus_dict_append(&dict, "Size", DBUS_TYPE_UINT64, &transfer->size);
-	obex_dbus_dict_append(&dict, "Filename", DBUS_TYPE_STRING,
+
+	if (transfer->filename != NULL)
+		obex_dbus_dict_append(&dict, "Filename", DBUS_TYPE_STRING,
 							&transfer->filename);
 
 	if (transfer->obex != NULL)
diff --git a/doc/client-api.txt b/doc/client-api.txt
index 3c6a2e1..3b5444d 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -299,7 +299,7 @@ Properties	string Name [readonly]
 			Size of the transferred object. If the size is
 			unknown, then this property will not be present.
 
-		string Filename [readonly]
+		string Filename [readonly, optional]
 
 			Complete name of the file being received or sent.
 
-- 
1.7.7.6

