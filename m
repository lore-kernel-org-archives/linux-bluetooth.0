Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729E3597B
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781990896; cv=none; b=lBlZ3bANGby8CDDAuBUDTOqq/xgFsN56EaBteT6MQ4HTiloy8u69vpqIkXnxQ70klpTyxQVAc8wkbjVOZtt3uOI9waqyjsYHYnAt6RyLCFJonrhEA2p6A0C0ucyUGu19MoO6285xkIfFphJnc4zZREI7u9qrP2KvnTvkUyfYIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781990896; c=relaxed/simple;
	bh=Jj46+DzH6hBCPlMMUMPIFHk7L3oqGYG2p5oX1LCXVs4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Abfit/dMnyPKbE2pKxx92/NKm4zjMGM+/XmfrJlBImNldY+WgGf4bZv1XG5ZpQcNEbqAy57KjXBYD8tUyt665TKivQFzUZiOI0CymVT4U2TJ+NhYZiZXD80kGeriUxhuyCoTBEzcqeXOrQrt+mB/DuygoAKSDHL50zh1SZK9gFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA0z/Dsj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA0z/Dsj"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8de7bfa31d5so27364356d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 14:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781990894; x=1782595694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LtCALarYCVIr1n2NwbW6AWW9snp7gV5V8IkCqMbrRtk=;
        b=lA0z/DsjNalseeL76fphJldChlXRiAZGSDHyGO6hdJk+g2v/REI94SVR+ay9lgOICN
         HhL6bsU1f9OQhisn2LhqnasXGztxj4B1PO/Xux20c1iVLUBhOb4Fq0IkeNjchC66YPXm
         Ab9Jt+ijhJBhvjxICBTfQj3GyT8828bCXnd3FMKFrpr9T5R4XYgp6FdYRDNwxT7hJk39
         6hY2FpzX8X47DBCSYaYlTpYSLUAmwrWojyhaMfYO0BM0HUA1wqMeQ3+6sTcYny5meUU/
         ID/IgVl67bZr9jdl5QXdoXYD7xUUwpV+m3xSOBCM7eL6pnM1hFF/bnkztWEZCddcYiM4
         xjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781990894; x=1782595694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtCALarYCVIr1n2NwbW6AWW9snp7gV5V8IkCqMbrRtk=;
        b=rVgQA5+cZ7GSfAOuTaXb1HkGNj/V9tmaBGcaj5QRidn9dr/HH78HqFNtVPYIvupEvl
         yt65R3tbkjtXpo17II/SID9I1Szb3sVOFpfzjxAm7O3Yp/uyIPonswTjjXLY4q6bU1yw
         BUlrWuIhVpuK8LA5SCSKWTQdcY1Zj+sFJA4T6rVjV2hm7s8DS+zB1DjnH707gj/4SDaD
         95CVErFG0JbwlD910eUtJzYGr0f6bo0noVavtA10D6VcdUazV+/f2kNZTAA4kkKWxvGI
         pdvp85T5HEzqsnSEsFV8q1AzPbkthVWdf394yXo1l55qur89AW1vfEG6HBp9svChFf0Z
         eIJQ==
X-Gm-Message-State: AOJu0YyDqZVs2+pumuqXYqJL0OL/CNGyB2TIosgIQe+vYEL5itHrO2KK
	4Mz6NX/851CDYEZnKcujeEB91ei0FAEiA1/2ZWV6uKA3fKd1BcVi9NZ7Fz8AVQ==
X-Gm-Gg: AfdE7cm2LGYCCteOAAm55AvpQ2jfcLJhiWADYRUG0M7nojL5UFpT2gUpcq2g2F7tuYU
	+o+r146GiG5S9DoKG3RNOvJ0C4tnFXnHH8rpFm5ET0h7024IqwcIZX8uoNeiIXNySxC5y/taV6k
	9sVBxg7rREZqB5dt96gPBzZFUCxjWzhf9trY0EBXh5FlKLyvB0GTBBXcIjcoWmr8+zxjJiPaYlG
	9Tn2Ya4LXjwSRJWW+N60tFLQDzMmPp8rCDAvobeoGFFvxlJ/HAGW/uYBQ50XU7pVWoGn0Rj2aVt
	wFWBObJCy+pSJtxGBSMe0Jaf6NYzOTT49s1VQt+zVQ3AJ95EfTklCFUi34fnjYaS1c5DcsM4DbU
	4mN916Sjv7jq5qiZq2hF07aMhVkhwOBdOog37xMmPSqPaZu7+fcYUzdz0m2X6/ELtWGpaSoEfn9
	k/VobNWb6+EzGXzRPnyDM=
X-Received: by 2002:a05:6214:2023:b0:8dd:5fa6:cb31 with SMTP id 6a1803df08f44-8de40053d2dmr179548656d6.17.1781990894402;
        Sat, 20 Jun 2026 14:28:14 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.173.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82b67affsm42487156d6.45.2026.06.20.14.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 14:28:13 -0700 (PDT)
Message-ID: <6a3705ed.201aaea8.242921.8478@mx.google.com>
Date: Sat, 20 Jun 2026 14:28:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5123504890370984982=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: Bluetooth: L2CAP: validate option length before reading conf opt value
In-Reply-To: <20260620195635.41765-1-meatuni001@gmail.com>
References: <20260620195635.41765-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5123504890370984982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1114248

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
VerifyFixes                   PASS      0.16 seconds
VerifySignedoff               PASS      0.16 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      26.86 seconds
CheckAllWarning               PASS      29.46 seconds
CheckSparse                   PASS      28.43 seconds
BuildKernel32                 PASS      26.20 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      576.66 seconds
TestRunner_l2cap-tester       PASS      58.98 seconds
IncrementalBuild              PASS      25.33 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/335

---
Regards,
Linux Bluetooth


--===============5123504890370984982==--
