Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156491;
	b=5rWj9VBCNR1pxXGDwBcYM82jFhRfX87ttkjw/U21Jfxa9uk+R4BUlWZRCVzlXhRT5l8G
	 6kcBLMOsCxVRqs7Asu8kFliufs7uwj4AYceC/WTGUgD620NIiF5rjeWjp/PJMj4KZBj5C
	 rQEPS0IxumP8VX65aThkw6IaHESopIjEd/vFzi2p/KH0HOFXppvk1ECtMFF0uBfrzwzI5
	 8Soorq71Z4/25eBI2tnR3CCsT2m5/qsPeCVwMpjAah6qaSvMz5BxuWpYdBmVo/KnOSC11
	 ZJQQy1KanIGlVMtS8gfToVeR/XEaO14DMtQGCywwnn2Fm99pxuHz6m4n86FkGUQLZxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nDbZsYirix3QMOEIn80f0c4VmQbp/ZwzvITGOaV2xMQ=;
	b=irWqc7Vrj5RL9Z2EL7fD/Bx5/xwWg7eY3Hi+J0E2WOs+p/HwM/XwQh8op4WDxD0R0y0p
	 jqJXj8nuS0k54EjXX3kCeEas//aiXQQFGHsxKc2tgQIBrFSmCRID5DEG3A1z2htPWbo5H
	 luSfhpsoCyZtYURCgWzaYxCRMKrtY0DLg8OA1zR7OXA6eeBOv3BzdTNN5me4u414M1DjD
	 8/TgZpovYO31T8CwHhVep3foTBJXIG6HtKhMtzu6nEPHkh8gd2InW6aY1V1EGk13cYz/2
	 finU41WxR4RG0PQHBQHZX7d+75GHalH/Q18fdK/59SsIA6ht2p9NHl3zYMmgwBQGncQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OW8Xd9AF;
	arc=none smtp.remote-ip=74.125.231.135
Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B64606A325
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62B64606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OW8Xd9AF
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-71abadc4460so205629eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156489; x=1795761289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nDbZsYirix3QMOEIn80f0c4VmQbp/ZwzvITGOaV2xMQ=;
        b=OW8Xd9AF4ZQAZL2FZpwb9GVujvBFvwfFYenu9u5Uwj1tQydA1z3S812ZxpAM3P1Z2n
         so9rvSu4G6m0vvv0hzmqAJNJ9ho/yuZ/ZodO98R8ayt/L06b7IX4fHX/M5NwjazJE+MT
         DII1lMNq5bAnieNPMfqpOrSIvgpkRcO+u4sW1AE/W6ArJzirNxl/zjkTrCBgrS+NMSur
         Up4sJE9GJVnAxJDStlCL7KlRlGXCD8/ebD+01+m0GT288meCPX+t7lmPLAv0EiMELgwj
         r2s7pYqEO0v/liJk42pTG7QhaTEYj1D7qQoKOyamxP5/p1JcyUZuWOs03xuW52yBnQZI
         jwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156489; x=1795761289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nDbZsYirix3QMOEIn80f0c4VmQbp/ZwzvITGOaV2xMQ=;
        b=qgL+pbGTnhzKcfhMGAKgep6qlUSgzETUlpZDZ9e+H7pmgN+UdWOYuGIGJEMGy+pnvn
         sVCLOzMS/MYSxELC3WJiy5nirEb7im5OX5+hpYknSiqjSwrYzfeRrhu7GT5zdo4CvHTp
         nLATpVWtL4IrG+/q3ELm5QW/8Rqa4Qr1yWKfVwMk29KlShC8o2ZvRmI4KBlKddQjy+Q/
         Oq4TjCpGXfbiCogEMe/9ghhecZlj3apf0DuA+djOcHWw83xFdEmwXTOiJ3DJtr3cmdP0
         4cIeoWDgpVHNaq4g8G/7NBtVDr97m+ZPOYjYHzV4cI4i/Uj47pF4z4FrSP/JSP+3ilOt
         MyrQ==
X-Gm-Message-State: APuU4Z9br6OysWCbdSU514iMi/69T/qdUtNhCm0O0edqArJPiplYWRNx
	thIH2QHJQ9zF4VdxKHEGVQD0Unnf92U1Fv8IvlGzBseCpSa4f1UY7FAv
X-Gm-Gg: AYBFou2Ij42gvQWC/mVxCi89dfguOd66y+KjFdfEJFbiDPqYSqBv/boDUprh5z2WmXk
	c8FekFiw3onfZn1SNTz+mqTEnzFbV8r+OTm0g4leFnzsMNFHVU72eQa1ejTbXEj+mgH6BWQhwHl
	sBx20BOqrjUn589z5H5cmc75nQ+zGHGGEkTRWK4FEAB8bD1zjaOvMQyFrWWQXLxjxom2TE1pJps
	8y0O1gg0GJcJNpM/Rx3AAV40R4DHFwibYAiAhBsOKACWD4rUtrWK4ZxGrMwi6rXmzaRyjT45T7+
	bqAf8dVP56IwqwRKg7zZcIAbipO5cVVn9RcRsOCmrYPMQqRVQhU2WTQCDYyEeEXXTz3mw3A+HkN
	HqJ7ZgT4EqwbsGSgqy3SDV+Cp6Ct3V3wptoG7MP290Uf5M/A358wjQecILzj+2JzdQ5ijCiDK9R
	QSvRaWa3v095/qjzQ8mDvuMwjvcbGoQCoT6qSUKZxmht3FUEVCAZY+oLXHjz+X6R0FytQR+3Gjf
	IuoGQVmx7LcICh1eLtKLXrNwc19Jqf0n3qU4oisjN0+5dFxa2Ciq5Ukw/jTVQJ8igSSnpzMp/Hh
	KhiiHO8/4lIhd+sSgcvE/x68Q0PrgEpoG4a+XZJLpATG34OhN8OV4O2pNe5e6U6cfESVhaP1ZNg
	3STyRiIrfd7iLfQ==
X-Received: by 2002:a05:6820:5201:b0:71a:e95a:34dd with SMTP id 006d021491bc7-71b39591d9amr1586691eaf.78.1795156489197;
        Thu, 19 Nov 2026 22:34:49 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b37ea818bsm1513192eaf.1.2026.11.19.22.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:34:47 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Juan Perdomo <jcperdomo100@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Zhang Cen <rollkingzzc@gmail.com>,
	Siwei Zhang <oss@fourdim.xyz>,
	Maxim Skokov <skokovmaksimevg@gmail.com>,
	Pauli Virtanen <pav@iki.fi>,
	safa.karakus@secunnix.com,
	Hui Peng <benquike@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Tim Bird <tim.bird@sony.com>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	aliamemis@disroot.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	SeungJu Cheon <suunj1331@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: fix race on dlc->session in RFCOMM_CONNINFO getsockopt
Date: Fri, 20 Nov 2026 14:33:43 +0800
Message-ID: <20261120063343.3875317-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

Nothing serializes this against rfcomm_session_close(). The session
thread unlinks every dlc with __rfcomm_dlc_close() - which sets
d->session = NULL - and then frees the session in rfcomm_session_del(),
all under rfcomm_mutex and without ever touching lock_sock.

An ioctl(RFCOMMCREATEDEV) with REUSE_DLC replaces the dlc state_change
callback with rfcomm_dev_state_change(), which does not take
lock_sock(), and sets sk_state to BT_CLOSED only after rfcomm_dev_add()
returns. During that window every check in the CONNINFO branch passes
while a full-session shutdown from the peer unlinks and frees the
session. The check and the dereference then lose the race:

  KASAN: slab-use-after-free in rfcomm_sock_getsockopt
  Read of size 8 (session->sock, offset 0x10)
  Allocated by rfcomm_session_add, freed by rfcomm_session_close

or, if the session is freed between the check and the dereference, the
dereference observes a cleared session->sock->sk and faults on a NULL
l2cap socket:

  KASAN: null-ptr-deref in range [0x350-0x357]
  (l2cap_pi(NULL)->chan)

rfcomm_session_close() runs under rfcomm_mutex from the session
thread. Take rfcomm_mutex before lock_sock() in the CONNINFO path so
that the session cannot be unlinked or freed between the check and the
dereference. This is the order the rest of the driver uses:
rfcomm_connect_ind() takes lock_sock(parent) with rfcomm_mutex held,
rfcomm_sk_state_change() runs from __rfcomm_dlc_close() with it held,
and the connect and shutdown paths drop the socket lock before calling
into the core.

Copy the result to user space after dropping both locks, so that a
faulting user buffer cannot stall the session thread.

e.g. on a KASAN build, with a userspace RFCOMM peer sending DISC(0)
during the REUSE_DLC window:

  KASAN: slab-use-after-free in rfcomm_sock_getsockopt+0x714
  Read of size 8 at addr ffff88810dfce210 by task poc/1748
  Allocated by rfcomm_session_add:
   rfcomm_run (krfcommd)
  Freed by rfcomm_session_close:
   rfcomm_run (krfcommd)

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
No Fixes: tag: both the CONNINFO dereference and the REUSE_DLC wiring
predate git history (they are present in 1da177e4c3f4), so there is no
commit to point at.  Cc: stable is added because the race affects
every released kernel.

 include/net/bluetooth/rfcomm.h |  4 ++++
 net/bluetooth/rfcomm/core.c    |  5 ++---
 net/bluetooth/rfcomm/sock.c    | 23 +++++++++++++++++++++--
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 9dc5fd4cb8c8..251ae43b4400 100644
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
index 8a4205347c4a..655c55e1f2ce 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -42,9 +42,8 @@ static int channel_mtu = -1;
 
 static struct task_struct *rfcomm_thread;
 
-static DEFINE_MUTEX(rfcomm_mutex);
-#define rfcomm_lock()	mutex_lock(&rfcomm_mutex)
-#define rfcomm_unlock()	mutex_unlock(&rfcomm_mutex)
+/* Serializes session_list walks and dlc/session teardown. */
+DEFINE_MUTEX(rfcomm_mutex);
 
 
 static LIST_HEAD(session_list);
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3fb8b5474948..23bafb42e685 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -747,11 +747,20 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
 	int err = 0;
 	size_t len;
 	u32 opt;
+	bool copy_conninfo = false;
 
 	BT_DBG("sk %p", sk);
 
 	len = sopt->optlen;
 
+	/* The RFCOMM_CONNINFO branch follows dlc->session, which
+	 * rfcomm_session_close() unlinks and frees under rfcomm_mutex.
+	 * Take the mutex first, like every other path that walks
+	 * dlc->session: it must be held before lock_sock().
+	 */
+	if (optname == RFCOMM_CONNINFO)
+		rfcomm_lock();
+
 	lock_sock(sk);
 
 	switch (optname) {
@@ -802,8 +811,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
 		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
 
 		len = min(len, sizeof(cinfo));
-		if (copy_to_iter(&cinfo, len, &sopt->iter_out) != len)
-			err = -EFAULT;
+		copy_conninfo = true;
 
 		break;
 
@@ -813,6 +821,17 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname,
 	}
 
 	release_sock(sk);
+
+	if (optname == RFCOMM_CONNINFO)
+		rfcomm_unlock();
+
+	/* Copy out after dropping the locks: a faulting user buffer must
+	 * not stall the session thread.
+	 */
+	if (copy_conninfo &&
+	    copy_to_iter(&cinfo, len, &sopt->iter_out) != len)
+		err = -EFAULT;
+
 	return err;
 }
 
-- 
2.43.7

