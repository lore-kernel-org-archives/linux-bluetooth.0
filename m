Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA09C3AC01
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941984; cv=none; b=PQctt9tHRpOiKkyss1pCpONV7yEJPUxFEJ2q4FHyyQ+J8p2GVFKVB0xjJ10pgpV978jQZOiym7TDBSuc+HndTqgxsuAXNLa/MQeUJc2varOJzlgORZ4RyYSoTcCAtyYjtN2NkW4hjYBY8fVVGqcnQOrgl2eKgS97BmfUYCcXURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941984; c=relaxed/simple;
	bh=leWP96vQjC1baKz049wawtLDLt1gMq81V6PrNm6ys+Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZXmQwJb4DKkFnCm2JCwKZkB3noyr5FykjvEUHst/98aUKHnlJGpUq7LnOAj9DqkmYnA+cQAAfbH2x4/FzBBvydgnlHScrL+8xX/six7zp0boMNfcFUVaWjqptt1J/q7EU86xMbrslV1p8m0R+EEKQDwHhvibgGHh566qkBUxRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3dkvQ0I; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3dkvQ0I"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6a3652a740aso2252286d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715941981; x=1716546781; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M4Qmaf1pqzfdU73Xp8G+HfIkiBjKQ1nAsZeMKPocQUw=;
        b=j3dkvQ0IJTvy8C7qiMHLh0uCcgCK4AITxmWodl7NZnydW+8AVp43S469dlWqah2WSj
         3NrWEllkxxgxLNOYOVN2lPJLCD24sgEXa+Y3uvd7lCpSdX1CYOJfH4OY01xryTIqUn1q
         a8p08EHkZdPVNw+uxDoERwcFSEe/aXF3dns5/Il4uBaM0EgFpQOZ15nV0Sx1a3vk/KVD
         9Y+WM+qwLbB8f6134huultz6k36U1QMn5sxb33G6PVEAJ4rtvXboD/swV4yUjNW6wqAl
         CGYXQCiOvnIh4ZqqetCfzktb7A2VnDzsJejL8bBN6p2sdc7vRvYgyuctb4tZVvYHn1+1
         l4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715941981; x=1716546781;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4Qmaf1pqzfdU73Xp8G+HfIkiBjKQ1nAsZeMKPocQUw=;
        b=Y72N6v/R4Cd30b3r0loTbgVV8HKc9I99eBUb2T/E6q4vijSr2CE8taMNhcn86i5TOg
         D4p34zg7quCIZtBse7jPkA9VSUKpdVRQ9cHzm7vCtIVBykcu5ajPvDp+Mf/CrrNgvpvF
         ojX3EWDFtDuGF9doUfrS+p30p0gUTMKwTrcO9OcqFyRaaiT9/7YCR5tGo2PVbfZmW69r
         FV1aKwP11wSmGKjiIPTwjIDfm3oJXxQG/8wE/qbizpQGiAR925SDVBlNXnAcLdUKOidr
         p/8oDUQhto1ADiA7K8aIz6QWPEOfLfWJmKU1iQO1MKzInlWO8x+Y59RJnT5nDY5VHchP
         VoaQ==
X-Gm-Message-State: AOJu0YzoYAQcJc6mo+qPolYO6SsueSqLwO+LvxqWXhmA5CQjxj8QVm02
	w6ALPHI+cjvprOTm+r76Y4nwfBKTObBRe7iVk2S4z4e8XuJoRA0iFbuC8Q==
X-Google-Smtp-Source: AGHT+IFviHt8R4zyHfWG5a7ttHEXVSc1quU+LtQeT9zT7D2ugnNw2E2VpORu70cWAK1nSxY9HN2ryA==
X-Received: by 2002:a05:6214:540e:b0:69b:6a3a:c673 with SMTP id 6a1803df08f44-6a168216c61mr245146266d6.32.1715941981514;
        Fri, 17 May 2024 03:33:01 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.51.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd3aasm84774256d6.84.2024.05.17.03.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:33:01 -0700 (PDT)
Message-ID: <6647325d.0c0a0220.57cff.c744@mx.google.com>
Date: Fri, 17 May 2024 03:33:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2440541694241636440=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer information
In-Reply-To: <20240517095447.956132-1-kiran.k@intel.com>
References: <20240517095447.956132-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2440541694241636440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853931

---Test result---

Test Summary:
CheckPatch                    FAIL      2.39 seconds
GitLint                       FAIL      1.10 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      29.56 seconds
CheckAllWarning               PASS      32.55 seconds
CheckSparse                   PASS      39.25 seconds
CheckSmatch                   FAIL      34.92 seconds
BuildKernel32                 PASS      28.64 seconds
TestRunnerSetup               PASS      521.07 seconds
TestRunner_l2cap-tester       PASS      18.43 seconds
TestRunner_iso-tester         PASS      32.71 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      109.65 seconds
TestRunner_rfcomm-tester      PASS      7.21 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      7.85 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      37.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer information
WARNING: From:/Signed-off-by: email name mismatch: 'From: Kiran K <kiran.k@intel.com>' != 'Signed-off-by: Kiran <kiran.k@intel.com>'

total: 0 errors, 1 warnings, 41 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13666800.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v3,2/3] Bluetooth: btintel_pcie: Fix irq leak
WARNING: From:/Signed-off-by: email name mismatch: 'From: Kiran K <kiran.k@intel.com>' != 'Signed-off-by: Kiran <kiran.k@intel.com>'

total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13666801.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer information

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B1 Line exceeds max length (83>80): "[ 5335.695918] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0190-0291.ddc"
16: B1 Line exceeds max length (82>80): "[ 5335.697837] Bluetooth: hci0: Firmware timestamp 2024.20 buildtype 0 build 62871"
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


--===============2440541694241636440==--
