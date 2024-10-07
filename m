Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F7D1DED71
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336958; cv=none; b=BfqR33cMSbc77nSGAVonJh72UR8A9CeOoqxYawnd6LyAwKkqgOeEzxJRKvqHzYl6pSqAEb9/UlZ1uD3h9tc0+uVLHaRTTiZqRGcVrYiKuGSl4+ny6zJSrU7x6cazAQyWn5icy0nl5BRONL7gWS5GKGnEjI7kHJ1dDlt0pqhcwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336958; c=relaxed/simple;
	bh=B2jIOs9L3gzL5PsTv6zAjfQ7uhJ1V7bXBI/aVWUwbYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YoRXPZlLfUJLjiTrC82jRVzAn903jd7mTg0nO3XVT/izjjcuacHwPCbpy6eF3OEnU9I5Duh0ykoMrNNr4xR/fMetBECXUiyfh8JAdo5A0uLT675by+SyuIdCS8QHsCwkiCZLUzAT7KNnSFpefcfz98sCcNa1G1VKpw8g6m1zhlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fwi1TuZE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fwi1TuZE"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so3176987f8f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2024 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336955; x=1728941755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc//y1BjgJvxxX3rGB4aDZ3xX09SUgENBX50qA84hL0=;
        b=fwi1TuZE6U+cV626UHx2sfHQOtvBK4ewje5Ti3AQ+2l1Aez2OmKyZ6zr5pIdE2z6v9
         /XZjYBsm/b/6WmY3v8aFONI+5YPww37GCXD6u8W/NN9oEJgEB7Jz5EiqXw6Gw9oBuiU0
         AlqwxE5oYzKjXOiKQFya+KrrOIfXcOKO9fMt8GBWw+fhgNMnwXn5RwDuvSlM0HDZGxGz
         HRE40KxC7KmVwbRUIoWtoh0kKW5s/pmSozzLAknn/9x0x12Jq4HX9oHB/ts2R2OGPdL2
         e7sGq8iO92k3xIxqiXHEmcqjMZfAraBxkD982nldy2zJxZyrprysYOuMpnQ4zuAUuLoE
         6BLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336955; x=1728941755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc//y1BjgJvxxX3rGB4aDZ3xX09SUgENBX50qA84hL0=;
        b=CD0o7EwNSDZZsOyvVQoDw/JDRfZqKFw4Z/CV1ymF8EdE/tVlwQlCdoCKXqN0rCRp2z
         RTZIZmfgmaTeo31u69fKbvoGmwoPhYJaRQr4NGF1qOxcxjwSprpeqIu4KoZNBBs33ddy
         sVOYM/uNnYsTnOlT+qY8vNPuUHn7Y9UWrDWOGZPrUZPkj147wYbYmHUqAZFMaZd2mUYD
         BiKDsVHrOi91TBZeGUncGAa3bhbKdOQIg9VohEnKReeslMuCepUduWHe9xGIQbM3mdY6
         4D4W69TrjhXI/e1eL3ZYgYUtdPw4nboeEI4VvDoRs+7C2eId6CQTIOVRGvxSW9OvZQzO
         gWIg==
X-Forwarded-Encrypted: i=1; AJvYcCXAEFivT2cKNS50cWKSySHsvL43aBkvevHIb8tC1b7C8iPYg205gFYt15/6l0GXJtY8duROkN6VzWHIhIz3eHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzacAONpPP3fBWUGeU16Mr4vtekJw3LgCNK4Csmp9JwmnY8ObTx
	FqywJ/krk730eNwOYphBYv9F7mqqSvZorp8Ae/9HgWvXBcWf+rpcxenRwWoEQCQ=
X-Google-Smtp-Source: AGHT+IFlr52AJGKwlZWzuyM1U26fNN+5lWsZfsZ3/C7NwJE8QNsJ8h0z9W2aZlJldJJxtKVirxozSQ==
X-Received: by 2002:adf:ec03:0:b0:374:c11c:c5c3 with SMTP id ffacd0b85a97d-37d0e7d3e2amr7529022f8f.41.1728336955301;
        Mon, 07 Oct 2024 14:35:55 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:53 -0700 (PDT)
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
Subject: [PATCH v2 8/8] inet6: do not leave a dangling sk pointer in inet6_create()
Date: Mon,  7 Oct 2024 22:35:02 +0100
Message-Id: <20241007213502.28183-9-ignat@cloudflare.com>
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

sock_init_data() attaches the allocated sk pointer to the provided sock
object. If inet6_create() fails later, the sk object is released, but the
sock object retains the dangling sk pointer, which may cause use-after-free
later.

Clear the sock sk pointer on error.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/ipv6/af_inet6.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index ba69b86f1c7d..f60ec8b0f8ea 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -252,31 +252,29 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		 */
 		inet->inet_sport = htons(inet->inet_num);
 		err = sk->sk_prot->hash(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 	if (sk->sk_prot->init) {
 		err = sk->sk_prot->init(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 
 	if (!kern) {
 		err = BPF_CGROUP_RUN_PROG_INET_SOCK(sk);
-		if (err) {
-			sk_common_release(sk);
-			goto out;
-		}
+		if (err)
+			goto out_sk_release;
 	}
 out:
 	return err;
 out_rcu_unlock:
 	rcu_read_unlock();
 	goto out;
+out_sk_release:
+	sk_common_release(sk);
+	sock->sk = NULL;
+	goto out;
 }
 
 static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
-- 
2.39.5

