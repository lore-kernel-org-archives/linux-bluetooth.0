Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A211E33EB0E
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752432; cv=none; b=NbiiT8/Yzb+CXL4tUtPJewukRei2T20A4LkUC6TPY+RzzYbVaGnSW92OaWHj0mQb+2/7aPCOomMYNrB9ldYi0gsxXSn/iavNYCFDhtBh9iSATV+jz5JvsW3WQCgpXDCTXybz+lyHDVdqpP1pEbbLcABZzv9G4T26BMEwWkU5kM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752432; c=relaxed/simple;
	bh=JwBOcBdWdp4MtjK9v/FpDU0GijvfRmuQHNiAVXIB3k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzXfgkTQUDq5aHzfPrVG0CXkJoFnm9qymsXeG4Q7MC9+gB6mRM0hNy8z9+KQBpapnJCHpoDl88FgB8xKhwbF2Pb+POp2Au+FUJEikzITf+S55KxZ10NL2NH11/98oqeM+41eNg0oaHLMrDJqu781I6f4dCjX5fl/yaEERgfWjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=catQTvd9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="catQTvd9"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8452a597afcso197386b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 20:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781752431; x=1782357231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUiLNGPqh5xoaR1mbDbB7mwDPFmDNybYuGD8IeVqIGM=;
        b=catQTvd926o6KecgwBNrEESVAEunx71GvHEVHs3hPK5oga38+ljzwGk7mDbJHHOF6q
         qGCbLIVjw8yh6FY9iqQxYjD4ukKf5RzgIZn/38E+QksYsc6c/xyL4RESG/VoVEW5Glu1
         WJQEfBDl4Lo85Um2BGxcCE0edAHZacWzUJK4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752431; x=1782357231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUiLNGPqh5xoaR1mbDbB7mwDPFmDNybYuGD8IeVqIGM=;
        b=ksgchsjob5rXxlfTt7fhQP1/51HM2/92xNdJmIP7dtT0SbY+rtnfpYWsHGePmF3cH/
         mJl7eYqC17PPRzo4jecINLo0lv6YfvOhLzZF7ObW1PjmFV3tehIW/RDt0byuOunkcLfz
         elz3hD68nYcxi5rfC3fr/Q3gJ2eT/EaJ4bni+8y/JZbTHsdVNkLgsfXHLTmwSoyoWNXZ
         L3gJ+jE7sYCfWdqHUyzh4XbBpMo/zqaXdxfIGvRKtKpp2i4k7SW3zQZdlFGtrc/vlFMo
         CAoKLs22iWRb31C3Ou6fiMdOZCLhy7lGAt9DJ9ijry+sv0hAb9bMOqz4chrVk/QA2IW5
         caFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZZSGteSAReh7L2EpQ+wPN21aNoO/p/waSoJmutkQom+pdM0Hx+kG+MAU7sjFF50RAv9rhHEDl2Kr7xFhZ2Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbhGJxtBQRcJ6IKEe4JVMYRwTfxb+fZA6y8cQbZ+gHLe2fWxXo
	isrJPqiCVzH7bii/v3UhxQiGS3ChJJ9WXL1CJ4AdTQd7KR9nhypVaN4eZw3oNdoodw==
X-Gm-Gg: AfdE7cnWk0+DI7EPJGBLDWOa6qZC7ze9iTgONLajeFqmiXDEQw5IQGVoa01YgMiYluu
	hoG4ZRkjQTio8VSVvYhipTy1Aj063HTUOk26NiYWQDeB52izD316SyCnvWpT5A7bGSvqLR9Is9B
	xjKT6yOBaJ6389ti/ktDerxhA2wckEn2kQLLMV9f6114uXmjS27MLqZl27oMYrTLpPk1Bnw9SAs
	5g1Pz7/2WcOxhYK0l3YKyO1CxVroITUo2KOIl02hPNTXsmI9GHNfj9lqKbMhn9vZ089ty+Frz0w
	13Qv7OIU7ttjFJ8m5VKs4LPVQHmqkIj1qzrSNXuH6s8mA/852KFa8+65C5VDwCxd/En3ut3rvIV
	nZL6Uw8oQAfhrSC0kMFVzj83IOUKPulOZ1OGoWCE1Lc1MXJq7a564TVeN1OSHExEaDqO+8DgBW2
	Qh12htodiFGeRNmJO7IxDSkqxIvVUG6Ha4tV9waJPmsSlcPrLkCE4HBOip24S1ExiQZqvU0JVid
	d0=
X-Received: by 2002:a05:6a00:10cf:b0:842:708f:39be with SMTP id d2e1a72fcca58-84541991b98mr590884b3a.5.1781752431077;
        Wed, 17 Jun 2026 20:13:51 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:20ef:efdb:f2c9:836f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm17548232b3a.53.2026.06.17.20.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:13:50 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: btmtksdio: call cancel_work_sync() out of host lock scope
Date: Thu, 18 Jun 2026 12:13:22 +0900
Message-ID: <20260618031338.1011410-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
In-Reply-To: <20260618031338.1011410-1-senozhatsky@chromium.org>
References: <20260618031338.1011410-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cancel_work_sync() should be called outside of host lock scope
in order to avoid circular locking scenario:

CPU0                            CPU1
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
2.54.0.1189.g8c84645362-goog

