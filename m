Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD520882B
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428874; cv=none; b=rd8ZX03z7gPTd+W5/Y6xckPtgQ27Ny3FD+crRpvvl+W994pFeRPrFDMZCElo7kvqXtnbNoPaA/rk4dx+QBNiUQ9W2BdQWSA8c/muGV0RGJYCKpx7kwq3Z0B3V1ieRp9NPEii1nE4g0wZXt9sRk45DJNiIcM9NITypDCChD32O98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428874; c=relaxed/simple;
	bh=UJppz/OvgW6UKAsNuhaO5MxLndHb0iaImF5KflyX8wY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Zo2cp3zlGW3K9JjlPnS8vDvlSfNsMDyg3YQCSHsRJ+S7L0Qo7M57fhojQArAnJtjIoxAS9epkmEXi7fUevfwVaEqUy1w2/+tzwPZcKcVfXjWJcsIIQSJqg3Zv6JbtUupIBQon1wjnEdKpMd5N3Gik8Tog1wJ5czAiVe/jSAAru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqelwwV1; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqelwwV1"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d1e17dd278so1915443b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2024 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717428872; x=1718033672; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bNxIzVrfita4lJwqyiScC1x+ImAYFOWCnPoWL+w0vRM=;
        b=JqelwwV17fd8lHJq5JeKZayeLcfFRO4Ri7FoeUvZfT3U9Dy0A6UKov8aa8mkkqePzV
         CUBiayPvYzfp4kMPKFh5QIFVOJUbYkLfBGsQcv2FGx9uVpPEK+jfBSx7ZBdN2Rk1Y8fi
         SdkjzFK2qKYBEIJdjmDygo4bg9AKVVB38cXvx6yZTG3KLvMpZ6XhCYA46XUeqZWwbXg1
         zFlX/UjNTFBwh+DScGlbe/T6cjGOUTBVf9FoY+WGrS1AGWQd+MqAaai2Aaz7T5b27qid
         IdG62e1zQlp8s6+yrnVG/0Leeq1vjwpiiMjn+o53+B9vpRUhk0PphkCZN4EW1vQI8fx9
         iKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717428872; x=1718033672;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNxIzVrfita4lJwqyiScC1x+ImAYFOWCnPoWL+w0vRM=;
        b=dvqBb8NXywU/GIjuynGnyHfeyk6PFhw7n1/vUyQvp/S+EhSm40RerFl2B2twv6WKwD
         vdFf8NDf9aQlnuRy/qf7+IV1716CD+IGKz8JppYZU6AgS8Zc3N/5/fZ1nX68gqV1y8gH
         ZcLCtyioV9ELOjCdMpGHEaCCBMU/Da33r31fCtTMd6aqz4mK0byZqFTbOyrSXqNppP4y
         4LAHD4BKU3xtwjO8quDNB/92NMgrcMhXIp+Bw4SV93eCe35Jes2jc7CNludIKh6ouiyY
         AWjfcxY958Iue3CWaMrbJtzAu2yoha9zyqkcqrkw8M4G2BHs1f3J3lfJbwMtaL7dgZKk
         OM3g==
X-Gm-Message-State: AOJu0YzOVE+82Sn4YbnmPPMI83VryDHRpI340Z1lG9INK2wv/9j4t4N4
	qLkKZVXAF/1eV+RfpAF6n+vY0nSJlyrQAVPHkLemi5OXf26LIeRbZMHp0A==
X-Google-Smtp-Source: AGHT+IFV00SrDGrKHIBm7NrawhH3Vgzxcwey0T29DicaOaPPg3UPad59jLNJuyxU45Ypv2Jx9sKg+w==
X-Received: by 2002:a05:6808:481:b0:3d1:d0ee:8635 with SMTP id 5614622812f47-3d1e34a6898mr9273234b6e.32.1717428869935;
        Mon, 03 Jun 2024 08:34:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afba632e2bsm13555846d6.117.2024.06.03.08.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 08:34:29 -0700 (PDT)
Message-ID: <665de285.050a0220.b074e.4412@mx.google.com>
Date: Mon, 03 Jun 2024 08:34:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4057854469398163378=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andreas@kemnade.info
Subject: RE: bluetooth/gnss: GNSS support for TiWi chips
In-Reply-To: <20240603144400.2195564-2-andreas@kemnade.info>
References: <20240603144400.2195564-2-andreas@kemnade.info>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4057854469398163378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=858321

---Test result---

Test Summary:
CheckPatch                    FAIL      4.08 seconds
GitLint                       FAIL      1.54 seconds
SubjectPrefix                 FAIL      0.72 seconds
BuildKernel                   PASS      29.90 seconds
CheckAllWarning               PASS      32.84 seconds
CheckSparse                   PASS      38.35 seconds
CheckSmatch                   FAIL      34.96 seconds
BuildKernel32                 PASS      28.90 seconds
TestRunnerSetup               PASS      523.03 seconds
TestRunner_l2cap-tester       PASS      18.24 seconds
TestRunner_iso-tester         PASS      30.81 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        PASS      111.23 seconds
TestRunner_rfcomm-tester      PASS      7.39 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      9.49 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
IncrementalBuild              PASS      41.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,3/4] gnss: Add driver for AI2 protocol
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#139: 
new file mode 100644

total: 0 errors, 1 warnings, 550 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13683899.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/4] gnss: Add AI2 protocol used by some TI combo chips.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[v3,1/4] gnss: Add AI2 protocol used by some TI combo chips."
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============4057854469398163378==--
