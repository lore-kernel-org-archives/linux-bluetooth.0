Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35A3F8D1
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557397; cv=none; b=BqEYfHWjMmXO1LWiaBOyksbBzAZn9BP34GiMzhNqQz7ewytXl44dIGZjpXvHtas9HWUc53VBX4DJNcLOy//OsrPWjhiZWAzqLNEn3Mln3lv2vytplmY4AdA1eZhrrdCGkdyijawOPccj075WAmKf15E/BIMmvGNk1eLJD/GyFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557397; c=relaxed/simple;
	bh=dsPWx2eavqi0WMPLyqnWXfro1BSQBh1PhGhzmqhpo0o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mYx30ovmtu7T5nzy7WXNI0OVfll2aUmYKAPzifL0Vk3qH0nZnGm8v8gydU8cmIxxZil+ysCHekDX2ekfpI6+qUHxdqO7QgRKua8nbNZrn7uh6hgRfffWT/XDZL35GXT6HN35HJ7VPasUa76EO7YKdvOJaX2MfdsuiettUCciFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUtEuwKv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUtEuwKv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e65a1370b7so62092415ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714557395; x=1715162195; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cHKa+PO5FYG/aT0WC95Jk1JlbztIflfkK1iUxMgTE8Q=;
        b=FUtEuwKvyWGTA9cpUHJRdo3X04NkAhKutXFyBhM9BmGnfsvs31Fwi4V6U17rnBnA91
         Pul5sRSliruF4yiGrTCwPZmSk46WsKhgJAmBrXuCjoLo0+BnW3C6xBx+zVIAJwrcHMuS
         gVtLZ5fmyHVHA81UUqywBKMMAO2LjtVoUGvIJ1I0wRv62iIsp4x1uuJsLTVU3nIbPt4e
         6p3P6RCZigkHhZ5xKpuEB1YhDKUOToMBOOmq8/ys5GlDp2or+im/L+xq559atSPrIK6Y
         0ekJY5RNsW6zQ9iEBosO9+H0K19U2953EbX+fW4Cb3Mf1oFh9d+DLnhWw5cJIQQmfVbn
         kenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714557395; x=1715162195;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHKa+PO5FYG/aT0WC95Jk1JlbztIflfkK1iUxMgTE8Q=;
        b=qwvH5uWrRTkn1mzhTWhQUVxqOtK0vwIUynOQfw5IUEGB9hRnBPj/9r6s/UGrhTbHqs
         yWySajLSB0LDQ2zEZCSbCvmsMcPBFVAcBbvBSr4aq3dPuePd1l3Q9T95YzHHrkEVTQ5X
         k3K3n3JiiiuvAv3BZjaOVWc9oSRjN3ylX9TV2rSLWsPi85/W8qPhc7o40Yglt5C7NRMo
         CVqDBKTIbWyBZGMHsWiJ5NIqwZP45abyTJR1fhjaoWufn3U3c24g1ys8pOvOT1XXzeTa
         ZQK9YLUECNyRpqr9m3SdjLxa18qAgRdmpm9urN47Pd3c2R6NNrSBU4LFZlPB6tmgSNb5
         aeXw==
X-Gm-Message-State: AOJu0YyNv/L7R7b85/ei1B18CgRplHbIySUQpnl2yAXhQZYqHReyl2Ye
	lxo+6iri8rMQRrQs4a+U7UzV8g0S0yELqS+I9sLz3mm+tY60wsTqroGXLA==
X-Google-Smtp-Source: AGHT+IF4AEFDj5W2Or0FWb76uE6SxQMQvFnKeOYwWLqq5t3W+ieglsZoUDUCnZPpTY13CahrH0kX1A==
X-Received: by 2002:a17:902:d2ce:b0:1eb:85d:8973 with SMTP id n14-20020a170902d2ce00b001eb085d8973mr2650920plc.58.1714557395085;
        Wed, 01 May 2024 02:56:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.4.138])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b001eb51a43562sm7944267plh.185.2024.05.01.02.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 02:56:34 -0700 (PDT)
Message-ID: <663211d2.170a0220.53812.c2ed@mx.google.com>
Date: Wed, 01 May 2024 02:56:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4981838568342658324=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [v7] Bluetooth: compute LE flow credits based on recvbuf space
In-Reply-To: <20240501092053.72045-1-surban@surban.net>
References: <20240501092053.72045-1-surban@surban.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4981838568342658324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849598

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.07 seconds
CheckAllWarning               PASS      32.72 seconds
CheckSparse                   PASS      38.31 seconds
CheckSmatch                   FAIL      36.46 seconds
BuildKernel32                 PASS      28.97 seconds
TestRunnerSetup               PASS      523.54 seconds
TestRunner_l2cap-tester       PASS      18.40 seconds
TestRunner_iso-tester         FAIL      35.39 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        PASS      113.33 seconds
TestRunner_rfcomm-tester      PASS      7.29 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      7.69 seconds
TestRunner_mesh-tester        PASS      5.82 seconds
TestRunner_smp-tester         PASS      6.78 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      27.86 seconds

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
ISO Connect Suspend - Success                        Failed       4.169 seconds


---
Regards,
Linux Bluetooth


--===============4981838568342658324==--
