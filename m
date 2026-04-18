Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAA33C528
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490467; cv=none; b=GCW+uTu+f3WMYajz408a9n8La98RB2dO3vpVKr/BlfIP0b/DjiZPg1yqFr1vinb/Mc+ZO0XXSPunYBBI+L7tynKUBpe30YS8/CnmbxSiEC1fNuIt1MCBdSYIDoXnkevnocw0JuSMYNVj9VHgr0YON5Uam0Amo5I3w4i78j9JkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490467; c=relaxed/simple;
	bh=C6Hn3L10r5uhLd2QzSnPaJi2BVQnAFECz4DQWvB6GuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAGhzJJKkvCvfZ15X/mc1eIz2KqTYYw3sw3GCIb1qWtYKIOZpc18JR/XdzbbXPwPRGLNAWKycFO6ykS8YD9dUwvplc3+52TO9F0vK+Loaz2mKxs8kTM/lBGKWsNmP9xQtLqgn5ZmHcWNJBRkIzFMTdjQKhQADj/V2Ue8KXIqBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj2AV8xO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj2AV8xO"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c79467f128cso504621a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776490465; x=1777095265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTLB8mgGvaT9B2aXVBnKEZE3IH4dRJ493bKxw7Qh57M=;
        b=Wj2AV8xOZwiGNnzUlzPLyXKgzP7N5Lfs66P+JzI0V1unT/jWACx2l8I18X+upPDTF/
         cKF16UalLUvU3o35mime47e2bYL5/QUkS2Pi4SUOvWvv1tbDCgmHAU/duNEdK5xTgK7n
         itYXRxEQUE+9OcLEZFoE95JHkdyuamtrs3JlB8a1Yky2in1r4l4rjlX0hiZXgt6h3VoP
         3cjdBQxQlQvNbUZDNJTTuj70J2fev3u3rFbz/wCjyCxWb6wG2gun7i1M/Q151jtS3c9p
         r2k2R8DO9unv0ME3keb4GAyB9CiczzEO4K30yPTt9ZNC1UWv28+a6Qj+25r9NicYLigw
         cyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776490465; x=1777095265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aTLB8mgGvaT9B2aXVBnKEZE3IH4dRJ493bKxw7Qh57M=;
        b=X3ASvNxOPiPlTXOh7YnEr4rrmqfY5QP0CBUIs9KkBNAG8h2vCBS7m446e1xUCucdoZ
         PHFEeRXTZgYIBZHQE2qRbEj1glo4hGig23rcNEGleMS5vDMz4H1ze2+Z7lCpjA1JaTpL
         v4MLi6NO+F+iOZzV/DutlKMzPZ1vldOIh6f0mbp0f+RDzaoVXkmDi2FqXLitxMR/zw+Z
         ACPePRkJQmPOowfrd0GTNSyZVRWkcd3RDFKVu5qySh3dwYzT9LShbgPIszXDvz0+4etX
         kYthyNHTnps9luvHj0YDwS1BTnK5V/pQNPkxwgsWoKwsIMqJWfHT41lUApXEh2HjuQ4z
         kkCA==
X-Gm-Message-State: AOJu0YzIRiKDxK0/PKklkYGiPAJ74067UcxAR2eY19PCaYJUJq2WUNmp
	+zY3BbnkBFYedMTUl1yf61SaFnE3RG0cgDh1YOXwD42ZW1Fyyz6i232v
X-Gm-Gg: AeBDiet4qH1NdnYRjjmiPUpfCbLGsGwrswgATx2duSAbOPFeaSZzF34jW4fk8VLdaY1
	iKnVzwVyf5F9LPNll+8jqIcefB8iGsI/5r6YRIVc3dgs1+6UudfZ10l53sLEwi+qkds4Fulg1zO
	Ymcg50iMCBYglR5xrrTP9T8we5BnfJsuahVsi2jHtKae2Cb8nKOi78y3XTtfBAuYktYgu67lEL/
	PMErfVYfGf8v7/k3Y4JrNBFGJpxSt3szOsR92Rui0N1TMTveBm7BVbb1h9Vrwn5JaBcFoAu2jQ3
	VY6fhOhNCx+YRM8VZp9GRpmiTGnXDCff16H0QwxaGRj3eCeVy/dz20wUqd3MY+Ga0vKiUirnA1/
	YGC+08M3CZqxX0r41LtP7eH14S2VJegSop0zjUcWhmgCkUbOhRYpgdWkdOw28Eu+z6byYf6HQ4h
	t6A7T9Zx4YF4putPi8SlLLD9acF+ym64qwwaI/rnRwsV5SSdbQZ0Jn9dSWOgvxpE4iOQwA
X-Received: by 2002:a17:902:cf4a:b0:2b0:4b3a:9b4d with SMTP id d9443c01a7336-2b5f9f1c862mr62346035ad.20.1776490465079;
        Fri, 17 Apr 2026 22:34:25 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3bfsm46251885ad.7.2026.04.17.22.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 22:34:24 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH 1/2] Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
Date: Sat, 18 Apr 2026 14:34:00 +0900
Message-ID: <20260418053401.128483-2-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418053401.128483-1-suunj1331@gmail.com>
References: <20260418053401.128483-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iso_sock_connect() copies the destination address into
iso_pi(sk)->dst under lock_sock, then releases the lock and reads
it back with bacmp() to decide between the CIS and BIS connect
paths:

    lock_sock(sk);
    bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
    iso_pi(sk)->dst_type = sa->iso_bdaddr_type;
    release_sock(sk);

    if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))  // <- no lock held

This read after release_sock() races with any concurrent write to
iso_pi(sk)->dst on the same socket.

Fix by performing the bacmp() inside the lock_sock critical section
and caching the result in a local variable.

This patch addresses only the bacmp() race in iso_sock_connect();
other unprotected iso_pi(sk) accesses are fixed separately in the
next patch.

KCSAN report:

BUG: KCSAN: data-race in memcmp+0x39/0xb0

race at unknown origin, with read to 0xffff8f96ea66dde3 of 1 bytes by task 549 on cpu 1:
 memcmp+0x39/0xb0
 iso_sock_connect+0x275/0xb40
 __sys_connect_file+0xbd/0xe0
 __sys_connect+0xe0/0x110
 __x64_sys_connect+0x40/0x50
 x64_sys_call+0xcad/0x1c60
 do_syscall_64+0x133/0x590
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00 -> 0xee

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 549 Comm: iso_race_combin Not tainted 7.0.0-08391-g1d51b370a0f8 #40 PREEMPT(lazy)

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 net/bluetooth/iso.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e2736b7..14963ba68597 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1169,6 +1169,7 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	struct sockaddr_iso *sa = (struct sockaddr_iso *)addr;
 	struct sock *sk = sock->sk;
 	int err;
+	bool bcast;
 
 	BT_DBG("sk %p", sk);
 
@@ -1191,9 +1192,11 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
 	iso_pi(sk)->dst_type = sa->iso_bdaddr_type;
 
+	bcast = !bacmp(&iso_pi(sk)->dst, BDADDR_ANY);
+
 	release_sock(sk);
 
-	if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))
+	if (!bcast)
 		err = iso_connect_cis(sk);
 	else
 		err = iso_connect_bis(sk);
-- 
2.52.0

