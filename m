Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Nagaraj D R <nagaraj.dr@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>,
        Nagaraj D R <nagaraj.dr@samsung.com>
Subject: [PATCH] src/device.c : Fix BREDR-ATT MTU issue
Date: Wed, 02 May 2018 13:46:25 +0530
Message-id: <1525248985-10990-1-git-send-email-nagaraj.dr@samsung.com>
References: <CGME20180502081635epcas2p170eb2b4ed9336425921119b66e554fef@epcas2p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For BREDR-ATT, according to spec, ATT MTU is same has
L2CAP configured MTU on which ATT is running. So, set the MTU to
L2CAP configuration and for LE-ATT adjust the ATT MTU based on
EXCHANGE_MTU request and response.
---
 src/device.c              | 2 +-
 src/shared/gatt-helpers.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index f693b70..cf4c8df 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4922,7 +4922,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	}
 
 	dev->att_mtu = MIN(mtu, BT_ATT_MAX_LE_MTU);
-	attrib = g_attrib_new(io, BT_ATT_DEFAULT_LE_MTU, false);
+	attrib = g_attrib_new(io, dev->att_mtu, false);
 	if (!attrib) {
 		error("Unable to create new GAttrib instance");
 		return false;
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 6b39bb1..8ec65be 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -517,6 +517,7 @@ static void mtu_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
+		bt_att_set_mtu(op->att, BT_ATT_DEFAULT_LE_MTU);
 		goto done;
 	}
 
-- 
1.9.1

