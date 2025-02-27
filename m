Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950C22425A
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655810; cv=none; b=eky7uXaU4dM6LwWEzcibezId5AGDvhpuv5R46QL0m//5Oa7FmfKapIbuZQhF+amc3Pm06MK2lSKqaljAJywQCQlRFGrxV6Vx5aOqsbm5otieR3KFgmd0K4Jk5n0YrM58S10/wiUt3EBlFP7E138H5eHeiUU7dQpVz2V3rcU/7wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655810; c=relaxed/simple;
	bh=fhNC5F6ogTPs5yUxsfpFazrxADrSaF/aUrXTv1GLYwY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QEcnXrotqfzGNen3A6WIAcrk7f6rzM90gEBTqITUJ9xzKcHmgIUnhnx7or9Ek5B/h2ioedo0JIdcw2DginusbiDiEhnepCyZ41SY4KTfITH0uvZLYF7WPUhNMlWZUNJzXUZ9qn658i9wsy5+QvTZF3fSERTJClIBz7oEefKnSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwVgmrQ8; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwVgmrQ8"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0a159ded2so67205285a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 03:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740655807; x=1741260607; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rfNqkHctKeZdzQijQ9m9pLot2qrKjLHYGiCGhe6RwcA=;
        b=RwVgmrQ87ZZzMnsgfs4rmC1Xu1UEjt4ePH+eonZwPxjp42fuAssQoXMMhoi/1kndae
         Y0qi0QwOQSIRYmtXhckwoKhnVyxUyNRdfjdf8+EpcLcZTrSl2UI+aXI0ydGc1vi127jC
         0+LzJGAPMu8cj7TJBC5P9h6yw/ytQYdyrrxC+391wdWqwxoCO0b7Wg5iv7Nz6kVLxGiq
         j2w2G49uv/zpoTCFWfEhIzHMz40Y36w+ota48sXUDWBX7PodVAYPikPLNyqH4jASSonO
         sXi46BJX3F0C0qbD/CDh8jMy/qEnoLifB4sBHOL3qGapMakb7K+xMXqc1LcvdKWi8uGX
         Itlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655807; x=1741260607;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfNqkHctKeZdzQijQ9m9pLot2qrKjLHYGiCGhe6RwcA=;
        b=mKJ5yjOKYe/PYylXay3OzZy1HcCNjqCi2AtdtRDt9xrVEZxoraKTdtmDfKt3EV3ppm
         lnroxRskKkASNHqeK525QKpMiIkaZwvyxZMTtFnwz3ro54rHEWMLzh3S/N59eu4iH+p7
         +ZaOGJ2ho25+Kb+AFhlV9pwQdQ2WuQC+eegM/whTCqpRiDqx4uBnZHNfXKjN5PqTc3cU
         A49XZxUW71F6eAWwcitJ5lJvOJztso8Nx6mFxVduC9f95iyAlBuvRmCDzPouvq/SQ9V2
         LRpMD0QKO/CoM37mlTkvnqaJZpswPjERIkNk4K0A2hdO+6fxaeCxXu5bXlb1p60n0xwR
         +8iw==
X-Gm-Message-State: AOJu0YyoGhOToVZgdGm2uFfq84aGC1LCjcXwnUfg26dC0kptFmLajcTd
	MH1+mf7cTVk2x51HirEsAOITTRDnusHV5x6xxbQT4rXWpiiGXofsftIpUQ==
X-Gm-Gg: ASbGncu0qGQUW4slHUvUjMkAWhurhmQ1r9fgg4akmWJKCmH45BmvVuF0iVNz91fzguy
	k5dLTdrhSKuR5DyT8c3I2Maimpqj6Zzj2TXeR+CTc1fz0gg8gq59P1vdbQ3p4dLNwkAqpneeB81
	SpI80d5byhTvENwsjpOF8T1Yw1i8Ix6W/DilsX9jt/lxvhhIebvofn9upXuRw5fxvkRIyF2R2fn
	YOBOOSZW18y6tj720JUVKBTWz2c8mfqJIwU7+2rgNYd5qmVj7e+i0PurtG/gQzT7ff1gp/t6RNk
	87e8/ZTlN4s5OLCKhrUdcN3Yi2zQsYk=
X-Google-Smtp-Source: AGHT+IG+ihdtvy14xwkS7pGaSTuk2Mw1qBrzn+qvTJqxvOX/m3S4f138j4InzJHQldA44p1vSVwjSA==
X-Received: by 2002:a05:620a:1aaa:b0:7c0:7818:8554 with SMTP id af79cd13be357-7c247fcd5cemr1180304385a.36.1740655807114;
        Thu, 27 Feb 2025 03:30:07 -0800 (PST)
Received: from [172.17.0.2] ([4.227.174.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec3f2sm8829176d6.123.2025.02.27.03.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:30:06 -0800 (PST)
Message-ID: <67c04cbe.0c0a0220.7886d.1d66@mx.google.com>
Date: Thu, 27 Feb 2025 03:30:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4153816291482078982=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, catalin.popescu@leica-geosystems.com
Subject: RE: [next,v2,1/2] dt-bindings: net: bluetooth: nxp: add support for supply and reset
In-Reply-To: <20250227105718.1692639-1-catalin.popescu@leica-geosystems.com>
References: <20250227105718.1692639-1-catalin.popescu@leica-geosystems.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4153816291482078982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938443

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 FAIL      0.43 seconds
BuildKernel                   PASS      24.23 seconds
CheckAllWarning               PASS      26.36 seconds
CheckSparse                   PASS      30.67 seconds
BuildKernel32                 PASS      24.13 seconds
TestRunnerSetup               PASS      428.32 seconds
TestRunner_l2cap-tester       PASS      20.95 seconds
TestRunner_iso-tester         PASS      36.17 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        FAIL      120.63 seconds
TestRunner_rfcomm-tester      PASS      7.94 seconds
TestRunner_sco-tester         PASS      9.67 seconds
TestRunner_ioctl-tester       PASS      8.36 seconds
TestRunner_mesh-tester        PASS      6.07 seconds
TestRunner_smp-tester         PASS      7.27 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PENDING   0.56 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.174 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.158 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4153816291482078982==--
