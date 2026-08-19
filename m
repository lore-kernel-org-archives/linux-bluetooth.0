Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D40388E43
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125790; cv=none; b=IzTRnsISzKaHUhCQggee01+B0BmSU23IPRzIbpzbVn03Gb3lmTuKk3b3NYSRCrVrEcwLmbMnOfWFOtOPODrd8Flsr/xMgB8bTcDQmOOpqiR6iNXAHzkee7bU6gpJQWt4U8AiZGj9vAZJpDPdl8HKeKXMhG6BPf0Hc7dSK+/chKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125790; c=relaxed/simple;
	bh=zy7xdTbhZxnvkNKOF/7MGo44sXCcIlTW8it/KzxuC5w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C/8/2K+WSzZR8oxBMPX6B63ViayQq3obxslVjxDJtZO+MknYNj9JCIbjOa6w3nznN8rO77Qa2gbfP10R3sFDIY/IG1qavg6aBzIXjftrGXYV246DQxMqjucdQr8iMR04oFtKZfhqSMb37SLJgL22OSA+gWj8VADFPhETzCxCrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpGm5BKB; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpGm5BKB"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso316663a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787125788; x=1787730588; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uNGP7OP18Aql583kDpR+iZpOh0zUAhc8L7WTcdVJiMM=;
        b=lpGm5BKBoU4of9qCovHHHuGo8aW9kqXuYKaPRjWwIkhUeqyFSQaQadS2yyB0kUa3v4
         7HbRnQO87QeQa0Or2yoveq090Mk3W8yyDgCfLIjdLah+XtC4y/uJjY29IvZf8c9hWV0f
         8wTE5TSQGSdbvkiv5UgQ/H3w+/ZRqUJs6MfJYhW+galGnkOVQpbTg2sA+cbs9oxfDcJz
         IU8rHhp6xB8idTOw9dcKfed9y2gpFfq0VPh303374Vv4EgAVYcTDZfHGvyHi9seLg8Kg
         ts3d4dW6WR4LkjJdYap5oHAjlxlk9PgGQDatPg+KWI6O8D+hPw1UuvaYjDXaXvsRW3mF
         BprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787125788; x=1787730588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uNGP7OP18Aql583kDpR+iZpOh0zUAhc8L7WTcdVJiMM=;
        b=tEFqJ6EUTiI7KxiCSVr0fB6xvDju0nNU2M+OPx20ZpiBuJytdsB0tttm3PJ2GcHq5n
         xWV/qZcVttyQ9picdbKiAmfMaFTCGkxa7Gfw4+dxBnrbS6md+cG9MZH8N2/cdM/66y9F
         fKxGHhDz7aazefm4H73B8/7ztP20Idnussu0bB7vzV9bc27YEuXtxV+KFSS4TSnSVhRQ
         9Lt/OATbvS4gYa8y4jtiB/821FzPnlpIXScN+AZMphZyCpuqSgOOSO4qopCjo2ekQp+4
         qG9OJay5UmN8rJiRJCnurg+qqhJVCK+7qSEQzZtpncBdqebdFPY9KUz3SlMxtmf7yg0D
         F7Nw==
X-Gm-Message-State: AOJu0Yy0WyHmmO5HhEDWkIGqi53MYaJcfTtwQ/XMfyoJA+6byLL58Hhj
	lRxSW9xn18w9uZDVDOWcFu7LDye0QzVk8qyTyL/CL1MSSOaG69IxK35P4mk7/g==
X-Gm-Gg: AR+sD10jevPCYrHkErWuTuj/puzodNbGR/JWsIOVvbBbqarBIrLyfyMkFj4IB9U2NDl
	/rpWxYoUSMIKmcpXTyX6Cfbtb+wwbEKUfkduOxsY+RLJOZA5qc1UuT9vFy2xcnfqhIhxfaRfL+L
	NCxNKnIsmnHDIxetYWX1dW59LAQfecWVxys67m8U8/ALD8V6KaR21Uk/8W+mBcx60cx6ZvPaijT
	+zVngd9kzHcmUWhtNHD+P0t3FJpnyHyWkItrbXgyznJwr4/IX0cwgGVZi/QeyIz+2d8+PHiY6fm
	5E6cfja8hE2oO+4ZwAOTETKilu7P26+ytVuvKQxlRbB71pSkc49SKNUSNmLwOs/JQ8qwn2RscKe
	vXAaZNJZ6UGJJ1zMOM8bKLY7+Ex4gqSGy3WejDB40ATnMJcvQ+YYXBAL/MDTBdr3K67Ue5KgsR/
	GI15L9EmJI8PJNKPFgySwgaRy4jgku8wpewPkTvHVNEgbcA5jLvBDNSDCFvAEMjPg4/Khv
X-Received: by 2002:a05:6830:6add:b0:7e9:8867:cb23 with SMTP id 46e09a7af769-7f43fa82a14mr2712595a34.16.1787125788125;
        Wed, 19 Aug 2026 00:49:48 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.143.210])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f440025ae0sm1012573a34.14.2026.08.19.00.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 00:49:47 -0700 (PDT)
Message-ID: <6a85601b.c8bb8256.1eb08d.5e63@mx.google.com>
Date: Wed, 19 Aug 2026 00:49:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2295299313817250201=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lijun01@kylinos.cn
Subject: RE: [v3] Bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
In-Reply-To: <20260819064115.2449018-1-lijun01@kylinos.cn>
References: <20260819064115.2449018-1-lijun01@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2295299313817250201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148251

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.66 seconds
CheckAllWarning               PASS      28.88 seconds
CheckSparse                   PASS      26.96 seconds
BuildKernel32                 PASS      24.72 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      459.62 seconds
IncrementalBuild              PASS      23.87 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/614

---
Regards,
Linux Bluetooth


--===============2295299313817250201==--
