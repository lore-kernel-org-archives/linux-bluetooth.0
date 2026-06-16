Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A842982C
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608373; cv=none; b=LJqa8cafIGuf79edDez2y2V842XZCOoad/0k7Hi5JzkKKCGoVY358UE7dJDKtyU4ZTL5zy8TCoYpOO94enYAx+qQ/NG06easQXPXY3bbHEhILODn8T4xeJzopRqluyu0aFy2X0svQcElpSK8R4LVRwJ4dweH1TNvKW1eYCZa0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608373; c=relaxed/simple;
	bh=wPk0jvbiLk1gnxWCbBjPWoSYq2XDqp+9aHn95n8KQik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGJgmaT0dOLYiQOvSq3Pud+8WINRCKgwPr4qbSND+NUFpQlC2sd0Crmvd81pAgxsPHUjgHgVMzIPaXr/q5gBVgWes9rMAP2qHtyW+yUcyymZXQ4lR2g1VO0s/k9fM3jcCAC8Jzb/KOZXCgzQA157/ZmpMz3vt0hp5qngynhuhUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CRHOB04C; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CRHOB04C"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8423f1d8902so2043589b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 04:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781608370; x=1782213170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on8hqRmuM/Ky2/WGRUWRuZiJutnnNXtBaovb+8l2mm4=;
        b=CRHOB04CMAZ0FIHIqixvSm16DquGUwE/M4wDyyNgza76pSO4guxxOV+WlTwUn+BGvF
         pO/NfJIF01xfUe3D9mQkmPcKMwZ/vxbz0p33+IO4Qylb7edf6YC0YYZXw0CcwiBUqNPo
         h/VfSc3kjXUQyxOkE4vNELxYWcQKSi/7oQcg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608370; x=1782213170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=on8hqRmuM/Ky2/WGRUWRuZiJutnnNXtBaovb+8l2mm4=;
        b=D0eXuJwQtIi6TPvmoNvw3nOX0Eet27pAR6FAlm5GgsjLhwtgpBjEH3XFqjrfZQKrNk
         WuabaXUNz++c8p++WyKLMONtEAW/umZHCnpVpDWOjC5mu0l0qMWBRVpxGPJwejhZMDbu
         3jPFt/Ou9k3AdLXryvOqyb0Od5AdsoLsnoTL543T4pLu9cxGiGYEG15XL02NRxbp9/jx
         J12mmX6b+RspQezyhKTOo37OKnZ9McHxJ7nFvCB6Q8s0XWCeX9GByiCUBac8BFiGYKiP
         0GUpspTrCyeacxvxaP9CRT1ksYHtchK0hB5xSd8oKExxEIO1HphmNO543WeUoVTQoGov
         TbQg==
X-Forwarded-Encrypted: i=1; AFNElJ/lqT6n4n1JBXs84DwAD2brJSFgHMR4YiVfdqorCWkL+0IH+GxC2iQigqB8omJvGgHNyirFPgK7M+EVbJAXHFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLu0fptRN5EL0l7NSVfOnC1SjjMBdnegI8Eh7inniE/fi0D0z
	sc9wpphwIxE3ns9izLVfAjeWTT/a+K5zCYe6/O83q5fEIzKqvBWZs+nci63PWUKANg==
X-Gm-Gg: Acq92OGf+B3trD1mFOsB+jR81OBvADKZcQyTX12mW1K0WRmPzWkXPQxfLfX3YbG/bAs
	gwyG+omliwuvjfHYfbCUXkftrxVyNlWS9J577I0CSvy3D3Kyge20lf/VheMyZOnmLsM1an3icDy
	5diYJGJG7WESJSL17otjggN/TMgWZcGawwKCeZTM0OOgC2zVlP5IyeAv28bWXtHl+Zs7aKvv6v5
	gzjvC68c+/vAGa2nQWQ8NDdl2vnoM9/09kdzekZtAZnJpnaofPBnVvqO+q6KV41TXY6oP+ORq93
	G1K0iJB0HiNcpwPdwY3iP5Z52annZUda4fYtRQFeaSqeKHotUC+HuZhLxUc2bVSJTIYeJs4QxNF
	vCoCDyYO8sz/cct9sl/mUPuGZdbe4pKSa8Q36Uv+2BaWflaqGrZwAg69fDPkv/IgUXupcpi4X1K
	nDrkOM4yWXUBL8vNMMAEomvJLYDu+JMJJOnkRkdb8YJqnJWLVLssdcJ5KD/quJbjNMhOVrMwkop
	ZFn02wgr6L5
X-Received: by 2002:a05:6a00:9285:b0:82f:abc8:ae0 with SMTP id d2e1a72fcca58-844e19879d5mr16162588b3a.17.1781608370193;
        Tue, 16 Jun 2026 04:12:50 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:a0b:fabb:5b62:b85b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05921bsm12906321b3a.59.2026.06.16.04.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:12:49 -0700 (PDT)
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
Subject: [PATCH v2 1/3] Bluetooth: btmtksdio: correct btmtksdio_txrx_work() loop timeout check
Date: Tue, 16 Jun 2026 20:12:06 +0900
Message-ID: <20260616111224.152140-2-senozhatsky@chromium.org>
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

The btmtksdio_txrx_work() loop is expected to be terminated if running
for longer than 5*HZ.  However the timeout check is reversed:
time_is_before_jiffies(old_jiffies + 5*HZ) evaluates to true when
old_jiffies + 5*HZ is in the past i.e. when a timeout has occurred.
Using OR with time_is_before_jiffies(txrx_timeout) means that:
- before the 5-second timeout: the condition is `int_status || false`,
  so it loops as long as there are pending interrupts.
- after the 5-second timeout: the condition becomes `int_status || true`,
  which is always true.

Fix loop termination condition to actually enforce a 5*HZ timeout.

Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to work")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/bluetooth/btmtksdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 5b0fab7b89b5..c6f80c419e90 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 			if (btmtksdio_rx_packet(bdev, rx_size) < 0)
 				bdev->hdev->stat.err_rx++;
 		}
-	} while (int_status || time_is_before_jiffies(txrx_timeout));
+	} while (int_status && time_is_after_jiffies(txrx_timeout));
 
 	/* Enable interrupt */
 	if (bdev->func->irq_handler)
-- 
2.54.0.1136.gdb2ca164c4-goog

