Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59E33BBB9
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782153334; cv=none; b=Kqv09ysoNA56JIJF4HwfKkNlUdk5R7AL8lADnH9iKByIJxhFIfIPc1jVo1xahZq3x4PoLSFpGOmdb5EKBRFMtv+sNYURTMthcW45C0wDWHyI2o1sHcVcUlUYbDqc6OLJ7JvxK7Y4bSDo3tPBo3K2D8XEsxjM7uux0vHP+UkCCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782153334; c=relaxed/simple;
	bh=TeCYU5REXi/eH22Nn4JmtPWzfz1GXHvXWInvW3IZtPY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Aos5Upq0Dv+3Yr8u/vSMN7nkbna0x3EV3trnwugmBh8Jt4B8Y8Z0hoRickjZhJGBCJTW6WcNOml27ax2EDxD+7Qo4sx2E5nhfk7Uwe+Yt4YlRzoYPWmKLfM3pxfiNh8eqRxtHCtB8mbmTontIJODKVjSZ7dyCXZq27uJ8bb0rek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMspCT+q; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMspCT+q"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-915d64fead9so20913685a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782153332; x=1782758132; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YYtriWG6uHHrwDOy1jthbPA4Dv7BRui36tX1/hFAZco=;
        b=TMspCT+quZBhoYXCrbKyMAC1AeBqg7Hek1fB40yZhLu8dkCWPh6Q/8TDsDmQMYq3C1
         sYY+duQbvajctqQpMNnKDCkaKHjwa0OtNyhJbYpT75r+qAKaD8cyGgxE+ZupH94XsvR9
         2w/oSwVH+SHflICqOE3fwLILdbDMYSyOzI6TLs9qW/EGDKxvM4FapwFf/tBp+CwcOHsg
         Zb0KxejrNqvL87LYZED5vKXCa6HBHn2HNbOpbPkthjf86hep3ZX2K654+KUSNn2SWrqf
         V3FFCPgp+wKVXCc2qnypoYd3xlOGR5aQzk2EFfJwTqRIUM70AGWxsFo7gLCbKXFMdpgg
         dFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782153332; x=1782758132;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYtriWG6uHHrwDOy1jthbPA4Dv7BRui36tX1/hFAZco=;
        b=fiXLnq/Mvl42c1ykou//FlOk9BjU+2fURM9OhUjFxDniy87Tyhkbd5M+5VpoKoGijP
         aHsbj+9u/tfPx9tIZkHSHgenzMNLWHS2whVqvfraj4E+eRFvyvhYGkbt7SLTaCV3QOeA
         PftxE6K2ju2Nu3dkHjMKhwUxXAvabpRA3KHc85Vb357sqFX358ZZ5E9rmJlfZxTq7KOZ
         1mLEVA7UqZIZxQcC90ryg8CtSAKAsOSDBU0wEALpyNVhq/z2gouLNc1hECJLv+7yvCt0
         MQJEpAToASJJMp/C8XeE6508wL+s5yiu8tUyOjq4WoOojR6LS4MF2G/HNwCo0lm3y8NV
         mfAQ==
X-Gm-Message-State: AOJu0Ywu3ROCO9SGn5Z97vON+qdB3tf87J++SgGBhyO6iEAiS2dh8/yu
	g20MdyNAy3uwYpsb7FWW//tEL/h1jFXR4oURF2B5Weu8r9hgESRbxSDeFhq46A==
X-Gm-Gg: AfdE7cmkORK4Ss1qqNuOBHzmAYaISd8AJs93IxtuQcpHdLl20a2mgTg4q/HOw+As6kt
	UlJk2kufwQ+VgHvFZtBCAr3Kyg2imJIWRHP2nl1zHssiihGIudFqX16k2ibgQWbURbL/BD2JilU
	qpItaVmzVSBLCo0oAtqAdr9faafJ06LS2mo4N/K6acM0p827WHhNMEfxXCfG5dLiyfNxmq6IZVU
	eEBT87taTzd3NcaYWULCUNPvfAso/BXXswGM5jaqMxnpfz9cO3o904KyniAthUwnXvdB2cFOUSm
	D01x+bYxyBAjLDS8GdcNUUDBs7ZeatW/Bu45aCBJtS2Bmh8NYQTBHdQjWxZ1hm/yObM+hexJeD8
	/ZPNm+5V4H3GApHITQelbUnHWjhZo8MwkYwSXeJBbypetyIV3EqD12/W382MpJaF6Eo6sIaOF9P
	K81rfdRWf8u1wUf57wHg==
X-Received: by 2002:a05:620a:2606:b0:914:e9eb:573e with SMTP id af79cd13be357-925fcbab356mr110199285a.0.1782153331604;
        Mon, 22 Jun 2026 11:35:31 -0700 (PDT)
Received: from [172.17.0.2] ([52.150.29.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fda626b9sm50594785a.14.2026.06.22.11.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 11:35:30 -0700 (PDT)
Message-ID: <6a398072.f0689485.95d99.2003@mx.google.com>
Date: Mon, 22 Jun 2026 11:35:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0515469884615996636=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btusb/btqca/hci_sync: Clean up btusb and fix several bugs
In-Reply-To: <20260622-bt_bugfix-v1-1-11f936d84e72@oss.qualcomm.com>
References: <20260622-bt_bugfix-v1-1-11f936d84e72@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0515469884615996636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1114806

---Test result---

Test Summary:
CheckPatch                    FAIL      14.74 seconds
VerifyFixes                   PASS      0.31 seconds
VerifySignedoff               PASS      0.30 seconds
GitLint                       FAIL      9.09 seconds
SubjectPrefix                 PASS      3.49 seconds
BuildKernel                   PASS      25.01 seconds
CheckAllWarning               PASS      27.84 seconds
CheckSparse                   PASS      29.36 seconds
BuildKernel32                 PASS      24.64 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      522.56 seconds
TestRunner_l2cap-tester       PASS      57.21 seconds
TestRunner_iso-tester         PASS      77.02 seconds
TestRunner_bnep-tester        PASS      18.82 seconds
TestRunner_mgmt-tester        FAIL      205.87 seconds
TestRunner_rfcomm-tester      PASS      25.34 seconds
TestRunner_sco-tester         PASS      34.70 seconds
TestRunner_ioctl-tester       PASS      25.44 seconds
TestRunner_mesh-tester        FAIL      29.97 seconds
TestRunner_smp-tester         PASS      22.99 seconds
TestRunner_userchan-tester    PASS      20.16 seconds
TestRunner_6lowpan-tester     PASS      22.20 seconds
IncrementalBuild              PASS      74.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[11/13] Bluetooth: btusb: Move struct btusb_data and macros into btusb.h
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#322: 
new file mode 100644

total: 0 errors, 1 warnings, 276 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14639541.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[04/13] Bluetooth: btusb: QCA: Do not populate devcoredump fields on ATH3012 or QCA_ROME

1: T1 Title exceeds max length (88>80): "[04/13] Bluetooth: btusb: QCA: Do not populate devcoredump fields on ATH3012 or QCA_ROME"
[10/13] Bluetooth: btusb: Simplify btusb_shutdown_qca() by using __hci_reset_sync()

1: T1 Title exceeds max length (83>80): "[10/13] Bluetooth: btusb: Simplify btusb_shutdown_qca() by using __hci_reset_sync()"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.234 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.978 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/337

---
Regards,
Linux Bluetooth


--===============0515469884615996636==--
