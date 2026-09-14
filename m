Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FDA381EBD
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365775; cv=none; b=LGxn6IR7VtkzEVWCZolOqUWoIhxmp2YtzoRk/ey8DIc6MRbx9PXfGSLa3G26Fgedquq+tHQDS+r93ARQJPSNeLUJLA7TH2BuIIlXir4TPBIwCS6itbL4Kac8h2EkyUySTlNA6DIprDyn0iqfUcP2UetKZaD8dzGV5pjRtcNbzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365775; c=relaxed/simple;
	bh=1hVJC5DQbv3T4Xn2E4Ppb87uf+xyWxhGGknSJrq6HUY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BlLjnJhIG1eAlzPu8pNrYZSjr02gpsZ8V9gwl45TJbDcrWDM3sU6zZLvlxCpluOAG/l4/OKKY0WXUOYcyZmCs4a9of41xNP5LXWFSJYf4Br0ssF4GCpiipLhy214cho+IGJ1L7qS/yJ1K0olUZYm8vZTnZMLzJe4PQIBfEQZBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fe5Q0abt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe5Q0abt"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-395cf2535acso2795848a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 23:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789365771; x=1789970571; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3Jh4zO1vb7EZsiXgTwWwyXlWBB0r20y6GoIye7Q16zo=;
        b=fe5Q0abtnhmZE2cxjqXmcmz6hPDlzgfPx/B6dZmaTEvJzPDK5+8YjmqiwY+BYpS1Kf
         GJL4WXgYj7I68U1nqli26lS4lZKv9sn3q/wrK2Dy0Ek89Qq7iYY9XmM5+KV4nrL3i5Ez
         xPTocKLiNFGxOvhJurg8YyXwE8HMqdHRLZdLLBCnzTOY/LPT5bo0w39uWVSl9usdviIp
         SsT1zirruL+rYq/aEeisU+6YEC8Te+ymydlfls8I7cwE88uhcIpRYtNg3ZYQbJRJk29w
         mDdA6CqeFtJyb5U+mBto1hL7AOUA+/DM9mETmE54seFKw2QwaNca1FjoNw6dWj2Qj1RP
         I/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789365771; x=1789970571;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3Jh4zO1vb7EZsiXgTwWwyXlWBB0r20y6GoIye7Q16zo=;
        b=VjUhMo6viCSSH+7NoP5qJvq6grWeHAlAiSFE7hnGxnUVe1gm45nnaB2f7KE1cmlCT5
         uLBMZb0zG2gTiiC0mzRe4uBW5fvMbPF5+sfdWfIRpd95+t5cUubbpcoJuEzIBNcSjVfi
         Y8chW2oZYNu3Q46+uzlRHe73ZvObyt3mRMaYVR2MK0079GAst8gjRHGStuBPbqHDXS0T
         5SsezPiiVBAoG6WDz0gqFAN9xScXMfBEjEoHFoH3DFuOfe9CUBXuQv/xlolbzOgGUaPQ
         8eGZI0lOYQObUt/0j8c+MuVEj0U3a8NBuR8kRab7CI+rZqMzg5ds8pRDp+8Se+2Ouruc
         X/MA==
X-Gm-Message-State: AFuF++nSYKyYY7ewnQfVidKFh/U4NZhzoSBSpJi8XHPKdz6Sz2QbNGpe
	ONuwCjc0x03pFaQ+3QSFxg+eJ8ToK+HuZWwkymkzIk0+kuHU0cBSmpOifFA6KA==
X-Gm-Gg: AYBFou2smlsJTsh1ExQkRdR8YCWayLxwMA9vZCS3TjyFQb98bQlXqRlDC1qFwftCLyT
	/Q0mK6+iofUieUOv0KlULdM0bbD0tYit0lunaePZcUIFPxjdqc0mh54hxk+FJg7dCHArImFlWoS
	hzeUtDWmfskqgg3cePeHlNITgo5LvqH3QuC9tJOfWmNwusl+tmWEJAk+HcNZrWU4ptDJ0XTj8Qs
	wIws/QX3qiPVrEytauIDYE0bnAgWxvFKNUpQrLQ8J85ChTd44YW8/3P336FtryALnnlKEfQLYBg
	mHSFSlBWcFTUGT2eyKXEkScVQ90AuBkdD00EZRQrRRo9EO0H7LpSzwh98U5M7rzTbkKcVEErMv1
	0fQQw/0ogKvIJRKSrAFxA+OA4qHTSsRCw0LrZIAos6XfCHTlBpasS6zV+1B5jCakfwaMiACspjT
	LgFM/PEBNalKCVUHgZKuz1OUGVCq3kFiTQ4nW0FWtMlbEWBzRYHq4ICjCwktf/wIa07xqv3fqS9
	F+Y9ZjwpdH2VlE=
X-Received: by 2002:a17:90b:2203:b0:396:669c:b5f6 with SMTP id 98e67ed59e1d1-39dd54eacccmr4846467a91.12.1789365771098;
        Sun, 13 Sep 2026 23:02:51 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.5.192])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fb3ddasm21622148eec.30.2026.09.13.23.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 23:02:50 -0700 (PDT)
Message-ID: <6aa78e0a.fb0efb2a.1b8054.1aaa@mx.google.com>
Date: Sun, 13 Sep 2026 23:02:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5146169637998684747=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btusb: Support Qualcomm multi-subsystem QCC2072
In-Reply-To: <20260913-btusb_qcc2072-v6-1-137898715844@oss.qualcomm.com>
References: <20260913-btusb_qcc2072-v6-1-137898715844@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5146169637998684747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1164132/

---Test result---

Test Summary:
CheckPatch                    FAIL      6.16 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.89 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      23.17 seconds
CheckAllWarning               PASS      26.44 seconds
CheckSparse                   PASS      28.32 seconds
BuildKernel32                 PASS      24.35 seconds
CheckKernelLLVM               PASS      27.24 seconds
TestRunnerSetup               PASS      605.78 seconds
TestRunner_l2cap-tester       PASS      42.72 seconds
TestRunner_iso-tester         PASS      81.46 seconds
TestRunner_bnep-tester        PASS      10.11 seconds
TestRunner_mgmt-tester        FAIL      120.92 seconds
TestRunner_rfcomm-tester      PASS      13.29 seconds
TestRunner_sco-tester         PASS      18.15 seconds
TestRunner_ioctl-tester       PASS      14.73 seconds
TestRunner_mesh-tester        FAIL      15.41 seconds
TestRunner_smp-tester         PASS      12.70 seconds
TestRunner_userchan-tester    PASS      10.49 seconds
TestRunner_6lowpan-tester     PASS      13.05 seconds
IncrementalBuild              PASS      42.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v6,3/4] Bluetooth: btusb: Build the driver from multiple source files
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#169: 
 drivers/bluetooth/{btusb.c => btusb_main.c} | 0

total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14812146.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v6,4/4] Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#523: 
new file mode 100644

total: 0 errors, 1 warnings, 4930 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14812147.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6,4/4] Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072

8: B3 Line contains hard tab characters (\t): "       USB I/F	|	   internal link	|"
9: B3 Line contains hard tab characters (\t): "BTHOST --------	|---- PERI -------------- BT	|"
10: B3 Line contains hard tab characters (\t): "		|_______________________________|"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.960 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds


https://github.com/bluez/bluetooth-next/pull/761

---
Regards,
Linux Bluetooth


--===============5146169637998684747==--
