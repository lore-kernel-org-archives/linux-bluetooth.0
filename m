Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 12/14] client: Expose all transfers in D-Bus
Date: Wed, 30 May 2012 17:50:21 +0200
Message-Id: <1338393023-29941-13-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Relying on a internal policy (based on transfer type) to decide if a
transfer should be exposed or not in D-Bus has some limitations. The
simplest possible alternative to this is to expose all transfers in
D-Bus, assuming the overhead is not significant.
---
 client/transfer.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index a14624d..c073612 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -263,12 +263,6 @@ gboolean obc_transfer_register(struct obc_transfer *transfer,
 						const char *owner,
 						GError **err)
 {
-	/* for OBEX specific mime types we don't need to register a transfer */
-	if (transfer->type != NULL &&
-			(strncmp(transfer->type, "x-obex/", 7) == 0 ||
-			strncmp(transfer->type, "x-bt/", 5) == 0))
-		goto done;
-
 	transfer->owner = g_strdup(owner);
 
 	transfer->path = g_strdup_printf("%s/transfer%ju",
@@ -290,7 +284,6 @@ gboolean obc_transfer_register(struct obc_transfer *transfer,
 		return FALSE;
 	}
 
-done:
 	DBG("%p registered %s", transfer, transfer->path);
 
 	return TRUE;
-- 
1.7.7.6

