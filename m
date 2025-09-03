Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFBC2DCF6B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Sep 2025 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930010; cv=none; b=Xm5z686FLZK09a+XA639naLDhOy53vGR/vXaWJwrRWpijI51yHZ/L8Xs/9szLv0WOpdjA1FkE4z/mJ9atZ/3BRk4x8uLuu7V4H3rjzwBqs2Fyfj4NukpbOpM1o6aLwEOmI31ehLkXNRGTwe+g9WV+b0qhNXaT8qPkxB56Fm3YZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930010; c=relaxed/simple;
	bh=KNiNpxBcNz8P7WNJ+6rSnOx6/ytnkFFpMlK3jOodp5M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ORhVorFrRCwel4nUv0mMcFQ57iCMJdD4aVkwQjfOfNLBFBLI4vLPBuhNxtgEqmOEGhU+VGJFmtdQE8LQ6f7g9Zv7XlRgJKeoifkrc/FgNtNLhBhtbY1jNqrsrAYsLlV+5efyEcPAF1MaMB2dNqkbg8yaoWHHprutT793+U3R5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGWC76gv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGWC76gv"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3f664c47adbso3029825ab.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Sep 2025 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756930007; x=1757534807; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NT4ckgeulgvnq4aWNS5ncKrYlArJJo5eX+gfiPgeqvs=;
        b=dGWC76gvZR8mdC+gBm4dAH+eEIcs+IvMwhe4+afGA09TfgA9/YN36bjQjDwEM1Ociy
         cwCd3a+V4eDNQR0z+5H9w1NYVQxoKa/lkBd1rUorehZG1jmod1IZ9F8t1+f355lgguMc
         YbA4tRTStPuYGe6TM9e++VoVAF4hiL7L0odgi/crAUjieI4Y64QRsKTBZTISzvyf8hTK
         /4nYqu5AwcqMLz5sTERMnfRaeA7N3qiRRObgEpsDmksT427V79UcPoDVdvEQK9evV6TC
         rCUeJvhaZiKOR0L0fldvi3D8banobFbHeHhEKcC115nK94z8t/y6DXTBmy7teR1M+S8w
         mH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756930007; x=1757534807;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NT4ckgeulgvnq4aWNS5ncKrYlArJJo5eX+gfiPgeqvs=;
        b=JeFW88xvjRJMbJQfZZO/cak3WCtpcWpur1o0nVSC5aEN+zimpw73U/1CiGIRjTQCCY
         6qrNW2i/cTR71yRZ3VsouSA/L6S5PJVULVfsbDWc64BIcGVKwnb617EKF0raX2JxSdVE
         DpowFKHngRO3KJnFrA1nTQ8oveKyGwvk7aS3KHFio4iQLzOWKm5RX+d/VkfF4Nigb8P9
         /VX/ZE0kvjJpv+HIXn/DME9yjHkMleP1u+lY5M6+4d2wrJ0FpFim3a87Z2fgXoR33YFK
         yog+41tWFppDmumslXwQFeIQWYfCpCkyy86R13Le9ORFqo+AqXgLvm3bkdcrVvWOGF+g
         FMyg==
X-Gm-Message-State: AOJu0YwcFiq5LWh85r9SMLAvd/IhacVRRjn/R5bNMSKRvY4/d4a8tJ6d
	HCVSXjAX6L7fTkkWTIOCOPfgx+Su40axo5P9STDs+kNzAFca7qJ69TDVoiQY6A==
X-Gm-Gg: ASbGncvK2yg3n3wEJnrE93NKC4AfHCqBMKkfGYM4shAVv1dRlekAmgI4M9A0YzBq1qO
	R1QvKDMTA7CQLd4fsvlObFQHE1cpjTr/710pkBfRaVoYcg3L1oMJgQcHh4wmDIWJWqp/nCDDTUb
	el9HSs9mk75OkWw5Fr950gH1rUfsXlay9y1t2EQZXmqlOxD8v65coReOGjGZLPHyrzHdqr4TFRc
	T6DTtJCwg6s+JUZOYEWQtmzu7bzIyPM4Ar9Xf2C/1XHTGpWQHHHsvicEEuJFoPttzPUM8bS+Vre
	rwWnCyiSYc4ivzcFOhyHvDtxYMfDtIUDkH+0+wFdG+1iTuEvVFvaNNOAwGLinitGZF3et2/0gox
	PiGe/f9wGCqZ53w7v+P4eFcQI6At/fw426+4crAw=
X-Google-Smtp-Source: AGHT+IEBw1REnj5Kksb/lOW1iCMRpFSZ9qaSpBV1axp4TXybj1xflGXfWeTdxlRQ0nnJnpQPkgFyhg==
X-Received: by 2002:a05:6e02:2285:b0:3f0:1ad0:2c17 with SMTP id e9e14a558f8ab-3f4023b91cdmr261603815ab.23.1756930007291;
        Wed, 03 Sep 2025 13:06:47 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.201.22])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ece96399csm3834012173.20.2025.09.03.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 13:06:46 -0700 (PDT)
Message-ID: <68b89fd6.050a0220.efba3.873f@mx.google.com>
Date: Wed, 03 Sep 2025 13:06:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6203164189259005384=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] main.conf: Add FilterDiscoverable option
In-Reply-To: <20250903184240.476314-1-luiz.dentz@gmail.com>
References: <20250903184240.476314-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6203164189259005384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=998542

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      2768.70 seconds
MakeCheck                     PASS      19.83 seconds
MakeDistcheck                 PASS      188.54 seconds
CheckValgrind                 PASS      238.61 seconds
CheckSmatch                   PASS      307.60 seconds
bluezmakeextell               PASS      129.87 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      940.19 seconds

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


--===============6203164189259005384==--
