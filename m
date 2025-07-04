Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA28143C69
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609110; cv=none; b=PqFw43tBCyCSXTJnkpmXM21bDojXsZBVCjeMMMQWY25eBz4PFPqT7T4C7jYORu1BBWwkjlvcGKsNuH8dMOW8s+Ia3/R/ddIpMbsxO/bB/kSHGvrDqXqMDLc9pBwt3Z0EI08uCT0vOZNPUDb+7nmYdDVZtIDY9Lz6V9Xoy3FSodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609110; c=relaxed/simple;
	bh=coL4eUFvXvQOazqsdJqls0GAaWI6FusquSEmt+d0ZjI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J85CA8PTSOzFZMTHi9FXF1as3X/YEUr0h+HN9jLvayT18fGdzYDwhQrfSYJTPhZBvyI3rdIGSmafVPEk1HsGocgL6itEci3MVdn5cuyX0UvZRalceGMcaA75MQMbAkAhmyiDbzv+M2ln8YkkH8hJHn55OMvmCTsE5uCpHrAPoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOkPCERf; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOkPCERf"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6faf66905adso4869646d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751609107; x=1752213907; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a6WbvcbRnebHVEmhd4pqo9uuGU2/iIDY+GebQRkPZlk=;
        b=OOkPCERfQAkCHokVRx1gMcULvNXB+4S9hSQCNYpji73xeuIE53mf2M4CO7lc0fpIaE
         +uIDHDNggAwHBmcPlEcj22vRe1v7MBBRQx53m0RSbqJiuhRN9Atfz55zzizi4a+AGnCI
         aR2KZ7F81TEG0Qi/liN7GuG+7HksD0ZisHgejJT9lT+6tDgvAxuV3suib8IUQDRp/bWh
         4id0GTppzM+lqKSl5/jeAq/xZkbbBPDwTjqP8yYW0z/rbnPDna+qE9SqCpSOZ2hiFC0T
         2996SFH4x+m4KXLzN9dohVsK7zbAfzr4epfPJriDP+gfYUeOMK7XuBxj4n0c71kZLPS+
         rUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751609107; x=1752213907;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6WbvcbRnebHVEmhd4pqo9uuGU2/iIDY+GebQRkPZlk=;
        b=pYRHPuwdEynQ6p/LZgmx8vxGrab1uOg/4trL/4cwruuVl1aJSh6w9H5nf71JubUwst
         vxd0J+vwV+wIF9QZXV/SyxQx0JbMJX2wu+7gF8jzaUa/YoYf23yNthfm+2Mtnadwi7Ud
         fkkNm4+5s03VOuL8/j0PNf1CHYE8vwEVc7Ypdzzm9YZnMnTt5qA7GUGvI21FAPOB8llV
         XIlh6b1rRkyvSReNkZ9o+LABOMNFzkXU16twsUESkC4++oxMDMDjOVQty/YMZJgIiuY8
         9yL6zHJzjZulm7cshMcspptgohr6n3FolF6EpMwB2Mt1ANxW1aw9xEu8WO2C5zW1k4i0
         1b+A==
X-Gm-Message-State: AOJu0YyK0OVMZSJy2YCOUKwHMs509t2iRC3+7fyq5LPAVBuFv/KPLPUA
	dVMyjgl9S89fD4ojg0c1MjjGmcwWR+7/5veX2tah0X+fZaVoviY5QYxJ5EDUq7Pa
X-Gm-Gg: ASbGncuTaMiyVhZuVV05qdsGLP+4rQ9eCOOngYdiHCN3P9x87yFC4reh43pXhSwn9jP
	5G6iHHvDnLxeQMg4qjb3UVvDr1ZsTI671rTX187Sop74wtaSdLhmYR/XXBoHhvwiJjelnTZs7jU
	YNr3eW6DzZUlMb6h/3VwwYrfsjjiBSEE/V908/XXr6n3ZI2bOckYgz0qCmxXM6mHZIGSOsC6PeK
	VpAXL7EAlUDeqvJ4hLaCoBV/PeCRI39lLp2LQGzivz5FAR/StzTod4o8R7ozIvfKf8mvzcZuFxR
	QOllw5l5bJ1ukElei+dCOu30dO7Xb4mMkE3rNocDLjKRG5BHDdVR/aKR0Ceim0T8AmFAPKGgGqf
	Jza4F
X-Google-Smtp-Source: AGHT+IE0Bts4l17NYsZjjPF4b0cFcrEcE2NMvJmQL/B/jbwjwMrUjCgNqdxEErrQT8/ius6dUcfyqA==
X-Received: by 2002:ad4:5c6c:0:b0:6fa:c8c7:82f7 with SMTP id 6a1803df08f44-702c8bcec31mr9963226d6.20.1751609106989;
        Thu, 03 Jul 2025 23:05:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.170.237.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4ccd647sm8258096d6.48.2025.07.03.23.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 23:05:06 -0700 (PDT)
Message-ID: <68676f12.050a0220.291f2e.2d8e@mx.google.com>
Date: Thu, 03 Jul 2025 23:05:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1603515707251487112=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v3] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
In-Reply-To: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
References: <20250704-iso_ts-v3-1-2328bc602961@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1603515707251487112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978953

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.26 seconds
CheckAllWarning               PASS      26.77 seconds
CheckSparse                   PASS      30.12 seconds
BuildKernel32                 PASS      24.29 seconds
TestRunnerSetup               PASS      469.52 seconds
TestRunner_l2cap-tester       PASS      24.87 seconds
TestRunner_iso-tester         PASS      33.46 seconds
TestRunner_bnep-tester        PASS      5.86 seconds
TestRunner_mgmt-tester        PASS      128.74 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      14.57 seconds
TestRunner_ioctl-tester       PASS      9.93 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.20 seconds
IncrementalBuild              PENDING   0.84 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.187 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1603515707251487112==--
