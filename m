Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CE47D936
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714388; cv=none; b=je8zf/Q2bHrcW6NpIAI+rEhtJE1M9YXwkxV0Ul1+RV7nThfbtFgUEuIdD3YKC9JsvA4mJr96zLrg4G1PHPaIkRJV/uu7GpJnaIaLsTpG+hhojoiUlqFKmqTf8Np311dyJIIfcPfE7jFfig9frFrMTg6L5tQo2J7+fTtKaeleeaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714388; c=relaxed/simple;
	bh=jlLrKmUWSIuCM1yCSaMnLM7m+tY5qSOH3114rwBvfJU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CZBqM+7mx8eiRPtZwlFtpk9HVM4MA2q3qclqWaHbF5kdy9uDtK/G4+HUltsNnuJuHMenj6CJtrcHCC5zCM/AatA+ULLJcinS1kZVQUtLVUrGkyKtlVONfZP8s/A9cQ2Pl0pDM/L6wcv9OlAhb9MiDznEi3lyr1EoYqGbukQRtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kza9ri+0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kza9ri+0"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceae1ed204so103563605ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784714386; x=1785319186; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K9g5GgNfA6mkcTbwKJ7ejeHThAoclW+oVwYiUucKbFk=;
        b=Kza9ri+0vvi32/6aVuOM94FUanIIyGBCkhY3gxC0Euzq5hnan+C2TSITOqbdylKApJ
         EHga4r1XctNL6HOY11e4p+VL0FYYjP/sC6Sc6pKQKPeXCvFjQwk0eDl/XHJ+vEWIbh9m
         bUZus+7GOCdxJ01jsHm0lqWvsTBjIHPrQO++2TyZNbQiwZePJ1o50GzwBJ5ITapImtEV
         AM7OTKddSvGeBulQBA0byZ4sHOPw4tmsT+t57w7iVrV7sjTGwZAzyrylEH6CJUpKhHeT
         dUlukg6K8W30GTLBSecyXhxNfJOa871SojgzlU5mGhQ2PFoaQoxv6y9jEjnGguGAb4Kv
         L/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784714386; x=1785319186;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K9g5GgNfA6mkcTbwKJ7ejeHThAoclW+oVwYiUucKbFk=;
        b=a0ACjb+/Hab4rMDk/TEMbACGDenvJo8Qf37NnVBT9VWjzuIgeH+4bGW9xr0w46yOqs
         Q8Y4QupChsP1MrtMSL7Bpj10m2lWn2mURCIWI9P2tw9iwjea1ONellGnMBbWcp/WW664
         6QelZZ1pjOgeCKsBNdO0usq7X8z9eUhb9TGZ929Pinz8CnPqsTeEOyyAZOB0Z2wVZehc
         18RsC6ncqB8vWNkoD8/Ypa0swrlYl7QuPqMJvhF6vDk6Gp3296UZT94jGfJOSrIvwYzK
         w5+GQaAMm+lBylKUD91uJ9XgP79P1KcVVIs1up0BfJhzhFRh81Zv5u8qeJG7HxEu30U/
         qQDA==
X-Gm-Message-State: AOJu0YwGHJYmpxgM8dxtGE4Jn01uaAO+qpGQjUMM3E5o7iiEFn/qClmn
	XzTSnI7N/Ui92f039f3py4ftZ0sb/oKn/zZJnHM6gSc2VSk7i955UVf/JCNRXA==
X-Gm-Gg: AR+sD10p4Prr9qA4YIIXszBImURCCGMBjrPDxJKuSmIGfRiTFdNn17+vAZqmCGuYlFn
	Lguzthe0Y6Nw8PvApj8W7hItr8rxUy5TCD1supKKUIRsd9HGV/kJFQT/wL377TnxCm9p0xiAPji
	QnwWhDe0nR4K57Xw+GbIPyWwYmwNeB8j9maUv9X119sIMx/F5CDCe7jwa3brmissZXc81sCn64a
	WOAZxbSKXV/SDtMyLYw4/m7E+Du63/PevOdndwtY532hnGQMYrKK0ABnx9ZhDj2aKHioo5ARc17
	G2B1c/xPgC/RVD2woHihjs20LlJmU3fsKDAGy7NwBC9xIWf3fCxkXHDkEPUfnx+32R2F4UQ9/gn
	4YVo9zrueYbaL2eVE04m1CPCF3U/3fjzfcNfebXH6TFaknjMSQsNo1EXwBVtg6Xp5Kj18JUyKny
	pnXXCav3YxcQ==
X-Received: by 2002:a17:903:26c6:b0:2c9:dbdc:c0e with SMTP id d9443c01a7336-2cf34997720mr218441195ad.26.1784714386126;
        Wed, 22 Jul 2026 02:59:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.46.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df0686fsm8114067eec.14.2026.07.22.02.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:59:45 -0700 (PDT)
Message-ID: <6a609491.0c05e68e.81651.cc20@mx.google.com>
Date: Wed, 22 Jul 2026 02:59:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6747316699197069604=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chenchangcheng@kylinos.cn
Subject: RE: Bluetooth: btintel_pcie: Remove unreachable break after goto
In-Reply-To: <20260722074315.166919-1-chenchangcheng@kylinos.cn>
References: <20260722074315.166919-1-chenchangcheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6747316699197069604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1132223

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      20.03 seconds
CheckAllWarning               PASS      22.08 seconds
CheckSparse                   PASS      21.18 seconds
BuildKernel32                 PASS      19.59 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      361.05 seconds
IncrementalBuild              PASS      19.10 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/473

---
Regards,
Linux Bluetooth


--===============6747316699197069604==--
