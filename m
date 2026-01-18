Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247A21AF0AF
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jan 2026 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768738340; cv=none; b=Q/MVWWo2WkdDVf2wosLaTOQ0rmwFjcU/GXWDThbmS/nfG59F50eDjt0CmxLT4Of/NEEQYKWlNntOcvB6QNBRKfc2yWS/s6WadLOF45q5pZ8OmScDG40SZJgIPY4UkW/JiZNNzeZRcjg4y9V7CBHU3AvxiiEeiB1t5QjTi0PEg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768738340; c=relaxed/simple;
	bh=N8uOl1EaA/aS69tNWeZPW69lrkXIWIKD+RLBU8Llom4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jxUi1wMcrddeoVa+kKBbF1d65xpSJCFJzSKOQbQakVs6c320EnIsmnqJVJYYFRj6hokLkg7mmMBakHYvjVbFm+p/ktYONfG/LxeRns7TuXGEbC2m394B5FXeSfnhRhneLwO9EYDIAnItrNTrgMue6z+jEgs4+4ODPGfGseojo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODYc9bkM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODYc9bkM"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81e7477828bso1847692b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jan 2026 04:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768738338; x=1769343138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo/liQNhmIP33PmLWiQZilkrElIrHhpcOhaaOZJIRQo=;
        b=ODYc9bkMTAdH9iT+musBSCAioqGRso6tF/ZKh/BrKSUM7vBNiiEdnoTudUxF1XwDcQ
         tbgeLFfm82RHMoUR9evaORbGRL7taNar6bgKPxndeurNiXXC0IvBBpOc3eWrOBQU4ggL
         1e2EccfyuHdvvoKBD27FGr5jusO56K/V9IRtROyEzMO/oIMrIze08hl5IgUimNxf3Iqj
         ZxdZKrkg52+H/FINYdUjFEqrKKlZDQzS7YRHGdRF/HAtsCbV8XDAH8mwkaHiqWBIi9jM
         EZ+o4KP/Dqyx+EyDUjEv93dlyLnrZi/+ep0dckvEn4+fKZGnVKEsSmhD0EiYnA5RLGrV
         6nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768738338; x=1769343138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo/liQNhmIP33PmLWiQZilkrElIrHhpcOhaaOZJIRQo=;
        b=iGvZffiNrSDGCt09GixNR84x29LwBf9Vaxz908e5npQnAXvDa80+71jbm15hL6tDSS
         jvHcO9rjfsEZzwTGP9yrOIBXqmHO8HS/pgQHznFL/kZag3Kup6U3j2iI5KMbMcRHNML/
         Zlgdvr/ZJ/e+tiJACRIHhkG5XJyzNO/wbF8SMucQ9SkaRGMURTMIg5DAxELoHgc7mRqv
         PIJvLS1XSrT9urW/EstQWnTgnz1VFlb1NahbhPDOAQMgzeUb+3flZxfUjOoAekDGlfoN
         YchMa1ysRd3oEwzUrnPhquAuJ2KEVwR9tiS1XeVT9pePRRfRf4+CIHnIw8Xbeme03zLI
         fgAA==
X-Gm-Message-State: AOJu0Yw1Jr2999G8nRQp8hVGBgGGPWt2bGiaoXkadJgxAT+QQNh93Zok
	bjIADpWigNMV3/q87Nnw3CZiOahWqbdnQwEXGHv7HjL+iPbU0YYXs6IW
X-Gm-Gg: AY/fxX7D7hEQuRDR0e6w4c3BO0YpWYXCIntSsDsBBq/ZUZhQ9EDC78wTHowJrYH/HHG
	bSLG47YcL0/VgC1ZRv+Thocq/dN89d8nD0EFHdRRcjg+aVYSmb0J3FKZulImX41eRQKHUe1kvtX
	cVL1SaY5z8xcyn/ysGMJyn70KlaIPeMc7a1/9kaHZluQPP3cYsfrHjF9fFV/AC4tRF+K+zgzQwg
	dvIEBinNDKxvKNZQj7pwAI0khVgrB0keDWDCwPYgxqA10ipnzf8uiZKpr2i1CyShkMVxgzXNsN1
	Wzr8eXnH8e9cAxnaHSAPk2qv3tp4+O2tX0++uKurVpB+uQds4pa1H4dBQ033oEJC2I5nXWEnFBv
	/otfbaARQFZw3a+VS3GV72nJTnzgsB/zpccqEL2ok34kwTROHPwijM9byq/5aw5pvtU+AYXuJKW
	5nWXUQ+DonFdT2/Azf5loplJAHn8sbKQlnxvI95vnoWrGqmr9C6V3+pShWefb8zSPm
X-Received: by 2002:a05:6a00:a86:b0:7f1:2aac:b75f with SMTP id d2e1a72fcca58-81fa07549d1mr6531317b3a.30.1768738338396;
        Sun, 18 Jan 2026 04:12:18 -0800 (PST)
Received: from localhost.localdomain (118-167-220-133.dynamic-ip.hinet.net. [118.167.220.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10c3721sm6566721b3a.23.2026.01.18.04.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 04:12:17 -0800 (PST)
From: Jia-Hong Su <s11242586@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Hong Su <s11242586@gmail.com>
Subject: [PATCH] Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work
Date: Sun, 18 Jan 2026 20:08:59 +0800
Message-Id: <20260118120859.83680-1-s11242586@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_uart_set_proto() sets HCI_UART_PROTO_INIT before calling
hci_uart_register_dev(), which calls proto->open() to initialize
hu->priv. However, if a TTY write wakeup occurs during this window,
hci_uart_tx_wakeup() may schedule write_work before hu->priv is
initialized, leading to a NULL pointer dereference in
hci_uart_write_work() when proto->dequeue() accesses hu->priv.

The race condition is:

  CPU0                              CPU1
  ----                              ----
  hci_uart_set_proto()
    set_bit(HCI_UART_PROTO_INIT)
    hci_uart_register_dev()
                                    tty write wakeup
                                      hci_uart_tty_wakeup()
                                        hci_uart_tx_wakeup()
                                          schedule_work(&hu->write_work)
      proto->open(hu)
        // initializes hu->priv
                                    hci_uart_write_work()
                                      hci_uart_dequeue()
                                        proto->dequeue(hu)
                                          // accesses hu->priv (NULL!)

Fix this by moving set_bit(HCI_UART_PROTO_INIT) after proto->open()
succeeds, ensuring hu->priv is initialized before any work can be
scheduled.

Fixes: 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during initialization")
Link: https://lore.kernel.org/linux-bluetooth/6969764f.170a0220.2b9fc4.35a7@mx.google.com/

Signed-off-by: Jia-Hong Su <s11242586@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index d0adae3267b4..2b28515de92c 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -685,6 +685,8 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 		return err;
 	}
 
+	set_bit(HCI_UART_PROTO_INIT, &hu->flags);
+
 	if (test_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
 		return 0;
 
@@ -712,8 +714,6 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 
 	hu->proto = p;
 
-	set_bit(HCI_UART_PROTO_INIT, &hu->flags);
-
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		return err;
-- 
2.34.1

