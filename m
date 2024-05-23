Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E513F011
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460185; cv=none; b=m4yHdQ6ej1DGNMHdOWDnpJAHWOw6LZWYk+c784o4FORNuNCAyMRlTZHvyIHn4NZN6rJk5pKZm3djhWELdkjpDMqlC3Z61kjZzmm0M/+084qcrmF7FLKPhT/QxQunuQIvpOhNuTfISYcuHDZ02qcIXdXD3/5vnWMPTW648U//mhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460185; c=relaxed/simple;
	bh=SqD+UOJGF0Jk0zYKoUy1sexDMGh1ScGkFsyOcGV4ZRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hX2QMf8L75NPUJR70z0301POkU7MBREeEmeTxMm3wp9WaNfM5PRmPU77+EY0ko2NhRp/B+Zh4UHgejukwqnwvZpNfiPbuoRc/J/jMB02nLfNBhWdjRc0pbWMDZYFK/jBDateS2HuVmg7gJY0JGu3jYejwLUepMkhVSZ6bwZfbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=u/t76vr9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="u/t76vr9"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so1001808666b.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1716460182; x=1717064982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeNIB0sX4tQfadYgJUl9JrvcylR67c6SCCwJuVnog6U=;
        b=u/t76vr9SjVbMlUi8evDR1tOAGbIElnwiETbMUB7BCbLmtiReiPBiQm1G2yQHqo+bF
         IupEvNR2UIeshW3EnIcPLAOnHLmYEK4cCcgSocRIEKsxqQU62tuwmBr0xV1sRLbHFo5W
         /7NzTW+GS/oItSWQsEMh8Kt/RAeIaIasYHj3PHYYnNtK9c7zSojqMwHoRz/3t6bP8nW3
         6nElWr0jEV2aklegbRJKyE4903PFi5EULb1AQYITytWC2DNbsvFG9UEwzHicZXn9TraO
         fN7hw7LyBoDhpwtxsi6PGERmwfwvSQrlXRBjsXLRfteCUNHbqPMlKloG+DpKdWbjGawv
         Pccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460182; x=1717064982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeNIB0sX4tQfadYgJUl9JrvcylR67c6SCCwJuVnog6U=;
        b=mXJi/N36fzJS01S3FM0ng6zUpJpnd/SaKLY8uFigcDYiiDsIytec5AsRTFnwXpo5X6
         RHy92M8PxsccBMlqtduiXGpUBzCsQ1kT1tL5Rnpc0a3AWllZei75qzMdcFS3dcdmwA4l
         5GrrhOURlYM/P28p6LJTyxTVPWmetsUAUVjg6POvXB+E+qChgDYFDQmQjkeo9a/OT7Z4
         inPYV4lWjkroXq6UF3vzS3uEeMhfWN21C8EB5bIjvnB4gq9ZyEG5JldNQuGRwJFG+Cl4
         I3lpLmmSSTZ1Ls3Up8oqtq9EGNsHB38GCaQjAeefYBc2ljjFL8hzDFM12J31xO5IjiwJ
         eUJg==
X-Gm-Message-State: AOJu0Yzqbvb3wB97rFL0OwkOf+jMBFOkp05L0fTBWOi2Ph4zWyzsiguq
	ooGCfvX9vDkFXg604lmGRJuqdBB3KVA8UwIm+NiO1zo38hIRXEoKSvEz1iyudDOGDf4BLFO31On
	W
X-Google-Smtp-Source: AGHT+IE51c75ZwDEwPYeYwuX4yTOJVVuK1f4xTkTHaQeEvM6BGmo4BJO94Uz4hFwlRyJjKPkFvf56g==
X-Received: by 2002:a17:906:b88d:b0:a59:b6de:2919 with SMTP id a640c23a62f3a-a6228083aa1mr329525866b.43.1716460181742;
        Thu, 23 May 2024 03:29:41 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a50365669sm1673515666b.193.2024.05.23.03.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:29:41 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v7 4/6] gitignore: Add compile_commands.json
Date: Thu, 23 May 2024 06:29:27 -0400
Message-ID: <20240523102929.37761-5-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523102929.37761-1-arun@asymptotic.io>
References: <20240523102929.37761-1-arun@asymptotic.io>
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
2.45.1

