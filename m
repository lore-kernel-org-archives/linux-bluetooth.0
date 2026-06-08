Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82241345CCD
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917047; cv=none; b=FEMqnG/E5BNY9xJVhUjYpDTam7ztd0zvoC1GpJf3pBGgGimOM2g1CBj45oHe9mKJP+4nbXJpVBlAWNQVPnLor+jRFqRq6YahFTh3TNpxE3upe5CSOnplIixi3hl6PqjA3SVjbGwsyndKlTCz6/fK1OMUVfZ/4bXTvQuKKRJpSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917047; c=relaxed/simple;
	bh=nII7xl+AeODd28zfPotN78SaMlkQvbjTP+nBGKJwb8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZ80Q9ShC7iDF2IG6eCOv9ZvM4oY6vKImdrWe1il+iz4gbuM52USojgS5GEDIvPZ9dgSKdOlw+EVIbHByDxRKGuB1zNMuHFdi28QrdpeNdv1UG7xFPtoObMVwjYR2/W+sLC0rYG4dWK4NwoIXn5JcF9fFrbHbp3xD9GF9Ynxl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=qNuCvec9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="qNuCvec9"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b9318997so30445385e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780917043; x=1781521843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uCPxS2SGJk+K8ayqRv/DNpOVUsBc8/1a7C9ZwUBRezk=;
        b=qNuCvec9dBqm1zokyo7CgMJM+qJ97DnUrxQ48UecGiL7p1JB+KNZ88dfVoLPEFRiQS
         N4pWoFnbeB+QzCXxx9Uxpw/Kl9Ix+2EgapYSgzvGO9v/yGSR3ZO0HzA6WjSLfQDWEP5L
         AwYaj8zw8eUJAouUaMuIDGJpPz9DxWq2fzu2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780917043; x=1781521843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCPxS2SGJk+K8ayqRv/DNpOVUsBc8/1a7C9ZwUBRezk=;
        b=KEz5iXzzqHDi2U603uQ7bJCW3WRpyEm8l2H1wyNEEPtflJQA5TbsRJ6x9P6fc7i4Ki
         wIY5ysbC4U/gd4SszXBd5U5syC2FsJ/rNvMste70h3MCgVfVNW2MkvoIpAHg8fM1OcoS
         WKJxLYASWmVzmajOehKoktMpeds79c4DnKSTjva/s4qT5H6Ii1KWa4yjipVtTd+nDT37
         au/BPzVsnzagcMgvEge69lDD62DcMCXVGcClMIsg4+ceCvPiO/2e0GbZNd5ohxVAnDmU
         oxrHb7a0VZ+LVO9DjLbnQVWfaJXHCkkekTUan7zz4SNP0iu8yVSK7gY7uuzuzXAGAQkx
         vIDA==
X-Gm-Message-State: AOJu0YzcSy7DMiTX3HV5LVBujSs7aCqxCK5vWqZqpeseJU5ZihBZeHnu
	ourEpm0pB8QCFTCLcQ3+GTdjYMxzINy0OF7SsIYsmci8aWjWUBpLxhVfVWBTPsVcC50nlGan5Si
	wn1Wf
X-Gm-Gg: Acq92OFQIvA6QUR7KmiYTB/vQ+XonxigvFyPuuZuBREV2KcjiuuDeUMgRg/pq7hvd9J
	XBmE5VN97Q1Xo+z+4Y70MW23mvkPX7fDSXuBOnvosekYqDBjScMOYqL8Ytk2vOLDkFHOI6XH7L5
	hhb5gD6xsKx9MVr/xL+9ywQrYfOeXsL6kT+wXECBIYnzybXxKAlST+gqZwTYcyMmrPHfA1k3VNg
	hmiSnS4CQTr13cAcFoHaYOpyEOWs8joGqTk4IX+GJf28ZcBht3pEU9/hMp6UIdmkkwlGa6C9ONg
	z9kFNoV6r8+5y46trOeujXhLkU+aGrP/Rivx/Jh1f+O0f2CLxJ8h6oasuNOuZESfNmV2E9XgmLf
	5u7yFuV22CuXdVpb/40UVUZTL0kseX/UIcf4zAag79dG5QQXss8u4bTgAsN+11Iu8WHRVncZXBT
	jblxe5nFluNyE2N0XHmY1eNvaCfw+I5r1aDQ8nhqoPIl61fT4t5F1kOA==
X-Received: by 2002:a05:600c:3e83:b0:490:af90:f9c2 with SMTP id 5b1f17b1804b1-490c25b224dmr247497835e9.12.1780917042972;
        Mon, 08 Jun 2026 04:10:42 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm412922155e9.14.2026.06.08.04.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:10:42 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] adapter: Fix failed bonding attempt after LE link disconnection
Date: Mon,  8 Jun 2026 13:10:34 +0200
Message-ID: <20260608111034.3684632-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

What happens when issue occurs:
- device is connected to both bearers BR/EDR and LE
- bonding is requested
- LE link disconnects
- pairing keys arrive

BlueZ would finish bonding request with error and mark device as
temporary. Then it would be disconnected+removed after default
temporary timeout (30 seconds).
---
 src/adapter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 03593d962..a08847663 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8622,7 +8622,9 @@ static void dev_disconnected(struct btd_adapter *adapter,
 		disconnect_notify(device, reason);
 	}
 
-	bonding_attempt_complete(adapter, &addr->bdaddr, addr->type,
+	/* device could be still connected to different bearer */
+	if (!btd_device_is_connected(device))
+		bonding_attempt_complete(adapter, &addr->bdaddr, addr->type,
 						MGMT_STATUS_DISCONNECTED);
 }
 
-- 
2.43.0

