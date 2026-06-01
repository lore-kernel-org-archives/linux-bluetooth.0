Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CAF37B03F
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340189; cv=none; b=S4aysEqlPpxP+sNK+dqwt/FiljY/u2+Wt58hzr/Kt3OHMwdEub1liLfYTNs7KP7t6vpwdea5T9HvKA9TEYQBrbB5A1amT5NoJQNr9OvDU5RKZt7TI66TRrG7wlglyfw0lBWDGU9woMR4xtW/2HvGziwo6aBXRKH/Q6Rf+lyaMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340189; c=relaxed/simple;
	bh=7kn6VXa3gNweB3VyvpKCI0l3KIYnuyerVNQ236gihtU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XZvoPNLn5bOaWwTkLlLOj6oTt99RINg4OxLnCTxQk/Ov5eIbdDcgEb6WGcDWh20pZX47vrSA/ZqxWf3lDip0ieBbtQCjWB8FNs4HQ4rmhv26/t85l2CjKKHJNvGB5ocZZAlaftR9cLywrk1glukEK1ay1dpv62FKG80QDMSUbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPLpT27M; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPLpT27M"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-963b09d5b91so2579813241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780340186; x=1780944986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHR1i8pGc0KwkX7d5u4ZyVbdURIb93pSA0BTlt6/L2o=;
        b=JPLpT27MO4mOJGQo+R0fsPdD2Njfl8+KUODcPpvPSDQ/rNjoURiBWplBGZ6rYElV+A
         7OXo2uyd6UensS84/dEptEYDun9/Y78Mu04MnxV/6PS/Q3oKxq/v0vCG0p8pkxd4EVIu
         1CAVO4ysinqr575kVmZ3ke3hAhsukOu/2EXkkZt+nnxaywCJp/0cVcYFYfCwryZBmA78
         fJHCHovooMEg2DYHmVzMKAbGgZ0cF2PZwl55x2Q9dMJMXGPAjueMHjXcptokkTLFShVu
         u2VlH4xSZLM2LM6CEX29orwaVrHRpze5dcDIUW0/UnkkQaeR+1BVOR1LJwktreO1WrF5
         e2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340186; x=1780944986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHR1i8pGc0KwkX7d5u4ZyVbdURIb93pSA0BTlt6/L2o=;
        b=K+MfLpLSMy844IYLzhna2BenN5cJvnqBF54QF2UZRpFU7XFtz47kHZ1eY9iy32eaEM
         vEg33Z7wHhb80f/KApYaLJx4KV6Zkcphtd+h4W07/JSgnYwjGVNh5Ie1mtK5V11uBuOb
         hR6C3TzkTtvW8z0mjghVlNGxtkEtDseAI8nK0Cx4XssTFmltXq0VvfJR/5bmlDH/Rn7Y
         LeK/X5PT+X17nTkXbC0Wl+a/7tzUARGYrY0rrZcOnRqnVVQXYlf3oP6YeUMrLUTJETFv
         DvCA/XIPsk+7nm9W7jFQTAyIl7AMizzyfLXNt6VS2rGUCLfpLQJoj57zL67KAZrbRHkF
         H75Q==
X-Gm-Message-State: AOJu0YxT/YJwvWVtfsAwrCfzBDEBh6XMxdWA8lvoVHifIPjlEmCgXSBN
	fgMrgJecAKcrVVkqfMLXGhh1ngj8j/nl0a/MuT9fk1TodKUC/btdKQDWta9s5EESZlg=
X-Gm-Gg: Acq92OHQt/GDm04kPFErIppl8pJh1YF2Y5c1wE3iF21GgkyKAm07fmbnQYlRIKNgivE
	ARwtEgQIm3Swnu6Y5E/HrsdStv2EoUChX5LCi042PQLKPfANv+13LiZJHh5cJ+yNeZJ/hmmPlcu
	s4/w+pk51v4a8NNUPwRRW2bGwRLeDf3yRgCWZoMbA6qPwmtyS9DXRrJmIB8QEniyPBS1lfvM9vk
	c87jV7tGnCbFA0s20c5UGufPue1qh9Ny8D1U5Fs8+aM/O9H2MgLEDJk1Tyyx32C+HlS63gMhuq5
	vPHN3elzk2gZIh0HYpQorct/yMqhDXNjvkXetisdi64Gmcr3CdEyzaIfkLVJyfXWr8I75Ip7YDF
	bw1LAuf0+CSi8NpRFDvCfxXO4xK9Wdv2w/Wn8H2FkAjlLXyRdNdM6Fh2CBYPVrmv0xiUIwXEk6R
	p7KccBqpGwUmOJIKyzazrKDysf879HsMcjHWDJErYsntoHSOv9JIgrA2YF3DmXFY/vmT+O67UJh
	WE/IBerEigTiNy3RhhE/fY7ezGj
X-Received: by 2002:a05:6102:604a:b0:643:80f1:350f with SMTP id ada2fe7eead31-6e1841a6973mr395892137.21.1780340186561;
        Mon, 01 Jun 2026 11:56:26 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-963aba249f0sm6773382241.3.2026.06.01.11.56.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:56:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
Date: Mon,  1 Jun 2026 14:56:19 -0400
Message-ID: <20260601185620.727132-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_get_route() returns a reference-counted hci_dev pointer via
hci_dev_hold(). The function exits normally or with an error without ever
releasing it.

Fixes: 07a9342b94a9 ("Bluetooth: ISO: Send BIG Create Sync via hci_sync")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index b998741b2d3b..3978a78d5252 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1600,7 +1600,6 @@ static void iso_conn_big_sync(struct sock *sk)
 	release_sock(sk);
 
 	hdev = hci_get_route(&dst, &src, src_type);
-
 	if (!hdev)
 		return;
 
@@ -1624,6 +1623,7 @@ static void iso_conn_big_sync(struct sock *sk)
 
 	release_sock(sk);
 	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 }
 
 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
-- 
2.53.0

