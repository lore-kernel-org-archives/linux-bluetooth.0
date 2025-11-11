Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B562D9ECB
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870893; cv=none; b=R8n3TsGCCP95zz/DmveulEX74I5oI8WDSGh/+/0Mz9UJ8MMfgBLdctNFlrNlqaIDp0/N40OdnN9xQKd3XuKnWuO9HKZPMb5ms1si2VBrfsfzuRnqSgIzr5xabYZD+PIBBRrniLTzwB9a6wQ1tAho+lACX2bLPm9//ws95hZlaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870893; c=relaxed/simple;
	bh=mirizuC8TyyJX00lroFQwpv5tEUAq3byf2K4tEWDplU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZpy6o/jnZXlcer4O2zyQ8RYd1jcpS8fbnLusJzsqGOSLHhMpM9q4CiUEgNXVEHC0b+jGsUNiVJQk/aMNNNUdpj2atgL3BduYyhVbkwcbxy+WZ0DNyqG+yzKrcgC1luN/YiRRohrHy0U4ZP9PcAUkjp29K51eXlFZJfcmyChIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSfw7buN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSfw7buN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2956d816c10so45287145ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 06:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762870891; x=1763475691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCmLGPtWM1OsfKhrmlp8FzG2vpcxwFoPVUUdxec3ZQ0=;
        b=gSfw7buNBccQxPMtKqugZid4WUXzqdKajSeFNXX0fyv8PNCX124MTxw/hUIpcQy75l
         4L+y7RwHAvCRM2V/sYHpV2fouTsDSCpbWIonrEYGP8QhTNAPqRvtMYQKwzcXqLX8yGt8
         qcks7I1ZSaVIPNY8SMTsLLZY/DcTwKyn5f2koRYYxT41S1S2qWxJPjxOO6Leuaa5pfJg
         9dAhTH2mz0ejirff+5sHqVJtUX0tj9Hpg8nmBI9gbXxbjxzup0LZx2NOucQgWzkk/7a9
         ow6pFujhmc3bD4xj8txuwzvu6h6yN6xkH541W+Sq1WkijqZarVRV1HFgwGH+6y9a9+Hq
         R8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762870891; x=1763475691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCmLGPtWM1OsfKhrmlp8FzG2vpcxwFoPVUUdxec3ZQ0=;
        b=J8GGl3q+Ian+59PEHHKFOf6IqiwQlluo0ot1Bcnemqi9bgGPBqSjL/rHcAB0yfJeQ8
         GhapZvMuEgFTgJlERjHrfYUw+EPvLGnwnXtvoxBdrrOhZH7pI7vAdjwQLlmcuGB8DXkM
         jgTHu/9CD04kK/ygFAKOg9vVKJzjXYG6pzWY+yfy4XI/0flOg08fZ086+1ROLcGjEX9M
         otEzdVC5Rau61thgZ95IAnvBZW8FKY3YeIE4o54LYCHZa+XEOjx4hvTXVNt12ulntwVD
         Ez3v6dGcS6t/LBN/kAIgddBBWCgXTKGCthUcZKowbCgzWpF5mU7JynAfqBynbiJJp8gA
         F6FA==
X-Gm-Message-State: AOJu0Yzyqd8OsWoglGdUDPiMaQQ5+QDlJBTZslDSeLGnoNNje4IIcyFj
	mpORjxfE5Hu0cLUjNi7pZPrNHRrJYQH2JeJa6icvtDoWlxeZLmTiWsfs2QI4aA==
X-Gm-Gg: ASbGncuB8IT02o55bWSD6Cn77NcHFcp2zqs5sXpDw3Cv0l20VtcDKo4rEHUZTeSynVy
	4j0qdwKfeIozyKrL16tNeD0lxrDUsxAsd24vHrcVQ3gxC+VkrRMfgUHbwPOxGnALI68hBW9hnXs
	Hrziuft18DfuAPN/t1/5+nzgNCvil8fzluMbNLBlmWWaOAKjh9g8FeWg7hMWFpJLcXbWunH8ag3
	WlhiJZVbEr03UhmCKRWkkEmAhl4fzYGp5LZ2k+JRn8h2/uCtOA9uYeIJJBEt7jpAjZoULehPp3a
	UGM3GUAIukNd4kA5f0CGBJUKImsGZK8JxmOH3AmxL3QuZ1x/Miy+7ZwVaimw0o5zE44+wlcwpZF
	TblHFPf0rUFgRtQgTgmH/Zd47azzOUSG6zCRebvUmLmGPgMgT5VTFQgg606cKLTDt1hP5SlUtmQ
	8E9rkD7+ysMpuqM7OvKX/r/JhqEA==
X-Google-Smtp-Source: AGHT+IEs7xpmcNZnJsjliHZC0ld5rZCfWHQ2iPXSzKvwMv5E9eXIiHOYDCKLYHZIjbKdd8pcxIBPPw==
X-Received: by 2002:a17:903:4b43:b0:298:90f:5b01 with SMTP id d9443c01a7336-298090f5c89mr110694185ad.52.1762870891402;
        Tue, 11 Nov 2025 06:21:31 -0800 (PST)
Received: from ideapad.tail50fddd.ts.net ([139.5.199.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c747d1sm182061515ad.63.2025.11.11.06.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:21:31 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Subject: [PATCH] drivers/bluetooth: btbcm: Use kmalloc_array() to prevent overflow
Date: Tue, 11 Nov 2025 19:50:41 +0530
Message-ID: <20251111142041.229145-1-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded multiplication in kmalloc() with a call
to kmalloc_array() to prevent potential integer overflows.

This is a mechanical change, replacing BCM_FW_NAME_LEN with
the type-safe sizeof(*fw_name) as the element size

Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
 drivers/bluetooth/btbcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 3a3a56ddbb06..d33cc70eec66 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -642,7 +642,9 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done, bool use_autobaud
 		snprintf(postfix, sizeof(postfix), "-%4.4x-%4.4x", vid, pid);
 	}
 
-	fw_name = kmalloc(BCM_FW_NAME_COUNT_MAX * BCM_FW_NAME_LEN, GFP_KERNEL);
+	fw_name = kmalloc_array(BCM_FW_NAME_COUNT_MAX,
+		sizeof(*fw_name),
+		GFP_KERNEL);
 	if (!fw_name)
 		return -ENOMEM;
 
-- 
2.51.0

