Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927236920C
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041932; cv=none; b=d0ZV9aZoLxyc2+MHnrY6N28aXwUI+Q1mClBi6yfd8K/h12XB98efWnc2VNDsQIqKUZYv4WX8zxMX0D2Tcmw2IP29uK471dFH0dT2um90vV12UzjHUiy5Shvuq/UDRU1lHcdhwJjahBZGJk8lTkFhty4nNayewytaGzbYILbdn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041932; c=relaxed/simple;
	bh=cT32DFg8ivov3Gdkhqs5vsyJBZYcu0ejF+NS+135Ag0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k0ikry0aNIILgzDw1HJI7dw472WB/1kE2hmAa/226zfw6uJPdloHq/yhS1oRWpWAKnwu+dQQ1qHChBRUVXcps7VrXUVeQojiRcpTDEKf1N/aGF2Svd+uobzCE9n0OPM++f/ZISENKxFzX7eNCOVHad8a1Vm7V7NZZVcLSKMOjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edZr1n8X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edZr1n8X"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso3133192a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 01:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787041931; x=1787646731; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3FV5lhZhwbY7Rpnjd7EBH+nbMN5OXKmIZZmZdzbZZRs=;
        b=edZr1n8XJkiZe/qHoqLPOLA1XuEfynTvlK9E0yAvWch98WJIBsQ60i/eofOAFUUJk0
         xsChIkmZ4hNSIMSgnUpZdA6ydNtqMfDdq71gpOkJjZaXmPNHvQTzQWhDIryLJE2PGFdF
         0M+8nd3736sQG7MN64K58JBr8kOGz6E6L248x0dYKtbD5MkDSZlrMHdSUWkxSuHVA3cT
         fA7SmVCRctNdtXht7m7f3Sy+TuvDwZOauRD45fbRa3ebBqHWXnbkDkix5ycsB3jGvtPm
         dxDm940FB6VItYl+YMfoA2H5fyjfF0iZVV6bjtbG4d88YUasZkGZ2ERRmqPgi3YQ6q+j
         Isbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041931; x=1787646731;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3FV5lhZhwbY7Rpnjd7EBH+nbMN5OXKmIZZmZdzbZZRs=;
        b=tE5488Q1yqtgKhOJDwTxpLvt0WuZDdETu/Foh9Fxv+632FpaQAx9CgKYKBIjlFeIv1
         vYhiuFcQW3LlNohhLtCcxXp8+zVYDZr2iy0I+XatSs/5cpRIf2XSQJxlf69sY6FXcy5o
         jaT9yaob4Su4pmPfYfZRZoooKtr/FaJ9u1oQyKOTdJkLT3hYnrcFl40gvnyfAcyy6N4y
         fdrUd7KloH6fQxUzFSILiKM3YaEC/V0o/GGbDmW/xmxxMofIg1OTzUYbnWunyrP5mi6V
         Gq5nQVZfV/NKCleCf9rmnRPPj21YCL1YOiZRHpiS/gMxRU34e5K8EQSBEoBy2MRqPDiO
         FIMw==
X-Gm-Message-State: AOJu0YyNuzRu+l8rcfb2uI1qZMQHJnHFYH4SuwdOIu/xty4K8agm/eb1
	MzrMYGwLn/a9jBfzDSkoLKLi/29BayWB8okyhnNH1gT6ZNX1r36GFaZ8jhx66A==
X-Gm-Gg: AR+sD10Y1YZjw2vlPXiyB9kcheie74wRoDockDSlScZg0mBMSI7eFp6XU2TvaHNOuvI
	skQR9JOKeMlGLzhCPE0tCyQa0sBe/CKLgEGCEtE6ivxHEPAd4mFDnnwZPd8wAthw4TvXe1lTLMd
	FBA3NM21t2T88WEqP0dDtvulLJj5rRJej273BLyEIKMOfpwQfbbVwSEq9sKV/RqnpGwQXWWIMPI
	6nU67Nvwc2LTbm31qcgb+qFfKKvbyz0J4Pb3+NSMEE56iyEItOaNEmqEABwE/PyBf/67a8FU+N8
	nTTfwmxUtbNsGinbjRcmaScfw1qI+mClM/eH78Q8mTtf6VyGW9u+/T8xWpn4pdcxFnNo2o4YBtV
	1jh7cTKLLFxFJOmbrSqxrajY8rfQrbdfGlfkWsEvml0gKxEl0vdu3uX9inijf6uiixmisjDerky
	Z2+8tfJZAO7fTVabaVmySYdovELQm1hBU8Vneb7SFZPR5xDWH4/pY6Ec4beUEV+Qf5gl+4YAHS0
	IE9zw==
X-Received: by 2002:a17:90b:4986:b0:38d:f94d:4c6e with SMTP id 98e67ed59e1d1-3955aa36b9bmr8421122a91.17.1787041927693;
        Tue, 18 Aug 2026 01:32:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.33.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c388e26sm14776307eec.22.2026.08.18.01.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:32:07 -0700 (PDT)
Message-ID: <6a841887.642c3f8d.18da66.ca8d@mx.google.com>
Date: Tue, 18 Aug 2026 01:32:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0745894392358757235=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: [1/2] Bluetooth: btusb: Fix leaked runtime PM reference in btusb_reset()
In-Reply-To: <781dc2cd5ab0533fff9ee7fdcb92fff573431f18.1787039123.git.liujiajia@kylinos.cn>
References: <781dc2cd5ab0533fff9ee7fdcb92fff573431f18.1787039123.git.liujiajia@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0745894392358757235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147623

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.41 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.05 seconds
CheckAllWarning               PASS      30.29 seconds
CheckSparse                   PASS      29.07 seconds
BuildKernel32                 PASS      26.38 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      504.49 seconds
IncrementalBuild              PASS      27.54 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/605

---
Regards,
Linux Bluetooth


--===============0745894392358757235==--
