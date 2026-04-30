Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449A399350
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580326; cv=none; b=ftqtke0giVLz7f8Fhtp6Rb1Dm8Xz7tgEKePb7iRjleiw13xuxfQ60hgvP93NdgzpXJYdTXfnEO27QvzyLa8A6ZfLIcykAf0spqB+l9LKrWwJAoZlCAuaRd/vxRwmzdk0HXwJW45wiJCk0U8qVEwBQOL6C7BhQBBCubdBekvjdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580326; c=relaxed/simple;
	bh=hIKxWYyJu37FLsxYi9Sa3m+kkUrVDVruiLNzHbqlXk0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QtwHboKdupnfgBguoCsGOT/sNh4syBCkd2X75/o8ImcAqwR4LX3Gz7IwHA4TMWQORLAAEbvqhZG/SVKVJSF65pO3xWqzoLk/Om35vmlpR0NK4NlMtrO5EUw+cLdR3J7EBkzg1QCZ9tI8i1e2cSoIxS+o9YFJQynQ5w6eNTJ+1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qicEaF9t; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qicEaF9t"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8acae26e564so15520546d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777580322; x=1778185122; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zZlWaNlI3piu+ugE2XLIMWKD3k+SUWB/LacDtKOhVxU=;
        b=qicEaF9thDhDA3OzSTxvRBxZDVdJoi/r68Dw36/cuTMkF0SEj3tYuPtcsp8aynheR3
         L/JtjDzS7RJ4LcCmkuQocW3ZOAnUDgqxmeOEYVSBJwdAaauW8IFCtQsyBpya8fbC5LMx
         jHkXSonYEMfQ6gHgMFgjvlC7kVV3Tq9VYfgHsae1FUoMLjY+00kS9UUO39zmYRfW0t9G
         YPe1eJBW/my8gb9YpPriwwcmdpJ9hD2owj8VhLGRCTLjI+/Vi6GfWfZuHkU+HxDzYE/M
         5WTMw5MEYiD5y4EdjI2IyN2gzJtoQMOL/zBiHzjnEAUnVzPsABP9jhiHVODjLXx/frfc
         aTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777580322; x=1778185122;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZlWaNlI3piu+ugE2XLIMWKD3k+SUWB/LacDtKOhVxU=;
        b=IYyBhmevmt5MatOUV7lU7Un7I3nauvWv93/KBsM8zN9iaSFr/FTD1Bwiphms4NR49Q
         1oz7OBPdeblhvsZ3dWeOQv03j8OEG8Co2saSCS85JzJJIeKve9erlHOS42f6ZFDACb5w
         EXPfKDIBmwBJI1Qo95sPRX+CuU+/eLGW+GH4GfORQWULolwP3ucOTUBMDfEL3b7QHEV5
         OH/gomvUriwH8MKjlLGLGQH/hJkEijxhK5r3OkI5kOv2JmoHqMoEtg2n3517MudtH7d5
         n6LWyJd+jiSdymL2EVTmBSnrjwuZVIDGJfsZLTinu7ro9VZZIxlUY9p80a5CY98EKU0w
         u4Xw==
X-Gm-Message-State: AOJu0YzyQ52TN9eMt8LzpYzvIrlbjvPhnTJrV3PNNU2ltvaDWdfvokYK
	D161ICZF/Zc+XubJjxGG/TuONYkl2Y8SCJ1XFH8mln2utKmoMPmwu8nCXb8w9Q==
X-Gm-Gg: AeBDiesOhKTvoSMO7nQJP437DMSbiwkhQOyXD+PRwxJ3srqdVMNDnFEPOw9w67qA8zG
	a+X95EpS6dsC43NFsUZDMgFxMirtL04E83Hqjmcjx4u9J7Df92N21ftXqcEXF4//UP3uUSVTI3e
	pj2QcfNSOG4cb33SjH9KRcSTYDcr+1is8Zv1bQIbySX/aC4lbwTwfYV5z9XVJkp3jgG61DYUjJV
	TlSWcguplxCHw2yNFVgsZUadUwBcmWcasRWW0CC6SgciX/6CpkBdPDNwbJFLEttrFdCYiBlIAu1
	5smSiMJoM+itIest3KEcL3N3wGh1SNCSKU6C4kByHjSkE90EkWfHmDYrfOJwjNxK4IhY7U05cVq
	MEiNL3nXGPTZSd0Y/23GZoKSXMvlBvnucKOUMNrc745iHXmahxq3gKsPDsSo1ngaAgnxkRtkmV9
	YHK6PjzRy3P2zBKd3DzeSt0sTQuegu+/s4Ic0ayJg=
X-Received: by 2002:ad4:594b:0:b0:8ac:ab3b:39f7 with SMTP id 6a1803df08f44-8b5448089c2mr236446d6.4.1777580321977;
        Thu, 30 Apr 2026 13:18:41 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.93.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53ca982a1sm902416d6.38.2026.04.30.13.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:18:41 -0700 (PDT)
Message-ID: <69f3b921.d40a0220.3c3ab4.46fe@mx.google.com>
Date: Thu, 30 Apr 2026 13:18:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3097802335393112276=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: RE: Fixes/improvements for the PCI M.2 power sequencing driver
In-Reply-To: <20260422-pwrseq-m2-bt-v1-1-720d02545a64@oss.qualcomm.com>
References: <20260422-pwrseq-m2-bt-v1-1-720d02545a64@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3097802335393112276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084240

---Test result---

Test Summary:
CheckPatch                    PASS      10.21 seconds
GitLint                       FAIL      3.79 seconds
SubjectPrefix                 FAIL      1.77 seconds
BuildKernel                   PASS      25.35 seconds
CheckAllWarning               PASS      28.26 seconds
CheckSparse                   PASS      27.92 seconds
BuildKernel32                 PASS      25.29 seconds
TestRunnerSetup               PASS      522.56 seconds
TestRunner_l2cap-tester       FAIL      6.63 seconds
TestRunner_iso-tester         PASS      295.69 seconds
TestRunner_bnep-tester        FAIL      6.52 seconds
TestRunner_mgmt-tester        FAIL      8.69 seconds
TestRunner_rfcomm-tester      PASS      28.93 seconds
TestRunner_sco-tester         PASS      68.09 seconds
TestRunner_ioctl-tester       FAIL      35.27 seconds
TestRunner_mesh-tester        PASS      26.96 seconds
TestRunner_smp-tester         PASS      6.58 seconds
TestRunner_userchan-tester    FAIL      6.58 seconds
TestRunner_6lowpan-tester     PASS      22.91 seconds
IncrementalBuild              PASS      46.87 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[01/12] power: sequencing: Introduce an API to check whether the pwrseq is fixed or controllable

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (96>80): "[01/12] power: sequencing: Introduce an API to check whether the pwrseq is fixed or controllable"
[02/12] power: sequencing: pcie-m2: Add support for 'is_fixed()' callback to 'uart' target

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (90>80): "[02/12] power: sequencing: pcie-m2: Add support for 'is_fixed()' callback to 'uart' target"
[03/12] power: sequencing: qcom-wcn: Add support for 'is_fixed()' callback to 'bluetooth' target

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (96>80): "[03/12] power: sequencing: qcom-wcn: Add support for 'is_fixed()' callback to 'bluetooth' target"
[05/12] power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[05/12] power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices"
[07/12] power: sequencing: pcie-m2: Create serdev for PCI devices present before probe

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[07/12] power: sequencing: pcie-m2: Create serdev for PCI devices present before probe"
[08/12] power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[08/12] power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table"
[12/12] Bluetooth: hci_qca: Fix the broken BT_EN GPIO detection for Qcom WCN devices

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[12/12] Bluetooth: hci_qca: Fix the broken BT_EN GPIO detection for Qcom WCN devices"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 0 (0.0%), Failed: 11, Not Run: 17

Failed Test Cases
Device List                                          Timed out  -28.814 seconds
Device Info                                          Timed out   -6.189 seconds
Reset Stat                                           Timed out   -6.192 seconds
Set Link Mode - ACCEPT                               Timed out   -6.195 seconds
Set Pkt Type - DM                                    Timed out  -14.382 seconds
Set Pkt Type - DH                                    Timed out  -14.387 seconds
Set Pkt Type - HV                                    Timed out  -14.390 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.393 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.396 seconds
Set Pkt Type - ALL                                   Timed out  -14.399 seconds
Set ACL MTU - 1                                      Timed out  -14.401 seconds
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/137

---
Regards,
Linux Bluetooth


--===============3097802335393112276==--
