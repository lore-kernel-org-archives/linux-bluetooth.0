Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187727;
	b=mEa4YsqQ1E87KWBmpYyqywnyi3B9bi0MOlFNa55gOOdCx6qu/xddehmZ71L5xXnDG0Dc
	 gtQ7F7LbFiFvGveZ6lkEPwRn+lCdLhgJoT5tLBalJnicNLYx6IgfF8rqUCGKHUBP535Jn
	 npU1qj7N+yVBJjK7qorsL62IWHPUrNrYk/UDIACKhB783jryKnGKNp4SeWosd1JfcycJo
	 oJjfC215NVqNAo9im5vN3YIt3+Z38+U6np8yQY+3hEgQrzGRTFHviRdjoUzp9OxDxTKoR
	 sIgayvNjl4Zvez1eUKKm2HlYXHsLeB/iU8uiFDmVEGceHViXUKjdJQAgiPm0ECS/yAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187727;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=/UcP02JfZncVROIkkJXxIKBFBQh4Hf0yQx0jt7s8Ob8=;
	b=KcCS8tKWp82h//paKX72I7eFfprXDAh9kyc2W6Cof4VDwI/hjaOkOSxwf3cPKjpqThk+
	 r4aHHxOM6fbKv8wLevt0+9b8KYavJnpqVN0DUaAfvs1jT2AmwzMY+c9kvNGONfoEDRSLP
	 mKKFriH8GpjaOzBsi+yQy0XjzyXDJaQeF/gHl82NMetW/wF2qIOLPRz0fkqxm5ELDnFxF
	 zlCgt351Dikn27/FYufQrYCfMhH7+jfyJi6crN9vygKzDTnBe1Xw0tqghnikWmfAWc3+V
	 GKKy4SxMJnalvOjbHAies6FvKbm6M3Iun2C1hc918/qu7sQFLf/um0gOGXzZmuPxSEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="rLU/Z4Yv";
	arc=none smtp.remote-ip=43.163.128.47
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46660A2605
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 15:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F46660A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=rLU/Z4Yv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795187716; bh=/UcP02JfZncVROIkkJXxIKBFBQh4Hf0yQx0jt7s8Ob8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rLU/Z4YvCwj8IbPFGLq4y3C3/mJEQ/wLnrHBajYtqnSFgBIMgNQxw3eUd1a08DzMN
	 WnDep0jDJOxVoDQj5mOJ5Q356/JDZsd0OBM+8iH0qJwfbJyRH5FuwMHf/SqwKwCJRi
	 txpkhL6T3jPSZqX5cA53sCUoMm8Y6Dc8X5FKa+HY=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:65c9:1ea4:b234:d5d4])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 3CD99263; Fri, 20 Nov 2026 23:15:13 +0800
X-QQ-mid: xmsmtpt1795187713tlp4sbamv
Message-ID: <tencent_F776F667C4504F55486A5FFFE91A655E1708@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeer+xcSOflgWWysJAxVk+TnuffDWl6iiP/L4HIiiay1dQSYSi4/
	 jor0cn5Go8N/97Ue9wm/VA53cJ88FOxIgBglGzGG0YqrsBO+i5SM/Nkd8R8pwPiqaPkKGAMRbGir
	 VL6RKOKXICjOUj8jaPQ6MTOh1gsRoQFjvAQ3rALNx5EcYMbigbhiueZTa6l5k14mla+oAyqlNM/c
	 fNXtWFV2cd7Nh+4K18J4mT8v1F+2xlu89f6q2pq7f1UfZ0GKCBjBfsUbHMFfXMsOnVGUrLSM98QA
	 VfbqnuuM9UCo/vVFMXYv3rSqX9BWkoxA+Yy/hLUPwahRjnxf5NJYcP81lRD8Q/vk3QMrq0u0dVqR
	 jx9Zvdl3aus8xu5gwh1JFcpjqgKYGUnf0c0DDSfgY7K+zivTTBJ4luf/fGF8MjeNIjAq15FhTNSR
	 JUENSJ5SkHlyIZ2zlm1xjdU/HBDKcatUctZ91RAQpYk9dO5eIJvBQUGa9/oRk5d8d/GpdiYTTiul
	 qrA5S5ZkWw+TyMOkYNmMemibDDSq7ZDCdFGwptZqNxayzXfGFGgQq5b9ZbgIz7o0Q8VAxInaQf9y
	 M4zpEIbroXFGlHOpPjEzvPe8LqgblyRWFOczwlyV7Jix1jRZr0gJ6axDc6QcYzk7rBBJUj9P6AEB
	 djauKtwU7yZ2XnZQEhdEgrtx/nS4B5jPScAgFZXnjGCbG357a2DUPPdY5FU44MENwXXpkkA/f+U3
	 NeRSD6QOLQIlmpDVpsMwAUoUdusAhknO/UZj1oCK5PXfN/Kt70x6opiBXXx0ykkSnSvaU1yFHmkz
	 okk7TS1E8LrusXhFbFwCIlz2Q/Xo7J6/7s+vdtdj2DY30F3s0yINbipyhITs8Ji82ZCZ5LVMAJaT
	 3U5i0/Da3iMLfrNrpFeBsJE2APbMoReSCmsSzOm5rLTfUC0vDSYYlwbQ8dICsklK/JBiaqZEwUgC
	 pPsnuM4eFGoz4HZlGCryIpvvQUq3enB2iZHRV4zmsmdJfIidBTI4UCDP+ADBDRC0dOC1S+cSdZgt
	 tl1rWdEYT1U4Tr/CSLfGadTgbVxU0vCTz6aka9a3nI+f9UgXFooO2nl4CsBtFxNSk/H9bp9pX1Qh
	 4kCqnBu/kLfr2e9HY=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hang Nan <2122295973@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
 pav@iki.fi, zzzccc427@gmail.com, enderaoelyther@gmail.com
Subject: [PATCH v4] Bluetooth: RFCOMM: hold the listener across child teardown
Date: Fri, 20 Nov 2026 23:15:13 +0800
X-OQ-MSGID: <179518771373.129860.16468151947315332758@qq.com>
In-Reply-To:
 <CABBYNZJWXoTxVYKEhQfZ82-P=8ogS-yBrMPR1sNxo3C6yQG-2g@mail.gmail.com>
References:
 <CABBYNZJWXoTxVYKEhQfZ82-P=8ogS-yBrMPR1sNxo3C6yQG-2g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Bluetooth: RFCOMM: hold the listener across child teardown

rfcomm_sk_state_change() takes the listener from bt_sk(sk)->parent,
unlinks a closing child from the accept queue and then notifies the
listener through that pointer.  bt_accept_enqueue() retains only the
child, so once bt_accept_unlink() has dropped the child's queue reference
a concurrent close() of the listener can run rfcomm_sock_cleanup_listen(),
find an empty queue, and free the listener:

    krfcommd                             close(listener)
    rfcomm_sk_state_change()
      parent = bt_sk(sk)->parent
      bt_accept_unlink(sk)
                                           cleanup_listen(): queue empty
                                           rfcomm_sock_kill() -> kfree
      parent->sk_data_ready(parent)                 <- use-after-free

KASAN reports it as an 8-byte read 264 bytes into a freed kmalloc-1k
object, i.e. the listener sock:

  BUG: KASAN: slab-use-after-free in rfcomm_sk_state_change+0x2ed/0x320
  Read of size 8 at addr ffff888002716908 by task krfcommd/60
  CPU: 1 PID: 60 Comm: krfcommd Tainted: G    B      PREEMPT(full)
    rfcomm_sk_state_change+0x2ed/0x320
    __rfcomm_dlc_close+0x16a/0x3d0
    rfcomm_run+0x1824/0x4000

The window needs full preemption: the only preemption point is the
spin_unlock_bh() at the tail of bt_accept_unlink().  It was reproduced on
7.2-rc6 with two vhci controllers, one side listening and closing, the
other connecting and dropping the child, with an mdelay(3) inserted
between the unlink and the notification for the test (full report below
the --- line).

Same class as commit 4020751fd0df ("Bluetooth: L2CAP: Hold the listener
while notifying child teardown") and commit b4a00dedc5cc ("Bluetooth: ISO:
Hold the listener during disconnect notification"): take a reference
before the unlink and drop it after the notification.

The reference cannot be dropped where it is taken.  Once
bt_accept_unlink() has run, close() may have released the fd reference, so
the sock_put() can be the final put and runs rfcomm_sock_destruct() ->
rfcomm_dlc_lock(listener->dlc) while the child's socket lock and the
child's DLC mutex are still held.  All DLC mutexes share one lockdep class
(rfcomm_dlc_alloc() does a plain mutex_init()) and this function already
runs under d->lock and takes lock_sock(sk), so that nests a same-class
mutex and inverts the d->lock -> sk_lock order.

Drop it in the existing SOCK_ZAPPED tail instead, where the child's socket
lock has been released and its DLC lock is dropped for
rfcomm_sock_kill() - the same place the code already drops the DLC lock so
that the child's own destructor does not deadlock.  The put is gated on
the flag set where the reference is taken rather than on SOCK_ZAPPED
alone, because __rfcomm_sock_close() sets SOCK_ZAPPED directly for
BT_CONNECT, BT_CONNECT2, BT_CONFIG and BT_CONNECTED.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hang Nan <2122295973@qq.com>
---
v4: add the commit description, Signed-off-by, Fixes tag and the KASAN
    report; v3 went out as a bare diff.
v3: drop the reference in the SOCK_ZAPPED tail and gate it on a flag, so
    that a final put cannot run rfcomm_sock_destruct() under the child's
    sk_lock and d->lock (Zhao Li).
v2: cite the two reference commits as 'commit <sha> ("<title>")', as
    checkpatch.pl requires.

Full report (the mdelay(3) only widens the window; the code path is
unchanged):

BUG: KASAN: slab-use-after-free in rfcomm_sk_state_change+0x2ed/0x320
Read of size 8 at addr ffff888002716908 by task krfcommd/60
CPU: 1 PID: 60 Comm: krfcommd Tainted: G    B      PREEMPT(full)
  rfcomm_sk_state_change+0x2ed/0x320
  __rfcomm_dlc_close+0x16a/0x3d0
  rfcomm_run+0x1824/0x4000
  kthread

Allocated by task 72:
  rfcomm_sock_alloc.constprop.0+0x47/0x240
  rfcomm_sock_create+0xa6/0x2a0
  __sys_socket+0x116/0x1d0

Freed by task 72:
  __sk_destruct+0x499/0x5d0
  rfcomm_sock_release+0x101/0x140
  __sock_release+0xa1/0x260
  __x64_sys_close+0x78/0xd0

The buggy address is located 264 bytes inside of a freed 1024-byte region
(kmalloc-1k).


diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 3fb8b5474948..94a495e86057 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -66,6 +66,7 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 	__must_hold(&d->lock)
 {
 	struct sock *sk = d->owner, *parent;
+	bool held = false;
 
 	if (!sk)
 		return;
@@ -83,6 +84,12 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 	if (parent) {
 		if (d->state == BT_CLOSED) {
 			sock_set_flag(sk, SOCK_ZAPPED);
+			/* close() may already have dropped its reference and the
+			 * queue holds none, so keep the listener alive across the
+			 * unlink and the notification.
+			 */
+			sock_hold(parent);
+			held = true;
 			bt_accept_unlink(sk);
 		}
 		parent->sk_data_ready(parent);
@@ -100,6 +107,12 @@ static void rfcomm_sk_state_change(struct rfcomm_dlc *d, int err)
 		 * rfcomm_sock_destruct() will dead lock. */
 		rfcomm_dlc_unlock(d);
 		rfcomm_sock_kill(sk);
+		/* Drop the listener reference with neither the child's socket
+		 * lock nor its DLC lock held: this put can be the final one and
+		 * rfcomm_sock_destruct() takes the listener's own DLC mutex.
+		 */
+		if (held)
+			sock_put(parent);
 		rfcomm_dlc_lock(d);
 	}
 }

