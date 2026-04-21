Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BDE282F29
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739897; cv=none; b=hjd/42g1KAhq7s2KKk9YjFtFVngHrdOhWR4JONJRpy2k+89h0/iUO9ykgEgln1ajYKbM6FbyEsmk1dK3HpFEHLhnrIo0kZ/MM5z4V5x9RpmAtE1DRqRxy70XdVTnraxRg0ra0t+Kh5hNrtEvKHpQipBp6nS5i2q5Q/mRDhicl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739897; c=relaxed/simple;
	bh=2GmeUgsVld79fKl1iNI45/UB/0MUWB93JcGKPSGrmas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3DZVHRgQbzUbqoUn3i5DDuykBnGKVHvHSP68mlsdTxDq0MpuYQL3q27XkVyU9d8YjKZ/lLdz/sPOPSFAF7VfcjXkX6qUVaxd+Vtk86bq69kd1a6UtMLceHBV3vE+SNRGaqIq0PemXeUvQNgSGFHJSG+ziUB36nNTAYcs/KUqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLT3/GbE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLT3/GbE"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so1735547b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 19:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776739893; x=1777344693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ95cJBTtwe/Q3ftFYdsD7Mm/4M8Wg0mB6kbaOeJjWI=;
        b=LLT3/GbEJBKqvtCxDzMplMKaq9W7twRUM5LB2NSL7xv//iAAJyEYHyKv4yDcDKymZY
         LZus+qvZU0Cfbb2K4AYvsdABZd4v8yqv6896Gsw1M73YnVZs2UKcnp1bWeJMaa6F02DA
         jm/RKyXmBqQTEFnBIkDMZ6GMoF0Sx6w5nX2hR1N1Ry56m+lDOSUxiqGn/i443X3h4M/g
         snpdoZwhOTXJ8zDB46OfftmEh0boIylpDlKddNIyJBI2f/RrY0zJbiriRE6ZvcJUSNY3
         KXj5r9D63om2P66wfRaawNdjJE5NUxAFhV82C3/CVG3uvTzh8DI0iSrS14zZvooF30+n
         TW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776739893; x=1777344693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJ95cJBTtwe/Q3ftFYdsD7Mm/4M8Wg0mB6kbaOeJjWI=;
        b=F2f02XFap3zGqhb7qg5uKZFxiBO2s0/mMnFFNb8v0kyNXG0aQmxmphhf95Z9JTPhX2
         bYHYev6DG+zAC7CMAeg0Oj/pHaYRmgNqybs49hv17vcFUjNwIvWzKAUxm/c4xZOxXGtr
         Ivhjgp0kGr59Lmnl2ieanRewQmKdE+HNr9+qLHuTZc8GFJyQ8xsMu3/yzPpb9E+Pg6C7
         TcukPLgwSF2y/XOIhZePP4irM1phQ0rc7GpknYGuidxyNiy282F6G7BzQ0GmWVMbMVWZ
         gxpOawe4JK2LvLs2QUL7NdBtPGDlsDtIiRqPRAqAXvawGaVj4j2jKOf9cxXnotlUpdiu
         ry2A==
X-Gm-Message-State: AOJu0YyhV0vvJYDamfyD56dDx7QGNcLSXia14eQQv7GN/vIDxubM4Qz/
	dRFVJXhzJFJwtAFobPyPabZfyiWfx80eRDUkDkce0O3GS39QpHnF1Exv
X-Gm-Gg: AeBDievWHObEiJtrlInqGAJDngKRJXSlE3n0Bc4yFcZqGcznu1sAZtF5KZBKp7UJt8r
	Wa0/g5lYQDfpJLcRE2+pg/liNq/odQ0bvVdRJQ9PwHZz24gAwKd5plAAR8lT5NEKt8Oiw0C53te
	glOBaSTSWevr4esfOLZCvSpdrRP2LMMQudfO169mTLQHEZM7rqB7eNEMKWj5QjKJzZbEjUBR+bH
	3I3eKoSu+pCs1kJCTbazW4UwuRXFQ8cbBNQ7Kidhuh407kYqbczb/kQm3gwdu0wiOn2oHDUbLRe
	vRPZSarPWVvTnYqLtF0lHQSVkCDHtjpWI6oJsZE35gLKy12rqwLifdRZ2uDl8YH4wjAwMBUJW4i
	cR0ACwH23y6vJbQItMksfR70PK2UIIM2bdK54PZwcVg4MVq2/Gpctt94Bxicy4ZADqyNBUmLsOL
	upNytdEvP2biT+dRq9sBesL/WFUHAdUHfhb2hPwDyydKDBB1hBQu5Or+HKTQ==
X-Received: by 2002:a05:6a00:aa08:b0:82c:66f2:1226 with SMTP id d2e1a72fcca58-82f8c8e4febmr15916913b3a.38.1776739892565;
        Mon, 20 Apr 2026 19:51:32 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm12823502b3a.20.2026.04.20.19.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:51:32 -0700 (PDT)
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
Subject: [PATCH v2 1/2] Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
Date: Tue, 21 Apr 2026 11:51:21 +0900
Message-ID: <20260421025122.55781-2-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421025122.55781-1-suunj1331@gmail.com>
References: <20260421025122.55781-1-suunj1331@gmail.com>
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

Fix by reading the destination address directly from the local
sockaddr argument (sa->iso_bdaddr) instead of iso_pi(sk)->dst.
Since sa is a function-local argument, reading it requires no
locking and avoids the race.

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
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e2736b7..290a1b9a9daa 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1193,7 +1193,7 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 
 	release_sock(sk);
 
-	if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))
+	if (bacmp(&sa->iso_bdaddr, BDADDR_ANY))
 		err = iso_connect_cis(sk);
 	else
 		err = iso_connect_bis(sk);
-- 
2.52.0

