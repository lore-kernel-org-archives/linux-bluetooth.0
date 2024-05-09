Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908613C9C2
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 02:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221634; cv=none; b=JAydjgKBZzXankaYqlGkHAiwB+agK6BC1oPrNv9+cLJOscqpGZH3lEgpo7+aa4Hf7EnLZDCrIe3pxvQTe1yZKoH3YIVBbj8uOmfI4/oYiT0s58f1u1SF7TvoxpJF98NWoi6gyfa0f5l3IoYriEPGUIQnde9Bxxgtv/hEocfiwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221634; c=relaxed/simple;
	bh=DdkB3V8ZGog6weE5ByFmwUWEnknZ/OFQfZ7iKFzZSew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJJKot6UtKB3EP+M0q5PFUT4W7Q5MrvUr3Xrnvs0s9MmOZYq1nlob5PkiXaymGi5tCBjjN2k46OTEUG1zfhfwMdUhLTGY4wmvfEwct4u81kCeQnkfBA9yjgvc7AtgozkfI56gO3Dr7kn4FNx5BmU3XWzeJRjyLNZUFTq5bljl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=aALH1Q31; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="aALH1Q31"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-792b94301eeso34101485a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 19:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715221631; x=1715826431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNMpiruIVl6YRQIpC270h59+7DyIgPoYQQZoXWQS0T4=;
        b=aALH1Q319JqzmZtZjwHexzNFmxkJQnRCQCrppKE9H1BYMhDu/uH5l/Mlv5xD1AvYqg
         cVlSkM4sjo0h5meJSJGY93YxaOe0kYFdOR5fR23ud0VN6dwxWy7B0lYowQv1uqLHJDGB
         YYjU8XJpYHJtN4e8plr2O/4bFeDldehq8WcIaWWHGkZlMPwusQnQxUtIiJsEaH6FKQ5W
         Dc9rSOXOH6EVi6q5934w3TrvKXriksz4UXJJW0UmYPWIevuLqrg4mfUoMOpFbD87gCva
         pIHdRgkyLbuU+O3Tce+XrNGoXOnNuo3b6/Ozn1mrYwZ1U9cHx7bbnNInITUIp1J5FM4T
         tj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715221631; x=1715826431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNMpiruIVl6YRQIpC270h59+7DyIgPoYQQZoXWQS0T4=;
        b=kYPnIxeo5CNyxEvj/OTApcSsT114TKuAynWjQs7EB4Ed8qevNszOE/TWSHTr+CGKmU
         KEgkdVG7nSqEKLtfu82pdjIXz5kxDZhSwAZBB+MvZNX8a6t4UzMZD8P6U4Gc9ubpM565
         YfhRgZXZm3T1Q0WMNgnF++REJwb25iMEJwT1NcudZcBe0J8wT5Cs67oKRPpV7utz+gvb
         eUaEsDXijDoS8y/YPpiZ5A2XCMmlZlcMpHwBvAIa1QrJXGhKQY1jOT1GGQyiVT8+KQdF
         YhZb7xvHwbzgY0OHxcCJ/1BAGDt1kPNDGFr9miQ2wrpyfOQ++92ET4GNXqTNdO/OGqNb
         /YgA==
X-Gm-Message-State: AOJu0YxzAlOm/6JvWwDak3oFNgEVWJVrVJ4oJkq0jAiBYOaiudnWLUY4
	ZNHoAiN0C7FE3xTZ3VYPhTDK+Lx01dGu9dwwMOMzPx/RSqBQW8KFsm2CIJe58hbURYF75N+kzhS
	i
X-Google-Smtp-Source: AGHT+IEeiyBxlaGdDDw91b31bClN9QI4RcDJ4S3FbUgMAwSWeGqkvLQxLHHQZnTtV0zkUNTGm4mFhw==
X-Received: by 2002:a05:622a:14c6:b0:43a:d397:4477 with SMTP id d75a77b69052e-43dbef8af2fmr53315101cf.54.1715221631380;
        Wed, 08 May 2024 19:27:11 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56e278csm2091761cf.93.2024.05.08.19.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:27:11 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v2 3/4] gitignore: Add compile_commands.json
Date: Wed,  8 May 2024 22:26:39 -0400
Message-ID: <20240509022640.451351-4-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509022640.451351-1-arun@asymptotic.io>
References: <20240509022640.451351-1-arun@asymptotic.io>
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

