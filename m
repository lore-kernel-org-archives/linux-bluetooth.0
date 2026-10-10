Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586DB3B2D0B
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645710; cv=none; b=YckrpsptZy7o2ye3VTc7pTCEKvsguWFPCuxkYDlA87jZDr/hGdvzlBTdRCX6ZhACHJoFOQ/FSAbBDG1K1BIVJ3Re+mb/aYC5OuMXeAd53ogBzPoqa5yYW892oiZ9BwmzDD0q+915U7Rv1HwqlEWxmEeVZJubJCboQ+IsUJuOr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645710; c=relaxed/simple;
	bh=w/D8juVGlKYxQyoXtIJt55eU69YtTq14+NxUWbKD1u0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hWsVHF2qN4/0UTZc4eAJDJZE/siyFZQbCer1Yvf6jiVoTHOdm4c97MksH5RiBed3m/6T2Qkx3MupCBPf/FYC0LY7U9oA0vCCkq/d1pzoZcSFgB7pSCV240C2h+DqBFG6A077xYLfmUWPEjxVgqHqYcZ3/DHMWNkGoOsSRgB+lCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAFPdRat; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAFPdRat"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-154e9d2d979so540014c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791645707; x=1792250507; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ye7jMIQDtLDO0ZT4oz2dVoU+CpDn2CPp0ygZ7KC8Vn8=;
        b=sAFPdRatq1eV+wZwjeedjLuP8CyQKP2uFdyzKclPmKs3hrwq+pUiWJNAA6eGciAGlc
         jvaE8qGa4z0hC49t5fc2niwERDagFtYXsnr8zcucGBj59CpRW+NejVgL7iQkxJsEjJTe
         OiyeJPSGUYKCJ5ysPNCpJGV2ukgHhn9VyLaAQEkS/+yrCg3CYor6xzyc8d47Sh1TuyjK
         +nXQywghgyxNdHfGI/vnqwNmtjQvLIzrpYwJhkIW530mbCpShxX2ITSFhhHaKLM567iT
         rd2XLwiGZ3fsyS66u4aPPGut+pXSNhXVs7EamXNE4Yt20+rlBt9Itt/IO8+cfJ33b967
         TkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791645707; x=1792250507;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ye7jMIQDtLDO0ZT4oz2dVoU+CpDn2CPp0ygZ7KC8Vn8=;
        b=D/z78fNkcUlZdhnNxKj4The5TtI4qhZpg59PnOWHfPAvwVMy8ZIMwCNb4Dvw642R1M
         VODwumjtwKJPDs6fzI4C/5f7hXSq9Ths5ZqcspFLs7WJJwXo+iRVJ4ikR3MbqFwNpOMg
         sjfrCrwSd7Z1Zm0yyBkM68SbGRWQxiEskHC1HW5SDhEiSfRRAnwizvJeRR4W6Ecczo66
         W9DtlAE8kAypLGgTVEP8H/PGYLApT01404gaAfuwHV/Kh6x2RPbK+69zfjo+MUPrygt5
         7se+p17B+f+F8B4f2E4VcmN/VfhnpIMlb3uxxb+0fxPVNkVcGUa4RVtBWIhVmgg+J+MX
         VuYA==
X-Gm-Message-State: AFq9FYJ5+n0MzbpHjV52oQkaSmEmJaTwKJnbwqZdpG+2E2xB5NJOAyhl
	nO1I9J1/fXKchZ+pdq6T8gWax2Bgbh4OdxOQcXCU+HyWtGCAo5NevhYrBKoisg==
X-Gm-Gg: AYBFou2bLOhrNAbuY1CefHlTfyPOojA/mnI4yW4Ynvq2oBxkxGVIHRO9wyi1kD0Dysv
	GObTWH1r4Py/0Pqy1NVseBMbAAVJwGvvUmso08O32Y2FzRn6rGW2tBxywC9Ti5RYjJ/S+Dmzrdf
	Hbbn7qCriR5v4iXgCQBNv/0umvnmZebRAKvw/Zn9di0D5ZUHksgN1OfXYqO9HpOtgEIRMOnvsY5
	cwBC1/vf9oDPNGL3UoudjDyhSQTBENXPM3pvZyoBlWVGONXG/iJejy4jjx1zr9coDs4aPR21df1
	awXNi5jlmdPWv+vW665VfCCYEGC5AvvsME+m5qn80CkjTi155sLSFjsFyIgNoh86yVf9CMKkzTa
	q9uHwyet6ADGWiusQURz5hCz/+skYJK6/vLnZ8KNJpm8Pl8H0JPfXd6Rd8qkYukQ1YKbTiUeZ6D
	ji7td43Q/ayD3fqhSHvO6aGV9lqLk9pHK2qvD2kOOfpp1ouYv9LeId+7cF1Yn/LXMhWy5q0S6Sd
	Xo=
X-Received: by 2002:a05:7022:f51b:b0:15e:12b6:7365 with SMTP id a92af1059eb24-16a54fab7bemr5686532c88.2.1791645706943;
        Sat, 10 Oct 2026 08:21:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.2.96])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567bd18sm14999376c88.21.2026.10.10.08.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 08:21:44 -0700 (PDT)
Message-ID: <6aca5808.4fcefe71.261a9e.bc99@mx.google.com>
Date: Sat, 10 Oct 2026 08:21:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1049632031303331549=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, birk.skyum@pm.me
Subject: RE: Bluetooth: hci_qca: Reset the in-band sleep state on power off
In-Reply-To: <179163212446.46972.2306254853726299632@pm.me>
References: <179163212446.46972.2306254853726299632@pm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1049632031303331549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1182949/

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      22.18 seconds
CheckAllWarning               PASS      25.69 seconds
CheckSparse                   PASS      28.46 seconds
BuildKernel32                 PASS      22.38 seconds
CheckKernelLLVM               PASS      24.58 seconds
TestRunnerSetup               PASS      579.29 seconds
IncrementalBuild              PASS      21.90 seconds



https://github.com/bluez/bluetooth-next/pull/893

---
Regards,
Linux Bluetooth


--===============1049632031303331549==--
