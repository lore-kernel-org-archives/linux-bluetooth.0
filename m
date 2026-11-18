Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995354;
	b=Q8w9mGI+DcVp7zch7IsrDyaM30FFJWVt++tc1XB2rAXD6FzXd855C6ohH30j46dPjaSU
	 GIMazCn2paw5JjqisEMPuTg1JXY6OUbXB7AjhSu0APS+uZwu8FHz5M4bAukHBVqO0QAnq
	 GVdEVEjU+vT5m3SE1uIPpXGqY9XB+cUpykmhgPlsdSnKpJufmhaT3DXKmEljyHVfS1Xfo
	 OMl6YQkSsht9JXusPVu/kOtHa9V0q7gonVWSALbwa+C9THqsK58nfMFqp7xmATM/v6Ip3
	 tM0jgzoIB+K2a+SL8v0M5s7tC3SdWRVHEBLUYQfOCdMmrsnhAtoFn3Pb5XFiVLF1rLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cYYEd9Y/llbfs9yVbWJzUGEpA5R9yePtOz4eFsjI2i0=;
	b=uYg+9JwW6kGlwNLNbdNGEIqnch5bXDUwzhLJkqsPDrFQHUBkuLPNNFJfZKj+prdkJsAD
	 FI+XjPrcVzf1SC9cRukpYFdOzfE2uG00jtts10M4T7/efH7ud/9OLNQOZEhnWTDhhd+td
	 Qle/VtA+3sfXJ7v+UdjYJO8K1nO5OhqEQ1x62cVvXA5ADCG1MFRLE1wdxvbzqYWiEPIMy
	 89+ofgBe2+AFeez7OABFdCDEzXS9A8n9eWeaipzAFOG9oQISG259FWXt8/yNwmR1OA8kQ
	 P3YYs8562+f+SMXu6IaYOBP7YwicmTg9MA73YnxA1hpT/jAw7d9Y1umIm9mv8OxFd0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=TwLCzfJy;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F0606A325
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 09:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F08F0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=TwLCzfJy
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49d05d51553so4881855e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 01:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1794995352; x=1795600152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYYEd9Y/llbfs9yVbWJzUGEpA5R9yePtOz4eFsjI2i0=;
        b=TwLCzfJysP/ordwYkhVjDPJyiUqimddrgEmY9S/fQLCQIOPAzjR9pVzCtiLsDTCh1P
         14eHjWGWytjDWhGvcA3r/KtJiWN7bb4gAUerqP26iI12K2ejXecRWDdhMcupzIjGLR6u
         jZRpc55u0HRrG/AAjp6qW4SSPkFSCKlETnbewmeiVDDCz/RwJaGjLuCixs/2E5f+a/MT
         /9cz1kDIjBGh1tD6vwLdDkBxCmE4TZlQBdgq9olzSAaGDgGGf9dmqwgT9SP3HanhDvay
         2+rzDu6SNOjR5mZSNav6treP9EJkxTyGl0AQp2sCjLnXYHQ1txjnuzeYGhe4lrh5773F
         oSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794995352; x=1795600152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYYEd9Y/llbfs9yVbWJzUGEpA5R9yePtOz4eFsjI2i0=;
        b=0vt5LYdN0P2m/xKm/YOfcwtd89XHwqrq/B2keoI08Q+hJrhel+2ACL1uS02l324PaH
         14DOEiNDuKA9XmEXUtAYjhEMD/04uV1TKWo0XN2AHC6NGtdMyDIwRyoAgsvQics19aTI
         vSCYpo27A3NC9rw7xlTKh1EewGzkQEnnopTZUY+nT08Nmr6naBS51+nJUYRXcOFPMITF
         AnDuFS0w6bL4UkpYUSYeRUIfmIBS8GBJ3yOJ/UIrf6s3l2JOC5xvw8upFJqAhp5ba4sc
         r/L0k+mVTFJRuBA+gcfK1QpRBAnEvPWjrD79Uf2cTNO2xibfzgJJPRjSBhhSdHYaNY/w
         LwXg==
X-Gm-Message-State: APuU4Z+Vy0AXSxlY8TUqm3cl0hwjeAeTnaZIQ9ssMaiOfXKjSdiAG1SE
	ZiP3Ds8yYzk8IvEvzLzdf4VJM/oTwI2hP9KO6T5LOUtqjeTIbbQDDOPU1YinPzpm/R8=
X-Gm-Gg: AYBFou2NAlj6iHB6vblB1JGpeoe9gT9AOvnxRJS4wLEjFCd75cvwWl3XsNv3n9roh1G
	u+AoOFI9SymH7k2nTQfu8/3z/Ha2e61m1W/4dQ5yW65Y7N9w5zjsBnN624QlqU+4I3n8ibw71IG
	4ENix1VTFVls7xCWPgcaqEQmM0FPze7yA9Yg+bW4KD7W042/7gZcYQ27RzZi7FEDnJGLh4LeVrB
	ytB+TMP24U9Ro2EyrUGVf6xv4X2r1j0OgEn1Vvf0SY6fbYfY+XnZd1b8wB1m5gxcMheBndprZB7
	qGu5uTbRQNa60bEms6UiPvD3XnJ7taQupoLlNTlDzZYd9c/fxTxN5EpNUGHnDJqpbe2X/QDF2C4
	KK5dd1tGuT4Y8Z4uShkz6SwpXC6bkphAxjjdRRbkeGGvsXPvrY3lpUTCRT+U/rYbYeTToxTqSGA
	bcuQKvsME+hp+Pvuk75Xb37Y1FWIamI7M8+N2RO/UlIjrOF9dorReDgyHd52zqP6W1wTjXWWlqd
	by+rPh9qoFwXNSkGJtPQofesgtbGTFxH2cbYUxXume4ydx/VDB22l5Jrs66JShQ8RMyScU4ZcNo
	P/vrJg52XwJeZFVC99n2N3rMHK+y6suhDfIOobHrTZlCxkfgjrVpt0paLjpxpFChpO0NLb3jvng
	EMQqE1iQ+hCMwTDGfKcUS31ln+g==
X-Received: by 2002:a05:600c:19d2:b0:4bb:5de1:e912 with SMTP id 5b1f17b1804b1-4bb7d5d6636mr38640805e9.1.1794995352243;
        Wed, 18 Nov 2026 01:49:12 -0800 (PST)
Received: from localhost.localdomain (static.16.56.4.46.clients.your-server.de. [46.4.56.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm188858905e9.8.2026.11.18.01.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:49:11 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: add the listening session under rfcomm_mutex
Date: Wed, 18 Nov 2026 09:49:11 +0000
Message-ID: <20261118094911.277-1-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.47.3
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

Sessions are added to session_list by rfcomm_dlc_open() and by
rfcomm_accept_connection(), and removed by rfcomm_session_close(), all
with rfcomm_mutex held.  The listening session is the exception:
krfcommd adds it in rfcomm_add_listener() without taking the mutex.

That relies on krfcommd adding its listener before anything else can
reach session_list.  rfcomm_init() starts krfcommd with kthread_run(),
which only wakes the new thread, and then goes on to
rfcomm_init_sockets().  Once bt_sock_register() has made
BTPROTO_RFCOMM available, a connect() can reach rfcomm_dlc_open() and
add a session while krfcommd is adding the listener. The two
list_add() calls on session_list then race and corrupt the list:

  list_add corruption. next->prev should be prev (ffffffffc0f12540), but was ffff8cdd86b43700. (next=ffff8cdd84444f80).
  ------------[ cut here ]------------
  kernel BUG at lib/list_debug.c:29!
  Oops: invalid opcode: 0000 [#1] SMP PTI
  CPU: 1 UID: 0 PID: 7188 Comm: krfcommd Kdump: loaded Not tainted 7.4.0-rc2-vanilla #2 PREEMPT(lazy)
  RIP: 0010:__list_add_valid_or_report+0x6d/0xa0
  Call Trace:
   <TASK>
   rfcomm_session_add+0xa5/0x110 [rfcomm]
   rfcomm_run+0x145/0x1bb0 [rfcomm]
   kthread+0xe9/0x120
   ret_from_fork+0x2bc/0x350
   ret_from_fork_asm+0x1a/0x30
   </TASK>

The above stack trace was reproduced on a rfcomm module with an added
msleep(200) before the rfcomm_add_listener() call.

Add the listening session with rfcomm_mutex held, like the other
sessions.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
---
The trace above is from mainline v7.4-rc2 (Debian trixie's kernel
config).  rfcomm.ko was rebuilt in-tree with one debug change,
msleep(200) before rfcomm_add_listener() in rfcomm_run(), so that the
listener is added after rfcomm_init_sockets() has made BTPROTO_RFCOMM
reachable. The corruption above hit on the 9th module load. 

Without any added delay it was not observed (0 hits in ~158,000 module
loads).

The race was found and reproduced with the help of an AI coding
assistant (Claude). Reproducer available on request.


 net/bluetooth/rfcomm/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8a4205347c4a..2d35121224a0 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2219,7 +2219,9 @@ static int rfcomm_add_listener(bdaddr_t *ba)
 	}
 
 	/* Add listening session */
+	rfcomm_lock();
 	s = rfcomm_session_add(sock, BT_LISTEN);
+	rfcomm_unlock();
 	if (!s) {
 		err = -ENOMEM;
 		goto failed;

base-commit: 3c5963d23d64972385786e0be47be16d89ff4434
-- 
2.43.7

