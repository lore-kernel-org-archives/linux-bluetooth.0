Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 2/6] client: Avoid GObex dependency from transfer.h
Date: Thu,  3 May 2012 10:28:26 +0200
Message-Id: <1336033710-2471-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336033710-2471-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336033710-2471-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This workaround makes it possible to include transfer.h from the
modules, without adding a dependency to GObex.
---
 client/transfer.c |    2 +-
 client/transfer.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 89690d0..411a7c0 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -610,7 +610,7 @@ static gboolean transfer_start_put(struct obc_transfer *transfer, GError **err)
 	return TRUE;
 }
 
-gboolean obc_transfer_start(struct obc_transfer *transfer, GObex *obex,
+gboolean obc_transfer_start(struct obc_transfer *transfer, void *obex,
 								GError **err)
 {
 	transfer->obex = g_obex_ref(obex);
diff --git a/client/transfer.h b/client/transfer.h
index f42e21f..1b83d18 100644
--- a/client/transfer.h
+++ b/client/transfer.h
@@ -55,7 +55,7 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 					transfer_callback_t func,
 					void *user_data);
 
-gboolean obc_transfer_start(struct obc_transfer *transfer, GObex *obex,
+gboolean obc_transfer_start(struct obc_transfer *transfer, void *obex,
 								GError **err);
 guint8 obc_transfer_get_operation(struct obc_transfer *transfer);
 
-- 
1.7.7.6

