Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE32C181;
	Wed, 12 Mar 2025 01:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742729; cv=none; b=DioyCbnUtaxT8AFyGe0fQlkcdObOXgUmSmIUbggUayHdxMqpZCujmSPtPV0Tov7nNYtoqm+/GgjBBd72mH7pZ+P9vh9Lfceku4iyqFb3QV5pPHIAa482+unDhybyLjWKmzOeMn37YOKSnwK5m4PANqSAnanF4a1CjhF4wVoDE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742729; c=relaxed/simple;
	bh=RvGWcc9fuIRtTev66CwxvXunOVuOUGiGWLCZu9fsd7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sYC2gPeteiJmWZqN2CBM2s0zuTdHTOMGW4vqOll14yu74GotB4dDQEZaJa3WY412g8lyDIbt7ehXviLLFXY9JQ+39h7QETPVuic876V+7nx77yjuiYJDeFRjeyWzOc63s5fxG7TvrZ0SlJSmjxu++1V5N6vsCBy4Qkzgy7hndbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3fa0eb29cebso250246b6e.0;
        Tue, 11 Mar 2025 18:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741742726; x=1742347526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlQ8zGSiXC2UMWrLxIq5J480S5wYp1oqhkE9P9/QTxY=;
        b=Zi5H6qv1aS/iYer5ihvuoIkFEH98t3aMplrlYMv6sPXX80Oq5xgkPsnChay3VNdjD0
         FAplJFnNMa6Lc1W7ldXRB3k02WRo8txQAvrNREZjSI+CAJxe1+KhZg+b81t44fBE3slK
         j+D1aTmW335MoH7aQYWg7R6vLx9vRYW7PyhTNj8cA5jYiL15ZoVWE7mtwFhPLhE+sMFP
         vfN6khPPYwfevhuUhArmVPm8s3hIKKlmicwQgi0qbFb9QfKkl9kaIh2lmPoaVm09hiQ0
         G+tgjEXpUf9jhEqM/qeQMFNhVait5aYuL4392EbfmWK9WFf3/ZZ3gOSJ/QO9JBGBeMpn
         3WYA==
X-Forwarded-Encrypted: i=1; AJvYcCV03MwXRVDXBovR+Kbs5O9C0jpUKhAINVRq2Q79dvkarxPAKddo7TzydrZ55crrZQa58ESDXVvPZJslpjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY43wuihrtSdoTdCvJKzngKWlLYj0B26UtVvavp/u/R1simTqr
	bUIJFxHOdGqyy0NVGvO8JGnR+8T390xMM31+ifluBoOlfWAlb/De
X-Gm-Gg: ASbGncu30ojHQXrSMl0+nnmw+3IBYnhHZ18INge2+x3wkO4USpmDwid24eMDNPO89NK
	gBouHkOtS9lmE6g17ZvjdyzUNlJGj52tJmS3JTzfa223GL/XOuSytGAocBspVI71kFA5wD4BRRn
	2dcJoJwZif3MwHOXdgEsPrGCSNPNK5WOETL6TsGtMkV08PgaLEeU3la53Tbr64pu6O8Il+mCExP
	URSk9KFNAxP+zOhGPPjmIQzBKRoxwJFJengpvGwDew+FjW6T6XGvO0GWmlSDNPmywy7q0thJlsq
	QVGcuA1oJQx9oND0MKjNC9BnrebjWP/aG+BE8K6Nm7Ljj349rcFFZAyQWHjz/w==
X-Google-Smtp-Source: AGHT+IHUHVqGRHi1FiHDLSZpilZtJwCnpP7CO+C8rk9WvHyA0Y80iswmxtal4O25p0GjBlCr+YNcJw==
X-Received: by 2002:a05:6808:38c6:b0:3f8:7727:88cd with SMTP id 5614622812f47-3fa2b7eda13mr3313051b6e.7.1741742726566;
        Tue, 11 Mar 2025 18:25:26 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f9ff1c6696sm650888b6e.42.2025.03.11.18.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:25:25 -0700 (PDT)
From: sean.wang@kernel.org
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Pedro Tsai <pedro.tsai@mediatek.com>,
	Felix Freimann <felix.freimann@mediatek.com>
Subject: [PATCH] Bluetooth: btmtksdio: Prevent enabling interrupts after IRQ handler removal
Date: Tue, 11 Mar 2025 18:25:22 -0700
Message-Id: <20250312012522.53604-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Ensure interrupts are not re-enabled when the IRQ handler has already been
removed. This prevents unexpected IRQ handler execution due to stale or
unhandled interrupts.

Modify btmtksdio_txrx_work to check if bdev->func->irq_handler exists
before calling sdio_writel to enable interrupts.

Co-developed-by: Pedro Tsai <pedro.tsai@mediatek.com>
Signed-off-by: Pedro Tsai <pedro.tsai@mediatek.com>
Co-developed-by: Felix Freimann <felix.freimann@mediatek.com>
Signed-off-by: Felix Freimann <felix.freimann@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index bd5464bde174..edd5eead1e93 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -610,7 +610,8 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	} while (int_status || time_is_before_jiffies(txrx_timeout));
 
 	/* Enable interrupt */
-	sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
+	if (bdev->func->irq_handler)
+		sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
 
 	sdio_release_host(bdev->func);
 
-- 
2.25.1

