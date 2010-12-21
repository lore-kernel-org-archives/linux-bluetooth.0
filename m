Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 13/18] Add support for making LE connections to GATT client
Date: Tue, 21 Dec 2010 19:26:35 -0200
Message-Id: <1292966800-6264-14-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now GATT client should be able to make LE connections. The information
used to determine if we should make a LE connection is the psm stored
in the gatt_service structure.
---
 attrib/client.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 0eadf1e..21ce439 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -409,7 +409,15 @@ static int l2cap_connect(struct gatt_service *gatt, GError **gerr,
 	 * Configuration it is necessary to poll the server from time
 	 * to time checking for modifications.
 	 */
-	io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, gerr,
+	if (gatt->psm < 0)
+		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &gatt->sba,
+			BT_IO_OPT_DEST_BDADDR, &gatt->dba,
+			BT_IO_OPT_CID, GATT_CID,
+			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+			BT_IO_OPT_INVALID);
+	else
+		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, gerr,
 			BT_IO_OPT_SOURCE_BDADDR, &gatt->sba,
 			BT_IO_OPT_DEST_BDADDR, &gatt->dba,
 			BT_IO_OPT_PSM, gatt->psm,
-- 
1.7.3.4

