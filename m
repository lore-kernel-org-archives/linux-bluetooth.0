Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B7190685
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2024 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632003; cv=none; b=lWSS/OkKQLBwYbs6RvacMBHcUKolAPHncCD7u9mAZ9NCUCKGclMIZ9Z/I3Dn8iUEcQBWgEWdHU/3GBesmfU8XKPLUcScQrZ+kqKn3AiWdd2QPrO2OivUW7QY9aNXGA+rYYmz5n/qQrTXKbizIOMoByX32lUAwpFKAmeWY29fqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632003; c=relaxed/simple;
	bh=JrqiFkABwdVWEDkgYvrq5hVOfgVhQ+lhdFQmx2wgo+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGJF8HzdaUDclttOH/iPoAozc8Iv5FwDze0V0Klwb3pjqMsISr6BlrPiXr6a/iHRDN70my6vZ19C+Ixyd5nVE9FclJR3Hi4j1UCiWOchC50hCLh5EvHwOF3cDNv19j2X7vSezHUub60bTLUp+LGMQ76ziCCnktXxQ/F/YE7240E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvFExYxU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvFExYxU"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3863703258fso1422359f8f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2024 10:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734632000; x=1735236800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YGcvGuzZjW/zmkf0ZeBWRWzW+IhaNErWIGnPg+MycU=;
        b=LvFExYxU2zLzs1sHzcCEgSdcrZZHtL4Kiv9B76+nNnAjcHNi3DFwF3d4McKZsN2Xtz
         RUWXmuLkn2HKRNgHPff731kIUknaV4pVhb3LF8ZbAIFFvCBrZEvl4pHXi7zBF15El4ij
         TzNPDVT5B12x+PTfN6HHT3y/ZZcpjzsrTzT9Ukjw6JbTMzY6mVGoSJrAG/G/NhcUB0Zt
         uL1Z7dsjsHfGK40XTskVbmJ1l8lT6/iik70SDxcReghWXBRDqGKEMGJEr+QOZQ9xYyAV
         ejWGCnPYlpDj9rfLtAyZJcxIEcdVzlLvka4JGb9XZioeg9vytYxt0yfWaIErxAabLSgl
         YoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734632000; x=1735236800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YGcvGuzZjW/zmkf0ZeBWRWzW+IhaNErWIGnPg+MycU=;
        b=ONCiHu6R2jrcwWFioJZ1dFgHVGH/WPyW3m1NS7jqNfmZ1FdnZdLmJWx/mRAxa6Wxfn
         NuARv9o5WyxyQSyJ+0PbNXDk7JiyTlG6+Fo4jtRzavZ19sD1IHOVHWP8QItWuWDiO09F
         0ZzCWcsNoSL2n9HW/1HViSSLXjuApG0FIAa5p3gDEToYgbugRVTVttt9RQc8NbyNp+R5
         uS0ceaDqB3z1YeVM7dNnT7XQAtWP9GpVroM1RK3KYVnLOZl+5QQyOYnKgjNcwjUNUqWb
         3xcx2rCps3chIfNpbQddXsi/9pdyT9+URn5C9Kvm6K2IKj1wkrVoo+QuV+6lA7KhH9U9
         tocg==
X-Gm-Message-State: AOJu0Yxzo4cY+e1WawUoKi0BzjwtGtgvyDS0TtByah6Ux4TuV4dOm1bY
	x4xkBn9DDr8zfLvEoHGL1163DCoZsCI+KaOcD5roTUnDemG5Pq56TAjUNZq+
X-Gm-Gg: ASbGncs8xtbGe2S3nF4sTwjRkzuPoRbYACXEH+PSNsfE66qHNGmQ/O0yzJ4V1FpjyDA
	Pu018paeryLlMoLBcV4zlJwn/K+tkFdUZ4mE38otEFUwejKNbCMhsIaxHApesC5/CVkP0OvoIEU
	9gV5u/Cf6y7cYJ3FyPgduHgfI9Rk7UCKpRekIcxTbqOoJM+IhENN7Ck9Wa4Oc177eAF7WM+r22R
	bxN1+lVeRlHdn77WLpXqzhvBTQExSNabwl4OAK5R6kLoGuq/4gRa4s6SsSiNPOhBCxWKGFM82Rj
	HZmObEtx1fSZlZtJa5KgEuzz
X-Google-Smtp-Source: AGHT+IFqTCjFggDA1Ccf8QY5ic9iEpc9qku7UAKkYxAY5n4RTnFuFBdKmDtUuXtfiS3jzNtP/5IAgQ==
X-Received: by 2002:a5d:5986:0:b0:385:faf5:ebb8 with SMTP id ffacd0b85a97d-38a1a203f10mr3394568f8f.7.1734632000070;
        Thu, 19 Dec 2024 10:13:20 -0800 (PST)
Received: from localhost.localdomain (33F121a1.skybroadband.com. [51.241.33.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c833280sm2106622f8f.40.2024.12.19.10.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 10:13:19 -0800 (PST)
From: Kieran Geary <kieran.r.geary@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kieran Geary <kieran.r.geary@gmail.com>
Subject: [PATCH BlueZ 1/1] Set `SDP_LARGE_MTU` flag for DS4 Rev. 2 product code
Date: Thu, 19 Dec 2024 18:11:40 +0000
Message-ID: <20241219181140.423916-2-kieran.r.geary@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219181140.423916-1-kieran.r.geary@gmail.com>
References: <20241219181140.423916-1-kieran.r.geary@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 2b3d19f55..4e5a5b945 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6047,7 +6047,7 @@ static uint16_t get_sdp_flags(struct btd_device *device)
 	 * results in SDP response being dropped by kernel. Workaround this by
 	 * forcing SDP code to use bigger MTU while connecting.
 	 */
-	if (vid == 0x054c && pid == 0x05c4)
+	if (vid == 0x054c && (pid == 0x05c4 || pid == 0x09cc))
 		return SDP_LARGE_MTU;
 
 	if (btd_adapter_ssp_enabled(device->adapter))
-- 
2.47.1

