Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3503E13DDA6
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010629; cv=none; b=mSfwq4s2ygiPKqprYa7kaQToRuqlHL+Gu/2N1+XFTIKPI0bhqePq8JrR751oBZSxX02JpKmgfqgPMnh/gz9HU1ZjQNES0oUn4WYb+ClmB1sPJCGy3yNZ7FdIKthLmRV7Hcv+JwKSQJWM/Cf/nLIUXUWgvXtCAl+Wl/RiiX3Lofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010629; c=relaxed/simple;
	bh=e5pSXzhgP+CypEoh24nYrRSR2IKZL+wtEyg/H4D24ms=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iR/XBLFh9n4d9aoXeiEeroqduhX3V/rvUdwcsq4Kc+IeRCfUaKESPdCEFaWnpJ44pxrVfH5jcntPJFhZ8O50DtFAE7a/q2OIahGVHl8bcFbDOhlSQyBY2JKtqnAShpcUrBeCSCO3UDgsYupTH2qh/0wd5dZUy2aHQd+gHaWvT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP6wBA7L; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP6wBA7L"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79d90e01b30so204903585a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720010627; x=1720615427; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1AAlrhiL6Fq4twAzoSEQ7lK2uffDexLdvJBOxYdJzRE=;
        b=GP6wBA7LURlQn36IsMK05K57rEXiScpVOIZmaffE+oYkimX3jajq9sWPUok/IpoBqS
         oi7tf/Wty+kZE2g66qJLJt6DSQGYLDuUhDgohQYB+EqTNu2037h0u6IBNdm5AogMKrm7
         JwKsYrpJZ73g4u2dKvFYj02JKJiWe7IxMOMKv9OcbUC5o5jYzW14QHP63fpsDqpbpOEw
         xxwGoKgPhALK15Nn78xqQxtbKNIUrTXOyI2sEmIXAUca/Rk2IqLZPYKlGrPS9SFlwEqR
         /i6jkJ6mdH4YahRVNu73csPuwHrghf/Tz6ZfDOvrzdgdO7uU4LRIlwPlN12cTGSUkyto
         3Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010627; x=1720615427;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AAlrhiL6Fq4twAzoSEQ7lK2uffDexLdvJBOxYdJzRE=;
        b=bKdysA+V8c3Mbzz+KxHo9ZPCDD9z4slr6TbGjl6NA9h45GEPClbne1xH5/afRDK6ZQ
         Jm5jGiXN4TQC1lW8tE65jqQJoSF8R2m1r4n9zxN0h3iRRr3DsBWP3Z9TFVL6M/pu5VC7
         6Bxkq7zegKgzQANzIVZ+m+av11GFz/8mgZq15blQUptQBpV3A/D+QiWhvjOdXy8bleIQ
         kJ3Zl93/B7bqIlWjm84+DQKPS+Du+YVp8mXEh8W9RMJukyd2CrxxQzQG5ISY5CK6R8k0
         Eho6joAjqpucylMY/GTUuDHXAHN6cNZILJg9IlhoY8x1oSzvNqjCNR//CgFUL5TvDAl8
         nXCw==
X-Gm-Message-State: AOJu0YyyRG1xMEJizNPhEe8kadZ0eDiAYaoyQVtz+Mio/lg84QXq60Zk
	+6MQmiflTDEHJ/PlT0Ni6FAJwlWUWFvKf4VGTiAo4yA+ULTyyeA47AKRDg==
X-Google-Smtp-Source: AGHT+IHZ1iVumUJbbN/7DvRTcQ9o5tIW1f6BkcgriVvTzIJ7RH469/JT7h5/8s44TDYS8c0CUEJriw==
X-Received: by 2002:a05:620a:29c6:b0:79c:a97:96b6 with SMTP id af79cd13be357-79d7ba805b9mr1825177285a.57.1720010626997;
        Wed, 03 Jul 2024 05:43:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.191.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692eac70sm563463285a.81.2024.07.03.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:43:46 -0700 (PDT)
Message-ID: <66854782.050a0220.42ef6.5886@mx.google.com>
Date: Wed, 03 Jul 2024 05:43:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6825172934073006161=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
In-Reply-To: <20240703113936.228226-1-iam@sung-woo.kim>
References: <20240703113936.228226-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6825172934073006161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867987

---Test result---

Test Summary:
CheckPatch                    FAIL      1.02 seconds
GitLint                       FAIL      0.51 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.00 seconds
CheckAllWarning               PASS      32.46 seconds
CheckSparse                   WARNING   38.20 seconds
CheckSmatch                   WARNING   103.78 seconds
BuildKernel32                 PASS      28.89 seconds
TestRunnerSetup               PASS      528.55 seconds
TestRunner_l2cap-tester       PASS      20.29 seconds
TestRunner_iso-tester         PASS      33.14 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        FAIL      115.18 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      15.06 seconds
TestRunner_ioctl-tester       PASS      7.98 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      5.16 seconds
IncrementalBuild              PASS      27.69 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#82: 
CPU: 1 PID: 2000 Comm: kworker/u9:5 Not tainted 6.9.0-ga6bcb805883c-dirty #10

total: 0 errors, 1 warnings, 0 checks, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13722112.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (199>80): "Code: 08 48 89 ef e8 b8 c1 8f fd 48 8b 75 00 e9 96 00 00 00 49 89 c6 48 ba 00 00 00 00 00 fc ff df 4c 8d 60 70 4c 89 e3 48 c1 eb 03 <0f> b6 04 13 84 c0 0f 85 82 06 00 00 41 83 3c 24 02 77 0a e8 bf 78"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_codec.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_codec.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.191 seconds


---
Regards,
Linux Bluetooth


--===============6825172934073006161==--
