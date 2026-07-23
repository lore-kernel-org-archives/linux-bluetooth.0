Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99047485CF1
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821603; cv=none; b=MoeaKAbQTPzI5os+tAZA6rVTNyEEBS8j7NuMNepNVum1ytF4uinZJt1aJIAqFPie5+6vFX5mnOrL1+cYQ6nH7JvdR6B+E7tUadcX5ZhxAyo585JRXakI8g/ZGJDIsdS28ohKH6Q9cIMBhmGkQxI7F/wHfR6Trdq0TeQNrlwtX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821603; c=relaxed/simple;
	bh=Qj4N4IYLo/poRfYNstwyAe5whl9tGG7mnH1aBGhIlOE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dm5T9OhulVAq1+GRc24Vhi+97go4kEyYz5K+VfHkySpqlkVDR+hrToDyYh9X1FkpNLKhOfrIk29bTfLlUfskYgeG9GQVG/scc0UD2YICHJ24yA9Z9We+VbbEIW8oeA6f6/2E+l4X67SLuH1WSl4L/b5UJ+TXrYKX818YmkjenkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho6SLbRR; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho6SLbRR"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92f03daaa97so75434285a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821597; x=1785426397; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8L3WkjO8UqwySc9kiDP8UY+ysH9l8uspsVWt/02VcC4=;
        b=Ho6SLbRREpbKeT05fgYD1KSYtsM4dANFewhTNL5CfRTBaGud0xlQvGbqjU1TvUE/K9
         34VcQmKkGnka5H48v1MjK+Y3SFHZBQvRIhXzyEM0/6puFUuUjOklS0pbsLX1K8kJBgiu
         RksqxpP3rfMqhEE6nL3TfbbdNDGpgvVvqLGwmQ4bVxbK5HTWxuCPepObf51ue0A4ysKi
         6NlFGD4ny393hsTmcSriiybvS0k5VvPXVMrBUT+ysmyIIuaILQFyx6+df0C8NXTc494b
         A2Jm1A6TeDm2dlRzytTaFhtO5ted81+n6z1KgTPpQyXjIIL8qOR4Ax10tNtZCL0e9SEO
         eHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821597; x=1785426397;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8L3WkjO8UqwySc9kiDP8UY+ysH9l8uspsVWt/02VcC4=;
        b=Wbkq4Yn0PO8fvqfjL4eWP2v9C3vaH7s43Q6Ntkkzfd+HfCPgZw0ooOwuwFnci9VG74
         v4y98R88AHgrAkqF5AGCIIay9GNiui2y1V+IWDkCN5jXRqKnyjLeZxm78uhmf7UAMbcU
         cfC3IiBPlNaM/NApkiO71gDTjYTmIb9lqPhDxw2/+VzusDHLEKXyuRoQ0LsV8+Y+W/P/
         VefdVJ/lqkDf9w5BX0CFUkw4DTzE6VfXfm4NUYbWxaU0SpS9yVbGOHxLT5s71/qaVvvw
         Eg9C239tpDNHsCktepzWFPykho755r153rh823bn2rz4T29B4AF4PNhsjrYTdXx1Brjn
         8I+w==
X-Gm-Message-State: AOJu0YwWo7Kut1QKyCYEZZQL2MrRuRjNCn/JUlk3dTVTQ9t8kxa0g8yF
	xMmHgr9dESyqGYAxE17l9E9NGUWpXmou4+59tFw604ZPA33olckHmZA/lG0+Yw==
X-Gm-Gg: AR+sD11nYTTESD1mg1PqYSGrmPlZCEOi14P8cgPAZLxWnfRzmOFstERPoXiI3PEgqQF
	jBlc0IRoUJS92lBVg0sVJJGkTkkC14giPrxm13neM5WqHTi37X4RwyFnPzYibdUcjh7TJLvl34u
	11swlq1lNiX31mnBgJJFkc6ypwclFstzoQWt1Zv8WuORMFoWJJPIpo3Q2jzxWtTjy9XvHaNZyT9
	feSZ0dTZEJLKbrHnWcJw1n1gh3bTJFTzVw0aYhLgVyLULw80qdspKYix6mizKasqPOiMJWaH7xn
	6oyjbnOhIllooVrvNcIICcp/2o93TA90s8OlA6ji/yHWCCL53hGs87DBdZfgFtQrvvPA6HAcZ/o
	HNK0ejhV0qZaJ3QctFkZMibdf0H0u1psdyZZvYtiFvsbVOJfBeNeIgmorcgXpQfrRWlK1rYpB4o
	gNujT1GfKov17ZXOrBWVA=
X-Received: by 2002:a05:620a:3912:b0:930:e53b:d76b with SMTP id af79cd13be357-9310385ec52mr352311885a.6.1784821597481;
        Thu, 23 Jul 2026 08:46:37 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.34.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a0342esm438920885a.31.2026.07.23.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:46:37 -0700 (PDT)
Message-ID: <6a62375d.6f91ca5b.c0d5c.9a1f@mx.google.com>
Date: Thu, 23 Jul 2026 08:46:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7881190944708260743=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rahul.samana@oss.qualcomm.com
Subject: RE: Bluetooth: qca: enable QCC2072 on RB3 Gen 2 Industrial Mezz reworked for BT over UART
In-Reply-To: <20260723-rb3-industrial-bt-uart-v1-1-3c8e580c09d1@oss.qualcomm.com>
References: <20260723-rb3-industrial-bt-uart-v1-1-3c8e580c09d1@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7881190944708260743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133207

---Test result---

Test Summary:
CheckPatch                    FAIL      3.78 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 FAIL      0.46 seconds
BuildKernel                   PASS      27.03 seconds
CheckAllWarning               PASS      30.93 seconds
CheckSparse                   PASS      28.48 seconds
BuildKernel32                 PASS      26.47 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      505.18 seconds
TestRunner_l2cap-tester       PASS      63.01 seconds
TestRunner_iso-tester         PASS      86.12 seconds
TestRunner_bnep-tester        PASS      19.37 seconds
TestRunner_mgmt-tester        FAIL      222.76 seconds
TestRunner_rfcomm-tester      PASS      25.78 seconds
TestRunner_sco-tester         PASS      35.00 seconds
TestRunner_ioctl-tester       PASS      26.77 seconds
TestRunner_mesh-tester        FAIL      26.97 seconds
TestRunner_smp-tester         PASS      23.95 seconds
TestRunner_userchan-tester    PASS      20.89 seconds
TestRunner_6lowpan-tester     PASS      24.22 seconds
IncrementalBuild              PASS      28.40 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/3] Bluetooth: qca: add QCC2072 support
WARNING: DT compatible string "qcom,qcc2072-bt" appears un-documented -- check ./Documentation/devicetree/bindings/
#457: FILE: drivers/bluetooth/hci_qca.c:2811:
+	{ .compatible = "qcom,qcc2072-bt", .data = &qca_soc_data_qcc2072},

total: 0 errors, 1 warnings, 240 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14706139.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[2/3] arm64: dts: qcom: kodiak: mark PCIe root port as bridge
WARNING: DT compatible string vendor "pciclass" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#188: FILE: arch/arm64/boot/dts/qcom/kodiak.dtsi:2299:
+				compatible = "pciclass,0604";

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14706140.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[3/3] arm64: dts: qcom: rb3gen2: add Industrial BT UART overlay
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#203: 
new file mode 100644

total: 0 errors, 1 warnings, 143 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14706141.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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
Read Exp Feature - Success                           Failed       0.256 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.435 seconds
Mesh - Send cancel - 2                               Timed out    1.985 seconds


https://github.com/bluez/bluetooth-next/pull/482

---
Regards,
Linux Bluetooth


--===============7881190944708260743==--
