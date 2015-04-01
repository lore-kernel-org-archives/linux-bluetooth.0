Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/4] Bluetooth: bnep: Handle BNEP connection setup request
Date: Wed,  1 Apr 2015 16:24:15 +0200
Message-Id: <1427898255-27496-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1427898255-27496-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427898255-27496-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch kernel will be able to handle setup request. This is
needed if we would like to handle control mesages with extension
headers. User space will be only resposible for reading setup data and
checking if scenario is conformance to specification (dst and src device
bnep role). In case of new user space, setup data must be leaved(peek
msg) on queue. New bnep session will be responsible for handling this
data.

Signed-off-by: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
---
 net/bluetooth/bnep/bnep.h |  3 +++
 net/bluetooth/bnep/core.c | 10 +++++++++-
 net/bluetooth/bnep/sock.c |  2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
index 8709733..40854c9 100644
--- a/net/bluetooth/bnep/bnep.h
+++ b/net/bluetooth/bnep/bnep.h
@@ -113,6 +113,9 @@ struct bnep_ext_hdr {
 #define BNEPGETCONNINFO	_IOR('B', 211, int)
 #define BNEPGETSUPPFEAT	_IOR('B', 212, int)
 
+#define BNEP_SETUP_RESPONSE	0
+#define BNEP_SETUP_RSP_SENT	10
+
 struct bnep_connadd_req {
 	int   sock;		/* Connected socket */
 	__u32 flags;
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 77ae725..2135b89 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -231,7 +231,14 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 		break;
 
 	case BNEP_SETUP_CONN_REQ:
-		err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP, BNEP_CONN_NOT_ALLOWED);
+		/* Successful response should be sent only once */
+		if (test_bit(BNEP_SETUP_RESPONSE, &s->flags) &&
+		    !test_and_set_bit(BNEP_SETUP_RSP_SENT, &s->flags))
+			err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP,
+					    BNEP_SUCCESS);
+		else
+			err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP,
+					    BNEP_CONN_NOT_ALLOWED);
 		break;
 
 	default: {
@@ -592,6 +599,7 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	s->sock  = sock;
 	s->role  = req->role;
 	s->state = BT_CONNECTED;
+	s->flags = req->flags & (1 << BNEP_SETUP_RESPONSE);
 
 	s->msg.msg_flags = MSG_NOSIGNAL;
 
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index f18b6bd..116e7d3 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -58,7 +58,7 @@ static int bnep_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 	struct socket *nsock;
 	void __user *argp = (void __user *)arg;
 	int err;
-	const __u32 supp_feat = 0;
+	const __u32 supp_feat = BIT(BNEP_SETUP_RESPONSE);
 
 
 	BT_DBG("cmd %x arg %lx", cmd, arg);
-- 
2.1.0

