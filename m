Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF1019883C
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693196; cv=none; b=J2lV83VBJQvo1rgawL1J+iOPIDmfWlhq4uXSCKPQ/wtH9vImfx4eR5/tVh5x6uIm0aHeRavhiHgSxV3GPPCQHoCJXKGZvHIuFsEEVFYloSbxJie6LZh/Apje1c4aKB9knkhB+VafhC3eUoT/Y6mJjtyv+w7qh2LnhqVIKBqmjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693196; c=relaxed/simple;
	bh=+/Cv0ZHBto3HRPqOOZId8Rd0G3Aq3YdjDIZeIEWniSY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=td6Zv0BVOl5rsVy0eyUFJQrQwFVCcN7P8QCwPv2WK1ZRNVwzw6y0x99/aq+7LrsFEdMbxlwK7o4EaY/uVVF5MQcQM6DCZ8Hw5rCEzcy1K1S7zizRk9UBzPQQ0StawNDE0sDgINNoqrUda27GwOOOWylKL1vw3Dw/DjBKqxYuHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV0yloEf; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV0yloEf"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4402f7cd5d7so5940101cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jun 2024 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717693194; x=1718297994; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r4LfOtmSKRplqruOsauJIQiEjDMaXsFWz+ZS3gULaMo=;
        b=NV0yloEflLYO7Szl6gM/Cwrk+xeMHI/PaLYHjM1EI2yWvebR1xlVrqVkOKZQe4MDMH
         imvaFmr6fC0Ta6oFKFjHQ3Nk2mdA5+wJa2/Dpt7DW0ITMyx1ugKo3Z26oLdGODD/pG9L
         40IsZ6b7l26O3LddsX1dmYs6k+J0vQogz682t4a9G2XR7UDYkA7kDkprS28fOGzjn0vF
         4WMWP1gjqYQYVfp1xr6VZbB1GyFRyGa6WQIkzboBwz8nVzof9oRWNjrb1Ong1vZ1uecj
         eYQ+D+rkSGRCgkqnCUq8WMwEbTP7EcNgCfHAAa8vRNcP17Bwijepa0eWT1bLECaV5wY4
         JpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717693194; x=1718297994;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4LfOtmSKRplqruOsauJIQiEjDMaXsFWz+ZS3gULaMo=;
        b=qjViURp97YQNsUL/IO/0imwYFDEs8o0RQJMNLELSB5+4lTMa7LQhrXvWPUUnXuDmCd
         9Sj6+REUVmT7hKLmcy6GgqXfhWcybFS9zxXy+0ET6tYRC0WqLouS3Sw4GZSqVHBJIiLM
         tVnxGDBNZC/PEGJSjQQ3DPwh7HYh1ME3exuu+SyY0rlF8W5rjX2ZXmvfJAbv07bMlzpN
         5oVS2vmu826wKcIb0i56MNyz65cRO/LSaJ0gRBVlIjU2wSyH6M2iDlwbc6FNnl9XRakM
         gB+7N/tnsV5NwnEfJCONa4EP/gXbXTGG1iefyh1vgdZ/ZJ10DpO4DP4bEOhBpOuzrYKr
         9vtA==
X-Gm-Message-State: AOJu0YwJhEkzUqMaprvO/BWBqShnN/ZYWJ3pu1YJz/qTpG6RLScExbfC
	V1bhgC3Th++qretc124ppP43PQcjhaIUUQCw4k1ywFWIn0pZ/cFw+LmlQw==
X-Google-Smtp-Source: AGHT+IFIzI3ZSkS83vJ58u5sK45zmcwXtsz2C+sDriCYrE1DnS0b4jsMG1CjAB/gSmSWyOqh5vTxXQ==
X-Received: by 2002:a05:622a:1448:b0:440:287b:348b with SMTP id d75a77b69052e-44041c4d007mr2462721cf.19.1717693193854;
        Thu, 06 Jun 2024 09:59:53 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.130.198])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038a68e55sm5816561cf.24.2024.06.06.09.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:59:53 -0700 (PDT)
Message-ID: <6661eb09.050a0220.f1069.2735@mx.google.com>
Date: Thu, 06 Jun 2024 09:59:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4409274361072127306=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Fix setting of unicast qos interval
In-Reply-To: <20240606162917.621031-1-luiz.dentz@gmail.com>
References: <20240606162917.621031-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4409274361072127306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=859628

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.40 seconds
CheckAllWarning               PASS      32.63 seconds
CheckSparse                   WARNING   37.91 seconds
CheckSmatch                   FAIL      34.94 seconds
BuildKernel32                 PASS      29.17 seconds
TestRunnerSetup               PASS      516.53 seconds
TestRunner_l2cap-tester       PASS      20.15 seconds
TestRunner_iso-tester         FAIL      30.46 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        PASS      109.16 seconds
TestRunner_rfcomm-tester      PASS      8.54 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      7.72 seconds
TestRunner_mesh-tester        PASS      5.81 seconds
TestRunner_smp-tester         PASS      6.70 seconds
TestRunner_userchan-tester    PASS      4.90 seconds
IncrementalBuild              PASS      27.70 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
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
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.181 seconds


---
Regards,
Linux Bluetooth


--===============4409274361072127306==--
