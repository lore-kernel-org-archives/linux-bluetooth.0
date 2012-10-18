Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [RFC 2/6] sap: Fix usage of wrong struct in get_properties()
Date: Thu, 18 Oct 2012 19:03:47 -0300
Message-Id: <1350597831-28380-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 profiles/sap/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 9a7cb72..cbe00b9 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1294,7 +1294,8 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *get_properties(DBusConnection *c,
 				DBusMessage *msg, void *data)
 {
-	struct sap_connection *conn = data;
+	struct sap_server *server = data;
+	struct sap_connection *conn = server->conn;
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
-- 
1.7.12.3

