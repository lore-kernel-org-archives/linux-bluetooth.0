Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 6/6] gas: Only do the Exchange MTU procedure over LE links
Date: Wed, 10 Oct 2012 20:35:03 -0300
Message-Id: <1349912103-663-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1349912103-663-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1349912103-663-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Exchange MTU procedure should only be performed over LE links,
we are using the check of the Channel ID used to verify this.
---
 profiles/gatt/gas.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 74ca9ce..f873121 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -326,7 +326,8 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 	io = g_attrib_get_channel(attrib);
 
 	if (bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu,
-				BT_IO_OPT_CID, &cid, BT_IO_OPT_INVALID)) {
+				BT_IO_OPT_CID, &cid, BT_IO_OPT_INVALID) &&
+							cid == ATT_CID) {
 		gatt_exchange_mtu(gas->attrib, imtu, exchange_mtu_cb, gas);
 		gas->mtu = imtu;
 		DBG("MTU Exchange: Requesting %d", imtu);
-- 
1.7.12.3

