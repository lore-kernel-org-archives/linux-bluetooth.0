Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736F156F29
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888335; cv=none; b=l0Gsft/dnGXmyd3pfa73ACAM8s5l+FVC3p8OGEdAehCCOJjYLlMXPOTwaExhj9NmZCUBKbkDpA2uYbkGYASZbeYCKvP3NEziIOmkPCpup84NYthlALnx9CdFlCeDvfaCZDw1VJrd6P5yFIKzGmx/ULRoQzfhpcmYCQPd+4tObsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888335; c=relaxed/simple;
	bh=DdkB3V8ZGog6weE5ByFmwUWEnknZ/OFQfZ7iKFzZSew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKzsgL3yV91VASCYAl7bv+8eNwC/szdaZQQGKtogXRPaszpn7qygAK7MY8zrFYZIqt3eqQqU9UP0E5AuBj/q+b3pREZiIh0uQ69S/gJ3ENFXMmYxiVg4qlQKsnSD380X+AICicIqpmK/ytoPIa28gVL022kJNnVj4RaFX3aNXBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=ZQgTwEg3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="ZQgTwEg3"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-523b017a5c6so1900570e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715888332; x=1716493132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNMpiruIVl6YRQIpC270h59+7DyIgPoYQQZoXWQS0T4=;
        b=ZQgTwEg3iXxjUUlar6tcJuBLN6rmvNCAW1gJ0yXLFRrnX3O285BnER4mwg6PSsSPHt
         cdVg1JfxmajEFy4mJzt1W86EZbtAOojSVi6A8GxlkX1ZLqhoDdjHdh/wkWjqnfmMUGyf
         1BtXAvETaEiGAL8BzR8XCQpj/eqUTpSIlRuH5YvFlwyazNYoD+0H0iWDQJPCRMN1y62S
         qbgB32lujd/vFqlrZJNcDCuLDVwTK9iE2TUnY6JrJJeQx7/yxwzE7UFvWysWgN21Msfv
         LJQYN29LhYKre7hSWtBrgEbhJdoVz2B+JBo222Q4fGt73gmWLJBCHQP/IhspZ7gOEkZU
         +Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715888332; x=1716493132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNMpiruIVl6YRQIpC270h59+7DyIgPoYQQZoXWQS0T4=;
        b=QcHMVOad05wEFoDqzqz5ngOEKp91N3eDbGP3FrBHpDRPa8jKlEWGdRVwg6mjmeJbEt
         GgOSkgf9CNkidU8KCRspqqoc17IdJQluAEcGIp7QHfVsiuNGFdqWxLWdzacMOIubS/uS
         XOB64piyaxrwfznK0LSvlIlEFzr4In5HsNBmy277moGg+n94SMRMCmzal3i7p+ZuMvU4
         U3Y97LdmABtoEp7CjRYQQAzpeVhaqvdfK6wF5z+d48R3gg//r15IUWMAdAA6NmiZK97I
         EaZvS5tDZvHcBbZAlF/yswe18AYqcSYNsFTXUbc6GtP24pEZNCT1jp3u2gLi8Ihb5rPY
         DYrA==
X-Gm-Message-State: AOJu0YzgI/4qog3J7vGOuSSa8Z4n/mOSC7Ys2sP6d0oTB52z0wpNwgce
	cRSVxjYA809qNyTcjKBKd2X4FuVGM8ozmpUvmIctg4qlVHOfxUuOkZjXm2386Dr3C2yvHz830Rf
	bPU4=
X-Google-Smtp-Source: AGHT+IEz76Ayou6+hmmtp3M4w99AHxYdG2cAlxAKHbR8CHME3daPNq8iEYbna0Kjc7JVLGv3WteJfQ==
X-Received: by 2002:a05:6512:61:b0:51c:5570:f570 with SMTP id 2adb3069b0e04-52210473d4fmr14863834e87.59.1715888331911;
        Thu, 16 May 2024 12:38:51 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-19-74-15-47-99.dsl.bell.ca. [74.15.47.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cd85sm1031241766b.15.2024.05.16.12.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:38:51 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v6 4/5] gitignore: Add compile_commands.json
Date: Thu, 16 May 2024 15:38:35 -0400
Message-ID: <20240516193836.228281-5-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516193836.228281-1-arun@asymptotic.io>
References: <20240516193836.228281-1-arun@asymptotic.io>
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

