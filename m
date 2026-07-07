Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017E364028
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416291; cv=none; b=aR0amoymTteNQWkqUHN+Dphnky1elsltrEMuama4n6ZlUDpCLnbn2NDD+GgQGcrrq/INdUSJpJxaVRh72yuT+omk2dLrseogkspwN20asNMV81mj4alxvlWm04r5vyLQNCZNNhSkGvC5MC43nFJJiaKnvA8OwfH/RnjxabZV9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416291; c=relaxed/simple;
	bh=+YTZUNM9EovwLc5tDJtZ58UhqfpmuIdLhRez8H7kMsQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ONwcqiYE8o8tvj9KF7nvQRtejzYEgvj9dVPSvDJ2ugfD0HW/6TvvvI5YS385+gcHml/H0va8nsplw+naKBHuu4V8ccL/F2RtHXIEg8HE0akZgtcOxl+Pf87E/kJptWRFhGn8F/D6LrFy+M2hiLn3xIBp6dSv3xeeGP0qF1cOJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix2qWK1n; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix2qWK1n"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96c92c0980so2210138a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783416290; x=1784021090; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N5QoIxhRwotyvtaYlUxeW27iTY4UnPvGGXaJy0d8YEk=;
        b=Ix2qWK1nPqJR8xQWZIM1i12WpogQYzoKlyTNBffUXDMzmt/k6g5+Qq0aHCpLm+4tRS
         1U5czRiaDRVrEjzBayEJzHPPKOXjAWdPt9ib4A5ahU8zFj3zO6w2CcZjxbQJjVDBI1Xu
         wvGCBmf1s5eidrHg5TNy6m06Uv+fSzzeTgj9Q6maeBCd1P0U7fYyU0KyhtWbVP1Xvnvr
         IJZp8Jm9UT+AYsFlHvyimuSyjPLBsELXSSl72Ct5G57lNHOzavVcUaM5gtM4Q2YxzZci
         OxQI3gSvX7CAG59xVBmmbn3XHfIggQzHP+HdOEfDUxY5ix0a3qvIDNCdwAc2BKAy57+h
         O9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416290; x=1784021090;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N5QoIxhRwotyvtaYlUxeW27iTY4UnPvGGXaJy0d8YEk=;
        b=K9xdO9qtPFBEP7yCpqi8FAJK8zRMDelySt5HrIRTrFjoRxsfgridPzJ6oYvw3SyzAS
         gRNKcV1XnnezgFOHNq7ZwGgmc7/LDiEldUv2qiSIYeOHXZtGuHThe2MXBTPSj4yqJe5c
         YJcqp4ZOe1ll6VRUaj18Qkma5LuOaxen1qLsFCjj8rIB52gdO5ChSu4Z5dO9qg8f0XfI
         k0GsdAdrPkYz1LMIDzyJt9V4ljwiYUFfKHfWdDVD+Xt+FsA7/AAIWbp6COXu4hp25bEp
         IcNsLmIObYW6G7Z5odo8PNQbyF7WwIcc2lqCvNPzGISFNcB+2R2jdF/LNyLawQ/53Shr
         fAIQ==
X-Gm-Message-State: AOJu0Yyb4sX4KG5dnx4uTwraL+m2EBt+UxgJ4vQT+M8dHKXNsAHicJRg
	lP9VawDSbomz6xIWHQmsosA0dvRWJfelga/0kTJvlp32hYfUQgJ0fvacOsDRpA==
X-Gm-Gg: AfdE7cn0fQAfW3IgexOcgvFhMW8YvKNUU8O46MLAzsVkA8MIE4aWTJGeXT1U52/zFJ8
	TNG+gG0q7iH8kWRWbttQcwFRPn+de0EiBz3Lny+tLtHqOIcm+2ruJ0THfLxNovW8IbvLQlFrVt1
	ucc5BvSZqSDmc/Ux61KReoN/B5YA6bRzwpx4qL4ZqKZYtXKvERSR7tAOCkS7Xm7qRDQ+hP5pgIR
	OwIFD1ss6C5RJnA8BEyEFKEP1rhN7H22r9RpLWVjXG9FeAXtI1x/tbEMYiW0LAAjxMp4myIfJH9
	YpTTvUn6JCpdTHuee8UNjJdPFXNZpoHB2GhNBd9PKCHgUiGIHrzkfN7qjKglcMYTVc9CfGGixUf
	Z5X1jo7mj+d2p5WJW6yN1AhoslFgzdlIhFFXTOaSN/6Iu/itLIoyZxNg3CfwxJg11fbbP3Z/Cqw
	eqQWje6uTJg4vhZEGIoA==
X-Received: by 2002:a05:6300:389:b0:3c0:9c19:b27c with SMTP id adf61e73a8af0-3c09c19b357mr1899192637.74.1783416289696;
        Tue, 07 Jul 2026 02:24:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.1.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6596681fsm7138551c88.8.2026.07.07.02.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:24:49 -0700 (PDT)
Message-ID: <6a4cc5e1.30759430.24d50c.8330@mx.google.com>
Date: Tue, 07 Jul 2026 02:24:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7370611396928790724=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, haoxiang_li2024@163.com
Subject: RE: [v3] Bluetooth: virtio: Fix HCI device unregister on probe failure
In-Reply-To: <20260707072955.3093138-1-haoxiang_li2024@163.com>
References: <20260707072955.3093138-1-haoxiang_li2024@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7370611396928790724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1122868

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      19.86 seconds
CheckAllWarning               PASS      22.13 seconds
CheckSparse                   PASS      22.34 seconds
BuildKernel32                 PASS      19.59 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      359.29 seconds
IncrementalBuild              PASS      19.28 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/406

---
Regards,
Linux Bluetooth


--===============7370611396928790724==--
