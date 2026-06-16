Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143642DFE0
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608376; cv=none; b=ZKMU5YXb0HzerUoRxnqZPLhQQW3arh5hamjhVyHgGAWXua48BUr61qlHUv/qBIO983KMLDTXSsVszeVviaGRX+geL/SFEyfqp1kevVSI5DgRw/j3ZskRtCDYsiDhgd0/MlKtnPv2PdZDDNw9zAmZ+UlsmFiID7TBUyvAiU6vWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608376; c=relaxed/simple;
	bh=XzhCB5GzyvJph4pAksg0ijeF4yJPIDyIY2jjs6KRlQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORRCgNoUUk/feP1HPWMlLVWl24aEkfFaWrc3VTkE/JGlbZaFagRUcsE3C2QvJBDFyov9Ew//+qx9piEICHj71fnP6JZxgOqBIYmVbV+mASphkcoXe/sI1Kte2SQngkqWvzNqkVeHhX3KTya2N//jd0huGKnEddQxqLPTggng1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qo2I+q5P; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qo2I+q5P"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-842307472d4so1627099b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781608375; x=1782213175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjucF5goefZfuxikv7tCuZJMVpoPtgqO36vnpR26lfo=;
        b=Qo2I+q5PflWGczlHlRiUo/fRgc2c3r7zrJNkD4+/3E1B2zfC8BOXqkTtmtgIEv6cTO
         voOXW+VFx9CDIjM0E/mj8aLuFTGT4wbfENSQUclvoSOVqz2Dfaugg9dYrQomw4wnhgCT
         kRveK0IFvF4nzqmleiR/fTeS3/ExciBCpZCzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608375; x=1782213175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjucF5goefZfuxikv7tCuZJMVpoPtgqO36vnpR26lfo=;
        b=ZpdnSWwIIYe+YofJlwnuDMnGvwtMdxQW8MyS88vhPK2+YZMZHt8ao6svM2aTj/cuPQ
         9/eXdQOcbJ8Q8DFsFl56J+xcTZ1K1HtQJvRBHSi97wInn3aG3aXABP2D7wHunF4ViDsj
         WbdIKtRLMtAVCa8VyQuQLF0v9Voh1xdAxXVB8whJH7r+99UbbNjRwSp/6sPMIdwXnnJl
         f3l5nQQQPjNLr2jz9EvkIOxwD3ZzCBHxPrakltryPqSsCbnrQWsUX5326ZofKHQIJ2R1
         I8xt9i/5A1JSejBiZ7AyY8/flyxs8qhCEy3K5qsJcu9mkL/lRA8eqda5b7AU7h46AefH
         K1wQ==
X-Forwarded-Encrypted: i=1; AFNElJ/n6wU+d9T1OmePl1r9qStb91tk9qOOw4V98t9JQNRBpDTLPSdQu+sF+3G/21wIFc5e9BTFmQPuKN4CVevXk0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXabG2gaq1zBSBm68jnAZWo5GjwY5iUH70emJMrQqvHsax8vJd
	zyvA8CX8lWBlfcLSsI73oiDjLrasgcAgFe320Du06rofbp9HyiH0sVwPI/IFbMhuxg==
X-Gm-Gg: Acq92OE93zHe+xTV/eGxFS+Dk5H8xVWvDa1pPvczXI9Y4VVC3fMJkWfjVYRXcG8cvQN
	2PfGqYsF7ja/m18grhzokZOExQZRDS0c1uZtkBQY852iYsMy3k1a0dHGQ5vmnDgB9paMTXu9Bmy
	HTU5HP/E4Lr9uFC+dH2R8W4T8wUoYE+2Fr8LAp4M4x0wDEoXp3SBNa4KEthNifZefUXxiNX16Q9
	sBLA/o3M0lqy4adBQ3QEkEB2jErXbju5I2nEXQp8EmVYqx2iiT1tpfVSUoW0xXhOcehfQKl/uDC
	/YfCdCAoegNiLHUOBvDEJK0p4U9boFiUtaegDzLdMElYl1I3MbJDLY0Xp0obbt4PIjOSGVdBiE/
	KAlYt7CJpe5T8BqJRdyrkyVFBLtFtByRMONDnNRdT5He/gw9mPRR51mA+TLVvzZ3If81kqv0C/v
	i3/YKqaZKzss/if/12rHvLq4u8J3yNKsp0L+PnQBctpx38q7BJ9/LLAlbPAxIIvAjUFs3fCp0nq
	kKxrR2atWCU
X-Received: by 2002:a05:6a00:1d85:b0:841:de16:8a8f with SMTP id d2e1a72fcca58-8451530c1d1mr3127048b3a.7.1781608375147;
        Tue, 16 Jun 2026 04:12:55 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:a0b:fabb:5b62:b85b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05921bsm12906321b3a.59.2026.06.16.04.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:12:54 -0700 (PDT)
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
Subject: [PATCH v2 3/3] Bluetooth: btmtksdio: call cancel_work_sync() outside of host lock scope
Date: Tue, 16 Jun 2026 20:12:08 +0900
Message-ID: <20260616111224.152140-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616111224.152140-1-senozhatsky@chromium.org>
References: <20260616111224.152140-1-senozhatsky@chromium.org>
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

