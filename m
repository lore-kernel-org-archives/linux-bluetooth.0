Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592964A94
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192982; cv=none; b=h4WMu8lHgdK+xjzuAiCjtr4Z4qg8K0PSt64NpS4/znA78VJTFRMKt50PYj36DOgh8d7U/0RUUsPQwHSCq/UICGjyaIYPfNYmRpBpJAknw02zLveW3VQtXAd/0viPU4IHjGyzq5hHaL1UnwphEcOTTlcVb3wjXt61vrSp+TDXiSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192982; c=relaxed/simple;
	bh=59ygPOQFjtsMRD2i/x5xdM36As0IBxaa3nOIgflrm/U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=chLTuXM5hOAsgNF0EC3lcEh9/DF7PlxHqS2TzIX5yGiBuF5llFu2qQpnDiJU3ujUqa0A8kXdX4SBCMKJczXN4Sz9R30LXlptogKLhEWuxM7xw68Z4wtnL4rTJvye+IxxVYp7BkE6olGQBhNNz0pMkGbDedWNw3CRJf+2Z3zj+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeFp9NPr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeFp9NPr"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso4891271b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 06:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706192980; x=1706797780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKb/umfW95Q6N4Y6buXO8KuXgym5NkVsCNnutzH8C2I=;
        b=OeFp9NPr2/chVpIGjfMlN7j4Vv2B1MJyKlr9WPYqta12j2YLbpkBELBQbNLSc7zitF
         YX2BrFFbBTOIGDg5SmPJInz+UCfvWCPq5bwLX8CC3dDCHy//u1Kv1QUz/lkMICPfMI/1
         BcNp3znJzfwdTtKcHB6KwPhISLvfvwRwGSPYNO/fBH/MIfY9VLpWlAhWVpI3XQnlLoRc
         vMujAj4Ok+M85+vISM8CsxnTh2J+M9P0y6Zk0Yj3iJbgiAg9+Ce2dDHmprWjlLZuxVUd
         pTt77bwIiKhsngtTGH64RQWvdRIqA/ixypcuHtVKzZf0z8148nNlBGs6cr092DuXfKiF
         H/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706192980; x=1706797780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKb/umfW95Q6N4Y6buXO8KuXgym5NkVsCNnutzH8C2I=;
        b=dNkc/8/XZwHTYZjgDGl38AivJDDDvJutTS09t4sEKwbW0xWHcbj1BStDX5BbZg6zHg
         o1WvDstAr5p0V4qwc1mhCMgJ2/G3OkpBesAoiGSptvuZ3d3mcmVgxrmL65QahY0g9qrJ
         b+tTJDcut6GineNUiB2WuKhOba7fXFKiAPP0X1U86BUYYBJdhQCVXORYIggLahsW0Hb9
         0PJ9NRyHWYo9d2ibDZMcYkhsFzF0c9+vYKba3a3J6Tj4T9mvZ+cysEAdwb4LvsarfYmQ
         qdOZ2oCPaW3fHT2K1+ezrdNl1M9t/oilRwuvv+EvuV5MTDvO74oCyhlzmelmo9YNL6dO
         Hg0w==
X-Gm-Message-State: AOJu0Yy/OF4CZktCVr5aOr6INY8O9wXm7k5i7fBp85nBbaER32y66tvR
	idusQG2dzMYMfGq29VSujaXySt05lE2CY1CHPqrA8pmM4w9yHVTsUU7cVteh
X-Google-Smtp-Source: AGHT+IFa9GDokv/scMwmpZzBe6EsnaOk2SQ14kkBdLg7/j+0GMzrw7td4SAgd98uQXIGvdEr9chYZg==
X-Received: by 2002:a05:6a20:47de:b0:19a:78bd:7761 with SMTP id ey30-20020a056a2047de00b0019a78bd7761mr722334pzb.102.1706192979602;
        Thu, 25 Jan 2024 06:29:39 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id x33-20020a631721000000b005ceac534e47sm13646143pgl.51.2024.01.25.06.29.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:29:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] btdev: Fix not clearing le_pa_sync_handle on reset
Date: Thu, 25 Jan 2024 09:29:34 -0500
Message-ID: <20240125142936.3373953-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

le_pa_sync_handle needs to be clear on reset otherwise the coce won't
be able to handle Create PA Sync commands.
---
 emulator/btdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 65ad0a40cb43..da94f29d12aa 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -562,6 +562,7 @@ static void btdev_reset(struct btdev *btdev)
 	btdev->le_scan_enable		= 0x00;
 	btdev->le_adv_enable		= 0x00;
 	btdev->le_pa_enable		= 0x00;
+	btdev->le_pa_sync_handle	= 0x0000;
 
 	al_clear(btdev);
 	rl_clear(btdev);
-- 
2.43.0

