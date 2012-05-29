Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 09/17] client: Remove unused functions in transfer API
Date: Tue, 29 May 2012 11:23:14 +0200
Message-Id: <1338283402-11085-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338283402-11085-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338283402-11085-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

After the removal of the agent these functions are not useful any more.
---
 client/transfer.c |   23 -----------------------
 client/transfer.h |    3 ---
 2 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 80a6317..bcafed2 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -753,29 +753,6 @@ int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
 	return 0;
 }
 
-void obc_transfer_set_name(struct obc_transfer *transfer, const char *name)
-{
-	g_free(transfer->name);
-	transfer->name = g_strdup(name);
-}
-
-int obc_transfer_set_filename(struct obc_transfer *transfer,
-					const char *filename)
-{
-	int err;
-
-	err = rename(transfer->filename, filename);
-	if (err < 0) {
-		error("rename(): %s (%d)", strerror(errno), errno);
-		return -errno;
-	}
-
-	g_free(transfer->filename);
-	transfer->filename = g_strdup(filename);
-
-	return 0;
-}
-
 const char *obc_transfer_get_path(struct obc_transfer *transfer)
 {
 	return transfer->path;
diff --git a/client/transfer.h b/client/transfer.h
index a65a2ed..bfa166d 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -56,8 +56,5 @@ const void *obc_transfer_get_params(struct obc_transfer *transfer,
 int obc_transfer_get_contents(struct obc_transfer *transfer, char **contents,
 								size_t *size);
 
-void obc_transfer_set_name(struct obc_transfer *transfer, const char *name);
-int obc_transfer_set_filename(struct obc_transfer *transfer,
-					const char *filename);
 const char *obc_transfer_get_path(struct obc_transfer *transfer);
 gint64 obc_transfer_get_size(struct obc_transfer *transfer);
-- 
1.7.7.6

