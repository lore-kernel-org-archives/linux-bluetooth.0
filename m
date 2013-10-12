Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Allow 3D profile to use security mode 4 level 0
Date: Sat, 12 Oct 2013 07:19:32 -0700
Message-Id: <1381587572-63593-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The PSM 0x0021 is dedicated to the 3D profile and has permission to
use security mode 4 level 0 for L2CAP connectionless unicast data
transfers.

When establishing a L2CAP connectionless channel on PSM 0x0021, it
will no longer force Secure Simple Pairing.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 10 ++++++++++
 net/bluetooth/l2cap_sock.c    |  4 ++++
 3 files changed, 15 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f141b5f..12523c7 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -237,6 +237,7 @@ struct l2cap_conn_rsp {
 /* protocol/service multiplexer (PSM) */
 #define L2CAP_PSM_SDP		0x0001
 #define L2CAP_PSM_RFCOMM	0x0003
+#define L2CAP_PSM_3DSP		0x0021
 
 /* channel indentifier */
 #define L2CAP_CID_SIGNALING	0x0001
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cc51cb8..e932ffd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -688,6 +688,16 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 			return HCI_AT_NO_BONDING;
 		}
 		break;
+	case L2CAP_CHAN_CONN_LESS:
+		if (chan->psm == __constant_cpu_to_le16(L2CAP_PSM_3DSP)) {
+			if (chan->sec_level == BT_SECURITY_LOW)
+				chan->sec_level = BT_SECURITY_SDP;
+		}
+		if (chan->sec_level == BT_SECURITY_HIGH)
+			return HCI_AT_NO_BONDING_MITM;
+		else
+			return HCI_AT_NO_BONDING;
+		break;
 	case L2CAP_CHAN_CONN_ORIENTED:
 		if (chan->psm == __constant_cpu_to_le16(L2CAP_PSM_SDP)) {
 			if (chan->sec_level == BT_SECURITY_LOW)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index bee98eb..bd6fe7f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -101,6 +101,10 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		goto done;
 
 	switch (chan->chan_type) {
+	case L2CAP_CHAN_CONN_LESS:
+		if (__le16_to_cpu(la.l2_psm) == L2CAP_PSM_3DSP)
+			chan->sec_level = BT_SECURITY_SDP;
+		break;
 	case L2CAP_CHAN_CONN_ORIENTED:
 		if (__le16_to_cpu(la.l2_psm) == L2CAP_PSM_SDP ||
 		    __le16_to_cpu(la.l2_psm) == L2CAP_PSM_RFCOMM)
-- 
1.8.3.1

