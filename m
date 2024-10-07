Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F9191F6E
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336951; cv=none; b=YNBVS7PAWdsTLeYnFJ8zjRT945okIfKRcE40uoDafy4S6ByB4vUlr8fY1kPFQ+0bdudWvVt3I5HEcNtmwu6tNZlpvA1DAE1lEyCnhWsGXkL6hlFx0nHqMoPKcam/1S+Llp5xCkGDWtkYRA6CfAXYT1qNwFHRT55t4UChLDJZMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336951; c=relaxed/simple;
	bh=q1wcm6mMQ7h4EZDUMr6oUmN6x8BUBq/PxsPoaXApW48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZuDwgxx5paNxh88ILd94nlXm/8IH31r8CRHNiyWq6hj+ZN1+44jBcu1ftFMbmqqqDqpcHVY4Jr2NwBayi+6V0gh/QcypTu2vNL/0B/BBlkqULlHMGpVBARHBn/NmWH/BS54ugNFLBi4DnV2ksE/ttlndFh+syyNb9W2efb0LHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EsUKZHR6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EsUKZHR6"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so66243565e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2024 14:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728336948; x=1728941748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lghPtxWNb8lEoXQFFkVieItQmyHsjS0TFzxCTFvvuyY=;
        b=EsUKZHR6KE8gHPsNB4I4rgBYgBHzsrQfAorSi7uc6BABzFKfAGp5rUwhby7kGPAMYD
         sMugXNGItRxJIUEPNcNzO/EKpXXC0G731pc06JVHjXhGKAY0GUGmeiCEKwRNI5KJG0vC
         NCoJMgIHRlgieYZQ4ahtFl8toYnjWdc4/gBMjLIDWTpNIfGdXeHgcnSU5EHe+utJrJzW
         82vShMelVBEy/T9pHgZtn39qBcfHsvQLqeGyU0pAkWjpClVTR2d98c2GOEr2liCBgkUd
         DmR2F7Il7fqKwmX5YXnmKYWMjSgIg0JQCLZg+A2AguR8jWfhO/KwXjy2dSZcrkKWVt/C
         ARRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336948; x=1728941748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lghPtxWNb8lEoXQFFkVieItQmyHsjS0TFzxCTFvvuyY=;
        b=IiomBUv564rDK87S9gqjg8s6pMGbNspqCtsSBJ4OnUTehWjqsBn3TJf8NsaGoeEjjl
         4G7nb+uB3FvfWGMFR2P20pLp6R0jOQMyo7IkTj6FC0BlOfzSh5JGsiXr0zIIiE6dg4fo
         +6R6SmkCs3laAhePPEAbGaTj03u4ewRx77KUFdmuF06UI16ypgTBoHuCxTaDebPZ2uSH
         ttr6Ai1fiMKXk0Wb0k5RUMJtu8UocGO3O+zJpASpWRn0vKYgpXCI8i2lxkg+j2/srqn1
         AM9efBK3NKOCGrF2EeL5c9VZcB0RpHpx8xeseFg7aWgtBOoppBRzDBIyuC3GnUn782Ni
         67JA==
X-Forwarded-Encrypted: i=1; AJvYcCVESIvQCrEu23hicTQ3Tm0wmdLl1JE8sT41c9bXJeRRp9vKtQjASflhFeR3e03alTw0p7cUceUUqkOEuVsI/d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRY1wLOGH5cXCVPYN2t6PPSjkFpraW2yN5rNqmtKYkYVUAEULj
	YX/iyMOw5QGBofv9rKiY/TRrlCnQx0syXjUiL1xTJVvUja/QzDtjVhzdOUKQCYM=
X-Google-Smtp-Source: AGHT+IGIEgvlVQ63MN8px9sXGIB6rH0PaHc0x2aiS2t9bCm+0YE6s5XpgSiahpjGOCaDNGfNsSEswQ==
X-Received: by 2002:a05:600c:5494:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-42f85aef6e2mr143742535e9.29.1728336946921;
        Mon, 07 Oct 2024 14:35:46 -0700 (PDT)
Received: from localhost.localdomain ([104.28.192.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4absm6535887f8f.29.2024.10.07.14.35.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Oct 2024 14:35:46 -0700 (PDT)
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
Subject: [PATCH v2 5/8] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Mon,  7 Oct 2024 22:34:59 +0100
Message-Id: <20241007213502.28183-6-ignat@cloudflare.com>
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

On error can_create() frees the allocated sk object, but sock_init_data()
has already attached it to the provided sock object. This will leave a
dangling sk pointer in the sock object and may cause use-after-free later.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/can/af_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 707576eeeb58..01f3fbb3b67d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -171,6 +171,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		/* release sk on errors */
 		sock_orphan(sk);
 		sock_put(sk);
+		sock->sk = NULL;
 	}
 
  errout:
-- 
2.39.5

