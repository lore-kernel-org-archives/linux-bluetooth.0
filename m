Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71B2DB798
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920776; cv=none; b=tdn+KZ761oUTo2GMv+sWL2SdewgXzPlxhOHseTcOM2ZLn9nzoT8fAK0onyD0orsbL6C2EUac1qVx4Bg0inySEYt4GroZcMIkSpF2mwsJwYUUGHvrIeg8aMeyIMAAPJj7EUDzzlRtEPp5tmd5xSkTzsAMgsnzvCCqWdJWtJOgPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920776; c=relaxed/simple;
	bh=6gQqhlqedY7gXNVFnRCqPY0GTver9m0bO7u+flqASi0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r9U4/qX7woKi+5kJZzFxdiGmUdZzXK47aLSNGWIci8yZM5itpnOEa+J12A6CU3/dgPvHQQKRCknR7h3FIo9UX7JeI7QSzhwGIIu0ou1NkVfcR8/Vk+a3TluLb9GjXoqbInVjxNR2VO8vJZj4Ik8BlpaM9Qnq6boK0WxOz3ffH+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkVgvFIU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkVgvFIU"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9158643e538so385316785a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 05:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920774; x=1781525574; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FhL1LMoGUMrDu3fknac5nzm4yTwwUm4S4cyjLP6L2gE=;
        b=QkVgvFIUAdiJkgKxiULpdKI6QOBxWNivuo071CQkeg5ki2p6RqjAfDPD1M9KUoM8qw
         AITl2XZLDfzinI80L3w3nayIuLW3DtB4EsFrQJ5Xkc3IWt1LwUXyY1SkXg/Dltdo5T4Q
         r+w1cnfSG8oXQqYIKzts8AuFlKU2mXIFRCo8FqPcA9Tcz7b/HJXi4RW5/LbTCwWIjcwh
         h3J5+XgDau3swdTZQLnFvI1pAMWRml2b2xfbU7atcNMdozI9Op38917H3uDH8rsJbB+X
         5gotrx9S7PYQNTfzy2a8uU/q1DkDqtjbDEg/hY+ERxOFA9NjG/aoVK8y+b/XoZeKfIVN
         yryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920774; x=1781525574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhL1LMoGUMrDu3fknac5nzm4yTwwUm4S4cyjLP6L2gE=;
        b=hIDQcAQsAKD8tsQYufJDGFvjEnbmIkcu08xyT2+JQyKxAJXv25c1Bvac/lMlHVe3Yl
         RRtZBtdeooLqXTVG+DXE9nXE+YughYFFUy+faYHVVDFuqBkRjl+1hcM/tN/3mmNytw0O
         iubV/l9yC0uw4w7X2dMGXK3ew1BfJYsihDBN7I9k9JPD0xnUQMS9CuNNLPfTK2xnRGPJ
         ZILJZ1m0PaFIGLTQcO48F0QL2lJkA9ZQrcI6re/QgPtf/89OM+tDAJQcLKk0Ku49eIfn
         wZPEgiqwUL8kKPvn8rfPndJTxIGBozgpySH0JXG1Zac5xjqe0kdH1ckZ8yWSZhmYsA9S
         hHwg==
X-Gm-Message-State: AOJu0YzUsSTimf53fzGb9g1hxxyESbGIcusehZXzpMK/RA9LW0DkypJc
	8HZQqekgFPuWoLUfSh0+bTGXnLPIT+I6g8F/LnDvIVj26KKHuJAvc6dWkn0Y6w==
X-Gm-Gg: Acq92OH7bEx867EsDra0RmHuzkYIlbkkzvOkuYKmDfDUDptspC/vyuUxxiQ+UkWGQh8
	JSwGEQdZse4XXeqUeIJVsdSTYL5/96gpJhlC/wwVC+1L4WvAUmDui+HCahh9hq7Q8Ucyu9wSpsv
	y61VeMAEq933v/x+jWbx30ee5db1k0OMgXKDxkX6st/AYGpVH5RDYGjdkYikASF5xhMBADJPacZ
	TCTvMd0R2ZerEY8Ly2paV4o5APD25CctbwaKrTzYCO/SNdfkLUPMBfjTZrqlXiYr7Augk8BsEV+
	ZWIjy8+XOQCW6tLgs5Ap9xYR5tMS3fCW7ZlsbQ7EivPvYp+rGRdCVK4eSetG4E9CLx3YqGk/Vpg
	OdE37qmbEuC7PWH3NCaT2DsvueQ/iGNsXoP5/4BGPbOOfUVVN9YzCZ5P3zvVTA2XcxRJ5/dp/bf
	kO9zkkwFQoISX6e7lUvHvuD5ao6g/1gLj3a187etQ=
X-Received: by 2002:a05:620a:601c:b0:915:820f:c78e with SMTP id af79cd13be357-915a9de439cmr2379895585a.52.1780920773769;
        Mon, 08 Jun 2026 05:12:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.14.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a243041sm1779003885a.18.2026.06.08.05.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:12:53 -0700 (PDT)
Message-ID: <6a26b1c5.a4791f72.24ac8d.dbc7@mx.google.com>
Date: Mon, 08 Jun 2026 05:12:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3588988718227727618=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20260608-block-as-nvmem-v3-1-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-1-82681f50aa35@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3588988718227727618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1107766

---Test result---

Test Summary:
CheckPatch                    FAIL      6.98 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      2.40 seconds
SubjectPrefix                 FAIL      0.91 seconds
BuildKernel                   PASS      26.17 seconds
CheckAllWarning               PASS      29.02 seconds
CheckSparse                   PASS      29.53 seconds
BuildKernel32                 PASS      25.63 seconds
TestRunnerSetup               PASS      536.40 seconds
TestRunner_l2cap-tester       PASS      60.81 seconds
TestRunner_iso-tester         PASS      74.90 seconds
TestRunner_bnep-tester        PASS      19.19 seconds
TestRunner_mgmt-tester        FAIL      215.82 seconds
TestRunner_rfcomm-tester      PASS      26.37 seconds
TestRunner_sco-tester         PASS      32.41 seconds
TestRunner_ioctl-tester       PASS      25.98 seconds
TestRunner_mesh-tester        FAIL      25.96 seconds
TestRunner_smp-tester         PASS      23.26 seconds
TestRunner_userchan-tester    PASS      20.05 seconds
TestRunner_6lowpan-tester     PASS      22.89 seconds
IncrementalBuild              PASS      50.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,4/7] block: implement NVMEM provider
WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines
#209: FILE: block/Kconfig:212:
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  typically used with eMMC to store MAC addresses or Wi-Fi
+	  calibration data on embedded devices.
+

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#231: 
new file mode 100644

total: 0 errors, 2 warnings, 227 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14616495.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.250 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.228 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/292

---
Regards,
Linux Bluetooth


--===============3588988718227727618==--
