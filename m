Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Handle security level 4 for RFCOMM connections
Date: Sat, 11 Jan 2014 13:44:01 -0800
Message-Id: <1389476641-28084-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the introduction of security level 4, the RFCOMM sockets need to
be made aware of this new level. This change ensures that the pairing
requirements are set correctly for these connections.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/rfcomm.h |  1 +
 net/bluetooth/rfcomm/core.c    |  4 +++-
 net/bluetooth/rfcomm/sock.c    | 12 +++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 486213a1aed8..c312cfc4e922 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -295,6 +295,7 @@ struct rfcomm_conninfo {
 #define RFCOMM_LM_TRUSTED	0x0008
 #define RFCOMM_LM_RELIABLE	0x0010
 #define RFCOMM_LM_SECURE	0x0020
+#define RFCOMM_LM_FIPS		0x0040
 
 #define rfcomm_pi(sk) ((struct rfcomm_pinfo *) sk)
 
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index facd8a79c038..ba115d472f7b 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -216,6 +216,7 @@ static int rfcomm_check_security(struct rfcomm_dlc *d)
 
 	switch (d->sec_level) {
 	case BT_SECURITY_HIGH:
+	case BT_SECURITY_FIPS:
 		auth_type = HCI_AT_GENERAL_BONDING_MITM;
 		break;
 	case BT_SECURITY_MEDIUM:
@@ -2085,7 +2086,8 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 				set_bit(RFCOMM_SEC_PENDING, &d->flags);
 				rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
 				continue;
-			} else if (d->sec_level == BT_SECURITY_HIGH) {
+			} else if (d->sec_level == BT_SECURITY_HIGH ||
+				   d->sec_level == BT_SECURITY_FIPS) {
 				set_bit(RFCOMM_ENC_DROP, &d->flags);
 				continue;
 			}
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3c2d3e4aa2f5..fb8158af1f39 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -648,6 +648,11 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname, char __u
 			break;
 		}
 
+		if (opt & RFCOMM_LM_FIPS) {
+			err = -EINVAL;
+			break;
+		}
+
 		if (opt & RFCOMM_LM_AUTH)
 			rfcomm_pi(sk)->sec_level = BT_SECURITY_LOW;
 		if (opt & RFCOMM_LM_ENCRYPT)
@@ -762,7 +767,11 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 			break;
 		case BT_SECURITY_HIGH:
 			opt = RFCOMM_LM_AUTH | RFCOMM_LM_ENCRYPT |
-							RFCOMM_LM_SECURE;
+			      RFCOMM_LM_SECURE;
+			break;
+		case BT_SECURITY_FIPS:
+			opt = RFCOMM_LM_AUTH | RFCOMM_LM_ENCRYPT |
+			      RFCOMM_LM_SECURE | RFCOMM_LM_FIPS;
 			break;
 		default:
 			opt = 0;
@@ -774,6 +783,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 
 		if (put_user(opt, (u32 __user *) optval))
 			err = -EFAULT;
+
 		break;
 
 	case RFCOMM_CONNINFO:
-- 
1.8.4.2

