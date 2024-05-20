Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C301B974
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716195492; cv=none; b=XsCLw6a4uTzbZ2TtNcHcMd/Ny3tEm/CvpazqebTgZ+gOTSXpUflyJgupqTAA35+iIr7hd/xRs5Xm+ojbvEw7ummRLqwg7A+mtmuGIjpqhnnx+hxKsieSfD+/CjLP7tmA83AWU7WbV4WJ3SF+dpd7omrbXvYIdoDokFDNxeLCqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716195492; c=relaxed/simple;
	bh=81cw5ZUWGn7m/GAw+ocKB2kpWOja2JNC56gFpxwA/Is=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lUypIluE2JaObqPvh5j8RDbGxkA36ZspEq+IjLvfPh+bgL8Rhpu+KkK576k3pSSIorG5pCfzPKBquwvsAnh2dYV69OyeQuy225KUE+d5sPnySB/kHHjIDp4Np0VuoozWQX87QAUt6Jcejkga5DHxZ6D5RiGoLWDqiZZY3NkK1Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1iqy9Vs; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1iqy9Vs"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-792b934de39so210295185a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716195490; x=1716800290; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=34EFg5B2rDl8awm5bzhLpzVdXaJKrOBTw7RYlaTzRdQ=;
        b=k1iqy9VsLLodyE0IL1GWZUAAb0w8f5YrgsBws3J7Kh4JqspbIDDprwa2mFEioq5QTK
         +xluW6iewTE/KL8vfgNEF8PMD31oUK68V5ibcULYvn+wdqruHxINxByISOrKCn2S9ITB
         cZkc8ob8dHxhsmH3NzfNnCTPnKtyzqtdg9ENR/o0qTd4kqBHJyYIiv6SWr5rbBTpZ2Vx
         yXZxclMOTH/Qpa6gGOXgTxL4kBFb0D4R+UOhc1d3JC5JVFOuqZJNvQvf4tlTDcXtgTOh
         UnnRPUYhnZsUoE0nHa3LRdKZjyEOp2PGFMBaeYhmqsoeYveKvpXP3QRL6pEB6J4/uMSD
         GSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716195490; x=1716800290;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34EFg5B2rDl8awm5bzhLpzVdXaJKrOBTw7RYlaTzRdQ=;
        b=YNoc/5W9E/uJ7ZUgeIF6JVXHEuL2WQ4Z9Uot59Yi8pTnJFkhcvOwYTis3Dqw++Om+9
         5cyV/osbN/yT3CKIublvmQBGseK3gxFXzGJKg7gR1DQTkPGyXQHCz6n4/UpJhC/rxmp8
         zNooW1R8RxgX6IrkR/Zw2QyoIswYpoj9X4Mo8C2kx9RpgqfTEbPjXt4CnWMGNUHchiiF
         5RZmh7w+sT9ffHvlmAlrMRCJyNktHnQxpI3PyDfXX0bqD3Z5dDr2FkFsvUyS8pJbJed7
         pUVO8vX0xDgw6iFfLh2WhhmIQMYl+Cdsj/r9bBIcCgvT0VP1+0Jh4qt8oGAN684GzlKj
         IIWA==
X-Gm-Message-State: AOJu0YxKa6ihqutOAqKPuI/08hSKciDELEwnMioX6cb1rEgPPomi2Vt7
	3WRagtXAJbhK1m1q12SOpWZpqbBZiFKtTtIxyRln4czc/kJz1IYNmiKxsw==
X-Google-Smtp-Source: AGHT+IEPZTvNFEZh5VtVaI/te7ku1cYQyz5NprSUuyPLVrXS5u0pjQCWfIzvlfds4oX00nscsmchCg==
X-Received: by 2002:a05:6214:449d:b0:6a9:9a62:d18e with SMTP id 6a1803df08f44-6a99a62d1a1mr38160156d6.16.1716195489771;
        Mon, 20 May 2024 01:58:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.84.127.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a8c2d39d7esm19872396d6.95.2024.05.20.01.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 01:58:09 -0700 (PDT)
Message-ID: <664b10a1.0c0a0220.f0d0c.3e80@mx.google.com>
Date: Mon, 20 May 2024 01:58:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0213413414912095597=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Nobuaki.Tsunashima@infineon.com
Subject: RE: [v2] Patch for CYW4373 hci up fail issue
In-Reply-To: <016dd2b28cd5435ba6f13b01d4da0d44@infineon.com>
References: <016dd2b28cd5435ba6f13b01d4da0d44@infineon.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0213413414912095597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854351

---Test result---

Test Summary:
CheckPatch                    FAIL      1.29 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 FAIL      0.35 seconds
BuildKernel                   PASS      31.19 seconds
CheckAllWarning               PASS      34.29 seconds
CheckSparse                   PASS      39.28 seconds
CheckSmatch                   FAIL      36.39 seconds
BuildKernel32                 PASS      29.13 seconds
TestRunnerSetup               PASS      534.76 seconds
TestRunner_l2cap-tester       PASS      18.82 seconds
TestRunner_iso-tester         FAIL      33.51 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        FAIL      110.56 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      15.07 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        PASS      6.02 seconds
TestRunner_smp-tester         PASS      7.20 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      28.38 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Patch for CYW4373 hci up fail issue
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#80: 
CYW4373 ROM FW has an issue that it claims LE_Read_Transmit_Power command as supported in a response

ERROR: trailing whitespace
#116: FILE: drivers/bluetooth/btbcm.c:452:
+^Iconst struct bcm_chip_version_table *entry = $

WARNING: line length of 107 exceeds 100 columns
#117: FILE: drivers/bluetooth/btbcm.c:453:
+							&disable_broken_read_transmit_power_by_chip_ver[0];

ERROR: that open brace { should be on the previous line
#119: FILE: drivers/bluetooth/btbcm.c:455:
+	for (i = 0 ; i < table_size ; i++, entry++)
+	{

WARNING: From:/Signed-off-by: email name mismatch: 'From: Nobuaki.Tsunashima@infineon.com' != 'Signed-off-by: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>'

total: 2 errors, 3 warnings, 60 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13668129.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Patch for CYW4373 hci up fail issue

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
3: B1 Line exceeds max length (100>80): "CYW4373 ROM FW has an issue that it claims LE_Read_Transmit_Power command as supported in a response"
4: B1 Line exceeds max length (91>80): "of Read_Local_Supported_Command command but rejects the LE_Read_Transmit_Power command with"
7: B1 Line exceeds max length (110>80): "Especially in USB i/f case, it would be difficult to download patch FW that includes Its fix unless hci is up."
8: B1 Line exceeds max length (99>80): "The patch forces the driver to skip LE_Read_Transmit_Power Command when it detects CYW4373 with ROM"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
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
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.239 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.734 seconds


---
Regards,
Linux Bluetooth


--===============0213413414912095597==--
