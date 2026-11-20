Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182065;
	b=pv1SfAzpVlV8m9im08KnG+H++JeYvJfNJrYNXKpm6jHBnGzV2z2wR1F7O6IEL2vPEC+9
	 HTyMopGv8jrnX2a3qnYmcqD5UNcVkdgZpcpf2HpMiHis8fctP0k3m0utomezSRYTXWVDg
	 m51TeCqdDUbU4F2TV4Ko5pAiMjzpHi2a85ovbYdtduYocBYBmOV2B4BHd9Zixl38Cb0At
	 ZC/F8GF5USXbRNLBvvQVnK6wo6jr+KBzqneQqS8xJXKsvyfF+drecognNfJhhJcmDGiwd
	 hNWJEtRr3p0dmBMS60jvI+K3RrN168aVVGq+XitF7+8ugl1UK13CwYRjd5i84rZ1zkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182065;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=6J6hVWng2rSlwYKEbhFdmNXPBAvz8eUpC47Ucla4fKs=;
	b=nK9RbsRL8wFbgQ6lh1tP9Wpj7MrbFS2VTtkuhLnh5VPoGNC1rQ6IlANlpxo/tF2lyCbG
	 I1QTITx9t/vIAUsQRnjfVEif+k1boxiVb4U1nhUzI7JOLcpWxeeKsMezJKUoyckNhq28/
	 ihsgpEpPXk6dLCzwPUL7YW2k2MxsmaqrdKMXQc5roLeFsevJjhnlh7jF3vXqPxyILVIDW
	 JGuH6QA30xmVX9b7v6DjZ3mFOmx5zw+enaw2XrP9yjWBSi+8ydoEAL9D0Am2dV9IPW9pu
	 YqMlkZHLurMsiC8xQB24VRZkKQ/H3P2zcQhyA3LiStpQLSTbn4HsKz9AVM5DygMSGzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OBMVqJyt;
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D1B60A2602
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D1B60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OBMVqJyt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795182052; bh=6J6hVWng2rSlwYKEbhFdmNXPBAvz8eUpC47Ucla4fKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OBMVqJytk0fcG3mVF3xaon2CwcDoPFLpMhEyRrKvcLojjXrkHkZw52vCI3hHoGrrv
	 r2wESDGRTaM58hFmaSjjTc5ePfq+LhysrIS44qVV1MziWPNQ9mX7SDvRb0/xuLzAFJ
	 oD/brX4OavDCNyNBM6GE0rIZ1b/7/fvmzQKA140E=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:65c9:1ea4:b234:d5d4])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id A320CC11; Fri, 20 Nov 2026 21:40:50 +0800
X-QQ-mid: xmsmtpt1795182050t6nfei0cn
Message-ID: <tencent_FAC43B4F7D48065F3FE97765001726F60A08@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtBD8Zm1zJWKzVnkbv9rWpT56sMYdTQKqFw17Ui6empn9XPBZECK
	 bkEZGn+XvSd8cUGKXnA4cpfkf2wVQRFE74C5OcIXhqh84JEmmqXhEjv1OoQ8dNMkl6maygdb/VIT
	 /c/UogczWuTvWMTvSg6/D2snXz9whpYkKN3/q8ENkE5b75x2GvEl9D1ZBXnx3ZKGm3JfQA3iysqN
	 2Dd+kqgH0UapOvJhVefAPh9Zehfp8dYP1w7hfaG1XP5I9VFPCD/fdqEvg6qg6eQWp1A9vdonecf1
	 mdWO4ygdTxL1FfSMB3LwRd3jp/AKNEyAeBvSXEwH2tfYbKH9wraZ37PRefD8Ms5TuhAj9jCL58cd
	 Jx03a1ROtK9U4EcMerEWXjm61OHaF/3Ul3J1vegLf7/HrBnYWt9Dtl5H8nGtV3kCMHvP6lXVgUsf
	 fH1jL4bpbBU9ja7eLJp9kVlLCMZG1bBNz6H8GAyaaInv35ai5R1tsodQ+fXebZZV+jfvWRPxagRR
	 49H2NvIpn7WzvXOp0s6g/AY2eHa7NMk7Gs0+qRPu6lev/ALrwUxoMUSnH6t+UOLt1nwROEBL8G3i
	 gU3qzqzfpsgxr1JSQFRicK6ln1nVbiwIcrxJVnwwG5KPhzZ03UPJWLduEsDTYlwkV/xn8hF8eW2Y
	 ap2zUlZ4hNn0NtHTsM6mgnvALVsPUKgRb45InjDwQFjCwo8iQTY/NEmXjpS1oha9gKso24ZoUIp9
	 GrGt4kEqwe7kYo2T2Z6jWbb9I1ri4raWpnkGL3In9pTE2J5bdTIAT01SNs30+b6JllIKmiVv3zor
	 AQsY83DV3htqE0Vgaxay7V22bEHTU0bbYeCFdY+WAwRQJcibQJm8Sz/dK8mUJY9tzz4k1gevkuoK
	 JqHlwTyvZFEyFTM4vdsWzDmF9UHD6McO+POUkkOHxii3ynZV+4SSCDSWTrZ46F9//TDY61BPlPEh
	 we6+YdL4VK5ngBrF/+AZ14yroVphXJVgu+I3e1fNde7AtkrKDUEphu8PPskqB2vLHQz9JItced2o
	 VXK9RIhVOJ+rcHdpmLiEx3m0r7i56lAdLjIqoeBJ3fhNor9Wyy2VyR3anJixK1ObH1zzxo0tSzMn
	 ++S+Yb4DwAeM5/oxzvGA5rIe7tEQOMeKpk7wJVPwi9+eBIBWZL9YmePkotDA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Hang Nan <2122295973@qq.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
 pav@iki.fi, zzzccc427@gmail.com, enderaoelyther@gmail.com
Subject: [PATCH v4] Bluetooth: RFCOMM: hold the listener across child teardown
Date: Fri, 20 Nov 2026 21:40:49 +0800
X-OQ-MSGID: <179518204966.64680.13551839061949152667@qq.com>
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

