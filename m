Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 1/6] network: Remove duplicated search
Date: Mon, 27 May 2013 14:04:04 +0200
Message-Id: <1369656249-27980-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Commit 0624791ea6e917d6c9ecb8e7e6e5a1327199448d seems to accidentally
have introduced this duplicated search as part of a non-trivial revert.
---
 profiles/network/connection.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 9481072..84f3dd6 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -433,10 +433,6 @@ static DBusMessage *local_connect(DBusConnection *conn,
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
-	nc = find_connection(peer->connections, id);
-	if (!nc)
-		return btd_error_failed(msg, strerror(-err));
-
 	nc->connect = dbus_message_ref(msg);
 
 	return NULL;
-- 
1.8.1.4

