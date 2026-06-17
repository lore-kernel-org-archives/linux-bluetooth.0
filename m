Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C793B52FB
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678763; cv=none; b=GOkJ0NVL/zYw+lB/T9zDjcpg/8Rw41MQn7x0jpHocW15UdwwN9FdWlgOfoQ0vUmKT0ex9+WvpaUzW1kxp+ZSgUT13RfX4msD2+EMnjQTDfVDdk8Zr9EfsMco4k7nsRy3UKa7NR4LcKDLsueuSSExCkhz9VubGTXtdUfc3G8Xt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678763; c=relaxed/simple;
	bh=XzhCB5GzyvJph4pAksg0ijeF4yJPIDyIY2jjs6KRlQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXhMQs01JvrXdOeBHZWU3joyisj5BYuJRyJ9U9jkb23OJqlqVJ1q+qqFdqdULxFnSQG2wtqRMLhTcXQKOJeL49SX4ISlI+HZnj2O50sxa7V5yku0PfjlnuC9x9469s5PEszjY3m/ul6R2P7ipCd0hEoEM37Rma7DPTRK64BobHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=exW6vLQl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="exW6vLQl"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c40397e746so33201805ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 23:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781678758; x=1782283558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjucF5goefZfuxikv7tCuZJMVpoPtgqO36vnpR26lfo=;
        b=exW6vLQlCk4OWLIY7PuS5bPGQs51kES9/dB2xSaro+zZuzpc1J2kUhzdsikASJCDoP
         35P7imjOtRehuZAglxbetAF02mxS1f/jxbYMNy+xn1ssq3rXOUr9W8xdpvIFr52jBdWo
         4OZr7enL9TwcDrszAztymRxhxO/3LIuO9ZWZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781678758; x=1782283558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjucF5goefZfuxikv7tCuZJMVpoPtgqO36vnpR26lfo=;
        b=Vi4zqhbCUCzKWnEoO/Ttvkm0OUdk50rDRFjK7NYimoMdIm54zU0ZA80PSGO2+u9yV1
         CreAdO35qbWw6neUI9UiXZFHYlCOLdZid2PXUc+tOAyINktnU5v6oyXn2yp3/w6iXocn
         3mrbjjt641I3YnS8UtgVq0qF1+yoLJXi4UwjnCgis0+XR4TugLp3zHMfHJV5GZlRDYtR
         x+1QHSOZBnchCcMmNzKXNK//iEFMlx+6AQXYU4SPju6JVybemTfNC0W1PMIQrhVfoJUy
         A8Hpr7H2MGq/X8jgBlxktb5arpurF3CKhMvUHE0qRbGpRnTlOa/DU50zomyN8oKNjWjo
         uPbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XZ3z6Q6ziKXWAig4ODMAX4TjcZeMTjLlJOANSequ/YwSo/1txtnVDReYtRZ1Kz7N9FDCTVD0yWtoyE1T76pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoGWRy9pIjce/PMCHXxEyLI8d44WBEGnrElyFE/Zaw6bgnQT0
	4tlv0O3IcJpY1ZGUrYsYnh7OgpXzmlIJ4Xvle25Ai1K3FBhFosvbKebv0g7IWfX0cg==
X-Gm-Gg: AfdE7cnD462n+Y+/cXPG5DU6ghuDWHhHSYKZaJ0SRH0WQrVr221gyuPNJLJl0RG8jw0
	CaAUc3nHlF3OoQHxjTVOyWo6bPmIW612BOnbLUAHgk0SkmlZbvA3bHELKaFgqimwEKs/xCAyQ4A
	48PzFkwKsA/aB18S7td8WOHTLhU5xBW8AZ9qAUZPRhLKYP/3HeSUha+Qo56G4/gO2XxUNfj2ksh
	6CrKW6HLgbEIF7mf3yWSgAxNYmNn+NJ+iFF/yFylLQV/UWvp7LP3xaI3rSv6A1jjJBg5q7wAOmJ
	qguafJJLRFYSQJB+NDFohKce/kvgigCIfducm3jaSnNYX67yMLYwsPV6D0Rc0K+TnAKZNV9VHCQ
	edhXf6m9TKWKSYBv7GOm6XkpseLl0CjZO2gF0FxqH07GJHuX/POPOG4qjxQuTyvYVx3kowd/c9b
	cp8Juv53AQIqCyA1w3ifR5+ry1dzGq1r/2OwI0sGyvLslinWIagmMkns8qd3VB/Vg+ms4Ivovyo
	9/UeRjKjUS0hg==
X-Received: by 2002:a17:903:1b4d:b0:2c6:9358:3ad5 with SMTP id d9443c01a7336-2c6bc20f6d4mr26872555ad.17.1781678758360;
        Tue, 16 Jun 2026 23:45:58 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:20ef:efdb:f2c9:836f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6af931f19sm24365675ad.74.2026.06.16.23.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:45:57 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mark-yw Chen <mark-yw.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: btmtksdio: call cancel_work_sync() outside of host lock scope
Date: Wed, 17 Jun 2026 15:45:32 +0900
Message-ID: <20260617064543.574704-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260617064543.574704-1-senozhatsky@chromium.org>
References: <20260617064543.574704-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cancel_work_sync() should be called outside of host lock scope
in order to avoid circular locking scenario:

CPU0					CPU1
					close()/reset()
					sdio_claim_host()
txrx_work
  sdio_claim_host() // sleeps
					cancel_work_sync() // sleeps

In addition, when txrx_work() runs concurrently with close()/reset()
it better not to re-enable interrupts by testing for BTMTKSDIO_FUNC_ENABLED
and not BTMTKSDIO_HW_RESET_ACTIVE before C_INT_EN_SET write.  However,
btmtksdio_close() clears the BTMTKSDIO_FUNC_ENABLED too late (after
cancel_work_sync() call).  Move BTMTKSDIO_FUNC_ENABLED bit-clear earlier
so that txrx_work can see concurrent close().

Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to work")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/bluetooth/btmtksdio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index d8c8d2857527..207d04cc2282 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -625,7 +625,9 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	} while (int_status && time_is_after_jiffies(txrx_timeout));
 
 	/* Enable interrupt */
-	if (bdev->func->irq_handler)
+	if (bdev->func->irq_handler &&
+	    test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state) &&
+	    !test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
 		sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
 
 	sdio_release_host(bdev->func);
@@ -741,6 +743,8 @@ static int btmtksdio_close(struct hci_dev *hdev)
 	if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
 		return 0;
 
+	clear_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state);
+
 	sdio_claim_host(bdev->func);
 
 	/* Disable interrupt */
@@ -748,11 +752,12 @@ static int btmtksdio_close(struct hci_dev *hdev)
 
 	sdio_release_irq(bdev->func);
 
+	sdio_release_host(bdev->func);
 	cancel_work_sync(&bdev->txrx_work);
+	sdio_claim_host(bdev->func);
 
 	btmtksdio_fw_pmctrl(bdev);
 
-	clear_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state);
 	sdio_disable_func(bdev->func);
 
 	sdio_release_host(bdev->func);
@@ -1295,7 +1300,10 @@ static void btmtksdio_reset(struct hci_dev *hdev)
 
 	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
 	skb_queue_purge(&bdev->txq);
+
+	sdio_release_host(bdev->func);
 	cancel_work_sync(&bdev->txrx_work);
+	sdio_claim_host(bdev->func);
 
 	gpiod_set_value_cansleep(bdev->reset, 1);
 	msleep(100);
-- 
2.54.0.1136.gdb2ca164c4-goog

