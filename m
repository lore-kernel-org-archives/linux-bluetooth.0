Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D72AE75
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718331644; cv=none; b=qds9DWFl+BDSoQnzHd/NXGs1yDCKAgspvJeiGBhZYSwjLTCpTUJuQLA0SNtKK2m2f5zBLgK2EOHAIuPpsTykH2HF7WjHPsz1v/Zd1DNzKCWJWl5LiRM0xWMuOLXYrmevWMnWw2VOkuNTU93+Ah1f0D0p1zfbPN0lTVKkUoa1nVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718331644; c=relaxed/simple;
	bh=DmlNfIMvE0u1cmeXM+p2mTMfBeAKgMO/YPHLOedZB4I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZN6+km8WupWsYysWqYW/QGPE+k/bJ9LInjHb27lCcjBQ4R/SGP/NF0b411/03/XpxwGNskyqtQTpTDsK2r6JXQOiwGhyvvJPdvhaQgGt0BnM1inroKgINoja/aDjoK07Qbu6VIR2/CVYCk6DHcWEvsKMbKL6caa4KGf9+UzNQAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrGu71J9; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrGu71J9"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7955841fddaso154459185a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jun 2024 19:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718331642; x=1718936442; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pTRU4CiM6WQ85Os65AclN8baIrnupT3yTpfB88gAOJo=;
        b=NrGu71J9W5086C0pfS73Klzn8/r7wH9kZSt3oZTwsxL1CP2u246kVoPdq/jCyQFgPY
         2xHESwDhbT8jenQvlkqi7DGy50srzgGaos9yjHh9lPjO/bu8dwcFFdW3CWsw/XU9vowp
         C73VwiKUvHaRcbNwahJhBBdwGYWOVxu2otgsiLCzqrs1mJ4jZMzc3CPC2a+RltuD3tZ8
         aVh8hj9m1aFxRe8s7Li+TawP2+dLRocHiZT1b45Zm4E3AXK6dKyocO4Y6aKrOit5KA42
         wC2tQnUTIODPlBhWNNv8Xsk5qliK5v2FDIZLl8N8BSoj86igTCywRSkLR62tiIIENEAy
         PeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718331642; x=1718936442;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTRU4CiM6WQ85Os65AclN8baIrnupT3yTpfB88gAOJo=;
        b=Ww6T3Uxtt/BAyaulXps4hrL6UVsqWGZ3t3MpIMI5+RMCKBPVwgnSA0pJ2zyzOHRUG9
         D7OVuf2nBgos8sQQCOrqHwiDY3dem5aKktwJTM75FMsSTnIVDKty3oM7k3rZB321sEn+
         dkmAYd7NaRrVshY2OUUT3gM6rNFshxBWo86paFNq3ocQFamzVrvPmBpQMyEAtw0enAbb
         qYBVAyDiMM0nrZ3Z1RWdqkwufB8cLD3PXY25i9Ebjxrtvz0uNklBk3Btpnzcs6qFjBpy
         5sXMKBhFhmv2oVGJsUleEJc+EI5cqoBlj83E9DlOj/JJ0QBsEAHqDP90v32KEGn10Jvk
         EEtQ==
X-Gm-Message-State: AOJu0YzfIOBRrwhziIx/jvqJQHFAp+r1rmV50WokjP+0P5tVQDCCYsyc
	8q1npZXuP3bbUwCzBzf0sR1RUGpNUFpfqs32urgTmpNFScs+eK74gG/q8g==
X-Google-Smtp-Source: AGHT+IF62fdZ6m0/Hy5JhNdOsNwg1VY361wUlVBJNe/u+knRdux8EA4BITnekhC4j3PvcadKxVNh0g==
X-Received: by 2002:a05:620a:4405:b0:795:494f:f6e3 with SMTP id af79cd13be357-798d02245admr251090185a.12.1718331641714;
        Thu, 13 Jun 2024 19:20:41 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc02df5sm102393685a.98.2024.06.13.19.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 19:20:41 -0700 (PDT)
Message-ID: <666ba8f9.050a0220.90ff3.41ed@mx.google.com>
Date: Thu, 13 Jun 2024 19:20:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4377673608432700541=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, stern@rowland.harvard.edu
Subject: RE: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages
In-Reply-To: <29855215-52f5-4385-b058-91f42c2bee18@rowland.harvard.edu>
References: <29855215-52f5-4385-b058-91f42c2bee18@rowland.harvard.edu>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4377673608432700541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=861868

---Test result---

Test Summary:
CheckPatch                    FAIL      0.86 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 FAIL      0.33 seconds
BuildKernel                   PASS      30.26 seconds
CheckAllWarning               PASS      32.87 seconds
CheckSparse                   PASS      38.68 seconds
CheckSmatch                   PASS      104.83 seconds
BuildKernel32                 PASS      29.43 seconds
TestRunnerSetup               PASS      532.86 seconds
TestRunner_l2cap-tester       PASS      20.45 seconds
TestRunner_iso-tester         PASS      32.76 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      113.51 seconds
TestRunner_rfcomm-tester      PASS      7.43 seconds
TestRunner_sco-tester         PASS      13.04 seconds
TestRunner_ioctl-tester       PASS      7.91 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      6.99 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
IncrementalBuild              PASS      28.37 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#66: 
hardirqs last  enabled at (73095): [<ffff80008037bc00>] console_emit_next_record kernel/printk/printk.c:2935 [inline]

WARNING: Possible repeated word: 'Google'
#74: 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024

WARNING: Prefer using '"%s...", __func__' to using 'wdm_int_callback', this function's name, in a string
#117: FILE: drivers/usb/class/cdc-wdm.c:276:
+		dev_err_ratelimited(&desc->intf->dev, "wdm_int_callback - %d bytes\n",

total: 0 errors, 3 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13697702.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B3 Line contains hard tab characters (\t): "	#1:  98% system,	  0% softirq,	  3% hardirq,	  0% idle"
14: B3 Line contains hard tab characters (\t): "	#2:  98% system,	  0% softirq,	  3% hardirq,	  0% idle"
15: B3 Line contains hard tab characters (\t): "	#3:  98% system,	  0% softirq,	  3% hardirq,	  0% idle"
16: B3 Line contains hard tab characters (\t): "	#4:  98% system,	  0% softirq,	  3% hardirq,	  0% idle"
17: B3 Line contains hard tab characters (\t): "	#5:  98% system,	  1% softirq,	  3% hardirq,	  0% idle"
20: B1 Line exceeds max length (117>80): "hardirqs last  enabled at (73095): [<ffff80008037bc00>] console_emit_next_record kernel/printk/printk.c:2935 [inline]"
21: B1 Line exceeds max length (113>80): "hardirqs last  enabled at (73095): [<ffff80008037bc00>] console_flush_all+0x650/0xb74 kernel/printk/printk.c:2994"
22: B1 Line exceeds max length (111>80): "hardirqs last disabled at (73096): [<ffff80008af10b00>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]"
23: B1 Line exceeds max length (116>80): "hardirqs last disabled at (73096): [<ffff80008af10b00>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551"
24: B1 Line exceeds max length (104>80): "softirqs last  enabled at (73048): [<ffff8000801ea530>] softirq_handle_end kernel/softirq.c:400 [inline]"
25: B1 Line exceeds max length (104>80): "softirqs last  enabled at (73048): [<ffff8000801ea530>] handle_softirqs+0xa60/0xc34 kernel/softirq.c:582"
26: B1 Line exceeds max length (99>80): "softirqs last disabled at (73043): [<ffff800080020de8>] __do_softirq+0x14/0x20 kernel/softirq.c:588"
27: B1 Line exceeds max length (105>80): "CPU: 0 PID: 6625 Comm: syz-executor782 Tainted: G        W          6.10.0-rc2-syzkaller-g8867bbd4a056 #0"
28: B1 Line exceeds max length (89>80): "Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024"
43: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/linux-usb/00000000000073d54b061a6a1c65@google.com/"
45: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/linux-usb/000000000000f45085061aa9b37e@google.com/"
46: B1 Line exceeds max length (97>80): "Link: https://lore.kernel.org/linux-usb/40dfa45b-5f21-4eef-a8c1-51a2f320e267@rowland.harvard.edu/"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.194 seconds


---
Regards,
Linux Bluetooth


--===============4377673608432700541==--
