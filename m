Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C98197521
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336951; cv=none; b=s6t50QA84gMX53ZyT985GlIn6e0ZiPxkFuIfmeVRbEq/f2yP6Z7iWwRAH50oPS1AbceDY2wnIgaLUtwr6IfYWxPUu2TRt1qe7j2J7/t02tiYYqmCsbA9tL8J9ohxHgB0oEXNFhpExm8Ucu7jafHIS4Dd2EUzJ/d7JrEh8f+GI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336951; c=relaxed/simple;
	bh=+sATRWeawQEUv1+UCi+L6joXgd2sN0KH+RYIISQm3Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIhmsNFwsGactMMMGyS0qGJDJR1icHSOrGiT7RWO9s7z1WS3ZSy6m+63z5lqDEbem+xWrfV5L2pBNOg91ygs8IS6PwoUyehSBeVARtH1yyXbYuylsdHKqPVjjTZSdFMw3T3OglpdZrKQi3s4nb3ILi5ZHF3ZFefn0X8aWNGZ9Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IHTWAhgP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IHTWAhgP"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ccc597b96so3101334f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2024 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336949; x=1728941749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47ahDvpGlziX1HY/1UDQ79MexuwMxPJ3vAc1BGnN1yo=;
        b=IHTWAhgPb3HdgloVHYocEY2AnKcpdxZogqrXgleub6TgSbKyJAAgB+4ugho6ciTijd
         Bg2GTLD5tKp5WM8IJJ6yiq8H7Vbd0N06vfB0HdAqKkXy663vopMy2Wg+IqznijbqehYf
         G2Ihpk7LibE1LGk7QwwbJdw5bRMf0Ue+CpIESxwyhynPDtd8oXt3qOYfZP2NhNujfPhi
         ogBmcRZwtUR29UGJJZIC11k5v4LQasYyv87wX6X3D0sjXBRhkNZ4nFsJBHajGlx3ZzWz
         rH6EngHBNUbt5+3PMbn2nZrybxoBU4Nk84s6rSlHZxPOf4WO5oJiJO2DTyxVqw4ooGiR
         xCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336949; x=1728941749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47ahDvpGlziX1HY/1UDQ79MexuwMxPJ3vAc1BGnN1yo=;
        b=jJ04Ru1/OVDuZtJkj2HCOX+dFoVeMO9BjId/ZUNi8RIjyC4xoV0reLrHoKS0w9CpyD
         iEcz4UvmMbZMTM8bGA8P/eT9793mHyiJpBHUAC1RouZQaSEq06J5DcxyNudyPspMAxHN
         6aoEHSFqaxuArEXyBJiIXHuJ+1/LU64ht1CbYej6HU/A/yIz+T+nXHkfHQcJVEbUC7Ru
         7a9SkxmJxqJU91gQ8XSe0Nz9aDP99zpicZjkwboREC+C9UVN5d7IYltzzrXJLcQP7RPF
         8wQ+cdSF/Xv6eCDlmyHM0+LECt5nMHsMPp8r5bsSyxVBppyu+90MnRY94RE1gNdogtLT
         DDLw==
X-Forwarded-Encrypted: i=1; AJvYcCVQd+Cu6DV20leLxiRVA9SD/y2PBeNMLV8OlUeBF8j+bwTwiZNI5au3vNF2yAmDOFrh6tWc/sNUVGeIgZvnqpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2l7J4BLp8fnNxJNq/o+fqRiisI9yxvuf/f2oyw3x9AgQngw5
	i01k7ggTmwhhke1zPaVgnkDG3kZ3gBcEbmiOwSM2rZbykESyE9Up3Ql39Cl7YhE=
X-Google-Smtp-Source: AGHT+IEh2nNtGTy8ZHuRwyExnrSdxDBOaaRu0AmF4uU5YudljkVsFMbPD2jmqiCN6O47wxbJKhk2fQ==
X-Received: by 2002:a5d:4d06:0:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-37d0e6f8eccmr8676059f8f.14.1728336944360;
        Mon, 07 Oct 2024 14:35:44 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:43 -0700 (PDT)
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
Subject: [PATCH v2 4/8] Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
Date: Mon,  7 Oct 2024 22:34:58 +0100
Message-Id: <20241007213502.28183-5-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241007213502.28183-1-ignat@cloudflare.com>
References: <20241007213502.28183-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_sock_alloc() attaches allocated sk object to the provided sock object.
If rfcomm_dlc_alloc() fails, we release the sk object, but leave the
dangling pointer in the sock object, which may cause use-after-free.

Fix this by swapping calls to bt_sock_alloc() and rfcomm_dlc_alloc().

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/bluetooth/rfcomm/sock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 37d63d768afb..0d0c4311da57 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -274,13 +274,13 @@ static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
 	struct rfcomm_dlc *d;
 	struct sock *sk;
 
-	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
-	if (!sk)
+	d = rfcomm_dlc_alloc(prio);
+	if (!d)
 		return NULL;
 
-	d = rfcomm_dlc_alloc(prio);
-	if (!d) {
-		sk_free(sk);
+	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
+	if (!sk) {
+		rfcomm_dlc_free(d);
 		return NULL;
 	}
 
-- 
2.39.5

