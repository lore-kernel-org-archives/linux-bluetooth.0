Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 1/4] client: add obc_transfer_set_filename
Date: Wed,  7 Mar 2012 15:50:26 +0100
Message-Id: <1331131829-28509-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331131829-28509-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This is just a setter for the filename field in transfers.
---
 client/transfer.c |    7 +++++++
 client/transfer.h |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index d1edef2..3471655 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -645,6 +645,13 @@ void obc_transfer_set_name(struct obc_transfer *transfer, const char *name)
 	transfer->name = g_strdup(name);
 }
 
+void obc_transfer_set_filename(struct obc_transfer *transfer,
+					const char *filename)
+{
+	g_free(transfer->filename);
+	transfer->filename = g_strdup(filename);
+}
+
 const char *obc_transfer_get_path(struct obc_transfer *transfer)
 {
 	return transfer->path;
diff --git a/client/transfer.h b/client/transfer.h
index e7e1000..da7d151 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -56,6 +56,8 @@ void obc_transfer_set_buffer(struct obc_transfer *transfer, char *buffer);
 void obc_transfer_clear_buffer(struct obc_transfer *transfer);
 
 void obc_transfer_set_name(struct obc_transfer *transfer, const char *name);
+void obc_transfer_set_filename(struct obc_transfer *transfer,
+					const char *filename);
 const char *obc_transfer_get_path(struct obc_transfer *transfer);
 gint64 obc_transfer_get_size(struct obc_transfer *transfer);
 int obc_transfer_set_file(struct obc_transfer *transfer);
-- 
1.7.6.5

