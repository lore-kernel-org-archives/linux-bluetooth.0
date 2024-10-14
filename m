Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDF1CDA08
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920324; cv=none; b=boz+fikezuT/3pSwqE1TNURh27/IbNpJamhwdLuIKOnZprTekYIx/xYDAgElX6G9yjHxIqtuVR04pMPw0jEiQG2cNQAfLPQDOrUNKYec/l9qyHUZrXAUHEKs3Ypj33qz+oPzMwY1Gj4sN2ifxbNw7wORDUtryJ4W/s05vTolwpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920324; c=relaxed/simple;
	bh=vc7OmTLH/01Z8jEmhW2hCpr6OvlMbxkqSwuRPTgWIpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G/OKZ1tco1b0TiOLQOwT17z8CfvR9x4gWTWIB5GRJkoY5TFthxYI3LDDwtTgTqV8rP5nA23fN9tKZwOC8H6mRJlLEv7wu2HWc4imB/DPhJrVscsg/FcjWC5HVWBwOiChJkhWePw7lli52g2fW8Pc3yPck7kAT47Kt5aTCa545w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dLXBS2w2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dLXBS2w2"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e63c8678so1984251e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920320; x=1729525120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItWQLKHEonR5Y2Gfm40nvdSQUxBxC+w2AGE8qbV4gnc=;
        b=dLXBS2w2f1B913FYyVksZ5CxT2FB/P+tRs39uNyDlb1TLRWeUYT/QYawOi8x+N/P+A
         5aQHYM+8mrlX7YEBLYq8XLQBif1j4y89y7ftPmjBbwEOjVsnOyZaA6MccY0LRNw9Sh2G
         tekWzAPCmS56R6wJRU6tmBWaZ5GkEmcQjGoK0K4jRC3RM3vHaKsC98ZF1nxUAZgBHM+d
         Km1YwFDgIDCPIejfnApah6wZQCkqro9Nb0q8WndtlIUTpGV/iq6rl5BRz0263+HpQwin
         ym+efHn4fKC1o991FRtxIXc0i7f5Y1lqe+K5B+K0kDgacoM/HiIcd3HUZFM+zv7Vajvk
         U3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920320; x=1729525120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItWQLKHEonR5Y2Gfm40nvdSQUxBxC+w2AGE8qbV4gnc=;
        b=j+VctxZSuoENfULlNIcj/7lWYLmT6Bv+NnkFjpZHSgNcDX5y5pOGIq+pK9YOea1gAi
         cl2vzcEwoPraFy5B8nN/AEoExY6dXj7X0KcITL7b+zB8BfzHasrrmDRmnS/5M6q57KDZ
         bGbFuMtSCAqWek2W4sZnvRh32NXPoOvoc+pMCQ1R0/b1g7nsGmGvhZIGr14+u7UQ6t/A
         VU4B+l0v1dv/gjSApEvt2VdMTfabMnL3YJCQ8vlxHhiKZXN3El2b/8fzqhd7xBq+ALQN
         jvVlC2tltF9PNSd3RoR6bYmpfzSQaU5dUrGoY1iM4tMjU1AJbfn+zdb3evRkxC+uzpEg
         eU+g==
X-Forwarded-Encrypted: i=1; AJvYcCW0K2nNtYjmTRZTvK7Edx4HZURyt315427JyLB2jxIwTU3XClXoTJvKBRFGOWcpa6qZK/ufNxCl2w757isrDMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCEAnRwTJkW7CVb9azgiRzE5UCIJ06Rrw/DqFTaoWbegj//dkL
	46erFfaT1SVxyrlF8u4BC5KmI2fKaKA9fN1bNJO5GYw/1yoCxPZMxIMxSMjyZy0=
X-Google-Smtp-Source: AGHT+IEttcKfkHe5cPisVJHUtmgl4wcFxdt3iQxg/FUhY3c3ela4IwMd9TUcQCCkSzxomrcD8IPSrQ==
X-Received: by 2002:a05:6512:3083:b0:539:8ade:2d0 with SMTP id 2adb3069b0e04-539e57282c7mr4527098e87.51.1728920320165;
        Mon, 14 Oct 2024 08:38:40 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:39 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net-next v3 9/9] Revert "net: do not leave a dangling sk pointer, when socket creation fails"
Date: Mon, 14 Oct 2024 16:38:08 +0100
Message-Id: <20241014153808.51894-10-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-1-ignat@cloudflare.com>
References: <20241014153808.51894-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 6cd4a78d962bebbaf8beb7d2ead3f34120e3f7b2.

inet/inet6->create() implementations have been fixed to explicitly NULL the
allocated sk object on error.

A warning was put in place to make sure any future changes will not leave
a dangling pointer in pf->create() implementations.

So this code is now redundant.

Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/core/sock.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 083d438d8b6f..a9391cb796a2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3830,9 +3830,6 @@ void sk_common_release(struct sock *sk)
 
 	sk->sk_prot->unhash(sk);
 
-	if (sk->sk_socket)
-		sk->sk_socket->sk = NULL;
-
 	/*
 	 * In this point socket cannot receive new packets, but it is possible
 	 * that some packets are in flight because some CPU runs receiver and
-- 
2.39.5

