Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374EE43901C
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608377; cv=none; b=KRX/VVDaG6Ah0d+lPpjxiaUL6JZv6Z9FfNSauq6sbLTd4JfFs84rVveBrKGnGuTyQKkLtr3rJstal1vBB1/YtpEyKCCi53/Frg2b67b4x/F9o+3+tP3ZhJnb+EThFdIq5fy4asSuRmSEfyWQwjt2CBqO5ObZC8hqNhfhB4kMd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608377; c=relaxed/simple;
	bh=4Z8MER+upsXsPgDv1PcDe7VVV+NEP+nEb0Z9kgnbjwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irSXmX1pq8unIeYXJc02BiwiW9rAVooiYFnWZ5YGOV3cO1FLhikGVIXCzxNHIXk9T1zk3NZJSHlNY4L2VGkZHqgTDe0VhK3ZlRPmnWgO5yKKgwd2wQVwlqUlbfi8cpl9wDKh5bsvW6kMF+UUBW0d/Ki3UEqMtFIZcXJyx+VQvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HnSlpc6B; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HnSlpc6B"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84275887a3fso3657488b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 04:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781608372; x=1782213172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx01qzHYL7zapV7JT7OmgAtxcHhwEqISMkYtU1aw3M4=;
        b=HnSlpc6BanbzaypVi1/pSWe0awb1WpbFqWJyPOUjEzaGWQrMR0OwNWSZ+L80iWYKiW
         9S7RybzC5142ldnyDO9lgSd6DDGc5lBzgdriv0h3fKmpywM+7TnVbYM7fp0FAkXtj6+w
         AG6hzNTMcSIP5J5iDIGrrlNKCtXx6H8NnjFn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608372; x=1782213172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yx01qzHYL7zapV7JT7OmgAtxcHhwEqISMkYtU1aw3M4=;
        b=HypwHjdbjpF2gK510WjK/mQiHMP4Qf+U6hzCf8zwW4D1NEdCjAIVGtRj+B7ho/Ew4t
         6ryHFWR4AXK/IKSudPWP3qpt+jiczkaGvtcjWxhTHh5QWfMYltPbywS7A+UJbpjRquzY
         IywYH23WIj/jt3M+6i2aTQXcZ5IVj1vaDIBdP6VQYFf2zufqkVnR++x3B9UrueLqxVI0
         qFFbXWCq/KmHqjhg7tbaHDSnYnDeim42jrwp8VKkvZWFvdoNZ7G7X2CMuSfi90G0j8Eb
         aVwYK49M9VtdgNndPNfuRqFAMi0VCwSHVl9P7crxoDerXK7oGvjlZiZ+WOUVWpvlcvcP
         5SIg==
X-Forwarded-Encrypted: i=1; AFNElJ8mj5gf4oZOmZwYeHqua2cBkMovwD8/LUp6bw7V2/jDn0iKrz+kbuDYmtt29OwF8k5sMxCmaKCdF3fmQ5JsgM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyd+OWVS7Glk1x3nznrGcRDz7S6AfMK+qOiFJvafoe3/3uhHIl
	4nBxEBNcVtBqZYqFhxA+6aR3JNaSyIpmhR62/Y9bMM33rnMcXwnFjYNPtL1e/9Cmiw==
X-Gm-Gg: Acq92OEh2JHfGTLFPLr3DfWqYJIXdKn4e5dUmdYElN7HVGny4tLuTM+xfBfwG5Mtdy/
	WYJFM5l01bc8snBwSInZNIdyjMCQ15HC0sjZAZucCGhZepHn+MIpoBJ/i+MkiVwBBSUJfZvWcfQ
	8RPrZVfRll9nlljJyyTelk0t7Mgk6XtD6+60kVTj8X4fKYE7fnQxmt11wJKvg+3a8XVE0ofNRso
	avoHnEebQwl5Eh6VgujhinZ4HJ1SLcIzGGxtf6xWLSziwBB0DBkqSg0Qpus+W925gOxGBof3A3S
	FlJhhtVXFI8knKqKKrrmL9lm2phKRBsnrGIYMIfg57muZeVAhtMH+7nXYSK4+fh20PFOt2JAjs7
	9VDzW74wigVeB6XCTLYw7YmhPAlHcC60zlXDe6Hv/c3sWdigt7DH0AJnlQ9BXQDwHeT/7Pidfzr
	RHgTo1LOmjrqCClm0W0dUduuOi6/WNxTly7VerjshV+4al4v9ydIsW4/PhSlgcQp0XlReoqiXfx
	BZvN9PvlAk1
X-Received: by 2002:a05:6a00:6f55:b0:842:6344:f33a with SMTP id d2e1a72fcca58-84513e1747fmr2470656b3a.3.1781608372537;
        Tue, 16 Jun 2026 04:12:52 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:a0b:fabb:5b62:b85b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05921bsm12906321b3a.59.2026.06.16.04.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:12:52 -0700 (PDT)
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
Subject: [PATCH v2 2/3] Bluetooth: btmtksdio: test for bug IO errors in btmtksdio_txrx_work()
Date: Tue, 16 Jun 2026 20:12:07 +0900
Message-ID: <20260616111224.152140-3-senozhatsky@chromium.org>
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

