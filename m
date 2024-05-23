Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9911401F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479598; cv=none; b=RHpgbGfWHm9UguwGTI/QrMWWE7dIu/To8HAR8mHfYzvRZz67ibqaY1K9xG5Xqj9hdOTtE3U7Tfn2jqWDJBPIF6gVkxpULpV00+2sfZ+sfaZtuva58AGGXWsN9d8bzqMfA16X48ejqOgtAEAARULC+/F4E9r4yY9StMwjyZtt3ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479598; c=relaxed/simple;
	bh=SqD+UOJGF0Jk0zYKoUy1sexDMGh1ScGkFsyOcGV4ZRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaTQWiFZBLMSyZGpVamRAGwYpariIO3UYcjURWbfsa208+Y/RqdEe0OTY7+6XJTZeGxeu4+7Le1yhxrwSUhssFILlqt9aYx4zi48vZj3YjQWg1gM4/BrZxj2m/xgYjqUcWPgr/typvBs6c8mabzhWpzIHmnCK3drOEfQz1GG+NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=xriSRg4F; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="xriSRg4F"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a61b70394c0so561436966b.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1716479595; x=1717084395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeNIB0sX4tQfadYgJUl9JrvcylR67c6SCCwJuVnog6U=;
        b=xriSRg4F/Yqr9i0Xcop9sd+cgEmwCkdaxs/bY+QrZ7LK8zKKamWRwkGnijx7k3TeAI
         kMexKL7caEsm4rtyeOlPzesxElWjbzB0EuGR2sRwrg/nbG3870vYxsgPFyhEGs57oUiK
         bH8q6Vjw8vxJoOcEeZvMqBOQoU1wR2c6KEipUzGunqCwYdHmDUteAyrRt9+1r1wR/rFi
         LVt3106DsdkZIOnB4LD9q5oInGoySaDqOfCD8korOe26ffEojqyk5BIr8HOAu/EPlwQA
         XfNbc6wT/A07HVCcfxV889CeRwhWq9FAfFEYtAS6Y9sjT4dHe2vWMOOMzgm+9vZisyD9
         yxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479595; x=1717084395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeNIB0sX4tQfadYgJUl9JrvcylR67c6SCCwJuVnog6U=;
        b=BjJH3vnHMI/8xA2OUHMnVXduSNfoQg/e56ENrByfYuNgoZdJcn4qTkbgH/I1oibzvz
         e66DdSBQtbLgxcqY6fAL87lLRmVv8TNt+U6oKwNQiwLXwCBd611GqjX1DaLRLedO1+Sw
         FVrALlOVez7MaMO84n6HwYhcz7FhxQnxyOPKCBmU3DW6yLT5zaJZbnJHJRQpV5mTQZEo
         JF3ZuWsHaICuJRuF6Pcmrn9+4jElEOgBcBxUhFsQAQZS8DMxQOFqPrnRhEwRoPJUMm2I
         sE9AOAqW/xYb91rWrwT75V1dfqz2GBt7CRU6pX4DqP1tcBn1L00JSaNaTVdzfSbN7fa0
         TUgw==
X-Gm-Message-State: AOJu0YyUi/29QgyWmDZQh3iS4TlKuEoU/KxuMcJTmZ8xuu8j3WuC/7lc
	8Yvx1wYOv0AAK5NvQZI1xRbmmAT7Oo/8yonvC5/dk1zIFIBeYpdXx2b+m5LvciJZOPolDy309UD
	6
X-Google-Smtp-Source: AGHT+IGmRklGQGh8PcSB2RTvE/iQRlIITWq4Z6+tPoJpb5ca5iWKI3MzpKY1N89tj/Hoff6A0fONAw==
X-Received: by 2002:a17:906:13c8:b0:a62:2ef9:13d with SMTP id a640c23a62f3a-a622ef9021emr305412466b.0.1716479595523;
        Thu, 23 May 2024 08:53:15 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c686sm1947600566b.47.2024.05.23.08.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:53:15 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v8 4/5] gitignore: Add compile_commands.json
Date: Thu, 23 May 2024 11:53:00 -0400
Message-ID: <20240523155301.140522-5-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523155301.140522-1-arun@asymptotic.io>
References: <20240523155301.140522-1-arun@asymptotic.io>
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

