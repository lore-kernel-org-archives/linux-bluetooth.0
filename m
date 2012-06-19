Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC] Bluetooth: BNEP protocol & multicast filter ioctl
Date: Tue, 19 Jun 2012 18:45:59 +0200
Message-Id: <1340124359-9510-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1340124359-9510-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1340124359-9510-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 net/bluetooth/bnep/bnep.h |   16 ++++++++++++++++
 net/bluetooth/bnep/core.c |   30 ++++++++++++++++++++++++++++++
 net/bluetooth/bnep/sock.c |   30 ++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
index e7ee531..2ccf96c 100644
--- a/net/bluetooth/bnep/bnep.h
+++ b/net/bluetooth/bnep/bnep.h
@@ -112,6 +112,8 @@ struct bnep_ext_hdr {
 #define BNEPCONNDEL	_IOW('B', 201, int)
 #define BNEPGETCONNLIST	_IOR('B', 210, int)
 #define BNEPGETCONNINFO	_IOR('B', 211, int)
+#define BNEPSETNETFILTER _IOR('B', 212, int)
+#define BNEPSETMCFILTER	_IOR('B', 213, int)
 
 struct bnep_connadd_req {
 	int   sock;		/* Connected socket */
@@ -143,10 +145,24 @@ struct bnep_proto_filter {
 	__u16 end;
 };
 
+struct bnep_netfilter_req {
+	int sock;		/* Connected socket */
+	int len;
+	struct bnep_proto_filter proto_filter[BNEP_MAX_PROTO_FILTERS];
+};
+
+struct bnep_mcfilter_req {
+	int sock;		/* Connected socket */
+	int len;
+	unsigned long long mc_filter[BNEP_MAX_MULTICAST_FILTERS];
+};
+
 int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock);
 int bnep_del_connection(struct bnep_conndel_req *req);
 int bnep_get_connlist(struct bnep_connlist_req *req);
 int bnep_get_conninfo(struct bnep_conninfo *ci);
+int bnep_set_mcfilter(struct bnep_mcfilter_req *mf, struct socket *sock);
+int bnep_set_netfilter(struct bnep_netfilter_req *nf, struct socket *sock);
 
 /* BNEP sessions */
 struct bnep_session {
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 4a6620b..3d29eb0 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -689,6 +689,36 @@ int bnep_get_conninfo(struct bnep_conninfo *ci)
 	return err;
 }
 
+#ifdef CONFIG_BT_BNEP_MC_FILTER
+int bnep_set_mcfilter(struct bnep_mcfilter_req *mf, struct socket *sock)
+{
+	struct bnep_session *s;
+	u8 dst[ETH_ALEN], src[ETH_ALEN];
+
+	baswap((void *) dst, &bt_sk(sock->sk)->dst);
+	baswap((void *) src, &bt_sk(sock->sk)->src);
+
+	s = __bnep_get_session(dst);
+
+	return bnep_ctrl_set_mcfilter(s, (void *)mf->mc_filter, mf->len);
+}
+#endif
+
+#ifdef CONFIG_BT_BNEP_PROTO_FILTER
+int bnep_set_netfilter(struct bnep_netfilter_req *nf, struct socket *sock)
+{
+	struct bnep_session *s;
+	u8 dst[ETH_ALEN], src[ETH_ALEN];
+
+	baswap((void *) dst, &bt_sk(sock->sk)->dst);
+	baswap((void *) src, &bt_sk(sock->sk)->src);
+
+	s = __bnep_get_session(dst);
+
+	return bnep_ctrl_set_netfilter(s, (void *)&nf->proto_filter, nf->len);
+}
+#endif
+
 static int __init bnep_init(void)
 {
 	char flt[50] = "";
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index 5e5f5b4..2c58c6b 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -48,6 +48,12 @@ static int bnep_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 	struct bnep_connlist_req cl;
 	struct bnep_connadd_req  ca;
 	struct bnep_conndel_req  cd;
+#ifdef CONFIG_BT_BNEP_PROTO_FILTER
+	struct bnep_netfilter_req  nf;
+#endif
+#ifdef CONFIG_BT_BNEP_MC_FILTER
+	struct bnep_mcfilter_req  mc;
+#endif
 	struct bnep_conninfo ci;
 	struct socket *nsock;
 	void __user *argp = (void __user *)arg;
@@ -114,6 +120,30 @@ static int bnep_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 
 		return err;
 
+#ifdef CONFIG_BT_BNEP_PROTO_FILTER
+	case BNEPSETNETFILTER:
+		if (copy_from_user(&nf, argp, sizeof(nf)))
+			return -EFAULT;
+
+		nsock = sockfd_lookup(nf.sock, &err);
+		if (!nsock)
+			return err;
+
+		return bnep_set_netfilter(&nf, nsock);
+#endif
+
+#ifdef CONFIG_BT_BNEP_MC_FILTER
+	case BNEPSETMCFILTER:
+		if (copy_from_user(&mc, argp, sizeof(mc)))
+			return -EFAULT;
+
+		nsock = sockfd_lookup(mc.sock, &err);
+		if (!nsock)
+			return err;
+
+		return bnep_set_mcfilter(&mc, nsock);
+#endif
+
 	default:
 		return -EINVAL;
 	}
-- 
1.7.9.5

