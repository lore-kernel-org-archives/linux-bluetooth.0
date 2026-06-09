Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0362F2D8393
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997514; cv=none; b=WaPJXL7RW+++Y0HVYLH3J2n3Xw84EOd2yWMAjAaBlOP2YbrbEg3cZ/Mt3ZBClfWbMtMWAVkLv4lVSaVfGoyW0OZ47+WH1L1kgwgX+qz8asrD1k1Wk4drstAlcAjCNZ8ATBsmjWiU2LQsYfGOQHfvgtymwQ46UkZXw0ZAxCaV3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997514; c=relaxed/simple;
	bh=JEDUPrutS9fik+XmLllDmm+DPTHhQDZXYN36lCmO4K4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CGOlKjOqrLzJ79a8YoQyP047eTFbc42KMFGxG3ryyO7P07iY2hlGWhvLWysKSkY3Zh1UU5jw51aWw3cMxplGmBMnK1s8KFq6A/RKEldNDRKkUHhMhG8i6erZSzCsw2obhj9refHFueZcsgRR3fmJZycjwW/dLT1tS15td3NYovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuflPLNu; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuflPLNu"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-137d464c47eso3767618c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780997512; x=1781602312; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SOilpXJzezvf5pYunVLH7gV66kFo9Jn/jkiI+a2/IS0=;
        b=cuflPLNuiOfA58+7tj3vgxaibqduDK53gleB0mCjhZRX6sqvq65Wa6YMkfubHeTe+r
         eZrz9xuHp4ngejYvpG0VMK23VzvWkSwHirbkM/9GkcsOjdaQrVUZN7dxEQi/jjUogQVS
         03Sf24I6e3E137avj7mMIa13SH8WxUorBxwmiaETuAssxOErRUjKsztwAugxtDIQ4pOw
         Y9lr1ayMR9d6vlB/8vvZEbzV7cCjwybSy1LxnUNk2TP6bbM+kS/kC0sIkZFLmCAqHCF3
         uOwWpI48DIHF/fKT2RAVL+FeWFkQh/YB6NxSjKnK/nO1Oz46KPiZhcGGcghOo9LLBM2g
         +pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997512; x=1781602312;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOilpXJzezvf5pYunVLH7gV66kFo9Jn/jkiI+a2/IS0=;
        b=Qb/ug6ZgTnp9GGXKxLY64lETQk2dsnuztzNn3OMPE38gt1lIXW0HqGKUV5LGL9NupL
         Fug7Xx7xXvyGfN/YudNw6/yPG0mt6dQnDKbd7M1PIs+7+Q6RuyhOUt9BH1THDnRmMXCn
         N+pQLUb/NUCClwefYIiBM8UtzU4ZMm0liLZSWHy/zdNcQtdbqoZN1wk++fFoXC52qY9d
         kdFR90amy11bbsX4CydCDBIuCQgWX6IIUPkCij9Ql2uaax5zShKYOjQ3y7JmpNkVkDBD
         ip7fSoVh3ur4fr9C9Y1MIW/02K4ZU+FFsMtkEURETg2zurDjkh1wvEhxiil+AfbQdt0I
         TMyg==
X-Gm-Message-State: AOJu0YyOm9bgT2Phe5XLL+jTPfbeXmlqCyj6XzzryqDtePZ+TW7Fekv2
	4wLc3Ft6oWjnc+kvlKarNFQ2fqbfieqhLr5lDM+C1/J7hLILKRRW6SbhoWLKkQ==
X-Gm-Gg: Acq92OHUXHAJQus7XWRu0ITznHDmflNUNJxLmdIW1uHTdd7024oDYlyjnj99NlzjyMa
	6q+TlaL8Br5BP3rYFYmwAlVlcbbSKdeA2vw0c5TnFANhwkF9s2/RyY2wvJWw1Gi97dGthtYBWbr
	Iz5MiGQqT7XjCCTDF1dWrqZju9amJ9amhgvPuxVbAEwc2SXyjdYNFlyKwlxEG9axBJzBZ8Fjo8V
	2qd0PofKXBXwSNKH+iQDTzLwyn8PfyMYquQp6+GmmCPdHgyJYv7vIcLw6Xie2+2m7CNZkWdVZzU
	c5fkoSEUK0UiKvKDt0WnA0qSHYComgu0p9m4jCTBFduOnZtrdLQDPbTad0fNznX4deoQsB98jEg
	RinkmQYMoI9nMoOLPNwHc+R2EsuZQNwKcIGB7EpQ2Bm1+nFVsSPJnoYTvoXSuTjsSZuHNqGGNK6
	JDZUKjodpnx+qt21OItGdcc+vFTpgO40PFC+jx6Hiw8XY=
X-Received: by 2002:a05:7022:2391:b0:137:fc2b:1ec4 with SMTP id a92af1059eb24-13807d022d5mr8912013c88.3.1780997511940;
        Tue, 09 Jun 2026 02:31:51 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.220.153])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138063de4a5sm10727300c88.13.2026.06.09.02.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:31:50 -0700 (PDT)
Message-ID: <6a27dd86.a8e23d06.327054.7a39@mx.google.com>
Date: Tue, 09 Jun 2026 02:31:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0312741472778128451=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20260609-block-as-nvmem-v4-1-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-1-45712e6b22c6@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0312741472778128451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108363

---Test result---

Test Summary:
CheckPatch                    FAIL      5.52 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      1.74 seconds
SubjectPrefix                 FAIL      0.54 seconds
BuildKernel                   PASS      27.52 seconds
CheckAllWarning               PASS      31.14 seconds
CheckSparse                   PASS      32.08 seconds
BuildKernel32                 PASS      27.75 seconds
TestRunnerSetup               PASS      604.95 seconds
TestRunner_l2cap-tester       PASS      63.61 seconds
TestRunner_iso-tester         PASS      83.95 seconds
TestRunner_bnep-tester        PASS      19.76 seconds
TestRunner_mgmt-tester        FAIL      232.93 seconds
TestRunner_rfcomm-tester      PASS      27.19 seconds
TestRunner_sco-tester         PASS      35.12 seconds
TestRunner_ioctl-tester       PASS      28.16 seconds
TestRunner_mesh-tester        FAIL      26.95 seconds
TestRunner_smp-tester         PASS      24.92 seconds
TestRunner_userchan-tester    PASS      21.24 seconds
TestRunner_6lowpan-tester     PASS      23.97 seconds
IncrementalBuild              PASS      55.67 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,4/8] block: implement NVMEM provider
WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines
#200: FILE: block/Kconfig:212:
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
#222: 
new file mode 100644

total: 0 errors, 2 warnings, 133 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14618741.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,8/8] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

1: T1 Title exceeds max length (85>80): "[v4,8/8] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses"
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
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.282 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.972 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds


https://github.com/bluez/bluetooth-next/pull/296

---
Regards,
Linux Bluetooth


--===============0312741472778128451==--
