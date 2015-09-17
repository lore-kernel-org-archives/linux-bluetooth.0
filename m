Return-Path: <cyrus@holtmann.org>
From: Seungyoun Ju <sy39.ju@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Seungyoun Ju <sy39.ju@samsung.com>
Subject: [PATCH 1/3] Bluetooth: Add L2CAP socket option for connection params
Date: Thu, 17 Sep 2015 15:57:18 +0900
Message-Id: <1442473040-14492-2-git-send-email-sy39.ju@samsung.com>
In-Reply-To: <1442473040-14492-1-git-send-email-sy39.ju@samsung.com>
References: <1442473040-14492-1-git-send-email-sy39.ju@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a L2CAP socket option for LE connection parameters.

Signed-off-by: Seungyoun Ju <sy39.ju@samsung.com>
---
 include/net/bluetooth/bluetooth.h | 8 ++++++++
 net/bluetooth/l2cap_sock.c        | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fcf2ae7..39127fa 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -119,6 +119,14 @@ struct bt_voice {
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
 
+#define BT_CONNECTION_PARAMS	14
+struct bt_connection_params {
+	__u16 min_interval;
+	__u16 max_interval;
+	__u16 latency;
+	__u16 supv_timeout;
+};
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 586b3d5..73a4ce8 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -602,6 +602,9 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_CONNECTION_PARAMS:
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -935,6 +938,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		chan->imtu = opt;
 		break;
 
+	case BT_CONNECTION_PARAMS:
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.1.0

