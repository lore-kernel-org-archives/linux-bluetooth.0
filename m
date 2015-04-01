Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/4] Bluetooth: bnep: Add support for get bnep features via ioctl
Date: Wed,  1 Apr 2015 16:24:13 +0200
Message-Id: <1427898255-27496-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1427898255-27496-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427898255-27496-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed if user space wants to know supported bnep features
by kernel, e.g. if kernel supports sending response to bnep setup
control message. By now there is no possibility to know supported
features by kernel in case of bnep. Ioctls allows only to add connection,
delete connection, get connection list, get connection info. Adding
connection if it's possible (establishing network device connection) is
equivalent to starting bnep session. Bnep session handles data queue of
transmit, receive messages over bnep channel. It means that if we add
connection the received/transmitted data will be parsed immediately. In
case of get bnep features we want to know before session start, if we
should leave setup data on socket queue and let kernel to handle with it,
or in case of no setup handling support, if we should pull this message
and handle setup response within user space.

Signed-off-by: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
---
 fs/compat_ioctl.c         | 1 +
 net/bluetooth/bnep/bnep.h | 1 +
 net/bluetooth/bnep/sock.c | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index afec645..19fb0c8 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -570,6 +570,7 @@ static int mt_ioctl_trans(unsigned int fd, unsigned int cmd, void __user *argp)
 #define BNEPCONNDEL	_IOW('B', 201, int)
 #define BNEPGETCONNLIST	_IOR('B', 210, int)
 #define BNEPGETCONNINFO	_IOR('B', 211, int)
+#define BNEPGETSUPPFEAT	_IOR('B', 212, int)
 
 #define CMTPCONNADD	_IOW('C', 200, int)
 #define CMTPCONNDEL	_IOW('C', 201, int)
diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
index 5a5b16f..8709733 100644
--- a/net/bluetooth/bnep/bnep.h
+++ b/net/bluetooth/bnep/bnep.h
@@ -111,6 +111,7 @@ struct bnep_ext_hdr {
 #define BNEPCONNDEL	_IOW('B', 201, int)
 #define BNEPGETCONNLIST	_IOR('B', 210, int)
 #define BNEPGETCONNINFO	_IOR('B', 211, int)
+#define BNEPGETSUPPFEAT	_IOR('B', 212, int)
 
 struct bnep_connadd_req {
 	int   sock;		/* Connected socket */
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index 5f05129..f18b6bd 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -58,6 +58,8 @@ static int bnep_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 	struct socket *nsock;
 	void __user *argp = (void __user *)arg;
 	int err;
+	const __u32 supp_feat = 0;
+
 
 	BT_DBG("cmd %x arg %lx", cmd, arg);
 
@@ -120,6 +122,12 @@ static int bnep_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 
 		return err;
 
+	case BNEPGETSUPPFEAT:
+		if (copy_to_user(argp, &supp_feat, sizeof(supp_feat)))
+			return -EFAULT;
+
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
-- 
2.1.0

