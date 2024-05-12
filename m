Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120529B0
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 May 2024 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715517663; cv=none; b=LHWi6/ItLBveIRL9ujH757684cKdxIb92JlUYbmMh/6kuwB3XPVkyrxqmyYm2wQ00S+OXV3ZjBg833ublShyGcB1VXKfHQzSrOKbywxNkvyQzkm9D/WXIj75mTgwCta8sq3MX4qsQdLyGQtdJ7LxPjawAjZpcANLY4JVmxXTIrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715517663; c=relaxed/simple;
	bh=evJraN0r+0Zdo0PXjVrTdj2GmcqdIFo/YH7nVeYNoUg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bSD8vkl1p54VAs3jvt6pC5Eb9gVj2LaX1bg+8S8c1m1uxi1aTPrYp1t3dYqNt103b8VXgBHLb0sXkDKL83qsAEmNRI77+Igl5owwaY5TcKekMb5LH45Q/KhGXzXWvlgb9WKtr+PZ0vDYqqaS5/Kzd0KBTNtjFtIDni0Oj6R3Y40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwNpHCIs; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwNpHCIs"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c99e6b8b1fso822919b6e.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 May 2024 05:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715517660; x=1716122460; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VgpxyOEeBrLCRWrBJDZpofjAZe/HmpBda8R3Ym92Kdg=;
        b=MwNpHCIsXflOyN471G2wWbmuQbMjxOayYfjFZnlxpQjK2iJcrsQtUMLMJ+Dc7oTVfI
         IoSC3M55bCOvF6tTecUehrv6b61tFqH89kex1cc+iJ3IgzcNeRf12btXP0i/Y+gD9l5r
         +4rM8huG2Zz9tGS77ubxdWIEImGLtxwNQCav+5Wfxt1h9Ui6Ya91gWX6J+5tEYUa+Uwz
         rL2sruabssHPb0YJuoXv7owleXvVSGh83h7TGp+pl4BI3r5H7VCpcGbvIZ6ww9Xcu/ug
         zYLQgdMRw74ZDC3bXURlgUWuBfuEhhUY2BlNifz2ZQOcH+jwMNa67H5jVhA0BBxFlZNE
         mjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715517660; x=1716122460;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgpxyOEeBrLCRWrBJDZpofjAZe/HmpBda8R3Ym92Kdg=;
        b=KDCM4Ah0bqr4tJ2h1xP02Ad1bwBVDqnx5rgsSlRPZ4t7qbhvTXrhR2auV5G8P8AHM4
         Qyild5YJG45Eq7ib4Li39kgqhJZTmatt39EuCH5Qx6sZfGlm3h2rPsGDekJQmwg7sCpv
         /Ifd3jNdnpmdxi+FrNl0PgZvBnpxzJuRGfbF0Yuk98J7X4hkpKQjCuubQyjcZP+8Etyr
         hFQ1kJ4y81dz9BLmvhGjbW5eOoq3gwLxvxQFcykVWPdlDXxxBC/UCh352cdUsDmMFVDZ
         hIb0LGmnGA+5NrXYxdyvaadh6LRhmbNGabFTykogrOvAFwx6l1zORB44EuPy7lg1y37q
         MBTA==
X-Gm-Message-State: AOJu0YwC9s2oyRrLhSy7mIOEIbPdS0b5Luxg5/Ac0NGGW0nEzD8zCS29
	hN5AdeeT6VId9uzqzkApISp3WhJl+p7sKYPSYC4XO9e2MBvhVMxYIdWoZw==
X-Google-Smtp-Source: AGHT+IGFJKtg4z8MqD0nuYoRNx8MX8JB6cOiiT6RA3meJPtaZKESbel5bRbwgjfvo1UjZy30ZMhdKg==
X-Received: by 2002:a54:4415:0:b0:3c8:430c:ab4f with SMTP id 5614622812f47-3c9971dd2famr9512083b6e.55.1715517659894;
        Sun, 12 May 2024 05:40:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.82.221])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f205c64sm34323776d6.146.2024.05.12.05.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 05:40:59 -0700 (PDT)
Message-ID: <6640b8db.050a0220.9d663.aa79@mx.google.com>
Date: Sun, 12 May 2024 05:40:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2115088008206457634=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+sven.svenpeter.dev@kernel.org
Subject: RE: Bluetooth: hci_bcm4377 fixes
In-Reply-To: <20240512-btfix-msgid-v1-1-ab1bd938a7f4@svenpeter.dev>
References: <20240512-btfix-msgid-v1-1-ab1bd938a7f4@svenpeter.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2115088008206457634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852644

---Test result---

Test Summary:
CheckPatch                    PASS      2.17 seconds
GitLint                       PASS      0.57 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      29.49 seconds
CheckAllWarning               PASS      32.65 seconds
CheckSparse                   PASS      38.17 seconds
CheckSmatch                   FAIL      35.96 seconds
BuildKernel32                 PASS      28.86 seconds
TestRunnerSetup               PASS      520.69 seconds
TestRunner_l2cap-tester       PASS      20.60 seconds
TestRunner_iso-tester         FAIL      33.71 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        PASS      111.85 seconds
TestRunner_rfcomm-tester      PASS      7.41 seconds
TestRunner_sco-tester         PASS      15.02 seconds
TestRunner_ioctl-tester       PASS      7.68 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.83 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      32.02 seconds

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
ISO Connect2 Suspend - Success                       Failed       4.222 seconds


---
Regards,
Linux Bluetooth


--===============2115088008206457634==--
