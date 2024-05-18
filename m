Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E2101C5
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 May 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716022624; cv=none; b=njWJEh/PNXHbRVxs2duyKFa+WHWM6Gyr8rJ0WcKDFG8jiMASiUwitKIQ1oTCLe3Lql1EyrmyjL5rrOg7WLusmj+sJGjbXW8yDeW0tqRtjN+vLJ6N8eE5hZnFMyzxKJ3i23H0JxK1AbJ5Kg414vfiMbE1KtkkDglkjeljniuScE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716022624; c=relaxed/simple;
	bh=fbGIk3dz1BnR+sYmoRToXkknj1pTdZrjcANuu8VqZOs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=enNN4QIMg8jyxFHTLUBWAFPtHRYKsPhLF+eoffTBtzL8qcwhnFw+FxArabo01EzxCbZZaKGzUT3jLYUm1459ey1HX5Kyz5rXjgevP7qqN8j+2tCAjcxB75IJ/10ZkDyRowGHpLRUxJKQ+3r/zLs4Z6pmKm1wMuqm4XmXiobAU64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC+yZnYb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC+yZnYb"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f0537e39b3so30453615ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 May 2024 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716022622; x=1716627422; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2yyvV0vjPOovnrulTd8gPM4NQHsJksn5xh/CnHZcjcY=;
        b=VC+yZnYbFbMekUqnEd2BWWLMwkjXWJ8u4VMRhQ5L6hjLL8LrrAA0A6a0CGJTrCXgNb
         aebDYOH+VX6A8J01HzKx3A9YPrkKzzsY4eSCqR+dhZcMrHa/L6PBiarIhFdsjtxLFShX
         U2BkvTK6Tp+rxbzoza2elpFvB8kJ2B31VWiMivwIxBylCFdJjl4nLkC82sghfUhw9yaU
         AxxieezU315DkzdOSG76DgavwWHIqBkGjKTWYMS11NtA/Zuip1XRgzVaZnX86g3/YMiv
         KDPQUTWDsxG7X8q5w68B6NWHT+j+uD3Mv647EGJ3smZhA+44Tm1a2HoRSo0KKZRrj0TV
         iYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716022622; x=1716627422;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yyvV0vjPOovnrulTd8gPM4NQHsJksn5xh/CnHZcjcY=;
        b=JyvGiXZTjIgjGKcMloR4exxBSfuhVOGqlXkWfV41dPkPpovu/ioZQmzs6uWMzyAmlE
         87RzQsQRIYzrdUNKwSHmPFpddhbba5jAZDegSJfwRJFn6RW+qZE9hhU1apUiE3j/rASl
         D3lEV3YxlYwYFdp/zZKZ52woecH8Kpxib+us9wEh+VFCPgR5mP0MTiOPRBQCWnUoSk6W
         PaQpodz4ftSG2KgowNfk3ZIHPk8s2ePOEGl9emFYjY8q9RPUMXFdljSJcChk/na2kHjy
         0hkITdM7JUZWnB0PijlcKXCAg7iOTLTDrKXAIA3VHZ6MYhyOdCaWOaCkPoskKFgF8TMC
         vIrg==
X-Gm-Message-State: AOJu0Yx1uv7Cc6XlQKTyXdsWpxC/k1yFbHIvwziM1x8D2lqomjUf2TA/
	xPWkmJHLBpKXKAn1xQBZRIeO896E+uZov/hKs+HyMO4ZQ0eAkOuLM9Wujw==
X-Google-Smtp-Source: AGHT+IFvCKhhp5NSxUr93k9exfbvb1fw13AIMBpSpo9jZn8+hYv9kydJ4I/7+HJcerLuIEhwgChbdw==
X-Received: by 2002:a17:90b:185:b0:2b6:c4d7:fbf9 with SMTP id 98e67ed59e1d1-2b6cc758aa9mr19579196a91.13.1716022622045;
        Sat, 18 May 2024 01:57:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.7.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b6711660fdsm16745828a91.16.2024.05.18.01.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 01:57:01 -0700 (PDT)
Message-ID: <66486d5d.170a0220.9fc2f.ad83@mx.google.com>
Date: Sat, 18 May 2024 01:57:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4915839975433500951=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, erick.archer@outlook.com
Subject: RE: Bluetooth: hci_core: Refactor hci_get_dev_list() function
In-Reply-To: <AS8PR02MB723788E9DB59D20465408A0C8BEF2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB723788E9DB59D20465408A0C8BEF2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4915839975433500951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854158

---Test result---

Test Summary:
CheckPatch                    PASS      1.23 seconds
GitLint                       FAIL      0.70 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      29.48 seconds
CheckAllWarning               PASS      32.68 seconds
CheckSparse                   PASS      37.85 seconds
CheckSmatch                   FAIL      34.73 seconds
BuildKernel32                 PASS      28.71 seconds
TestRunnerSetup               PASS      519.57 seconds
TestRunner_l2cap-tester       PASS      18.15 seconds
TestRunner_iso-tester         PASS      30.18 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        PASS      108.74 seconds
TestRunner_rfcomm-tester      PASS      7.22 seconds
TestRunner_sco-tester         PASS      14.84 seconds
TestRunner_ioctl-tester       PASS      7.72 seconds
TestRunner_mesh-tester        PASS      5.77 seconds
TestRunner_smp-tester         PASS      6.76 seconds
TestRunner_userchan-tester    PASS      4.85 seconds
IncrementalBuild              PASS      33.18 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: hci_core: Prefer struct_size over open coded arithmetic

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	[...]"
11: B3 Line contains hard tab characters (\t): "	struct hci_dev_req dev_req[];	/* hci_dev_req structures */"
36: B1 Line exceeds max length (117>80): "Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]"
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


---
Regards,
Linux Bluetooth


--===============4915839975433500951==--
