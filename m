Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD21F61C
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720164832; cv=none; b=b4eRYOhhK5tvU2IjNZLz2iO/GvUt5lRc9BBt3h/ihh99M0OezHbwIIIaHPVmcgW0E3MohSde5WBUe+M9Vtrn03mS9DbcFNyoItFSsLVqsGEx62Wc1QEX21I1hWPhl3mEAKKA4Gr53q7gIj/uK+3VYbkZ3Lk7VLaT9taWLqE6kyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720164832; c=relaxed/simple;
	bh=RX0maigTQm3Hfa+wWdKQCO2j4ZHisskEHgECB1iHx90=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NFHtt5QHQI9i3ivT6+l53M93pzYw0UB3f9CIN63ucl8B6ZFSlU8A8gyFt5EL+p2XxizurGUPA4D89LqoLKu8PnsXhDuy5EP9EfeG9xrDXYgOevQbsVajM6CAJmmCTzMG8qpfnfldE5Qg4lax+ezNPrh8eValwc/apNCp+Fkj9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDrnHflW; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDrnHflW"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79efb4a46b6so5729885a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 00:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720164830; x=1720769630; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d+Ba/POxiPvMnhhRwWM739rd0044HvrUXZYVmo9IrDU=;
        b=RDrnHflWaRmOrNLmTtRwRejo8KSsa0FwhIA4fvfKFItQQHNJ4wIq7OztwbLkc7RDsc
         yWEDYvt+/xPxI3QE6YqBudRJgNIAkLMKfx2vycDwJamZHBaPdZ8HjPk4DVYCwVRnU2ht
         d+cw0RKc0YEFF87EypqRTklysBcqep35oIJboiTldTOMfaxjMTGk6PiQ7EyfI5Ctkei+
         19kuEgCUAPq0t7m5U5XRDn4bRm/ZZcy9csN/NDqbAlxD3qQY5FwXIOegX4H9o+Imw6NT
         MlIwtXUQCAefc9YqFTIOqdLt/mE0JXVI1fM4bnUh9WCOMwBmxVX4fT9zx424l0qJ0ahy
         sD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720164830; x=1720769630;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+Ba/POxiPvMnhhRwWM739rd0044HvrUXZYVmo9IrDU=;
        b=tgisOXiIswoOIrMfTgboNd8JEcqtHSd9DiuVxaO6AVJEVAhLSLFaHXHyNaG78pvRNc
         hXd/3IVIn2QL5pNuQ6QsSFL5WMe7zeSDy3VkHVZad5Sa0v8u6El6eAmqEqWmNr/N+I7B
         3nOln1A0piuuzp1t+jlLTuYyBH574bPGsQr2/uhcOMOOfQG78tMBCAgkGf71PhmhOjaB
         +etCtC8doqyM6/oT7lNmUv1G3p/9yBOsVDpHn/CjxVlGI/5difGP9IHg8QuzundqxJxQ
         8Zeb0MFR6YpYkPsiA1O5xWkr4xUUxpVtw0A/8j42iRcoP4FKxiiD1QEwzVlHCueztXNw
         ZFFw==
X-Gm-Message-State: AOJu0YzgNEh+US9I6DNL8dFzsDYUM2UisT5SrtfdSqPKLAlUYDdKHTdX
	TeiV4dyhLRokkMRSm6KxLM/eGdhDKYhqnCeJfkM83Nl2nkO+ahn9Cor0zA==
X-Google-Smtp-Source: AGHT+IE3Oh4EiLpTzBcwDkpW9gVdj7LZs4uzPDaowJIPTbYI+VSgZmpzqyTI/LsZftB7IEmZTjC85A==
X-Received: by 2002:a05:6214:5004:b0:6b5:dca9:675c with SMTP id 6a1803df08f44-6b5ecf78e63mr46716696d6.4.1720164829822;
        Fri, 05 Jul 2024 00:33:49 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.14.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5f0ac4b97sm9726046d6.122.2024.07.05.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:33:49 -0700 (PDT)
Message-ID: <6687a1dd.050a0220.beaea.31e9@mx.google.com>
Date: Fri, 05 Jul 2024 00:33:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4575570399091743103=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Add system suspend and resume handlers
In-Reply-To: <20240705065826.782059-1-neeraj.sanjaykale@nxp.com>
References: <20240705065826.782059-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4575570399091743103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868654

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.62 seconds
CheckAllWarning               PASS      32.30 seconds
CheckSparse                   PASS      37.88 seconds
CheckSmatch                   PASS      104.60 seconds
BuildKernel32                 PASS      29.14 seconds
TestRunnerSetup               PASS      529.13 seconds
TestRunner_l2cap-tester       PASS      22.38 seconds
TestRunner_iso-tester         FAIL      41.84 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      115.55 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.86 seconds
TestRunner_mesh-tester        PASS      5.99 seconds
TestRunner_smp-tester         PASS      7.07 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PASS      28.05 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       8.226 seconds


---
Regards,
Linux Bluetooth


--===============4575570399091743103==--
