Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4270331EA8
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 03:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752428; cv=none; b=bUBNyyoDcvGcBbw3CSomhRMwfLBSiV/DS8Qx0kD7BsyMnhVNC0JCap/bApAWfc5f/bJy/gJcseoxeoZq5VyGo96wBya7EGT2uR18b51hszbftIPoBY1I3v1Imdk7L8P8o03yPoz0vpU0fB8Ngy+6M2hw7emKBnCOEf8+R29fmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752428; c=relaxed/simple;
	bh=E37VNiORkpcO/FMgcO/X98k+nxSJ28/r7kLDisR9Fn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HhuN2dlAZLrE5LjNWJErlUKAOYiyAKkCbN1R+SGBKqlUSgbzytoIC+TVrNdsGLZxZ4pZNjYULrBlQcs68OEcCBiCCLnsXQqYl/dZ4uaDOkW4Rcibm8hQxNz8BALlFRSS1JyBzXDz/HUQzktea9tCbCS0HtSdkhBmKoAXUroeVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GRiJj39C; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GRiJj39C"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84236f9b638so152707b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 20:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781752427; x=1782357227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jDBMo+uapTMqM+YZcqPtN2LM56ZOb5vW285QSsulV4=;
        b=GRiJj39CBx3sENqFWIsZCCzf7Up6zYw15Rzn8HsDXTbmtPsEWFr0xJtpR9l5uGt/+0
         QHTxa3H+dP7HjkdBz+mU9xtVgMt80LOsGgS3yG/40plF6hVkmoFwFr1VVqQYE/yaFaa6
         4lhF5Fw813oyvZJ++DvEwqOGJtXqD6mre+2Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752427; x=1782357227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jDBMo+uapTMqM+YZcqPtN2LM56ZOb5vW285QSsulV4=;
        b=YAt3tDjcpZ3hsHER5+g1m8o8UzODatiFVbQAu1QY0+6Sf21JvMn9E3KDRxuFbSzFQH
         8GRMvBJkClyonsLe2QGoLYnuUMACnvvt9HzrFNRX9husHTuZunZpGE9jj0sfC/BnQQ/U
         4jnu/uzDEiMmDq0tUxUZkPVyIi4kGic/Sgv35AGhX8U0j8aHW/hgNslYONW+ZoJfacHS
         P2wXuEHqd7Of/npTFKx15peGNyGYXeAcKDzh+6zCuQcZYKfeeMAXzizjxLjyymu1BSNV
         tKqUhHOY/1kz571Bd1inTfpkkrFMjxagfd9TANzE4BGlYsEvqmcZG9XIi6RI//ycJYGW
         sWZA==
X-Forwarded-Encrypted: i=1; AFNElJ+Pj6TpKOcVxXpuySs3ujwrV9PN7piauxsjNxvs726lf4LXJ0F1Q4IMdgQNEEeNPc6bUGYiVryXdak9gZsJMAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdg44O1eS8/zajtu3Db/wGw/IHcJHq5XI36D7RDCSSyorlxT//
	Oi8pWD2KtkPsrpmg2FgpIyj6GSOUkvHU2IyZcEriWQOt4VJ7tB3ogra2z2pa65qLmw==
X-Gm-Gg: AfdE7ckNCOLP7qcHRN4D3z9uw93Od+nRytOl33rDqJBuHkBfh/JWWVZKs6EimuiBsrI
	aernEDZaa/nuHPS1eo6g6tVxkV+S0FLOeDrzfq4p1zQQSaOuXh3xpN7sVlVgqy7Np9bEGTw+yk/
	Nbmjau+iuOTSQ12phBHBda3gUYYFor38DY2n/8OHX8ZckRtS7yuMwv+jZzymnsplyxiMq1pJKWW
	ltadEjbp7ghzMZmP6uylgeQt2CFGKnD387XG505UuXwit1cfHiQVwhQ2bTqIjcgZBegx65Vz+Ga
	Tu6DFG5yLajsKQrqmmXfbNkzH4HR9hnrmiCKA78hVN+BPa23+tFrsG4dspla+J28llZ/RCf6yfI
	vqpl7fCj99CmE9u8W+EIa0yYKhdIT0tHErFfUaXMDuTwVWkoUhqUiY7sWucuhakCdaQX5UEZXK1
	3RFq7tvI6b2ZhsWROVXv2kRQBFETRP6T3d0Kkh5RqPf1NfffC5eZzEWSaHx39q6mnMManAa2C3Z
	tI=
X-Received: by 2002:a05:6a00:84d:b0:842:1ffc:55b5 with SMTP id d2e1a72fcca58-8453b1959a3mr1855321b3a.26.1781752427130;
        Wed, 17 Jun 2026 20:13:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:20ef:efdb:f2c9:836f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm17548232b3a.53.2026.06.17.20.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:13:46 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v4 0/2] Bluetooth: btmtksdio: teardown fixes
Date: Thu, 18 Jun 2026 12:13:20 +0900
Message-ID: <20260618031338.1011410-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes several teardown issues:

     INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
     __cancel_work_timer+0x3f4/0x460
     cancel_work_sync+0x1c/0x2c
     btmtksdio_flush+0x2c/0x40
     hci_dev_open_sync+0x10c4/0x2190
     [..]

close/flush can deadlock when run concurrently with btmtksdio_txrx_work().
In addition btmtksdio_txrx_work() re-enables interrupts regardless of
close/flush being executed on another CPU.

v3 -> v4:
- fix commit message linter warnings/errors (tabs, subject line over 80
  chars).

Sergey Senozhatsky (2):
  Bluetooth: btmtksdio: test for BUS IO errors in btmtksdio_txrx_work()
  Bluetooth: btmtksdio: call cancel_work_sync() out of host lock scope

 drivers/bluetooth/btmtksdio.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--
2.54.0.1189.g8c84645362-goog

