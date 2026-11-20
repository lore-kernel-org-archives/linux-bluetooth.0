Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181395;
	b=pZh1WI04f856k3alFpxPSzH9bhtG2c1RpP4By5KZjGqL0q/M8VaXgaENUczaGEVtMpCe
	 pg2D8b1qvUZ3dML+gfNzoRy1jLLWYydxXFcqsHzCd5Ls4fs2jYYstTsyCYXPix5xrHBrC
	 CB9yHYbdCNDq7dIV8axEW+vUM1E9wzKt5i2vjo7oMEUNDwTBMnBRIDSWvGrDm5kD/zvog
	 QHhrUPZbgcnuIGJcSRQyH3Fq7iCFuhQlH/ql1Exv6wVhLqZRFzNnxDvDMsn5y8BvOCwFw
	 BGFp/Wtt7FYnUyGO8KReIrPOIb1fR/4/nbwAR++F4etPoECXAYXeyZ7N6Xam3znhuoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181395;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=6J6hVWng2rSlwYKEbhFdmNXPBAvz8eUpC47Ucla4fKs=;
	b=zOYIWXXpNwxyWfaVKs3ngeFyPJCdcATgShYpxTu13YSPeDBtvUnGOujUz2BpSAAHqtHF
	 U7euuW6IdL/h12wheHcCzvf7p4/69f3iVFCCrrZQOXJoUJp1GxswSEP3LsEalW9roEMiz
	 dmoXyzZ67usb7jb/Kp0FSss7t4cZt1SeUic102eLeEUy/jl9O3hwXr5T4gDfCUu8c8pPM
	 Y3uE0UxGZf4TDVJRlww7rFEnNRNoXmnc8u2rnoPm3vtHz8tNpLJ5yueVzydrbGNQQ5Pmr
	 t+YnfcX4OpawR9fVU87Gjfw/1t6FnbPkNk8g2Ve2jyNGA1ZuwYQuCRiuwT7Eys/a/9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=NggoIRwb;
	arc=none smtp.remote-ip=203.205.221.231
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9951606A325
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9951606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=NggoIRwb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795181389; bh=6J6hVWng2rSlwYKEbhFdmNXPBAvz8eUpC47Ucla4fKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NggoIRwbnxNA0febIWgrME82jVPE+PeYaTr0cuXekycJN0cCue4l5RUk9xYghKuym
	 +EMUrStrh/5xrz0hILEe047z8oSQBHHbZwkmhFopkeqpXq6FlJTdITNrWa7/qmYhj7
	 T1qXmPJTv33TNqWOczf4ULhlqZEyVqCm/HUD4Lzs=
Received: from [127.0.0.1] ([111.55.8.126])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 76E850D3; Fri, 20 Nov 2026 21:29:46 +0800
X-QQ-mid: xmsmtpt1795181386tmurh89pa
Message-ID: <tencent_9FE25F20E92F65CD175FF65FC4094FFD4808@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+s8WjMUMbjuv9P7yD2FNN/hOpOHexMNYq9P0/OTJUBI2Iwn+Jhy
	 GkANw7lDhIsFhqeJuSpsplhbP3YfdE3bl5IyJIlmlQRqEYQQw+Z7T4dRdqyzlnOYhUqfuY5Z36qa
	 +po63EfeOuj+IsiafyD0uIAuGa150riuIQdTX5T4PkxDylFIknjUj7hGI5MP9aevhp1SQlhR23jT
	 nR+ApnRZ54f4wvMHPMJSu+/PmKdNGyodnpaLK1X/OWLahmdBURflW14dEcb3kFyeN/BduogbXYR8
	 m8jSVa3dXFidrEs7Pf+9UoeqmX7I8vEgxVlgetsoto4xhb1XHTl/20BL5rcMfOiGMeNacw1Ztu4O
	 OKh2YKRjwqogeZcq/C/+YGQhp93yL+rohdh7nESy3qF+3iIUZ5tK+IVKDcvliTEOY94Ky9DdWtQF
	 KE5wsPiyX7y2h3cGtYXWK8AWHE1uwz0lkYVBeF0ANg7LJFN9ewIowI4QzjCRtTpytX5V75T8Y6WV
	 9iZUgW1/tcnfxO0rnUpqJ7SwVU1RpU83Ia7wdUt0NMmZvGGgi/KsdK24AMjL85k+m3+VJbRuhOJB
	 mB/Kcfvhb2Ya0Wilr7kQnQDHOABIFOH4jHhU42oEQX5CEWy6wKEPNzblziTzcXeLElZnXu4v+avy
	 V5MAJvEkdSv0KYUyhW2H3GOo3JamKRHPSVDLQ3MsEQCgbWCLvkReprYirIn3qNYLKQaPkSc9Zqc4
	 iAdc6kLwtmml/vFLcJd+EJUXixrOOmno8WQoCBRMBSSR4xbXWb4pD+rRM+KohRj2kkkELbDUhnyM
	 Xrd7mnqRDGwA073L6IhkBlB6jXOJgVYVGDtJ720b3+Juo6TC4B8YSAFI7H+Bmef7FSaTpv73xjoD
	 3nP7zxLQWuKMtFHov7EiUN1bi0+zPksSGH2jk/Sl1dK+Tga2wheVum8AyDqrFh2R9YTIhY2x0OrY
	 Q7+7DIa9zvsnxFcs5Bj+MQao6pKziumjMjpGeI7T+IhrKAlwTIQynfpUbQxAxEi/kZXNjSbWPDUD
	 RF+MyC973itaMS0I5oUTHO/x5x+iaLZOVkj29LN9EypL0dD4uwu3GrBWcrH5A0MhUUntZkqrggiV
	 NXd+9r
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Hang Nan <2122295973@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
 pav@iki.fi, zzzccc427@gmail.com, enderaoelyther@gmail.com
Subject: [PATCH v4] Bluetooth: RFCOMM: hold the listener across child teardown
Date: Fri, 20 Nov 2026 21:29:46 +0800
X-OQ-MSGID: <179518138666.64680.3988250149393352623@qq.com>
In-Reply-To: <179517710658.56988.15563657158904954302@qq.com>
References: <179517710658.56988.15563657158904954302@qq.com>
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

rfcomm_sk_state_change() notifies the listener through bt_sk(sk)->parent
after bt_accept_unlink() has dropped the child's queue reference.  The
accept queue never held a reference on the listener - bt_accept_enqueue()
only takes one on the child - so a concurrent close() of the listener can
reach rfcomm_sock_cleanup_listen() with an empty queue and free it before
the notification, leaving krfcommd to dereference freed memory in
parent->sk_data_ready().

Take a reference on the listener before the unlink and drop it after the
notification.  Same bug class as 4020751fd0df ("Bluetooth: L2CAP: hold the
listener while notifying child teardown") and its ISO counterpart.

The reference cannot be dropped where it is taken.  Once
bt_accept_unlink() has run, close() may have released the fd reference, so
the sock_put() can be the final put and runs rfcomm_sock_destruct() ->
rfcomm_dlc_lock(listener->dlc) while the child's socket lock and the
child's DLC mutex are still held.  All DLC mutexes share one lockdep class
(rfcomm_dlc_alloc() does a plain mutex_init()), and this function already
runs under d->lock and takes lock_sock(sk), so that nests a same-class
mutex and inverts the d->lock -> sk_lock order.

Release it in the existing SOCK_ZAPPED tail instead, where the child's
socket lock has been released and its DLC lock is dropped for
rfcomm_sock_kill() - the same place the code already drops the DLC lock so
that the child's own destructor does not deadlock.

Gate the put on the condition that took the reference rather than on
SOCK_ZAPPED alone: __rfcomm_sock_close() sets SOCK_ZAPPED directly for
BT_CONNECT/BT_CONNECT2/BT_CONFIG/BT_CONNECTED, so this tail can also run
when this invocation did not unlink the child (d->state != BT_CLOSED) and
never took a reference.

v3: move the sock_put() out of the notification block (Zhao Li), and gate
it on a local flag.
v4: resend - v3 went out with the diff only (no commit message and no
Signed-off-by), caught by bluez.test.bot.

Suggested-by: Zhao Li <enderaoelyther@gmail.com>
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/bluetooth/rfcomm/sock.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

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
-- 
2.47.3

