Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D41FBB
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 May 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715525820; cv=none; b=aCcAZsqLFZ8xQBcG7DajaFxmabD8G9pSS9S6lTpAl45XdtAooS7vafXywbf9GkENZiEzDjm1i6mrOjYf1ZOBwETUAj06pBBTk4awTV8D9+Femtwu68oTxhFTf+P5UuENTiqQIyTRcodatND/lTXs2YiWFmeMP95dHIncho1kxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715525820; c=relaxed/simple;
	bh=cyK33GgdI9/lBGpsOOAyAdPgZ49ZejHOjk0w8c4f0K0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LL9GwbDt2VFTDPCuEJF86ciQ6dc45/7F8bxD39VmJR496hb0B2bLKrxWgm+c/cSGEIZil3hBrAzeKM68aj/Aq8DRBW6gOB1EIYjeQjixfVtxO0zmjDETHlInKPb0h//pDbwfEUtCLBK39EktHjo18Jh4me/xdZDCI8vM2oTqJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goGodG2C; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goGodG2C"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f0e975f67fso1778667a34.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 May 2024 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715525817; x=1716130617; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ww5YFuKgrbInIDzjIWsQYtbxU3xKfMUAtig20XAunNE=;
        b=goGodG2CLW0ZqH+G62HjHqp8E/01/8m6TYdYKgUjrsFXJg0e0lQId+pEa+tIMIvAZp
         bJ/VDORUNVzt0E4GMKjIzjigwrT1vTQbgV806oP/xHY6F62/Nhh/+mDPseHgB6xjQS/+
         XESI7hoBdbT/tlgpuYWF76FWfeZHQnMBI94PyA4++0cXqQY3yCRnkyKMyaZtOGmxLmo1
         5bjg+zSAsuAxeQl9zsz5uTuvmZQTOy4UDWLlj06mc2aWjK03UGn7EoSWLbYj5EYXticv
         E/x/9nwS0oPL8dO7hf+eEXu/WBD5ZM98kcJnfe1I/tZW4mcWjjFEZ31Boc+BVJvgOqlV
         GxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715525817; x=1716130617;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ww5YFuKgrbInIDzjIWsQYtbxU3xKfMUAtig20XAunNE=;
        b=DqKa0C2MKDnLo6iz3ecKFy//PjHw1xXphX+aXfoLKgXwZeuVTD8vE34KLV5sK73Rx0
         ziMZvavtoyPfBgcpkRZb6JRmf3xLEy6uxyLgUgDJWAGI4KQ952/i1lhye4ca1/iKDC2u
         U+CQFsKrz1xwCUtaIVUyvZqjMDtuTzKsxH0+U4A8Eu1VCZNYSTdvhGuXwapZOuG5r6G9
         Bzq8BQryJ4JU8KMPpi3Jeug5rI1TWZHrJ+WuuGhiqPqocUdC4Zlh7EDXpsw9fNaNSYc4
         jHVZvecGM8UogVnVjvmb7Fn705a55hqGIf5aUjrsH2gnFA2pvSuTnmd6xh3i+7XS7ycH
         vuPQ==
X-Gm-Message-State: AOJu0Yxn19YBDczaYd3k10XK603COX3QhozYXo41usUrh/RqAf2/fWMs
	0OBCgOMwsNhUfNFRtYPWUcJUdrtR2LM3JpeAUkxZGzICbPa3s6vMcDzInotM
X-Google-Smtp-Source: AGHT+IEwH0qHw4rOVsQ6ACEcorPrWmZ5S397XFmR0Uq2riwsyiPE/JJAgUD581pvdADJAgKrE/4RQQ==
X-Received: by 2002:a05:6830:1e8d:b0:6f0:7b5e:2dc7 with SMTP id 46e09a7af769-6f0e90f55e4mr8527625a34.8.1715525817649;
        Sun, 12 May 2024 07:56:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.146.87])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27519esm372284385a.1.2024.05.12.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 07:56:57 -0700 (PDT)
Message-ID: <6640d8b9.050a0220.3a02e.b1dd@mx.google.com>
Date: Sun, 12 May 2024 07:56:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0930752575358843580=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, erick.archer@outlook.com
Subject: RE: Bluetooth: hci_core: Prefer struct_size over open coded arithmetic
In-Reply-To: <AS8PR02MB7237ECD397BDB7F529ADC7468BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237ECD397BDB7F529ADC7468BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0930752575358843580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852655

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       FAIL      0.49 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.77 seconds
CheckAllWarning               PASS      32.45 seconds
CheckSparse                   PASS      39.05 seconds
CheckSmatch                   FAIL      34.54 seconds
BuildKernel32                 PASS      29.03 seconds
TestRunnerSetup               PASS      520.38 seconds
TestRunner_l2cap-tester       PASS      20.58 seconds
TestRunner_iso-tester         FAIL      33.47 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        PASS      110.56 seconds
TestRunner_rfcomm-tester      PASS      7.28 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.65 seconds
TestRunner_mesh-tester        PASS      5.77 seconds
TestRunner_smp-tester         PASS      6.71 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      28.07 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_core: Prefer struct_size over open coded arithmetic

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	[...]"
11: B3 Line contains hard tab characters (\t): "	struct hci_dev_req dev_req[];	/* hci_dev_req structures */"
37: B1 Line exceeds max length (117>80): "Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]"
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
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.230 seconds


---
Regards,
Linux Bluetooth


--===============0930752575358843580==--
