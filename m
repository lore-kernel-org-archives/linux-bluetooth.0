Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7893D952D
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105919; cv=none; b=Y25yN+/TFg8dBCnASqV/qrEvwczYg322bjlU+hxxywQbDe1BIRaXKcFL3DkPnUgHJOUk4BF2Q/Dufze/nstiVnB0u1tF0Ki5VfxOxMeh3kkAJ81fwb5RMfQOwuLjJL5A8sQQ4P8LV07zCfnrzT1HljX2YwO4Z4BUds2qXEf8x08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105919; c=relaxed/simple;
	bh=zRmAb6kUPSFI1b/+VS52LQxz4wbTpvqWin49jyqNCDs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qOkJCQJqaT779i8k6r7JwkiOw6IXyECMiKEKoNJI0h6xInYphyM8YfR3/EVGw+HbRUYV99RjzW/VtpG53am77WRw8s70D3P3K1xWApWdes4qd8EcnDj5sUuqwHKPktOoo4Noqkw+HgH8Jjc5IajYS/8JCbItNzzLMF+sqrq2AL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNCr/vsL; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNCr/vsL"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1175855a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784105914; x=1784710714; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=insXz84DebuZHR42lSkAf9tlAtTHJlA7m7sgmZPK6/w=;
        b=iNCr/vsLHmAXrmTwZpeo1uZdWY2a0F2eMhg0/ToQhI6Tjz554URBu5CbMzzE/CH+JE
         UIpqjdkF6lPy7F9JxsFO3O2RaB9Dlm9gmDXBQn/9dWDD+an9HzlvlldunYRRYpho4m1z
         gTP9/GvWXcSrkyn1L1wnsJVlXYWcnPhRA9c20I00zFkNz0JcpDM5r87xt9f7Ydr0R+Mb
         MOXdolWx8hTi4bGcIKBoNhS9kt5NIoqYkjmYQkBAlHlbUzGycmY9xyLozBYmdce/qu23
         LzzirNkx+Dm+2H6GxH+jjj7dWHSo+iszusNzX36dzcbbZmelnCiC/Tr1Srdfb07iUxQD
         jWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784105914; x=1784710714;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=insXz84DebuZHR42lSkAf9tlAtTHJlA7m7sgmZPK6/w=;
        b=A6C7Dd3dWB1dPIDaTY3usR93AOXLwFJfhPci+A7lM906op/I+RG1aubNDm5Q5QBwL3
         jpXFzqqHwIEQ2WyuwddeuwhocMRPOWOBT8lQtTv2KrUVuu26GTj8CiubGfj+fLTzrk5z
         R1QxBI9vdNvRSMX1kzxhR6U5mK0wSbBs7wWIkalcf5pXvZ/ro/m5JNhi4ntK6KQ66474
         Ck5bnLfaBpd9oD0uYJp/4WcDhUMZC9zJMKt1VzrgC8BLKfLImjWbppuaHXsr9fjdwEC1
         GReMHdd5xFPTfHomGOLbWkQL53vVQ4tK4ripnLoFOFhRqrIaoP66MLpJn1QsDycjkMz8
         mOQg==
X-Gm-Message-State: AOJu0YwoOf806UyvelEUXoXo+dC1l4x/lRUsavBA9DnmnfcCLACMJIOT
	Zknc4DPXG3VGE1CZ9r8JMQEIboDArLnGdBxwAM0sEW7vvMwWOrTT4n7lrndOmg==
X-Gm-Gg: AfdE7cmCYqWoXj67g5MYjIk1YjUwh/Wfm4jlQc3gfRNapDwhbBZ5A8TCHwVEe1ttk9l
	n/7DKdhpr6fX421uTIAY6ORRAFAgB6tuoE/5yBkioSE8D2TY4RHlNqizw165Pe4BdJog3gHgU+u
	ZtSidaSPbvaLw6ygvDM63eI8WVMV4N3RkBhRh1H03VC9UT648m8RY2dgZJiFNQx3xhZUHR+MeQY
	EIHxITOjmk+78C+KfADdRuQPsVUoKefMgAlOsLsnnJrzTGxCQ0tByhCA2q+iaDNjJwnuaczJOBo
	e4pDg7q7tA9gpwBjLKV1JF2l2LUse/hYD8PLRFeaHGqZrRjoZDyPgMP4f1kPNoCDtpasGLe2UUy
	79pnIo3Qal0NuFdaxe5hgsfeL1mY0sYAwUtsSdci895f30eQlnEYdjmfU81LaKiFKAVkFf/6siU
	DiEm9c0FO1Lp1ZSqZ7zY8L
X-Received: by 2002:a05:6a21:1309:b0:3b4:b24e:27b4 with SMTP id adf61e73a8af0-3c11077668bmr18793399637.1.1784105914301;
        Wed, 15 Jul 2026 01:58:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.219.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311b00048a3sm59322845eec.5.2026.07.15.01.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:58:33 -0700 (PDT)
Message-ID: <6a574bb9.743400b0.2067c9.f103@mx.google.com>
Date: Wed, 15 Jul 2026 01:58:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5859857242364125648=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: [v3] Bluetooth: btintel_pcie: Fix DMA memory leak on probe failure
In-Reply-To: <tencent_02AC78E0C64C34C55D3AC3DAC5AE5DE20E05@qq.com>
References: <tencent_02AC78E0C64C34C55D3AC3DAC5AE5DE20E05@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5859857242364125648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1127925

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.29 seconds
CheckAllWarning               PASS      29.91 seconds
CheckSparse                   PASS      28.56 seconds
BuildKernel32                 PASS      26.54 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.17 seconds
IncrementalBuild              PASS      25.82 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/441

---
Regards,
Linux Bluetooth


--===============5859857242364125648==--
