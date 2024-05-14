Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6712A166
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715679244; cv=none; b=ks7idbiZY16kXU6lg9lVv2Telu1IbYBfd1rd7pXqbKg5KW34F0x2DJCeO7biyIfQ/hkgugjWwSmbNvzVMLZADi/l2pnrxc6j70M2+VKU+5ryCOZ1iwhtfuIdvqMdPCr2bAQM9FTCIiK/6rqkhpv50p6e9gRLG0l5MFvM3ysHy8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715679244; c=relaxed/simple;
	bh=IZPf3Pq9DtrkJQVOBm79/GPGQXEn7LmuZItvNOV7Nu4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QP5cNLt1IhALLNZFhpZDOQmcpA3O7O4b64ivcuyFw67A3nqCMRHuRgkyQCtGImvw3j044z9KnqGXKm/whGKlzOkIpDX1yxfk/qCwuPdZ8aFfx/0H8WuRqA/w6+CmMY/VM6TjuKlVqb8XHUhhP6S19RPGT0LwzaHpitA1tppHqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaOOfWVv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaOOfWVv"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43e18255597so12566101cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 02:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715679242; x=1716284042; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RogEV2skZcjuoInfvdDMOBF9WXIctvmp1NaHyvVr+ZI=;
        b=SaOOfWVvKElClrDaTPYjXwDFME4Jha3lkNRE9RK03rCv9j+WDnMLN2S+z/DRMDAS/r
         34yCGfzN8DCWHWrxEDt13nJjDA4s9O3P61rmMgoXcgfSveAuTPd0QA920iVVD7Umpg8A
         AQaYNoim6HHNiA872Jrcl+oDVEu78lTl9fSLvp3y/ly/K90mNJY+uuHnKvILT1+kv1HA
         3TZahBGOUfbutIpqQGFOt5dyKwHFWwIDsoddwaop1LoaZYS+DXGZAV67FQQVDfXuoQi0
         IvudtHSJX2277mixFqQCrpgQOEGVUA6FV/35xXQYAb0uFzrcWWW2sAahgDM02f0aYlbA
         ijhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715679242; x=1716284042;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RogEV2skZcjuoInfvdDMOBF9WXIctvmp1NaHyvVr+ZI=;
        b=t6N4PETIoGBAJeIVMpCM15QA3IIQgRTnGkJ2H2/oKauyRzUzcIM5TbvfYIREHr6uei
         u9UG6INyR0COS58y79hqRRgqkxvjHRK8oIBfkrDmRwqaSoxvAqwAycD4YGXVunsporpf
         5FmPpuFfhFfADTRHZj2/LYeU98Ibh6v6RLp8qqbCrdxIeJ9Zai8CPJhNBKHajX4qby4L
         /3LzYUuLDdwQVDvdWnfiBbAo0p4PRtuxb4RTqsnqJyDAmS64gceBmGrnRAh85EcvNnDZ
         XMVUwm2zfhMYN/8Chj08y6c+zIlLqL1vvBNi8VWC4ECfYDWuZS1eoAMutJqCULvK60gU
         EGSQ==
X-Gm-Message-State: AOJu0YxlJHVf+CGsuxY5F9cmpLYJqeeDeg+vR6VZDzWUhKeItmrK+mcL
	BmC+2p1X5h3HfRwUzA4NJGkoMvOY1IkAT/eWyXktGTCFxcsjaygf3oaygJ2h
X-Google-Smtp-Source: AGHT+IFWF3hh+vcDjueqpd86qcmHZKbSxJ4msAR6m55RpBUHKX2bFp02VWlEHPsinF9ZqKjMTZKv5g==
X-Received: by 2002:a05:622a:44e:b0:43a:ee30:c554 with SMTP id d75a77b69052e-43dfdaad22bmr114674091cf.19.1715679242232;
        Tue, 14 May 2024 02:34:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.86.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e1583185bsm27546321cf.64.2024.05.14.02.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 02:34:02 -0700 (PDT)
Message-ID: <6643300a.050a0220.b2ec9.7b34@mx.google.com>
Date: Tue, 14 May 2024 02:34:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6237241435446037324=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Enable Power Save feature on startup
In-Reply-To: <20240514090258.1507934-1-neeraj.sanjaykale@nxp.com>
References: <20240514090258.1507934-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6237241435446037324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853008

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      30.78 seconds
CheckAllWarning               PASS      32.99 seconds
CheckSparse                   PASS      38.39 seconds
CheckSmatch                   FAIL      37.57 seconds
BuildKernel32                 PASS      29.48 seconds
TestRunnerSetup               PASS      527.09 seconds
TestRunner_l2cap-tester       PASS      20.57 seconds
TestRunner_iso-tester         FAIL      33.71 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        FAIL      110.89 seconds
TestRunner_rfcomm-tester      PASS      7.37 seconds
TestRunner_sco-tester         PASS      15.13 seconds
TestRunner_ioctl-tester       PASS      7.72 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.02 seconds
IncrementalBuild              PASS      29.82 seconds

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
Total: 122, Passed: 120 (98.4%), Failed: 2, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.189 seconds
ISO Connect2 Suspend - Success                       Failed       4.217 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.166 seconds


---
Regards,
Linux Bluetooth


--===============6237241435446037324==--
