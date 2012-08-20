Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 10/10] gatt: Add MTU exchange procedure
Date: Mon, 20 Aug 2012 14:22:55 -0300
Message-Id: <1345483375-27621-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483375-27621-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT Exchange MTU is a procedure defined by the Generic Attribute
Profile, it is not related to the remote GATT primary service. However,
gatt plugin is the most suitable place to manage this procedure.
---
 profiles/gatt/gas.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index de23a13..61e6745 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -32,6 +32,7 @@
 #include "att.h"
 #include "gattrib.h"
 #include "attio.h"
+#include "btio.h"
 #include "gatt.h"
 #include "log.h"
 #include "gas.h"
@@ -46,6 +47,7 @@ struct gas {
 	guint attioid;
 	guint changed_ind;
 	uint16_t changed_handle;
+	uint16_t mtu;
 };
 
 static GSList *devices = NULL;
@@ -250,12 +252,46 @@ static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
 	gatt_find_info(gas->attrib, start, end, gatt_descriptors_cb, gas);
 }
 
+static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gas *gas = user_data;
+	uint16_t rmtu;
+
+	if (status) {
+		error("MTU exchange: %s", att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_mtu_resp(pdu, plen, &rmtu)) {
+		error("MTU exchange: protocol error");
+		return;
+	}
+
+	gas->mtu = MIN(rmtu, gas->mtu);
+	if (g_attrib_set_mtu(gas->attrib, gas->mtu))
+		DBG("MTU exchange succeeded: %d", gas->mtu);
+	else
+		DBG("MTU exchange failed");
+}
+
 static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct gas *gas = user_data;
+	GIOChannel *io;
+	GError *gerr = NULL;
+	uint16_t cid, imtu;
 	uint16_t app;
 
 	gas->attrib = g_attrib_ref(attrib);
+	io = g_attrib_get_channel(attrib);
+
+	if (bt_io_get(io, BT_IO_L2CAP, &gerr, BT_IO_OPT_IMTU, &imtu,
+				BT_IO_OPT_CID, &cid, BT_IO_OPT_INVALID)) {
+		gatt_exchange_mtu(gas->attrib, imtu, exchange_mtu_cb, gas);
+		gas->mtu = imtu;
+		DBG("MTU Exchange: Requesting %d", imtu);
+	}
 
 	gas->changed_ind = g_attrib_register(gas->attrib, ATT_OP_HANDLE_IND,
 						indication_cb, gas, NULL);
-- 
1.7.8.6

