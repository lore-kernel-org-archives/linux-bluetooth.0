Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15C10A28
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565852; cv=none; b=OiuRQv0E6h0qzXiiqd1AgID+ZfAHNK2eafvno3dnYtepdyCwdSckuhQv4VkpU+fxRVk8h9ZooPatPWompZnSwXdRhPZYDCh/Sn88MEEXOaNzyp85iJfnQnGlGFoomUmVbK6OsWZwQgtgN/n4tT0IUT2pSqe0wc/u6w87p9MJjI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565852; c=relaxed/simple;
	bh=0d9lBaaWvHGOSWhl/+9O+pgT+OLFPs9c8aqgPtwKITY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QSGAukVC3gwnqoasMieYwD2/UU2SrMReDDv7leCEaQq+b0YCwUCBEiqYAj7ZmWOuMI0JIgkjR4UjKKmozN54xXKB217MPps1nTmp7kLOPMkDf/7ezoicwA/b0NM0tNPkOYwmA31GnGvHPHXVSBQNWxYgnzy0xWyQpSNkFEmspag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chJYBulZ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chJYBulZ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-699320fcbc1so16172026d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713565849; x=1714170649; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B4lxcpra/N3iuYLwa5L+o+X0xmopsQ+h8QMwudEFn3w=;
        b=chJYBulZBR000E1LLwSGQnSS9+RRMZlW5ZRGcqqpMFa8ty7KPIJPy5PqfFqD8BDvLw
         YZ5nY7kBECE5C6s/1/jnIYFEphtern2BCIglUh0YsvpoXTbKCdfr8C+gC/gV0NfUHwIj
         gnf/zLmnYT4rbVYF53T89jlibSe0OFMHEN+kq/VOqcvtX1b2HWoq2Cy0D2IgX6AJ2Bwo
         uFrzWV3F+gKBlqMsPvkKpW3gr5xowmJxZgkV3DWgJdZkH1dBVdAaHDP2mMA67VMn65mu
         pihqFvi6oCmA0Rzd+jOMBzAeR+mxyafL9GYtiM8HNunFJcOeW/QvSot9yPECA51K3OOf
         /b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713565849; x=1714170649;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4lxcpra/N3iuYLwa5L+o+X0xmopsQ+h8QMwudEFn3w=;
        b=PEVUVH24ebEDKumvAPqztNOflMAOvtsGw/ti5pMIeRabwxadpOHgwmktjfvVjbNNFb
         Rbb45qSM/YfNl97uD2AoJLUQC5c2xlJNUvwfTW8lCkQQa8vPk1HWjFP+qovevdC36RyJ
         Gore/KTERlI1OXdUM4o6TTuzhVtmzjgMLJYNge0fwn1X0trXy8eAptkrfORTQkZEj6o0
         /lH0XsIEU+oGp/O3GnxeRU+LtU2ih9pHnNta79jwmmSQJm8yKVfAsUDpNU8FKWwbsy3Q
         q9deXxZx1dVc2RaE4xm0vpKBeEN1Z5ZM94jXFrcT3AX1KFE8rEubTiGk5Xh5Pw4APOH7
         XhFg==
X-Gm-Message-State: AOJu0Ywo0TzC/Hstlq7Yg0zrFACtgTe2/WS/0dLsx0/A7mKZs1IV9ys/
	91lqVAu0DHcxpW+fvJXfoHO875Gz9m/mBua7Uno2GRD1g8fZdgCA4EN2SA==
X-Google-Smtp-Source: AGHT+IEDS11yAM4GDU7nZhezDHGgAT8gsWdjm4cwVQVrBOpyc8jTiyfDzkqjWy2OzSS7UE0R5HaW8w==
X-Received: by 2002:a05:6214:410e:b0:69b:7ed1:7a79 with SMTP id kc14-20020a056214410e00b0069b7ed17a79mr3719661qvb.35.1713565849418;
        Fri, 19 Apr 2024 15:30:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.126.79])
        by smtp.gmail.com with ESMTPSA id z15-20020a0cf00f000000b0069942e76d99sm1919175qvk.48.2024.04.19.15.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 15:30:49 -0700 (PDT)
Message-ID: <6622f099.0c0a0220.49386.a793@mx.google.com>
Date: Fri, 19 Apr 2024 15:30:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6685370395582828347=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Fix two regression issues for QCA controllers
In-Reply-To: <1713564212-21725-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1713564212-21725-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6685370395582828347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846241

---Test result---

Test Summary:
CheckPatch                    FAIL      1.55 seconds
GitLint                       FAIL      1.15 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      29.65 seconds
CheckAllWarning               PASS      32.54 seconds
CheckSparse                   PASS      37.97 seconds
CheckSmatch                   FAIL      35.74 seconds
BuildKernel32                 PASS      28.71 seconds
TestRunnerSetup               PASS      515.72 seconds
TestRunner_l2cap-tester       PASS      18.28 seconds
TestRunner_iso-tester         PASS      28.86 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        FAIL      108.91 seconds
TestRunner_rfcomm-tester      PASS      7.24 seconds
TestRunner_sco-tester         PASS      14.94 seconds
TestRunner_ioctl-tester       PASS      7.64 seconds
TestRunner_mesh-tester        PASS      5.74 seconds
TestRunner_smp-tester         PASS      6.80 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      33.04 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#112: 
Reported-by: Wren Turkal <wt@penguintechs.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726

total: 0 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13636786.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
17: B1 Line exceeds max length (139>80): "Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f"
[v3,2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable then warm reboot

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (93>80): "[v3,2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable then warm reboot"
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 7 (AL is full)               Failed       0.191 seconds


---
Regards,
Linux Bluetooth


--===============6685370395582828347==--
