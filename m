Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123E3FFFA5
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007229; cv=none; b=JWS8xAsUGrz2XDAnhp4FPDAo9fHad4aEestYut/IboO9xjJCcvRbCE5YMLLToDVOPvWkhA8vrGnPSvULebPTNL2FpPPZfiOaRwCsdKlH4Sbxsnse52ZAD+vMIxAVRdZ9MMd31Q32rPaY5nvFupeUlFhMo9Ts6QV4nC/5WcTiF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007229; c=relaxed/simple;
	bh=CCCknRMucJa27YIj8zqKWb5yyna/lo4aYM4LXTZtUlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRu0Sdd6gYa+cSi3oNPmNjmeuW9t95eIk0VfIzk/LgPDP3mxcepF6eVcGZJusoi6s8ZfG6LgdKjuN2Y3yse2iKebic2XiYq5iP3yqjEROJyvdd7O2WzaHFY8ZQiisIeQ6vbQeTCLaJTW6hlNaJmXUp0Vi6KfnT0VnUWICmNWarI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JL1FGsMX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JL1FGsMX"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c379e8ffso37036725ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781007227; x=1781612027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=md0oLfExsjhQ5s9zgCStyVmZOOcuKHtb2pCgbVaO+NY=;
        b=JL1FGsMXbbC75moFt8w37Q32pVINddMCRpvyJsCB8g1TT6E5te3yOa+fXdYm8AigYj
         7mEyyd7qDiCUS3NXB+YgEWF6jcvLaAJUjn6+CEIH6C2gfKXzZ1ChQqu7/NBAju9VrjUK
         rOCRNqjt9cOSHXwh8SDAsFlBwAG3TN+XRCjUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781007227; x=1781612027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md0oLfExsjhQ5s9zgCStyVmZOOcuKHtb2pCgbVaO+NY=;
        b=nzflwl6P1IML3G7Fy1CD+V8sQ3tpGUKyrDBg1oOVaOTdx0Vcutp2mAgcstgzucgOB4
         CJQmRZNkTLUB3AJ9CbT+XhvQwG6azTnEkkHofvVN/O+EtYp9o4EUtaxG78NIWNt1bRMM
         q77Z3fLEGSM6ejUP79Jc+EYaEcgthOaK6i1YGH5YOJsVyTa58XersRkAfeLmM7ce2E/C
         +iaol3CYS+7tEu1+rnQIHerJVMSlg8P6oTGZodevnR42IYJsH4FQ9Sd/P4IoYNyATVnN
         qPF7KelQVoDWd86Y0KWkQz5YOXJKqZNKdoYwmukvITqiIJgkGHAHoUCDetSsKqb/Ijfc
         kOoQ==
X-Forwarded-Encrypted: i=1; AFNElJ85pG8WxTnwoJQyRhGEAbmUQ2Un6zPf0BmS1wWZeib4g8LWYqgtMEkpFE8vq26Bm/wtKDeT+LYZXFsCjlS0P1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHCRb9NTKv0UQ8iBteNIkEV8+58uHfkdKnyft0z94sOBMLbnl
	C2AzSCeGPKl44bydi7nSlKY1L28MHqa6y8Ecn58JlVsn9AOwCCSNFpX2eyroUFcUXA==
X-Gm-Gg: Acq92OHQS1NExDFMzu0RzHQxjaOJRXO8aAjUKy0RNme0Ku3wqk4Bt7a6gqtdF4XRzV/
	Orc4RN9k+EEKbl6Ur1++Tgf0X2tR3sOD7OCW9h8ZnuMgpJ5Kb+PnteQmvNeDOR13DVxLl+v9HL4
	jB3gCxl6qlq7jJJ2zSH3IPoWwXCLT32RmIBWCNx+EkwDC4fLmqIYjnm04/lT+FfrSqxMtyfeezQ
	AZ4tCbTXbU5x7R8FYnCIxwLZFLfB/XpSbRpHSswicIAPW6utXE5yRCBWe4kDTyDbUWU7L4DX+Tt
	upyN2DomBcegDCmZF5ihWLuP6wGSjxivFFK5dImvd+Qf5Chvodt80CsgPlV4DGoaHbplfE3Kdxm
	ZvDvC0boKPtTASreWTM1P3SPk3SL3F6kFdTHgxv9AKr8Xoc5M9axW0J1QBR8Nzb2UTIP9Wj73hz
	K+eBKn5lK+097Y5qo6NTO95vbrhkK9Xuqa6O0Y2LDaTCLFSJ6+KefcSzkwYpvR3CoNd4tgyjEKA
	OxtYxL/d5NwKb4qDj4fxctj
X-Received: by 2002:a17:903:fad:b0:2b2:ebed:7af5 with SMTP id d9443c01a7336-2c1e7b13addmr221626095ad.13.1781007227564;
        Tue, 09 Jun 2026 05:13:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:62ce:f303:81a5:1cce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm279998175ad.9.2026.06.09.05.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:13:45 -0700 (PDT)
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
Subject: [PATCH] Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()
Date: Tue,  9 Jun 2026 21:10:06 +0900
Message-ID: <20260609121329.1262170-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every once in a while we see a hung btmtksdio_flush() task:

 INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
 __cancel_work_timer+0x3f4/0x460
 cancel_work_sync+0x1c/0x2c
 btmtksdio_flush+0x2c/0x40
 hci_dev_open_sync+0x10c4/0x2190
 [..]

It all boils down to incorrect time_is_before_jiffies() usage in
btmtksdio_txrx_work().  The btmtksdio_txrx_work() loop is expected
to be terminated if running for longer than 5*HZ.  However the
timeout check is twisted:  time_is_before_jiffies(old_jiffies + 5*HZ)
evaluates to true when old_jiffies + 5*HZ is in the past i.e. when a
timeout has occurred.  Using OR with time_is_before_jiffies(txrx_timeout)
means that:
- before the 5-second timeout: the condition is `int_status || false`,
  so it loops as long as there are pending interrupts.
- after the 5-second timeout: the condition becomes `int_status || true`,
  which is always true.

When the loop becomes infinite btmtksdio_txrx_work() loop never
terminates and never releases the SDIO host.

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
2.54.0.1064.gd145956f57-goog

