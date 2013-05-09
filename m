Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 02/26] obexd: Get rid of gint64
Date: Thu,  9 May 2013 01:16:32 -0300
Message-Id: <1368073016-28434-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use C99's int64_t.
---
 obexd/client/transfer.c | 8 ++++----
 obexd/client/transfer.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 4b1def3..ac0909d 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -80,9 +80,9 @@ struct obc_transfer {
 	char *type;		/* Transfer object type */
 	int fd;
 	guint xfer;
-	gint64 size;
-	gint64 transferred;
-	gint64 progress;
+	int64_t size;
+	int64_t transferred;
+	int64_t progress;
 	guint progress_id;
 };
 
@@ -850,7 +850,7 @@ const char *obc_transfer_get_path(struct obc_transfer *transfer)
 	return transfer->path;
 }
 
-gint64 obc_transfer_get_size(struct obc_transfer *transfer)
+int64_t obc_transfer_get_size(struct obc_transfer *transfer)
 {
 	return transfer->size;
 }
diff --git a/obexd/client/transfer.h b/obexd/client/transfer.h
index 0d54733..474900b 100644
--- a/obexd/client/transfer.h
+++ b/obexd/client/transfer.h
@@ -24,6 +24,7 @@
 
 #include <dbus/dbus.h>
 #include <glib.h>
+#include <inttypes.h>
 #include <stdlib.h>
 
 struct obc_transfer;
@@ -60,7 +61,7 @@ int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
 								size_t *size);
 
 const char *obc_transfer_get_path(struct obc_transfer *transfer);
-gint64 obc_transfer_get_size(struct obc_transfer *transfer);
+int64_t obc_transfer_get_size(struct obc_transfer *transfer);
 
 DBusMessage *obc_transfer_create_dbus_reply(struct obc_transfer *transfer,
 							DBusMessage *message);
-- 
1.8.2.2

