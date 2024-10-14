Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4B1AC448
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920308; cv=none; b=Eh8wNirvML9RL6MEGWTGc/xTgKgVwugFlI4z6fNHimnkEMG+D9JwPFKXNi/9vM/o1UP733vN7LPJZpk4uWiH7Gb0jn7Ptpbw5gQ3sCoC8U0vImhTtP4w4YVMuLjqVJ9fuyg52HO2IqY5YgaHbHLpirE24e+tanrs3x4NTYBPLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920308; c=relaxed/simple;
	bh=Za6d2/ag0cx5W3bmCrv67Ur4+k+VPgr8uvsyupNoJnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZWY2nJC0SHoQ+GMq8Dvzx5P4+qoLXar0aPWmMeBcu1Z0K9yLa5z7YsjSbURPdKdrtjZqU9/jRVOCSCL0zHnlPN0QyZDrU3YtJCAHD1IHJa/h65aKXzbCniV5P2Uwl0GTxisd6LPlnMxGbgwfE8ZHRhUmww3C6wnNlx+LN/yPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ADSl8+Xy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ADSl8+Xy"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d50fad249so2830313f8f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920305; x=1729525105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TINcLHJMJcRO8N8gtca7WYNoZRWtOQnWeYtX29logTQ=;
        b=ADSl8+XydpCyUMT7zL3I7Xvi1Ix5wGUH5Qfk/p+HOYeLzB30nwmpsZnljcSmMl7gL1
         f5gBFjsvjemCwOTBAn3BFfZok4/J5eKhgkR0d6LFhagydEQ9CXJVOiZeSuHbZh8IZ6Pl
         4h+6QorPYZhw6NlENAoq5NXcVoV8SDgtaQFj+jV982TyCAhFCVV6luDMEjtEs7rHKnMg
         /CmjdtmnHerbQskx0gIUQFY4YluRL9dyg1C8jsGY57vCFoUF/RbPAP4xLWAJvi0UxtMy
         XhHNJZf0yIKgG9BlSHM8EIcMrPHPEc/6RFaVJdP9/HnrpApP7NF7p0Nwpp5905fxo0n0
         jBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920305; x=1729525105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TINcLHJMJcRO8N8gtca7WYNoZRWtOQnWeYtX29logTQ=;
        b=lWVF/iagW9jdIZCQF2q63sZgz994J0nAkf5jHXWSilrj1Mh2fvaPanNxMUHjqZxyjV
         /MN1Z1WQYGnY8TBTXUXaGdZQKD1nKEIqUWkgH42vxAOLkErR8MC4ecUt+6/5JvF/ZQuA
         UbbWPbhjB+jiZVb1TxOmtXB7u0YdZTp+9EtDuSqJVsk/7uxmTJysWSH6WyHL2Ja52RHy
         r9/tQ8vVElBDL57+W6j22DyHijgh2Fuw32gcXQtIhsQgcKDbM7DyHmkVxOaJKNCiwwKz
         eyTMJSYsUTfzWm2atr4T8uKF1UChntiLFNSJc9/IhFQsH3lmRCWeIdEq5t5S6pP5kXju
         jqXg==
X-Forwarded-Encrypted: i=1; AJvYcCXT6WfvfmEjFkoWEOmPfngZTn/nAyRYcm07eCjVRnIQmXunKf1ftFgiN2bfeKLiruSxdeD69Z9EvSgJcyVbtV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/KTRYLjVeHqyqtpbQS+y8oBezVN/ATB60pj7/+ODtW/+QW4jU
	EEffSbVXqDSQSvJProemLqwTYK6IBWQSCt/glPnFESVK7//KqNgs7B6BYhaqbHU=
X-Google-Smtp-Source: AGHT+IGI3bnawMCR2rBPHOoSypef3VQX2phi9r/huSmV/cqlV/2kFbNe9+Hj1byHQxm9DpEINFWl2w==
X-Received: by 2002:a5d:5c88:0:b0:37d:4ebe:1647 with SMTP id ffacd0b85a97d-37d61afacedmr5574208f8f.49.1728920305128;
        Mon, 14 Oct 2024 08:38:25 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:24 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/9] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
Date: Mon, 14 Oct 2024 16:38:01 +0100
Message-Id: <20241014153808.51894-3-ignat@cloudflare.com>
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

bt_sock_alloc() allocates the sk object and attaches it to the provided
sock object. On error l2cap_sock_alloc() frees the sk object, but the
dangling pointer is still attached to the sock object, which may create
use-after-free in other code.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/bluetooth/l2cap_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ba437c6f6ee5..18e89e764f3b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1886,6 +1886,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
+		sock->sk = NULL;
 		return NULL;
 	}
 
-- 
2.39.5

