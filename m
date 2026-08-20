Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D413481643
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248009; cv=none; b=jDu0FlC4DI9WlMdNyojE+w9IigBBYdZBbcDA6oA13f1Tpnxtee2Nb83dqTAz972o5VX0FOje/f6v/ARUDaPvyG9KOZLDq5CPOVBxKC2c6DCw2yutHBzbzpuRD2B1o6HZmKUs5XOzUbrdYsmf93bADXaJ1LyWoJBAN/1AB0ynsrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248009; c=relaxed/simple;
	bh=gprFRh2QaAtnq0hjOud0iB3tXFFYgeRSW5UO3hYoeJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQxmkF22sjcwP3FB70M8JnjC84gXKQ5DJjXGSquG5BFJfNsYZ/hCcmLMW3u+Ym0l2qVS+XejJmeJLRZyV2ho6ZIIWRPbyhSGLqviqKXFCjTDfjQUvg9Xf1uHaQN5nVTA+usaFNQc0WaUsM/XHqOz5jkGFfCw/2LwUfbzKFrtXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/hlyFCb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/hlyFCb"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47de008b020so20680f8f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787248006; x=1787852806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F+tptNGvayj5XTQ2x+XRb0sPDFabjITPvsIlhbrE7IU=;
        b=U/hlyFCbkdT8rlZfe/uVfV9QzYNBHEJFvTABIECXNx7dPrihZgxCXwMczUeMHcjDnT
         nPONi8IK9UxyVxf2mfPoCNy2IVnIa24zlfcHGc1mSg0735DxBet2yvGKf5O6lkWAyhqi
         WUuipd1sCjyM1vf6zE+Qxp9Q5fEKaFv5YhBmdFfRNmJZF6NRqrX1+2ndbWMSytKWJCTp
         8OCKH1cBtxMohYiVtH7LU3vW8vnDFOARvtnteVFhCbRZt9htdGyxg7Df4WmfncsqeuVr
         ZhKARoOspUeeOz7TSp6pqar2B19rAWX2tp411rxE9Gkq+n5EOn9XTpen06tBFc/jwluX
         beJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248006; x=1787852806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+tptNGvayj5XTQ2x+XRb0sPDFabjITPvsIlhbrE7IU=;
        b=Wkef15GiAGAZ3FqPjJPCkjjlD67nhUCfbtM+dGRdufas7tBer/q8NWtiZFFEk3QdCT
         X2Qd30qrsHZDiBmW3J4BJ22nzUKD66bAmHj0A0pvO2oYLpEqPTtLUhwRRoa7DI3KnVcM
         lQgRgmaNM4C6Z5w/cEc0oSJTWN0WI9DSlDQvt9uS7BhFheSvnZvaiyPpuTP7FkayT6NB
         yAPIk/KFRjEZdHEHn8i6et2KyKDiJ9LiriRSmmd8UycuLdNZDzhbKAZCGkBLV2ra8b6z
         rbga06uuf3J31JdzVZrOE5lqjxUMHb55PkJ3Zj9Agu18/9cjILNo7+x1THWaFCOG4mun
         Sddg==
X-Gm-Message-State: AFuF++lAO4OBiiNQjdNsCw/fDlt187Yo1anUKLJPD4Tq+ARVM/cktZJD
	h6AS6IIldzXhY0Hip2y++0I2lzxu5i4w2tGAkFytZHhbaVz4liz7hNIG
X-Gm-Gg: AR+sD12pUxPEUzpgTS4LziQg9i8oExBhdgmBDAmbNcoi3R6UL45Ma5uGnvsDhlyoEqa
	fMQ4zY2/amnXXr6x7T9kKWa9tIfKdC/AbTGMhKDvqU7ztEHldJimRynhlyvSEvq4N9rGiDwx+LT
	nv4BGPNUnWR0d2OhKfJX3d1SIDsIS+ernaIivT4psWDkFodtpvGwl+GS4p4Vz1JR5EyjR5RRsLe
	vJOpYhCdhNgl/Jh81embp9awqiZ8LmpVrSJUF86s/t0Uze8dIuU3FcPTDrcSro/4bjONIOkR+Su
	WeQa3ya80Yol/G1wqTzq8JjESOb2DWAC7SL4g5xu+hn9hAE6hQwC4UfVVWyqvZfbCAtMzfIAWc4
	2GZ3fS1eEEHTqwcZIBC3Iqg7Lwu3EJogYOAOAEHXxbS4edbg3TFBlGQyj0YeK0mgXiMhmTAMkXD
	Ah4NgMmzIsIsSSpYXAOPxU5HoVSmoFzBeYSaAG9cKsqmDlgHqKIxjYJanhqFYvzp+8vv29Jtp27
	f0J9byhhAcJ8CqaI9RCC7+yvGLkel3jXHhcFg==
X-Received: by 2002:a05:6000:4289:b0:47f:8b0f:7172 with SMTP id ffacd0b85a97d-482b7812077mr15390179f8f.6.1787248006116;
        Thu, 20 Aug 2026 10:46:46 -0700 (PDT)
Received: from kali ([169.224.126.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1441748sm15021700f8f.8.2026.08.20.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:46:45 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH] Bluetooth: SCO: avoid deadlock in sco_conn_free()
Date: Thu, 20 Aug 2026 20:46:33 +0300
Message-ID: <20260820174633.1570398-1-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_conn_free() (the sco_conn kref release) synchronously cancels the
connection timeout work with disable_delayed_work_sync() while the caller
holds lock_sock(sk).  The timeout work, sco_sock_timeout(), itself takes
lock_sock(sk).  When a teardown path drops the connection's last reference
under the socket lock -- e.g. sco_connect_cfm() -> hci_conn_failed() on a
failed link, or a Disconnection Complete via sco_conn_del() -- the ensuing
sco_conn_free() waits for a sco_sock_timeout() that is blocked on the same
socket lock: an AB/BA deadlock.

On a PROVE_LOCKING kernel, lockdep reports:

  WARNING: possible circular locking dependency detected
  kworker/u9:1 is trying to acquire lock:
   ((work_completion)(&(&conn->timeout_work)->work)), at: __flush_work
  but task is already holding lock:
   (sk_lock-AF_BLUETOOTH-BTPROTO_SCO), at: sco_conn_del
  -> #1 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO):
         lock_sock_nested ; sco_sock_timeout ; process_one_work
  -> #0 ((work_completion)(&conn->timeout_work)):
         __flush_work ; disable_delayed_work_sync ; sco_conn_put ;
         sco_chan_del ; sco_conn_del ; sco_connect_cfm

The bug is reachable by an unprivileged local process: opening an
AF_BLUETOOTH/BTPROTO_SCO socket needs no capability, and a short
SO_SNDTIMEO makes the timeout fire during connection setup/teardown.
(syzbot logged the same chain in 2022, closed obsolete with no reproducer.)

The identical problem in the ISO transport was fixed in commit 200fa1629c57
("Bluetooth: ISO: avoid deadlocks in iso_sock_timeout") by moving the
timeout work out of the refcounted, freed-under-lock iso_conn and into
iso_pinfo, so its lifetime follows the socket, and by cancelling it outside
lock_sock().  Do the same for SCO: move timeout_work into struct sco_pinfo,
drop the sync cancel from sco_conn_free(), and add sco_sock_disable_timer()
-- which asserts the socket lock is NOT held -- on the teardown paths
(sco_conn_del(), sco_sock_kill(), sco_sock_close()).

Note that merely making the cancel asynchronous is not sufficient: with
disable_delayed_work() the work can still run against freed memory, which
KASAN reports as a use-after-free in sco_conn_hold_unless_zero().  The
timer's lifetime has to follow the socket, as it now does for ISO.

Reproducer available on request.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Assisted-by: Claude:claude-opus-4-6 [claude-code]
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
 net/bluetooth/sco.c | 76 +++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 48 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3d4362a09df4..c87ad72af783 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -46,8 +46,6 @@ struct sco_conn {
 	spinlock_t	lock;
 	struct sock	*sk;
 
-	struct delayed_work	timeout_work;
-
 	unsigned int    mtu;
 	struct kref	ref;
 };
@@ -69,6 +67,7 @@ struct sco_pinfo {
 	__u16		setting;
 	struct bt_codec codec;
 	struct sco_conn	*conn;
+	struct delayed_work	timeout_work;
 };
 
 /* ---- SCO timers ---- */
@@ -89,9 +88,6 @@ static void sco_conn_free(struct kref *ref)
 		hci_conn_drop(conn->hcon);
 	}
 
-	/* Ensure no more work items will run since hci_conn has been dropped */
-	disable_delayed_work_sync(&conn->timeout_work);
-
 	kfree(conn);
 }
 
@@ -138,53 +134,45 @@ static struct sock *sco_sock_hold(struct sco_conn *conn)
 
 static void sco_sock_timeout(struct work_struct *work)
 {
-	struct sco_conn *conn = container_of(work, struct sco_conn,
-					     timeout_work.work);
-	struct sock *sk;
-
-	conn = sco_conn_hold_unless_zero(conn);
-	if (!conn)
-		return;
-
-	sco_conn_lock(conn);
-	if (!conn->hcon) {
-		sco_conn_unlock(conn);
-		sco_conn_put(conn);
-		return;
-	}
-	sk = sco_sock_hold(conn);
-	sco_conn_unlock(conn);
-	sco_conn_put(conn);
-
-	if (!sk)
-		return;
+	struct sco_pinfo *pi = container_of(work, struct sco_pinfo,
+					    timeout_work.work);
+	struct sock *sk = &pi->bt.sk;
 
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
 
 	lock_sock(sk);
-	sk->sk_err = ETIMEDOUT;
-	sk->sk_state_change(sk);
+	if (!sock_flag(sk, SOCK_ZAPPED)) {
+		sk->sk_err = ETIMEDOUT;
+		sk->sk_state_change(sk);
+	}
 	release_sock(sk);
-	sock_put(sk);
 }
 
 static void sco_sock_set_timer(struct sock *sk, long timeout)
 {
+	lockdep_assert(lockdep_sock_is_held(sk));
+
+	cancel_delayed_work(&sco_pi(sk)->timeout_work);
+
 	if (!sco_pi(sk)->conn)
 		return;
 
 	BT_DBG("sock %p state %d timeout %ld", sk, sk->sk_state, timeout);
-	cancel_delayed_work(&sco_pi(sk)->conn->timeout_work);
-	schedule_delayed_work(&sco_pi(sk)->conn->timeout_work, timeout);
+	schedule_delayed_work(&sco_pi(sk)->timeout_work, timeout);
 }
 
 static void sco_sock_clear_timer(struct sock *sk)
 {
-	if (!sco_pi(sk)->conn)
-		return;
+	BT_DBG("sock %p state %d", sk, sk->sk_state);
+	cancel_delayed_work(&sco_pi(sk)->timeout_work);
+}
+
+static void sco_sock_disable_timer(struct sock *sk)
+{
+	lockdep_assert(!lockdep_sock_is_held(sk));
 
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
-	cancel_delayed_work(&sco_pi(sk)->conn->timeout_work);
+	disable_delayed_work_sync(&sco_pi(sk)->timeout_work);
 }
 
 /* ---- SCO connections ---- */
@@ -214,7 +202,6 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 
 	kref_init(&conn->ref);
 	spin_lock_init(&conn->lock);
-	INIT_DELAYED_WORK(&conn->timeout_work, sco_sock_timeout);
 
 	hcon->sco_data = conn;
 	conn->hcon = hcon;
@@ -274,9 +261,10 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	if (!sk)
 		return;
 
+	sco_sock_disable_timer(sk);
+
 	/* Kill socket */
 	lock_sock(sk);
-	sco_sock_clear_timer(sk);
 	sco_chan_del(sk, err);
 	release_sock(sk);
 	sock_put(sk);
@@ -532,6 +520,8 @@ static void sco_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
+	sco_sock_disable_timer(sk);
+
 	/* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
 	lock_sock(sk);
 	if (sco_pi(sk)->conn) {
@@ -574,23 +564,11 @@ static void __sco_sock_close(struct sock *sk)
 /* Must be called on unlocked socket. */
 static void sco_sock_close(struct sock *sk)
 {
-	struct sco_conn *conn;
-
-	lock_sock(sk);
-	conn = sco_pi(sk)->conn;
-	if (conn)
-		sco_conn_hold(conn);
-	release_sock(sk);
-
-	if (conn)
-		disable_delayed_work_sync(&conn->timeout_work);
+	sco_sock_disable_timer(sk);
 
 	lock_sock(sk);
 	__sco_sock_close(sk);
 	release_sock(sk);
-
-	if (conn)
-		sco_conn_put(conn);
 }
 
 static void sco_sock_init(struct sock *sk, struct sock *parent)
@@ -622,6 +600,8 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_destruct = sco_sock_destruct;
 	sk->sk_sndtimeo = SCO_CONN_TIMEOUT;
 
+	INIT_DELAYED_WORK(&sco_pi(sk)->timeout_work, sco_sock_timeout);
+
 	sco_pi(sk)->setting = BT_VOICE_CVSD_16BIT;
 	sco_pi(sk)->codec.id = BT_CODEC_CVSD;
 	sco_pi(sk)->codec.cid = 0xffff;
-- 
2.53.0

