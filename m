Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Handle security level 4 for L2CAP connections
Date: Sat, 11 Jan 2014 13:44:00 -0800
Message-Id: <1389476641-28084-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the introduction of security level 4, the L2CAP sockets need to
be made aware of this new level. This change ensures that the pairing
requirements are set correctly for these connections.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 11 ++++++++---
 net/bluetooth/l2cap_sock.c    | 10 ++++++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index dbc4a89984ca..c695083eee2b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -91,6 +91,7 @@ struct l2cap_conninfo {
 #define L2CAP_LM_TRUSTED	0x0008
 #define L2CAP_LM_RELIABLE	0x0010
 #define L2CAP_LM_SECURE		0x0020
+#define L2CAP_LM_FIPS		0x0040
 
 /* L2CAP command codes */
 #define L2CAP_COMMAND_REJ	0x01
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b0ad2c752d73..3f0dd552cb2b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -737,6 +737,7 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 	case L2CAP_CHAN_RAW:
 		switch (chan->sec_level) {
 		case BT_SECURITY_HIGH:
+		case BT_SECURITY_FIPS:
 			return HCI_AT_DEDICATED_BONDING_MITM;
 		case BT_SECURITY_MEDIUM:
 			return HCI_AT_DEDICATED_BONDING;
@@ -749,7 +750,8 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 			if (chan->sec_level == BT_SECURITY_LOW)
 				chan->sec_level = BT_SECURITY_SDP;
 		}
-		if (chan->sec_level == BT_SECURITY_HIGH)
+		if (chan->sec_level == BT_SECURITY_HIGH ||
+		    chan->sec_level == BT_SECURITY_FIPS)
 			return HCI_AT_NO_BONDING_MITM;
 		else
 			return HCI_AT_NO_BONDING;
@@ -759,7 +761,8 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 			if (chan->sec_level == BT_SECURITY_LOW)
 				chan->sec_level = BT_SECURITY_SDP;
 
-			if (chan->sec_level == BT_SECURITY_HIGH)
+			if (chan->sec_level == BT_SECURITY_HIGH ||
+			    chan->sec_level == BT_SECURITY_FIPS)
 				return HCI_AT_NO_BONDING_MITM;
 			else
 				return HCI_AT_NO_BONDING;
@@ -768,6 +771,7 @@ static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 	default:
 		switch (chan->sec_level) {
 		case BT_SECURITY_HIGH:
+		case BT_SECURITY_FIPS:
 			return HCI_AT_GENERAL_BONDING_MITM;
 		case BT_SECURITY_MEDIUM:
 			return HCI_AT_GENERAL_BONDING;
@@ -7206,7 +7210,8 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 	if (encrypt == 0x00) {
 		if (chan->sec_level == BT_SECURITY_MEDIUM) {
 			__set_chan_timer(chan, L2CAP_ENC_TIMEOUT);
-		} else if (chan->sec_level == BT_SECURITY_HIGH)
+		} else if (chan->sec_level == BT_SECURITY_HIGH ||
+			   chan->sec_level == BT_SECURITY_FIPS)
 			l2cap_chan_close(chan, ECONNREFUSED);
 	} else {
 		if (chan->sec_level == BT_SECURITY_MEDIUM)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 20ef748b2906..4aa6704f0b33 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -432,6 +432,10 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 			opt = L2CAP_LM_AUTH | L2CAP_LM_ENCRYPT |
 			      L2CAP_LM_SECURE;
 			break;
+		case BT_SECURITY_FIPS:
+			opt = L2CAP_LM_AUTH | L2CAP_LM_ENCRYPT |
+			      L2CAP_LM_SECURE | L2CAP_LM_FIPS;
+			break;
 		default:
 			opt = 0;
 			break;
@@ -445,6 +449,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 
 		if (put_user(opt, (u32 __user *) optval))
 			err = -EFAULT;
+
 		break;
 
 	case L2CAP_CONNINFO:
@@ -699,6 +704,11 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		if (opt & L2CAP_LM_FIPS) {
+			err = -EINVAL;
+			break;
+		}
+
 		if (opt & L2CAP_LM_AUTH)
 			chan->sec_level = BT_SECURITY_LOW;
 		if (opt & L2CAP_LM_ENCRYPT)
-- 
1.8.4.2

