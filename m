Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF556140391
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jun 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490160; cv=none; b=N8lySuRJ7x+PbYUYZsHt2x145YmllfRUQ5+mhxGraTbkSs72sBxgDJF7TVlA+YaPFUFuIJib7MqoO46J3SVwwru2mtGXeSd2qFRkIvZFz6mkMyfBzzHpEdXDCPg/qs62hS/abcxj7VP1+eDNNHTK+bLhtxAtBig5j1gqSSBLDvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490160; c=relaxed/simple;
	bh=MIuGxpbvGrUdT8Z9lc89VvxhoNcrdBr/ThGX/PjCKP0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OslH2TV1cH4TSDYws1QEkEzo6o5rit45WqZlYTaS9PhpieifN0S+GzGN7hAIq+zz8w/gEqQshrDosOPK1VQSNhycYr/agZwWl6wCNoEOzA1s71chq2JmemjqdXKLt9c0ZajVvd9dk4lmsvJG1odtPjlkpRLnMHUz/SSHXQKf26Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBds+BdO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBds+BdO"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c199e37f4eso4290244a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jun 2024 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717490158; x=1718094958; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0OZJ6VsFB/ATKaLemV3muYpBkToxUK5hdX3lchTJzUM=;
        b=EBds+BdOUoqE4M0OUHtX/8FfWV87AnJEqnmS5xBvgxbrHC9pMWWWIfcn7UGrC5ZCa5
         /DFE+7GNpbFovqcw/0TvOqCTvDt7tW7U31yRkCIMSxdY4GXvHhJzUq/YDFwvDTURlesZ
         Ny5W2Q1cNoaahw6rGQg6fGwqDe1cffGLugiy8WWG8fSfcprGjnQ1ehthriKCeuP8KjYk
         A/961hmrxJE5iP0935tw1+4mIDYIHqtE3npZb88wzRHWcZLGa+6aGZjkpFLduSGq1zxC
         C7WbF9YaeosMhakJ5UtPB3A550j97F6uFiG3R+ILGOWyYJeMzcXbcM22317+5dWwNw26
         uFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717490158; x=1718094958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OZJ6VsFB/ATKaLemV3muYpBkToxUK5hdX3lchTJzUM=;
        b=WLVsQ6LpSBF2oiCYx4rIc/TiYkm4Pzi4F6c7BLl6iRDoooP4sO61MKFBCVeDftbQVE
         cE/Evoqb9uNhVlTTgDLXn1v+xAK+eGrSpjV1EZBeJUIGvA0hyRuU/NMQrDYPAhuDrKaZ
         6lMgSjC9jHAExJCdBdBpdXGEilRXGzFCq2sW4irCR2N72od3dT7DuquHFwPboQE2oQ8k
         iLuoUaQUdwaFMllW8596G/XsV1qeOsiLZRH3QrZKrBdLxIJrr3LHDBsOyvEx2M58qkKF
         FlDCLLvecdcJKIgLZX3sXF1wevVOxzTqFC7jV2OESMgRH3DaC57Me0Uim2bv7LkM7YPU
         3BZw==
X-Gm-Message-State: AOJu0YzlGtAAyBbfXZLkTvGUPe91AlQTSeKceVkXyiVVpMH3QkbOJhgB
	Uj30ZuA+Wmo6pyQdrAlhf5CtiiZPZj4rK3JRHRTM5JR02Sr7OtA4K25KeQ==
X-Google-Smtp-Source: AGHT+IFO2N20lp04kMKbkTEMf7ov7LtnEVFijZ10ZCOnUo/8HnOPiqLYjgfMUssa0E9SA7yODft+2g==
X-Received: by 2002:a17:90b:4d8c:b0:2c2:299b:15c6 with SMTP id 98e67ed59e1d1-2c2299b1d7emr4882385a91.40.1717490157593;
        Tue, 04 Jun 2024 01:35:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.5.86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c28441e5sm7529681a91.57.2024.06.04.01.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 01:35:57 -0700 (PDT)
Message-ID: <665ed1ed.170a0220.259bbb.326d@mx.google.com>
Date: Tue, 04 Jun 2024 01:35:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0502001603663696938=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: Bluetooth: btusb: Add USB HW IDs for MT7920/MT7925
In-Reply-To: <20240604074100.572-1-jiande.lu@mediatek.com>
References: <20240604074100.572-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0502001603663696938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=858555

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      30.06 seconds
CheckAllWarning               PASS      32.69 seconds
CheckSparse                   PASS      38.24 seconds
CheckSmatch                   FAIL      34.90 seconds
BuildKernel32                 PASS      28.98 seconds
TestRunnerSetup               PASS      519.57 seconds
TestRunner_l2cap-tester       PASS      20.16 seconds
TestRunner_iso-tester         FAIL      34.73 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        PASS      107.65 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      7.70 seconds
TestRunner_mesh-tester        PASS      5.80 seconds
TestRunner_smp-tester         PASS      6.86 seconds
TestRunner_userchan-tester    PASS      5.00 seconds
IncrementalBuild              PASS      27.88 seconds

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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 116 (95.1%), Failed: 2, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.164 seconds
ISO Connect2 Suspend - Success                       Failed       6.244 seconds


---
Regards,
Linux Bluetooth


--===============0502001603663696938==--
