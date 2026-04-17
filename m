Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA1E391838
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425388; cv=none; b=Mmssey0tlQU/LZixhFrZxzBCMbISgHZRwoThl163qQPN30Xm2wJsKe4nzfnTLHAgRmJO8ZEHKGHTz84Yvkj+wvJVYsN5DPpS5nH4UTrihOMvHYvqGgSIWJ6cFQ0svdp7zeCr7FZNdBGcqqxl4bMAMZzsFhHvZEQi2cwykPwIkJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425388; c=relaxed/simple;
	bh=rj4AwClwZ2ToewvI2v/8Lgk57xeEtJ8LTYQQz3Tv6tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Enc0v33pBj/iAjuvUzbtfE6gjsnAsf8ZD6nMVY0alB3plY9ehIa2pnEYvJn1Q4aW0Wbtk3wEkqckq2QLyNtj/zwKsQBaoTQGN1c0C8uy29dckdnbaDyqrPEoaNR44vUptcOMczAVHSLHqhqUzqjA/n5suyHWdEO/knzd0Y874Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=yFIFFZZx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="yFIFFZZx"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d43e09de5so320238f8f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1776425384; x=1777030184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NzeITAG++pKxR1aCVEh5NZM7KzZ8YugfRRUNsRrgZA=;
        b=yFIFFZZxq0S4RvUH2/1jEoRcea/fmQ1wPrKu94iKSngIdreEyAv1ejbcpZBe9BqQ0B
         NDHJ8qP4Ad79/77Ic/1SLfxJTtrttFfWq7DFdOT8LuVUAuxNVJai7O4b/cNTEQ3UMBxv
         J2qiEsOXyEla+DpYmP0BMlTHtH+BQEEtYmlnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776425384; x=1777030184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NzeITAG++pKxR1aCVEh5NZM7KzZ8YugfRRUNsRrgZA=;
        b=f8JkXHBOY4Q0/WDt7I2/D5wVK7q69eqT+pc/NQrA/mWi0pvMyVh8LKxoQsY5h1jqdT
         zf/tQ/mLwnuW7yf5pMzxazDF1gL7lz77mDAvWVI2rLqetMIEFaaez5rFD+gvn71Wf6JI
         ZHkmzPtthaK0kwGAhUx4cxZvObC99fYWuLKEWZCqrzCpjQq+GllpIWBg8xSBMp9y1J3d
         TsekYc6RmSJGhL3mLNMUOUQogdw0yRJgGVzf6jjofLkxbrEcOTcSAmOfnRnMILFbBMVR
         XaFRPWpkuZcnsalCF+zv4qqY1cDe3erFkowHF+Xz6yj60Z3QTQBn3LPssDye0dFrHuE0
         ITzg==
X-Gm-Message-State: AOJu0YxK3KONN8Gwc/RTKgVc/k0kaNra98FKXKPWrQfaICxNLB1Ord23
	rsXoSnvgHkDmgao/RUHYiSNwvbQyGmkUCIlkdRf9u0QPLJ14Zz4D6LDTlL2hkgbeoFd4ri7FIcB
	0APwapA==
X-Gm-Gg: AeBDievIzlmSk7mn+NOVPY5YERZF1LF+Gi80K3sRPM0wO98RSQJbesS/O8EVActXvo7
	Z9CG4LFE3QSU6e6yaoRNiOvvqSbZAovDxmfIoe/8OG2dcJcNGduEcsjrIDAwATGLvMqt6wlJJP0
	gTBzdGCdDXSXpIZhfpQQYk2Hn/FBy8OKG7nlR4jY6KWD96FKEAvYBwOgrcqujaHWhclTDtu1bBM
	kzutgSjzH52rlZ9taFYWtwyyvBvjlZBD3HZXwduVOHF0rgk96Pa/oLOWvSr7K2C+jC6Zxog/KP+
	MEDQen0yl3fJgY5oGclMSTKQLhCgYl6uxTGhmWimzZP5A9K9nfQDX/3j1oKt/D75NdY+QYO1MPz
	mv6V1H+WMFL6JvkPgRn4hNoNPsVYaSveoH/yNzItWkFrmozAzQV4l/QDDRz9KG2fjrRGjpyWWK1
	NiWHfVQehkvcpKNOdNbKTRe+pH0rd0d7O2j3/vetQfaNgy42b6isha1HlTbp5QLbvUxX845MULj
	FD8uEf3qyfp8afm
X-Received: by 2002:a5d:5f84:0:b0:43d:7783:c684 with SMTP id ffacd0b85a97d-43fe3e1e092mr3762866f8f.43.1776425383851;
        Fri, 17 Apr 2026 04:29:43 -0700 (PDT)
Received: from great-eastern2.home (public-gprs181528.centertel.pl. [46.134.48.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm3765865f8f.27.2026.04.17.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:29:43 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 0/4] BAP broadcast fixes
Date: Fri, 17 Apr 2026 13:29:10 +0200
Message-ID: <20260417112914.3752605-1-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style corrected.
Thanks!

Michal Dzik (4):
  transport: allow setting Metadata property on broadcast
  shared/bap: run callback after setting the broadcast metadata
  audio/bap: fill BIG and BIS for receiver
  audio: update QoS dbus property after it is set

 profiles/audio/bap.c       | 6 +++++-
 profiles/audio/transport.c | 9 +++++++--
 src/shared/bap.c           | 3 +++
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.43.0

