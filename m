Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 2/2] client: Fix invalid write in get_buf_xfer_progress
Date: Mon, 21 Nov 2011 11:36:57 +0100
Message-Id: <1321871817-8498-2-git-send-email-bulislaw@linux.com>
In-Reply-To: <1321871817-8498-1-git-send-email-bulislaw@linux.com>
References: <1321871817-8498-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Segmentation fault occurred when there were no (NULL) params in
obc_session_get, but actual params were returned in response, as
corresponding structure is reused - but not created in the first place.
---
 client/session.c  |    2 +-
 client/transfer.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/session.c b/client/session.c
index f288ecd..e51faf1 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1231,8 +1231,8 @@ int obc_session_get(struct obc_session *session, const char *type,
 	if (session->obex == NULL)
 		return -ENOTCONN;
 
+	params = g_new0(struct obc_transfer_params, 1);
 	if (apparam != NULL) {
-		params = g_new0(struct obc_transfer_params, 1);
 		params->data = g_new(guint8, apparam_size);
 		memcpy(params->data, apparam, apparam_size);
 		params->size = apparam_size;
diff --git a/client/transfer.c b/client/transfer.c
index e072a42..8340cc3 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -536,7 +536,7 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 		g_obex_packet_add_bytes(req, G_OBEX_HDR_TYPE, transfer->type,
 						strlen(transfer->type) + 1);
 
-	if (transfer->params != NULL)
+	if (transfer->params != NULL && transfer->params->size != 0)
 		g_obex_packet_add_bytes(req, G_OBEX_HDR_APPARAM,
 						transfer->params->data,
 						transfer->params->size);
-- 
1.7.4.1

