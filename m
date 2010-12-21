Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3] Remove unneeded variable
Date: Tue, 21 Dec 2010 08:02:48 -0400
Message-Id: <1292932968-3951-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1292885388-21703-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1292885388-21703-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 src/glib-helper.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/glib-helper.c b/src/glib-helper.c
index 0233eb7..bf39a83 100644
--- a/src/glib-helper.c
+++ b/src/glib-helper.c
@@ -514,7 +514,6 @@ int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 {
 	struct gattrib_context *ctxt;
 	GIOChannel *io;
-	GError *gerr = NULL;
 
 	ctxt = g_try_new0(struct gattrib_context, 1);
 	if (ctxt == NULL)
@@ -527,14 +526,14 @@ int bt_discover_primary(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 	ctxt->destroy = destroy;
 
 	if (psm < 0)
-		io = bt_io_connect(BT_IO_L2CAP, connect_cb, ctxt, NULL, &gerr,
+		io = bt_io_connect(BT_IO_L2CAP, connect_cb, ctxt, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_DEST_BDADDR, dst,
 				BT_IO_OPT_CID, GATT_CID,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 				BT_IO_OPT_INVALID);
 	else
-		io = bt_io_connect(BT_IO_L2CAP, connect_cb, ctxt, NULL, &gerr,
+		io = bt_io_connect(BT_IO_L2CAP, connect_cb, ctxt, NULL, NULL,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_DEST_BDADDR, dst,
 				BT_IO_OPT_PSM, psm,
-- 
1.7.0.4

