Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230529;
	b=tAgydvsHfW5v09loj1u2xDK6ldroVGpe2yNu2O5kclNuNP984e0Pjjgr0xngIh1SuEYx
	 VOiOR9HX2/RWKeJ/ATxeCpzte7EX5K/k9VtaBeeqODQHMgdSZSKXluWYX1hkU8myAO8di
	 18WaaRMxAuJUwqB01YIwvz1jPZgStg3RK2Wvccz7B0karykMrSfFdszQ1eldI4PDmZo3L
	 PcIpltkZO07/qDA0LVFBr4iJ4B7aUBe21douVXAecHXKFzbxj6EOQybIaZVVngIGybhUl
	 EV7iNp6qZIewIOeB/xRM/1DDHYT7go1YT8g8KjnCr7KV5Gp+Xr1I+rwCgNNePOYfycg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7we/GAiwR1WFvHBihvvXAm5IAlU8PXz2kOkz3WvO0/M=;
	b=1AZKKeEqP+PtCv7JCvnnX2AcdhCl0vGMEskp3dxCZdV0xtkU9amdQ3OZU0dKWilA4AGt
	 NkCdEjNIWp3wtf26SRRi4fJMBMs+5lOyyHeMq+EkRS23/2gwwV6gjakVhEMGkZTWXQ7zx
	 6uIw7mimwt8svey1oLFjGJXWoa2SWBvZw0o3xrm36vZexCm4+mFtWQPkC0xeUvgPvL26p
	 saQz2d32Ga5Xtu2wA5wBdRYwiESOwaUMms9H+mnfHazGjVi8Lm9lRTqizvUE28YxQ7o8Q
	 RmJz3R2lyUJgLPzlgoUeamehlPzUFFhVPTN2Bal/9CH44a4fpZPGfrYgCOxV93uDGnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ssn/dJ0h";
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96812606A321
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 13:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96812606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ssn/dJ0h
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso303792a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794230529; x=1794835329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7we/GAiwR1WFvHBihvvXAm5IAlU8PXz2kOkz3WvO0/M=;
        b=ssn/dJ0hIDcrWl8YGRCXQ0Oy2oyESWTAeJlYQdSL4pfgeUEik2aB0njapnZkBshcU8
         GDKFf5Jz/hzGT9GHmunRTpkzbi4eKo1tk2GR1U6q9qRTmUyeAEEz90NwSYMO5CU9Mj+j
         HeUt6CGviLhQrstxgXntw9jw3BM1tZl2Ly0uSF4Ua+tSl7fx7hYTyyNKzY7cWWzqal//
         VlNlL3w1h8fgUT0fl+dLKGCOwc/5ZnadDA9SszyVommmFwKcDBeXvlpLBJqjGEmOS41T
         aAQ7E5lCbg4vlT4315aUSUW6B0uQ8XHVhpYKZODYlS8KuPGLueV27EHfw7v8T5LupU4R
         YV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230529; x=1794835329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7we/GAiwR1WFvHBihvvXAm5IAlU8PXz2kOkz3WvO0/M=;
        b=FU0pm5QXLQoUTPw2IRRp151RJmcSwsAEPkDIPNH9CHjaODUr0f4dT36Ot19Ynad8Yi
         0LRsHxYVPg1eKwGvS+7RRYNdOylyNkKuIWbca1BDsbJtF0UJ8IqZtp1rqow3gk7ZjIKw
         z+qdjlHCnSFA9rCNFgwEg0fHbcj4c214xXvsLH4wGpLFJX/3/4kBobJoMc9G+/Sxaw9n
         aEAum26H6pSUgIB3N9bxx0zvsWdW5BQiCrq1pdKgU7fa3biFyk4L9ZaT/5xWOmkll3zM
         +wL+tdyNM4CLUJisE/05Vhu6Qr32gbtgIp34WWtPUZelkuPigxR4lEu3KNYl2Ezt5a2w
         +uBw==
X-Forwarded-Encrypted: i=1; AL+hErHPqf92J9bJZDzzR73V7IJAJoPy61kDctfft94Xw/R80mJkUrKdTr1MCDH+tcKTFNW0jcc6fKNTRviwrchHpKA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/thRXkppIK5OZ5RiZtv1FAWI44o3j90Qhdm4VXuqHbrZ0yHBjv
	M2H5zblh8ZImifrAhPv/ghcnSCc873bjD2G0rZdtFzL9nfE0TDx2gV48XwMpUTSC
X-Gm-Gg: AYBFou2Nd0fBJVzjXrB0maMqcysoVvZzbK5CavsjXv53EG5a+M3zwYxNUD40UmEBPuw
	LsKPBemP4hA8zY+zON5sogMYfHPAgNg51nHvSehBxIDmdRItG/Ryth2L/qjrvkH0F5zi7S8BUn0
	e9bQUkOkAROEepGZLLQz49AfhkPAuP8CTRNyNjVOSO6LuQ8kzIU0kT6zl22lDxQUPAIJWTuPQNX
	OlJcFhpVxLCDtHqhqf4z+i/zJ9K/sRDPIlk8m6U4DVbkPzgwjaEkZpTCHHAFR2dQiKljHaTHOEI
	M6wm62wZedewGRw360aOigdwoW99dvveI6RbdBq6kblZZHn2vTlbUPHDT6c/A4yjliXu6NsIJza
	pMvgfmGSD0k5EGLxJitP26wLakGaJ85bbHdKrMEFI4SE6vxtG6J6G980L3ie+YZZCUHkriSMdOo
	tH8Ykk33Okipu5pkXoazR2c7MUajpNJSnpLiBg4Mxtrg7xV2Y1Ku+labv9/vLhr0AijG9j93FVy
	iz/WN4iMUYR46e3HjrwqkGd9gGtNTnmcce3VacbYfqBTn1dTVQ3CG+fggzNzdNB9UNKWrsc+WC2
	zOutNVvKg5C+2UQNur/BN5UIXuiYakgk+YK8mlDpP4NZo/PkjORemK0qziHY7SyP8ly2
X-Received: by 2002:a17:90b:3ecc:b0:3ad:43c1:7d41 with SMTP id 98e67ed59e1d1-3b12d37dc87mr3626719a91.33.1794230528418;
        Mon, 09 Nov 2026 05:22:08 -0800 (PST)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105881e6bsm11010043a91.7.2026.11.09.05.22.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 05:22:06 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	security@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel
Date: Mon,  9 Nov 2026 21:21:43 +0800
Message-ID: <20261109132143.94305-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Reading buffered ERTM data after ACL link loss can clear local busy and
send a supervisory frame after l2cap_conn_del() has destroyed the HCI
channel, which oopses on a NULL pointer in hci_send_acl(). The socket still
owns its L2CAP channel, so its lifetime does not protect the underlying HCI
channel.

Require BT_CONNECTED before clearing local busy in recvmsg. The socket lock
already held here serializes this check and send with teardown, which
closes the socket before the HCI channel is destroyed. Continue to allow
buffered data to be read after disconnection.

AI assistance was used.

Fixes: 61aa4f5b9f43 ("Bluetooth: Use the transmit state machine for busy state changes")
Cc: stable@vger.kernel.org # needs adjustments for 5.15
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
No new W=1 GCC/Clang, sparse or smatch warnings.

In QEMU/vhci with KASAN, the base kernel faulted in hci_send_acl() during
busy-clear after the link was dropped, in two boots; the patched kernel ran
31 rounds that reached that state (RNR sent, slow reads, link loss) without
a report.

 net/bluetooth/l2cap_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7a2551ef7f50..e5c15c083c1a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1332,7 +1332,8 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	 * available.  This avoids resending large numbers of
 	 * frames.
 	 */
-	if (test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
+	if (sk->sk_state == BT_CONNECTED &&
+	    test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
 		l2cap_chan_busy(pi->chan, 0);
 

base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
-- 
2.56.0

