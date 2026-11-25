Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593544;
	b=aRvB5oQFiFUorgje5aOS5r9hqT7s3CfXK1H6mKQAiRuLc7ithpoLPJqDAInAcjtvkDWf
	 6qlw3uOefdQmMrCWoE+T6kYtNH058cL4hfUE8KFvveUtaBn26UJTOW+LDHxZIx//YI6AV
	 3/upf7TrUxHlV2nj6ACKiaOoMkBqSOX5FGflmtkJ3soifmZXsjUHZ8qJoZ6mSSH/XZ6qK
	 N07/K8eVk+/mQwEfclY0GaDML12b3PcjywdavVAkmcHk+4Q+/mdZCAVEYQlLUsPIWOKSO
	 UtMvcVT+MYQdGPxUAfu0h3B3mtyDXZBqlWEcLaGQuiUKcNCyxU6Avy4FEAV8X72F4xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Q6JZExf6RoZAgk7MbtKBkHAAQAgV+I5kcvcPOVpTCHA=;
	b=t/YMeOIc3GFiDKed+rePcQ0M/eKcj38fpKsQ9FFQkpydAvYXVgfyUqzrVfYufH4KZtkN
	 1s55X3xaOfiQcMFgNrfL2YYnLtnthtg6NXo0waXfzYz5Hk08Msxw0a9gdtHGr7L6MHKQK
	 FUzCHTXmA7dy8ucIOHDk0tanUQb3n/Q7AYJwdq+ecTX8EgVDvPBRZ6F9FsD0wh6KCY8rP
	 ZZVQhhencJFKJ2gPSCnh7X2ldUfXiuOlMT+ZrKeGihDiXdZXgPREKmD3h+jB5QUaXOp//
	 dUK/iYbuN2kl8XyXTMOSn+VaEWFDpRD0lW/uWDBbbk/a8Ym4bRZIHNwthuighPmbcVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Ct7/b+bz";
	arc=none smtp.remote-ip=74.125.227.131
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A1606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 597A1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ct7/b+bz
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3adc0ac3566so1303511a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 23:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593544; x=1796198344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q6JZExf6RoZAgk7MbtKBkHAAQAgV+I5kcvcPOVpTCHA=;
        b=Ct7/b+bzPpEZBzNUOR+J+LvkmOFyNKxWkERMMrXoIJ1SGFlsLgh076Y1lFHX5ooATm
         Ws6nO2DyjD4hx/S+EgaxesFOiyUigOl0bh32eUUiFlvW4KKdJ1RUlnkPt0uen20xesG6
         P/KCC+5a2FWLny7FJDnNWXq171YjrfAbUVa5nfaiFo4JvHuN+MZi+sXQERNzmqolITSc
         hzKDJ6iwXNIAQCZNZIrUlX6+GP6kXJVaSFdo63KPaqS4Wgo/chjop6gEHOxBSKi5SNgX
         y+G7s44PbnZ4Yy/TJap3wqxEVAAKJUh8FBtCJQ5kY3SvGxyKZt/6pBVGkvmPk7g9v/NX
         J1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593544; x=1796198344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q6JZExf6RoZAgk7MbtKBkHAAQAgV+I5kcvcPOVpTCHA=;
        b=zi4Xp1Bz9eR/ePys2rMwb5enfRo1Lou+UofpuIht6dIpekWLaFmmpxQoskVHE/ofqI
         lesWbDMwaXNQpri7skzUm6rwULyO0Kps/+22pGVYDviziNHV2rcxrjDtoldqBPqqLbxz
         r+zag1zmuitLvHQym+vEbfEppQ5ULum4XyuIKowGEvytb9NuhEwyCRsmn4WRmZKLqLE/
         GiZOm8PrCnoxmUNPG/L+KhG+tvC8w4YCcToWQwI5OegtrDzAsEuLGP3QNVY0nPSH8ukD
         jgD1J3t1FP2W0Vy9d9RWpraTqzZmmdVzh1wYb9B+36r1IVE59lrTiJ9o15zaxYa1W9mp
         DdtQ==
X-Gm-Message-State: APuU4Z+T/+u0ROlztELfxXAVL5pcZFHIh6r2T7MVFAVxspTJhblHBW3Y
	EI9Qh84t/JoG9neVyc5U1l0aYunWB8yMFOurI40360xzJj2JUA+hc0+n
X-Gm-Gg: AZFdTZeEeY3iuAt6Eu+moImso+6qgu0z/YVz4MG7/wU/NPmYOCajjaC/5ilOsViTKmm
	9of2UpiO4GKmgZEdNxx1Jb2x9ycrUH4L0P3NBX7WLnlve8itiz5nhXFEEZD3AmXxDdjFDKCoWfU
	XhQMl6Q3O9D4YZJ8RmRDe93RwXiCbicLlJtbDKo0AxP1lvgo0E3khk2ZNVS1uwbrqHPJ775VfhN
	8v+eZ6oCt0l14xdNuPyX+lf+H7X1HmPW8wqr+2t0wMeOXuOE/Eyb+O7gGlbfEQk4VU9hiae3yNh
	Bj9g9cVjVfhQ5tPHtbfJUGrNWj+yGYpVRMimorqo9HK0zjFycifE97ibui9MLwOC9UmNs7GSj7f
	7IjjcrGH0Uhoar+R0jkS4mLgAyL2g0COItNhG62yPE3r9HRYjBozn9Q8UIXwkN2ULh1O7Tg80Tb
	kv18S3OVAalw7i/P659GLMjpXrY73FKWNDS0YwX9ltAqo9kX5XJTuypQgJhBPsYkseSrFaf3De3
	uUMaSHwG3xk0p8BYZIDkFv7Hpe7M2Mr2hA22h/wg2voFfBn0JLQTEQzriUIUFCF1aDQasQBYwOX
	3vABp6ksKTpEaCZMOfpEUW2JFOuKqgXYZPBAoifESCGrdftjjCma9bj+mKzVSRsnSTP8L0J9ER8
	Y
X-Received: by 2002:a17:90b:1802:b0:3b0:c11a:9026 with SMTP id 98e67ed59e1d1-3b41c95fa0cmr16370673a91.55.1795593543512;
        Tue, 24 Nov 2026 23:59:03 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm28779384a91.5.2026.11.24.23.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:59:02 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	jcperdomo100@gmail.com,
	leitao@debian.org,
	rollkingzzc@gmail.com,
	oss@fourdim.xyz,
	skokovmaksimevg@gmail.com,
	pav@iki.fi,
	safa.karakus@secunnix.com,
	benquike@gmail.com,
	peng.fan@nxp.com,
	tim.bird@sony.com,
	nicoyip.dev@gmail.com,
	aliamemis@disroot.org,
	pengpeng@iscas.ac.cn,
	imv4bel@gmail.com,
	mikhail.v.gavrilov@gmail.com,
	suunj1331@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: RFCOMM: fix race on dlc->session in RFCOMM_CONNINFO getsockopt
Date: Wed, 25 Nov 2026 15:58:51 +0800
Message-ID: <20261125075852.641537-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RFCOMM_CONNINFO getsockopt handler checks dlc->session under
lock_sock() and then follows it:

    l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;

Nothing serializes this against rfcomm_session_close().  The session
thread unlinks every dlc with __rfcomm_dlc_close() - which sets
d->session = NULL - and then frees the session in rfcomm_session_del(),
all under rfcomm_mutex and without ever touching lock_sock.

An ioctl(RFCOMMCREATEDEV) with REUSE_DLC replaces the dlc state_change
callback with rfcomm_dev_state_change(), which does not take
lock_sock(), and sets sk_state to BT_CLOSED only after rfcomm_dev_add()
returns.  During that window every check in the CONNINFO branch passes
while a full-session shutdown from the peer unlinks and frees the
session, and the check and the dereference lose the race, e.g.:

  KASAN: slab-use-after-free in rfcomm_sock_getsockopt+0x714
  Read of size 8 (session->sock) at addr ffff88810dfce210 by task poc
  Allocated by rfcomm_session_add (rfcomm_run)
  Freed by rfcomm_session_close (rfcomm_run)

If the free lands between the check and the dereference instead, the
dereference faults on a NULL l2cap socket.

rfcomm_session_close() runs under rfcomm_mutex from the session
thread.  Take rfcomm_mutex before lock_sock() in the CONNINFO path so
that the session cannot be unlinked or freed between the check and the
dereference.  This is the order the rest of the driver uses:
rfcomm_connect_ind() takes lock_sock(parent) with rfcomm_mutex held,
rfcomm_sk_state_change() runs from __rfcomm_dlc_close() with it held,
and the connect and shutdown paths drop the socket lock before calling
into the core.

Move the CONNINFO branch into its own helper so the rfcomm_mutex
acquire/release is unconditional on every path (clang thread-safety),
and copy the result to user space after dropping both locks, so that a
faulting user buffer cannot stall the session thread.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
Fixes: points at the initial git commit because both the CONNINFO
dereference and the REUSE_DLC wiring predate git history.

v1 -> v2: add the Fixes: tag (checkpatch); untabify the quoted line
          (gitlint); move the CONNINFO branch into a helper so the
          rfcomm_mutex acquire/release is unconditional (clang
          thread-safety analysis failed the conditional form on v1).
---
 include/net/bluetooth/rfcomm.h |  4 ++
 net/bluetooth/rfcomm/core.c    |  6 +--
 net/bluetooth/rfcomm/sock.c    | 73 +++++++++++++++++++++++-----------
 3 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 9dc5fd4cb8c81..251ae43b44003 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -148,6 +148,10 @@ struct rfcomm_msc {
 
 /* ---- Core structures, flags etc ---- */
 
+extern struct mutex rfcomm_mutex;
+#define rfcomm_lock()	mutex_lock(&rfcomm_mutex)
+#define rfcomm_unlock()	mutex_unlock(&rfcomm_mutex)
+
 struct rfcomm_session {
 	struct list_head list;
 	struct socket   *sock;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a4205347c4ac..063a66b28cf7c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -42,10 +42,8 @@ static int channel_mtu = -1;
 
 static struct task_struct *rfcomm_thread;
 
-static DEFINE_MUTEX(rfcomm_mutex);
-#define rfcomm_lock()	mutex_lock(&rfcomm_mutex)
-#define rfcomm_unlock()	mutex_unlock(&rfcomm_mutex)
-
+/* Serializes session_list walks and dlc/session teardown. */
+DEFINE_MUTEX(rfcomm_mutex);
 
 static LIST_HEAD(session_list);
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3fb8b54749482..ecaffc408e736 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -737,8 +737,7 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 	return err;
 }
 
-static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
-				      sockopt_t *sopt)
+static int rfcomm_sock_getconninfo(struct socket *sock, sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
 	struct sock *l2cap_sk;
@@ -746,12 +745,60 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
 	struct rfcomm_conninfo cinfo;
 	int err = 0;
 	size_t len;
+
+	len = min_t(size_t, sopt->optlen, sizeof(cinfo));
+
+	/* The CONNINFO branch follows dlc->session, which
+	 * rfcomm_session_close() unlinks and frees under rfcomm_mutex.
+	 * Take the mutex first, like every other path that walks
+	 * dlc->session: it must be held before lock_sock().
+	 */
+	rfcomm_lock();
+	lock_sock(sk);
+
+	if ((sk->sk_state != BT_CONNECTED &&
+	     !(sk->sk_state == BT_CONNECT2 &&
+	       rfcomm_pi(sk)->dlc->defer_setup)) ||
+	    !rfcomm_pi(sk)->dlc->session) {
+		err = -ENOTCONN;
+		goto out;
+	}
+
+	l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;
+	conn = l2cap_pi(l2cap_sk)->chan->conn;
+
+	memset(&cinfo, 0, sizeof(cinfo));
+	cinfo.hci_handle = conn->hcon->handle;
+	memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
+
+out:
+	release_sock(sk);
+	rfcomm_unlock();
+
+	/* Copy out after dropping the locks: a faulting user buffer must
+	 * not stall the session thread.
+	 */
+	if (!err && copy_to_iter(&cinfo, len, &sopt->iter_out) != len)
+		err = -EFAULT;
+
+	return err;
+}
+
+static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
+				      sockopt_t *sopt)
+{
+	struct sock *sk = sock->sk;
+	int err = 0;
+	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
 
 	len = sopt->optlen;
 
+	if (optname == RFCOMM_CONNINFO)
+		return rfcomm_sock_getconninfo(sock, sopt);
+
 	lock_sock(sk);
 
 	switch (optname) {
@@ -785,28 +832,6 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
 
 		break;
 
-	case RFCOMM_CONNINFO:
-		if ((sk->sk_state != BT_CONNECTED &&
-		     !(sk->sk_state == BT_CONNECT2 &&
-		       rfcomm_pi(sk)->dlc->defer_setup)) ||
-		    !rfcomm_pi(sk)->dlc->session) {
-			err = -ENOTCONN;
-			break;
-		}
-
-		l2cap_sk = rfcomm_pi(sk)->dlc->session->sock->sk;
-		conn = l2cap_pi(l2cap_sk)->chan->conn;
-
-		memset(&cinfo, 0, sizeof(cinfo));
-		cinfo.hci_handle = conn->hcon->handle;
-		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
-
-		len = min(len, sizeof(cinfo));
-		if (copy_to_iter(&cinfo, len, &sopt->iter_out) != len)
-			err = -EFAULT;
-
-		break;
-
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.53.0

