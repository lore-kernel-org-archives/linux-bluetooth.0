Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAC15B0F2
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715804184; cv=none; b=ExO9E56BHtlGp/VbGeEywVGFXz19eRYLhjwBhXeQ98ruZ0Hc/xo3i+hjD4CFGVoE/ofld+B5d08v0jnErEt8wS16GrH3NJ5XZYkGPCGK+L6+jpwJfqb76uNTzTu8MHOnj04EpniDw/zhUoVckLUtEG4MAhLPOJpNF+IYS/dHdWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715804184; c=relaxed/simple;
	bh=DdkB3V8ZGog6weE5ByFmwUWEnknZ/OFQfZ7iKFzZSew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiZs3mXS83AHbrSJxS4C5lF1xwjiH40LOi4YuBd8QCNnv6CQNG1dPYlkqjSCAzHx/a1ARyN+TpydV3+wF3sXn6zslDD0tj8o3j66rRNPdqI8i9pWHUUi5UF4SQW8gm2sOQBLEJYVQyho+MXvkr8XS52M9d/NiB5mjF1oLQBS+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=ADpr5El2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="ADpr5El2"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f99f9e0faso8423604e87.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715804180; x=1716408980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNMpiruIVl6YRQIpC270h59+7DyIgPoYQQZoXWQS0T4=;
        b=ADpr5El27LVwr30DZocQByK2IJfRzvPtT2peLthWeHX5Bf3OQT/xpi/IZp4YwYcxda
         kL6Z2eVVrx2xlqpWhCOCxpADHPULxyIOpoCI0FxnjNQieFTYjI75vN5Gitz+C8SxFZI3
         nhygY/JgSlTfNwaXBym5EqjhyTHffMWFBDk3jw1Vor1/WuTRZKV6LjElUZXH6gayk9pJ
         sBIHRYfyzg8iMiAu66F6IYJ7XmsSxdtxffGnvptbUrWLicEfW0TvV30x90l5E0a9MhgL
         uUvufWEba4dlCZ1q6zmq57RJliUU5aZn3qUXWaITZF2g4KicedBP3omzl7rOOXnLhvRt
         PsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715804180; x=1716408980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNMpiruIVl6YRQIpC270h59+7DyIgPoYQQZoXWQS0T4=;
        b=dgX0SXvSAUZK4NthwiDObnjd7JghSv82unMUUtK7JqmVvtw/CD6OCrzU8AM2eV3HGx
         NQJvm29kIyTxh+eNV1kwppzrIMjv3rfqejae/1SdSYCKZ1zGhxRVt+DFMTd0aerig5ck
         7OBt/4DVXMmH7AqjzF8pQsZ+0hT/0g58ULd6xnbekivR6n2XW+NAIT+5K6yVGZB81ST5
         UIs3N7S9uXDQRyprcswaM1ju9s8XuMEkB9Tp6ZFIQyPPz09cd9DR9JqTndlT3/hZelr6
         u7dWCbxzppNMIO7yL6LctVMT4GTN6AVjdKq0fG6ZcZvb8T5Mp79HS5tcr1X31oDB9BkN
         5jYA==
X-Gm-Message-State: AOJu0Yw8MmnjuCbpnnjjgyusYrmkPxk+RuXNzCBNB0D1ZNZ0/RznDkh2
	UfI0JzKrY/38fXJ5wOfMJWLpOqEQ9BiBQR/DpGCJpqGY+6mZ67N67W/smAoeFRyylgx5j8bxV63
	n
X-Google-Smtp-Source: AGHT+IGuhcb/rMmD2qKeWrQXpvhdcmnhbnQZS4KRDGLqmGxjIaKDTfyEgvgQtNiScLP5hnW51HdO/A==
X-Received: by 2002:a05:6512:1304:b0:51c:5171:bbed with SMTP id 2adb3069b0e04-5221006e625mr13888706e87.15.1715804179602;
        Wed, 15 May 2024 13:16:19 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5743065dd09sm7457142a12.64.2024.05.15.13.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 13:16:19 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v3 4/5] gitignore: Add compile_commands.json
Date: Wed, 15 May 2024 16:15:51 -0400
Message-ID: <20240515201552.1831618-5-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240515201552.1831618-1-arun@asymptotic.io>
References: <20240515201552.1831618-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handy file that can be generated with bear, and allows clang-based LSP.
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 9c2ac236e..6a6422379 100644
--- a/.gitignore
+++ b/.gitignore
@@ -183,6 +183,7 @@ android/test-ipc
 android/test-*.log
 android/test-*.trs
 
+compile_commands.json
 cscope.in.out
 cscope.out
 cscope.po.out
-- 
2.45.0

