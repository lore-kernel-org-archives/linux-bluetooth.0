Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B37080D
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357252; cv=none; b=My9IlOL6LKvPkNvzJxMi5n+eL+CLzAwCXNc8mpbeIjAV7eHmPSm+VhVcsCkVU9TuoGcMbeS2VYKCuSCL5YK3/o3nDMg+ttrxD6qrYOwXyDEXe8f1MzQ3uVZSxrYDBK/9UoWuLpF4vVJcHQzwZB+8EL+eMlhPmbhfpAmg16ODDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357252; c=relaxed/simple;
	bh=dac0GZ9NM8HyEJliioZgz/y4Vg/6gSrKbVoHA0eBkf8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=F/O5fu0QZp7o/4NEme1htfNnt9MkxydusaqwrEWxROrxs0vnS1V77enTu0GggbzVmrWQ3VrDd3+pPNV6B8YOXzryORVog1o2QyDLrvybrjbY9Y64c/9SfQE5vLcGLg4YXpjrQct+uP01BCw/4Fbu3zCYrVUGzRItcWSaDG+VGvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8PuPIZR; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8PuPIZR"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb64371a2aso1575061a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 17:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787357250; x=1787962050; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KZlI7oZbbciwp79cUoCMCfE1DXwl+ypt9brJD5ILvBI=;
        b=r8PuPIZRGt7mUIWV1AMeo2erRQm1+aCEF/82RTeA0sy4Jfu4h/S1dpLfwoYFL6lIZD
         1ghSblVmupFt5f7p0Fn24utsIh/SfIJ5pyZf0iTNszwZ0Ouubala1C2hhkYmheQQPsR8
         Ed509fOqDLZCay+TC1xwbGKCIIZLdmZZQbGmL9v3OYkVEg5bIkN6gSNyXIq6oM4Cqwz+
         Nolf51qyl7gGM3/vqkaxbqX+rM4FJQKyJaULQo872ZsbXWlPuTlBzU02pug9jjbG0qWb
         PssrSvKdIeuCDqa7noj8pAZ9/JUJtZMKNZydlmcg3bKrSAMvKc8ViFi5egTWvxi6IdVq
         KHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787357250; x=1787962050;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KZlI7oZbbciwp79cUoCMCfE1DXwl+ypt9brJD5ILvBI=;
        b=plVOVxToep8dx9wb00fEcPlLJdJrbAM2z7UdP3X5RKN/WNGq8MRsn1Yd59NEWddKax
         N6Dq0pbPYna667lvt54AjDd2LqVgcfJn6NYEErTnb4XhpVnXAFfV43PKYLKPr1M+/iBS
         4yb9x6y5xASv/WfbGGQuPmtEMz0uQ1MUexYM+84P62AYc8hwGKZzn/FBpLfIKYLFvp2C
         rSAbRXpu6tQnyQVyUogl1770XsaRF+kE2EzXufTnVj4sxKuQ+gIrPpNPdRVD1jmCTt/H
         iS/6STzNov6s0fjiquzoqJ+SK5wqV+UjyyzJiqYecrb3squYglRQv2YIm3XHu3AuOOdF
         HYjw==
X-Gm-Message-State: AFuF++nnDpCGGd7y6pkIpgnFfH2hDtmOGK5LcU7xxrnretEsGPbtgpVU
	MmTy7if6v6GhsPpxh1MsXQuHXlcLf0merr7xj32ok5NDP3OWwdeL0w5aduaDDztQ
X-Gm-Gg: AR+sD13+U/MdLZme0OUDF04Cfranls7SfPfyG/+ByUPQkSHFqWk4ddnyTLmcKFYla7z
	yrZtH0BbPJdyJZXiCGAfImlKD3Y5VNqLWCaUvP5s1EK/HujW+P/pYRs3tpzMcL65pJS7s8RzCgz
	AauCsCo7kjTGMcy9zOkYK4VIiK2seo7J67o8WxeTJ1uaXLvEWXikABlo97lHxCS7bACPEV8AoWf
	h+27eNJ/CTcQEyiOChu/5crXx9WKRDaXBcjQ/Chwl/19EzgE4dWjEGSlDoU8IE4RQwCrvOPn01e
	zMOdJUpq5VShlQMLOgyvdrpe46p3ZFDT5dgPSHq7oL+S6v05dGRKDVOutbtBO5LMSSgbxvlyEwl
	q1XKSWIETQ/z02YbVWFVpPDkA9tCrx85vd2LK6b/mijXZ7OQ0IAMl6xUGo0S3YfDChPj4liY/pY
	RKFHd3DcfaaRkouIcw6uR6UPYJsOTLtOg0QraWKvrbDB6/p5iE/fKTJ4+LkeyKKd+r5Z0=
X-Received: by 2002:a05:6830:916:b0:7e9:e808:e9c1 with SMTP id 46e09a7af769-7f4617916eemr11053617a34.8.1787357250053;
        Fri, 21 Aug 2026 17:07:30 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.237.42])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f440056875sm8805218a34.21.2026.08.21.17.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 17:07:29 -0700 (PDT)
Message-ID: <6a88e841.afd65eb9.36b113.f36b@mx.google.com>
Date: Fri, 21 Aug 2026 17:07:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1273506236546323788=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, george.0xfff@gmail.com
Subject: RE: [RFC,v2] Bluetooth: mt7925: trigger reset on WMT timeout
In-Reply-To: <20260822-mt7925-rfc-v2-1-c88e3bcf7eb8@gmail.com>
References: <20260822-mt7925-rfc-v2-1-c88e3bcf7eb8@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1273506236546323788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150044

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      17.92 seconds
CheckAllWarning               PASS      20.10 seconds
CheckSparse                   PASS      19.22 seconds
BuildKernel32                 PASS      17.27 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      309.21 seconds
IncrementalBuild              PASS      18.15 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,v2] Bluetooth: mt7925: trigger reset on WMT timeout

140: B2 Line has trailing whitespace: "--  "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/633

---
Regards,
Linux Bluetooth


--===============1273506236546323788==--
