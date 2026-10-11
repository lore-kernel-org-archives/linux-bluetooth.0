Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB952455621;
	Sun, 11 Oct 2026 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751221; cv=pass; b=l+cBDa54HEOSSsTkNgrI8xRKP6Ys1aSae5hyIEsK7VUDQL76dDtGtdNOW10J+RUCpO5XjWDBC9ygNlukBhrRcFiUdjsU0kCneMr5crZsBaiJ6bxbkom3sRrI8QcBdoK+nehPp1Zq7AhQWzUMEKxoEGXT9x5QeZa05hV4UDDuYzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751221; c=relaxed/simple;
	bh=aSkVWwsC25s8fEGIBYT5QEO8eUTiIoSS7nh/6+MP5u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrRa32wG5ecaIGtR/N2j3ZL1mgPWnHxfNaFM74LOnNJtwamsU5BCTidtiNVwrbRriTYsEL5ms/sIYNcMEkE2eLonb2ZXRPiKL0I0ui+dSYw2fE9A5uHU47UP1xB5f3msQNjH0KFjooBqc5LJztNSFSkAvanKHTTK8D/2yPgMBNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=c35217oD; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="c35217oD"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j2st53NT5zyw3;
	Sun, 11 Oct 2026 23:40:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791751213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZAP3fqLrffDEDIBuYEvRIPQibTtr2Y3AAmzR/zhoZQ=;
	b=c35217oD977JTpUVVMRWoyhaaNdKuL5tbx+WpxtgrvYEFgruGQZCxA7odDMlcGW8jWX9cN
	2MAObRXEDoXUcxwZCU56Iv4nH0IOJiOq1KRjictWRMI38xdNpVUr6UY3PCKBgTuEBevDgr
	JI5Q3nXPpDH33y1OethjOszRO0+MHD8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791751213;
	b=gKk4cjgkLFECN6VFBoGtp64+YCGSRrXbY+QfIK9ovzYXa61CScD9rMk8JQszUI79gYdecE
	iEaslCDS0WWZkOPSAtm6AbyKjyDVIyo8w8aD0x9/on32zOQCezaNId2Fv/V0G85/kRqZiu
	QN08/9LYy3/xnNAPdGf59DDTB+nrveM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791751213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZAP3fqLrffDEDIBuYEvRIPQibTtr2Y3AAmzR/zhoZQ=;
	b=f6eHb4Ph7dw3+yMPGYoU/vDUFs1U15cC+dSmQh0VFi9V0M1VIE7EABgdXK58bgwihyr+cs
	VLLjrrfXbmJnqJdTEktnmOeRefU/JE/NKk9urCD0fnqAofoqsGCe4EeCIJXbIB5MtPjrup
	DzkyIDRgbfgNgzpUrhFD21Z97i62/6Q=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: ISO: Signal BIS PAST ready to userspace via POLLOUT
Date: Sun, 11 Oct 2026 23:39:55 +0300
Message-ID: <d08ab146735f556c17c24b29f7dddeb092c3cf5c.1791750397.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791750397.git.pav@iki.fi>
References: <cover.1791750397.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace needs to know when kernel is ready to handle LE PAST Received.
E.g. Scan Delegator should indicate PAST ready only after that (cf. BAP
v1.0.2 Sec 6.5.6).

Currently applications call listen(sk) to setup it, but kernel hci_sync
may be ready only some time after syscall return.

Add POLLOUT as notify for kernel ready for PAST after BIS socket
listen(). POLLOUT is not signaled for errors. Add BT_ISO_PAST_POLLOUT
socket option to indicate feature support.

POLLOUT was never set for Bluetooth listen sockets before, so this is
previously unused API. POSIX does not appear to specify behavior. This
only changes ISO BIS socket behavior. The API is vaguely similar to the
POLLOUT indicator for connect().

Assisted-by: opencode:qwen3.8-flash-next
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/bluetooth.h |  2 ++
 net/bluetooth/hci_sync.c          | 22 ++++++++++++---
 net/bluetooth/iso.c               | 45 +++++++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index cd9189244566..d78e34c0e5ef 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -256,6 +256,8 @@ struct bt_codecs {
 
 #define BT_SCM_PKT_SEQNUM	0x05
 
+#define BT_ISO_PAST_POLLOUT	23
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 058daf1f16df..ccf71e242677 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7680,6 +7680,21 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 	hci_conn_put(conn);
 }
 
+static void hci_le_past_wait_ready(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	if (err)
+		return;
+
+	/* Inform socket layer we are waiting for LE PAST Received */
+	hci_dev_lock(hdev);
+	if (hci_conn_valid(hdev, conn) &&
+	    test_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags))
+		hci_connect_cfm(conn, 0);
+	hci_dev_unlock(hdev);
+}
+
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
 				   u16 acl_handle, struct bt_iso_qos *qos)
 {
@@ -7706,9 +7721,10 @@ static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
 		return err;
 
 	/* Wait for HCI_EV_LE_PAST_RECEIVED event */
-	return __hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
-					HCI_EV_LE_PAST_RECEIVED,
-					conn->conn_timeout, NULL);
+	return __hci_cmd_sync_status_sk_run(hdev, HCI_OP_NOP, 0, NULL,
+					    HCI_EV_LE_PAST_RECEIVED,
+					    conn->conn_timeout, NULL,
+					    hci_le_past_wait_ready, conn);
 }
 
 static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index c1fdd9846eeb..6afbeb699386 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -62,6 +62,7 @@ enum {
 	BT_SK_PA_SYNC,
 	BT_SK_KILLED,
 	BT_SK_CONNECTING,
+	BT_SK_PAST_READY,
 };
 
 struct iso_pinfo {
@@ -2035,6 +2036,10 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_ISO_PAST_POLLOUT:
+		err = -EINVAL;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -2106,6 +2111,13 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_ISO_PAST_POLLOUT:
+		val = 1;
+		if (copy_to_iter(&val, sizeof(val), &opt->iter_out) !=
+		    sizeof(val))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -2278,6 +2290,16 @@ static void iso_conn_ready(struct iso_conn *conn)
 			}
 		}
 
+		/* PA sync listen socket notification for PAST ready */
+		if (conn->hcon->type == PA_LINK &&
+		    test_bit(HCI_CONN_CREATE_PA_SYNC, &conn->hcon->flags)) {
+			set_bit(BT_SK_PAST_READY, &iso_pi(sk)->flags);
+			sk->sk_state_change(sk);
+			release_sock(sk);
+			sock_put(sk);
+			return;
+		}
+
 		iso_sock_ready(sk);
 
 		release_sock(sk);
@@ -2289,7 +2311,10 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 		hdev = hcon->hdev;
 
-		if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags)) {
+		if (test_bit(HCI_CONN_CREATE_PA_SYNC, &conn->hcon->flags)) {
+			/* PAST ready, not a connection */
+			return;
+		} else if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags)) {
 			/* A BIS slave hcon is notified to the ISO layer
 			 * after the Command Complete for the LE Setup
 			 * ISO Data Path command is received. Get the
@@ -2900,6 +2925,22 @@ DEFINE_SHOW_ATTRIBUTE(iso_debugfs);
 
 static struct dentry *iso_debugfs;
 
+static __poll_t iso_sock_poll(struct file *file, struct socket *sock,
+			      poll_table *wait)
+{
+	struct sock *sk = sock->sk;
+	__poll_t mask = bt_sock_poll(file, sock, wait);
+
+	/* ISO-specific extension: POLLOUT on listen() socket when PAST setup
+	 * has been completed.
+	 */
+	if (sk->sk_state == BT_LISTEN &&
+	    test_bit(BT_SK_PAST_READY, &iso_pi(sk)->flags))
+		mask |= EPOLLOUT | EPOLLWRNORM;
+
+	return mask;
+}
+
 static const struct proto_ops iso_sock_ops = {
 	.family		= PF_BLUETOOTH,
 	.owner		= THIS_MODULE,
@@ -2911,7 +2952,7 @@ static const struct proto_ops iso_sock_ops = {
 	.getname	= iso_sock_getname,
 	.sendmsg	= iso_sock_sendmsg,
 	.recvmsg	= iso_sock_recvmsg,
-	.poll		= bt_sock_poll,
+	.poll		= iso_sock_poll,
 	.ioctl		= bt_sock_ioctl,
 	.mmap		= sock_no_mmap,
 	.socketpair	= sock_no_socketpair,
-- 
2.56.0

