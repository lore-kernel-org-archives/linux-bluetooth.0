Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E8342C9E
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705001; cv=none; b=MZlD6opz3zJNG4p8b2i3Nk7CEiEG0pMBHAjL/nmFP8VANUbncv8cN7iOkZsWsYRfCvM7r0K8jgAMqrhhf0tRMKVABpTOA5f/mnPb12JcIXIZfeMYTdl0U9gFSOPJbQ7ramMgtXg8luV5bL5RnaX7VMm8JOAG325e3VgiGoMXbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705001; c=relaxed/simple;
	bh=/ta3vu07z4egev5/Xa+9TIh84/QDyM9qllXi+5d3d2Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=W9bk4sma2v27YoG1nnwu1x9eiaK1bnmBjeI1UVgL5sZMSraUKV7/LpKJ32VMN4c3iRHZW6HiTSrjXZmRZh6bQXS8y9o71c7o2HFfRAoXyZ4g83JDOBPlrtzr1Taqriqc3joSO17lbi95OxQuB8DliCgn12cQkXQp/r9DYDyzISY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoiZaFXX; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoiZaFXX"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c655e0ee70so131158085a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 08:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769704998; x=1770309798; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PAK0VPCmJJGKV8SokUsbfpQpjZfL+Y30Jy60VSb0vUg=;
        b=GoiZaFXXYT0KYRl8deApzB4rsepqrS7Md7gneQ/VXnf8KrplBK5t2GeWnsFUrHrUMR
         O4jctjdsYbt35S0xpD3SG8OniUw55BLI8CISUq614ahkt0dVMIuad579g4Nb/AWMpyId
         Jhr1FUvd2VPRyWpnfWZgTMca5U6+TzztfbXSkowOHkKhoBTyL3BQ2aUY12Yrz505XS06
         8togR5TLKw1sdVB77e6uLPo4DcONDlo9m+ekYRas4Hrygw3ElZumVjVpSNUwejhZznTb
         5ckJXlOneKb2Sg26fF94ZNV6eI+QPawpuiZqLLiQmdJ544nY3+WwoOQHKsDbfxvhTwm0
         IF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769704998; x=1770309798;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAK0VPCmJJGKV8SokUsbfpQpjZfL+Y30Jy60VSb0vUg=;
        b=caanbPHCR24wb/LQzM6fO3e2AdRoQqlwhwVz69ldeyWZffV6eWtsjQVfP9SYHRqoko
         ZGE9yOrCV+oD+Oqlz5FpTDJ0VfAg8J3YPUz8/yIwuVenhVr0q/AY6Un8CS5PYTuIbytp
         lPORbAPFLKMdgw81s0hx42IkGFkYPQiRigwHzs09yVWr7PAv/CTbTJRGvGA5ByvNmIT2
         wvMosI1KThV0ZPsE4J56EU8jRmPTlypVRrkxm6VDLptmfR1hvjJDlD36N87LlMTg5pU2
         B9QHh8d+9/+UgCOLphzkPPLJVbjLLVnYzmBAy70IWCoSZMOXcaQ9G4CoFHa1Bujcbiqx
         c9QA==
X-Gm-Message-State: AOJu0YytvPStDHDdL4R3z2J8pw6Z5lqk+qotO+qU+5nAaC+8gTglXPjM
	fbyO9Q3ZsWifM9ee9di8+IXonT0+Veoo8V9wo7bXL+q0iBRw9IxgvZppzUmJVpew
X-Gm-Gg: AZuq6aL+kw67K0ynakuxHdtpkjC1K5uJcdm08Imrhr0o/rTNFhRDQ8zSucOyirYTFZT
	uVhkVE3zdBB2/IKsa+ZVVyGjmNw4c50WFOtSTv/0OJLze2eaLv0K19H+vLvVF888cxYojGi7vWn
	thn6b4bH2vit57FDz+HBe3h+FPrrY6USzmNaVTv35MeevEH/dEcG/B1sbtPMdbtN5RD7rcsOdP8
	y8eMzQogHpVqt3tAjd4uZqXafBLKU3El5kV4YUaQ29AkFIzucygy+6D9YLCR3SdtSObksaFbKO4
	AqoIxyT7BRC+zujJaGlDgvdbvJ7XImCl1o3DEmX8Oa0v5xUc8DsZEMZIZJGBjZno2UTFzgOx+Hu
	TpeO5Gwnrym/isCdI8aXacCyjVNvhtcq4wFVpyioEZjj+/wyfvVo6BS9UBYWHWG+QUbWKaqvXhF
	FyCFbs/284ONk7+WGx
X-Received: by 2002:a05:620a:4591:b0:8b2:f090:b167 with SMTP id af79cd13be357-8c9eb28f5d6mr33635085a.24.1769704998165;
        Thu, 29 Jan 2026 08:43:18 -0800 (PST)
Received: from [172.17.0.2] ([20.161.77.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c426sm38105021cf.7.2026.01.29.08.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 08:43:17 -0800 (PST)
Message-ID: <697b8e25.050a0220.30560a.c3aa@mx.google.com>
Date: Thu, 29 Jan 2026 08:43:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0526276586285926151=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arun@arunraghavan.net
Subject: RE: media: Fix G.722 @ 16 kHz codec ID value reported by transport
In-Reply-To: <20260129154755.410853-1-arun@arunraghavan.net>
References: <20260129154755.410853-1-arun@arunraghavan.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0526276586285926151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1048593

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      19.86 seconds
BluezMake                     PASS      629.82 seconds
MakeCheck                     PASS      18.69 seconds
MakeDistcheck                 PASS      238.36 seconds
CheckValgrind                 PASS      289.12 seconds
CheckSmatch                   PASS      348.82 seconds
bluezmakeextell               PASS      181.29 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      993.09 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0526276586285926151==--
