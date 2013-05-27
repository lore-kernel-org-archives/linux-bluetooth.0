Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 2/6] network: Fix missing NULL check for given UUID
Date: Mon, 27 May 2013 14:04:05 +0200
Message-Id: <1369656249-27980-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369656249-27980-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The code dereferences a NULL pointer if find_connection() doesn't find
an existing connection, which will be the case if the input UUID is
invalid or not supported.
---
 profiles/network/connection.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 84f3dd6..bac3b69 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -426,7 +426,10 @@ static DBusMessage *local_connect(DBusConnection *conn,
 	id = bnep_service_id(svc);
 
 	nc = find_connection(peer->connections, id);
-	if (nc && nc->connect)
+	if (nc == NULL)
+		return btd_error_invalid_args(msg);
+
+	if (nc->connect != NULL)
 		return btd_error_busy(msg);
 
 	err = connection_connect(nc->service);
-- 
1.8.1.4

