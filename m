Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63713B7778
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678758; cv=none; b=U57w/zggT8yft1R1YDS3SC/u+YoOVz+oh3u563CKWVaAXNct1z7zoL994qNO7X/KAm4YXggKMI0wVf6p//p+llPB/hk2RcvCbNkTB1OF8o1yVrsCuh5IvMKFXpObbR5Dj9HM6x3CikMXY7hER0QrToakDdmbFxeGzPqAQ4oATxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678758; c=relaxed/simple;
	bh=4Z8MER+upsXsPgDv1PcDe7VVV+NEP+nEb0Z9kgnbjwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adGePtW9flDbipLQuXVzRTlBH38eDgkbYUqOC0yCcGpuV/wUEiCX+64PStldL/m/jDeJ8sA+NjWZCrYt4B0uwGGzWDFfYu5LDvITkmPuw9zec4jnPbabhhdnje2Jufet7fCVHTXREUVGPel4UjfrBIcwI2XDnd2KaDSPt4Ok8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kaBAo7kI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kaBAo7kI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so5336485ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 23:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781678756; x=1782283556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx01qzHYL7zapV7JT7OmgAtxcHhwEqISMkYtU1aw3M4=;
        b=kaBAo7kIU1eHL2en5N6HyLiNOzbXs7kHrkCSAvtFmCtEdqJWoyA/nDul4oxvxzwPaY
         XNHozPt5Os4tdImsMsLZTTMbq/mxZAVKrQsDVcMi3LG8PosBIOrrMgZXi3syFrlAgyrh
         5qm5/qe5vxDBE2fmFL/SbSLipXpRBpoZTUZcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781678756; x=1782283556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yx01qzHYL7zapV7JT7OmgAtxcHhwEqISMkYtU1aw3M4=;
        b=cURx+jivJ0A9nVI6oC9/0L0ktjzKLRgCeBZUtWA/mR3LCcmYXBx74KLnGt3Ok6jd7+
         /xPwE9NEtzdeBz4xEtDz/Ghe2D/e/MRs+eyAaapui8AnDg00tiVAGFvuC1/t5RxZ5L8M
         fcQOMgXnW/xyPMgV+BQi8kkCsb1HbXt/h5d+oh5NpcUeVfC4+D51n9lHGgg4UqEIoXXP
         30EvsxuOrm3wqkkcukIDJDVfR5Pz74b2jo5kIyTnuiQpBQgYVL9a4Pae0K9es88qZxxJ
         GZ9SlFnr4rURU2VY7rHwDFCant7IAIuBjulurabcOqcwSoBUitqxIkjs0oiyV0G4S7iq
         67UQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jGFnJ0qncFMmLUHNFYYerWeEmLplddwROtKkSlj8fcq3hbDl+6hf6dAS72HNJA7uQ93bgDZJVBcKAZgpk630=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIU48ruxVAu5iJa9kpGBUgYBuULJ08K3x0jcQ19fP1o8GJOm1g
	L5R16VJnd1dgLlFSdLAE4TY1ax7y7/B3lrHKsAII1kMF2xgVY5puIh0hq+CcUH9YRQ==
X-Gm-Gg: AfdE7cm6eZF5ziLSCvHBTN5GC7cuQHpfO05hdmiw49uZ84Xgaf7asFAe1imUV6hx+JW
	S9T0YPteaARKWX51qCRaV7dUOfoW0hkjThlxYCy05vuAN08mr9NDy0XQujDfejZji0/Nyo5t6Bg
	jYliFzJvjWb/ZSWYEPZ30hDRiKy8nh2Veg+f1vKqqo5wQAC5w7eFcXSxz06p+t7VJKi+Iywi4+3
	cHc7J2bVan8UEBvx3+wKL9JGDtvi3kBV4xTRxrxJ65ta5bkZJ1gFX5AD4FFzGt045UKGB1ZeM6m
	skQE2WmL+O14zuBByDWHCPmoLyL2Uzdr9BdPJLb5u0d+dFQsPcgT7uy5Dbfr26HghYDcWbDUqRT
	3FOb5Hf6uh2QZEmKe3NEI7razKIWuWtHKwDpb9wTCXLa1XanLGzGj5L83PQVeb6XwcYFeMDM8yj
	aix/51G6WkK3zuYQAGsHbO5DtZJynuJu5l1B4BpL5XjBvOYOMPWn0Pwabi7XDqtH2or2f0UtcNg
	O0=
X-Received: by 2002:a17:903:32d1:b0:2bc:f1ef:2e64 with SMTP id d9443c01a7336-2c6bc0c8905mr27041175ad.12.1781678756057;
        Tue, 16 Jun 2026 23:45:56 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:20ef:efdb:f2c9:836f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6af931f19sm24365675ad.74.2026.06.16.23.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:45:55 -0700 (PDT)
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
Subject: [PATCH v3 1/2] Bluetooth: btmtksdio: test for BUS IO errors in btmtksdio_txrx_work()
Date: Wed, 17 Jun 2026 15:45:31 +0900
Message-ID: <20260617064543.574704-2-senozhatsky@chromium.org>
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

btmtksdio_txrx_work() loop termination condition checks for
int_status being non-zero, however, this evaluates to true
even when sdio_readl() encounters BUS I/O error (in which
case int_status is 0xffffffff).  Break out of the loop if
sdio_readl() errors out.

Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to work")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/bluetooth/btmtksdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c6f80c419e90..d8c8d2857527 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -574,7 +574,9 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	txrx_timeout = jiffies + 5 * HZ;
 
 	do {
-		int_status = sdio_readl(bdev->func, MTK_REG_CHISR, NULL);
+		int_status = sdio_readl(bdev->func, MTK_REG_CHISR, &err);
+		if (err < 0 || int_status == 0xffffffff)
+			break;
 
 		/* Ack an interrupt as soon as possible before any operation on
 		 * hardware.
-- 
2.54.0.1136.gdb2ca164c4-goog

