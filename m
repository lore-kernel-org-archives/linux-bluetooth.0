Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA51509BC
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085611; cv=none; b=hgK3fSDF7FVC6+fvKegNhBJJElpKeDnvkCOxRVvo3JRLmmNxmyxSeGwwXvMi95h058F1fQcvG3ehcDjgnjL9R9IWuyNhvJMByD04jhAzuZQmU2L9ZK6cSQk52ebI9dtxbr+ueY74bhvUympuc622hMCnelNHJ714BsW0BW20a2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085611; c=relaxed/simple;
	bh=3yt3tGkfBYWKHcUWicG9yDgSFlJI931OAT/BroYYrlI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Bw84D6ny+ZQgKwQPwW+4rLU3o49tqEhWeIH+6dK9Q5LnkGXrBfsE1piRMYD5LqkjQO6soTSsANEJ0VzXzIl/8NDiGdA7BoGaAdZE2R9CJRqoHbmLreeT62VVBkg2j8VAJ1MHTzoYiVGMTjVgVX60hDwYImVAkBdVvvGrSEgt2Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxmWprcM; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxmWprcM"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7ef2a623958so756724241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715085609; x=1715690409; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GxQFon6pfYmGV8cWag29wRm7fOrJi1JjLBpDDAa1sfA=;
        b=XxmWprcM7qIGho7A6eAbBn2fyRHQ79qdQYx3IIZ0NHVc+amSdxdy7rQXTwqRzkdpQg
         RrLob/EnNaqOh/rthcNO+mryPb7+mclHjMzp5BhXUSR5gHD8dwwQnn5fxxP4M87Xyki4
         WL1Z0wB+D3GgMR4U142Q7a37WngorYTy4m2XQOYIZ5tq9khwmPzISBu9HGTRQj9XM7Nz
         JmtLDkepLpOoqPQCBfLocufJpbYoIg6gJ+tV7R5tU5VSay49Sk9t+lKgHsX25PF6Ey+V
         z5CS1yVZlNI/O9G/TGVJPgZ1WhCASEQCoabIoW/7jJwrthgmId8hgII+OQ1Szv3Adn5e
         2POQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715085609; x=1715690409;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxQFon6pfYmGV8cWag29wRm7fOrJi1JjLBpDDAa1sfA=;
        b=rinUxCSzxPru7dbEkF/1+VOSj7aVor9jyl5d96oTCJ8Q4aEC1iVqNzGucQWJHaDLAH
         BDvBpaaX5nzZg7jYI7/vFacGfjviHOOeruud/Tp/aaYeNKDMdsvyi4AO5qVn6+bIIuNR
         biXQfhPE6f6llQLgleTPoa769lo7JfDFR+yl8gODo/DkNNNSaW53wqbDvkOuwGjGJVDr
         Pk8JfAPYl8U/jPAKFmHMR5e0ylWIYNx0vhrQkLods7+2E/1zfEvl9AYwLQvx1UXb8KHr
         QGSbHTBKHDloQTlx+RIx+geNGtst7YokMemX0BSRdsZrXKdwAOZisLapm0QpPq85njUr
         34IQ==
X-Gm-Message-State: AOJu0YyhJXHGZS27CA8zQXyJ6mfMlh0FEWvQ8EBK0WjreVqzbF/hRwsN
	6iqXv7aLNlQM5niiDHNoT09GWpxqchqCNUoJQ72RdZ3/HWtIkLJKQduXow==
X-Google-Smtp-Source: AGHT+IGU1TfwKgn1TfaIwb9mTC0hWYurlf/ngytLNszNJhRPIGUwadB0rTSuGYCVjvbm0whXaEbHoQ==
X-Received: by 2002:a05:6102:24b9:b0:47e:783a:cd5e with SMTP id s25-20020a05610224b900b0047e783acd5emr14937215vse.19.1715085608916;
        Tue, 07 May 2024 05:40:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.173])
        by smtp.gmail.com with ESMTPSA id e3-20020ad44423000000b006a0af6e25c2sm4658491qvt.94.2024.05.07.05.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:40:08 -0700 (PDT)
Message-ID: <663a2128.d40a0220.41b56.efca@mx.google.com>
Date: Tue, 07 May 2024 05:40:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8520273572825534010=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oficerovas@altlinux.org
Subject: RE: Bluetooth: RFCOMM: possible deadlock in rfcomm_dlc_exists
In-Reply-To: <20240507114244.120751-1-oficerovas@altlinux.org>
References: <20240507114244.120751-1-oficerovas@altlinux.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8520273572825534010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=851144

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      30.21 seconds
CheckAllWarning               PASS      33.33 seconds
CheckSparse                   PASS      38.87 seconds
CheckSmatch                   FAIL      36.55 seconds
BuildKernel32                 PASS      29.16 seconds
TestRunnerSetup               PASS      526.28 seconds
TestRunner_l2cap-tester       PASS      18.55 seconds
TestRunner_iso-tester         FAIL      33.83 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        PASS      107.38 seconds
TestRunner_rfcomm-tester      PASS      7.35 seconds
TestRunner_sco-tester         PASS      15.08 seconds
TestRunner_ioctl-tester       PASS      7.69 seconds
TestRunner_mesh-tester        PASS      5.76 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      28.57 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       6.251 seconds


---
Regards,
Linux Bluetooth


--===============8520273572825534010==--
