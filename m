Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182533;
	b=sdIZi2IBhslUiI3A/HI7JG1bmYGy5Wkw0QsgD2/T0VEiyJto83wLc9+7CPnyGqAYQLpH
	 EtfgO+2xBIlRyMNG+9wMBI3CmbgIU8BXksav1aQOdUiPZvrEzUXaqp7n2P2zBwLgnG18L
	 EEuQubMukI0XVqAw6uax17l/Y5epLMdSG6JfSht6ll/aOBWouBnnshxYk+yM9KcTpQD9c
	 nnzxg1ROKB4JJIbp2Ff2C11aLi70hE1T1pi/hh3rRzr0YmDf/UycPK408etIr7RTh9V6D
	 tBpoX7BtpdOzN5Ih6su4xOa4APzedIK8VzdI4PRCNg4NG+pEGwQvbVT2JUIHKkSAlDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182533;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=6J6hVWng2rSlwYKEbhFdmNXPBAvz8eUpC47Ucla4fKs=;
	b=PXfJ75RvD6WesKxtniRhkdbHum4Wk5YXIr8gQw7K5j37LsJD5xnkDZZs7LQTctUOB7DJ
	 VzO2P2XKpcsFUhz2Nu31rQeKcEkKipUq9yaNIyPrleZCIhR7FHqnFk+GKy0L9q6JHcRKJ
	 qvZ5ZzRIJL0GkfUUlhGWicgkaxOs4cCi7tCpOopDovrAdmYsh1lMcCjrc/QVzQx9LEiKA
	 m5zT5i61b2Ik1+LGI0OAOqmUQwHxAcyJ/HtmqhO/DE2utSm2BBiYbjU4mGcaByKvaFSwM
	 eUInH3jQ2eDdvjbY7zDImATmkmXSOObajPttQDr991bLXHbKa2byB9V31UpNxGz7urw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=AjpzNVp+;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B2606A33A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 338B2606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=AjpzNVp+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795182521; bh=6J6hVWng2rSlwYKEbhFdmNXPBAvz8eUpC47Ucla4fKs=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=AjpzNVp+zwz7gibWHcU/ePfgaXMlm+4zMAaNFHCBOHbq4h9Ig7xqqtFGISEWhwOxI
	 6TSYtmQakiY7ydSIz+ruTWiZ6XCOWEieF0Y418U4G1HVquPap7cScJk3YswrdpziYH
	 b4QTi2LB3C8iNRM9v+ogkxVhRwSzYoLKOVzw8ygY=
Received: from [127.0.0.1] ([2409:8d5c:8f0:65e5:65c9:1ea4:b234:d5d4])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id C28118D9; Fri, 20 Nov 2026 21:48:40 +0800
X-QQ-mid: xmsmtpt1795182520t4eh513iy
Message-ID: <tencent_010B36BDB8ACF762CE3E9238EF090609E205@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznDLDz2Wyvu10gQ9/u4nV7M0RwxESTrCmxmV2wZNaKo/+/4xxbzi
	 qc8H2Ad44QbU6OgShhXm2/8E8rLRLFfWJ6mntfEVqmOwfVVGDdPknIE5Vuhmd5u5GW7bytkPrByG
	 48vhweNTGw3+qOxotDyVAkOXZVui5poqMedQrF9e7MovJmrNlfh8Yq4mIQYSifcFtQDDQYpNBYtL
	 OSxkzdXFZnIdtkzHsBdri+3/EIAOyhX4fttCagWFsR8HD+lUG6W/QxLU/M4Gq3kuqeJzVT2TqJZo
	 5tcQ4IwhjdVAZTj1ofxh2xDAfXstxtnx9dN1DoB+6K+ZwFCJbLjpipc3RTVf6j4JyGMTeJJG2s9S
	 +R52MsNb3C6yQgY/Rmg4Sz0b/K/vq1kvq2YaWuJD3WAQcCCL2q1Ph/et2/8iAIPwsUJmT/auMogv
	 /iwDc0BLxYnBxYsstTsj33H2nsJul7MV7RpbWDSPzLBZpgWlpKz1upvIBwLoakV2o5MkdiKkhc6d
	 JKJD633ag3Om9auOLNPLg5d5CL/WN6sI3R0x+mzBHfBI75OhkcBhK2C9goL6U0H6j+bUgD2x2D9Z
	 2GCOdy4euOw32s4sgSv4HTDh1RV6MX4a9Ze5gSOgEOWWA9W6O/ysRm5en4Tn7B7oVDIBEfPkxWXj
	 g/VAl/zhhfes7eETZxY2fUdRkGRH4El31wBWHAcooSGKOfcHrBZGteOYk9Idri4z+g1x6mqiIbMy
	 UulOw9rdi7NFrmffRtfOFYpu9D8r7VtxKi31EoqN+kOvHUZX1CgNVqxoPv8leBSdijBowvVsaoqF
	 toJQeXZoITYbihs+4HlUo8yCpPSTFSGYtquaoRoMdxd8BYiIRBKOcb4SHpb4nBlTwuNIeAugcRes
	 8qNQLAboDzTqDb9Pgl935kIo2MKnC9vWtO6V7z1NiB1AdSbMQHvmWypFi0cYO8qIw/4taqSDbxrt
	 SgdKipNMuUI4JFBAcf8Ce5sCTMa+G3Q9ipW6XBwVSqADKNfTMv1ZV36MO6hir8v1yvmsFP18Jtov
	 UeGF14eJhomNBJ1N8AwOlcQJ0ndmh0FHBi8SfqMrI9nTxYINdD2kBOH7EWgbdnUyBSq+z5vzUktN
	 /HYx6QYP0Jh6GOC9V6uX+Nl2cvZeuKr7SHPvcqvX67ZWehkYw5ie8CqQewoAkwfgmHSqOpDEEDxS
	 m4jVsImVWcFkGTpQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Hang Nan <2122295973@qq.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: RFCOMM: hold the listener across child teardown
Date: Fri, 20 Nov 2026 21:48:39 +0800
X-OQ-MSGID: <179518251986.64680.15473101899696216335@qq.com>
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

