Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 1/6] client: Fix possible double free of params
Date: Fri,  4 May 2012 14:39:33 +0200
Message-Id: <1336135178-21707-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336135178-21707-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

obc_transfer_get() and obc_transfer_put() should only assume ownership
of the given params only in case of success. Otherwise some erros might
result in a double free of such memory.
---
 client/transfer.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 411a7c0..58baa85 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -229,7 +229,6 @@ static struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 						const char *filename,
 						const char *name,
 						const char *type,
-						struct obc_transfer_params *params,
 						GError **err)
 {
 	struct obc_transfer *transfer;
@@ -240,7 +239,6 @@ static struct obc_transfer *obc_transfer_register(DBusConnection *conn,
 	transfer->filename = g_strdup(filename);
 	transfer->name = g_strdup(name);
 	transfer->type = g_strdup(type);
-	transfer->params = params;
 
 	/* for OBEX specific mime types we don't need to register a transfer */
 	if (type != NULL &&
@@ -319,7 +317,7 @@ struct obc_transfer *obc_transfer_get(DBusConnection *conn,
 	int perr;
 
 	transfer = obc_transfer_register(conn, agent, G_OBEX_OP_GET, filename,
-						name, type, params, err);
+							name, type, err);
 	if (transfer == NULL)
 		return NULL;
 
@@ -329,6 +327,8 @@ struct obc_transfer *obc_transfer_get(DBusConnection *conn,
 		return NULL;
 	}
 
+	transfer->params = params;
+
 	return transfer;
 }
 
@@ -347,7 +347,7 @@ struct obc_transfer *obc_transfer_put(DBusConnection *conn,
 	int perr;
 
 	transfer = obc_transfer_register(conn, agent, G_OBEX_OP_PUT, filename,
-						name, type, params, err);
+							name, type, err);
 	if (transfer == NULL)
 		return NULL;
 
@@ -381,6 +381,7 @@ struct obc_transfer *obc_transfer_put(DBusConnection *conn,
 	}
 
 	transfer->size = st.st_size;
+	transfer->params = params;
 
 	return transfer;
 
-- 
1.7.7.6

