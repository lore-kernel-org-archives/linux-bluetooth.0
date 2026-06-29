Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C21B2773D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758112; cv=none; b=vBR+BAP6Tnw5jnKxs2XZ08st+uIoAbLTlO2jII/zp3+oKBUmMaT4hwPT/OxZED0EjFNM/l2864tvPNelYkd2JXnHgO1yoanEPVy7qWqwZj+N29EderxPy10mr21rz2BQSEVtcDtSnU6EayTf8f+RO5qhrh9zzDB60uQCvFAKo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758112; c=relaxed/simple;
	bh=yXDomfmf5ZV1zpjvClG8AE1wAKvI3DGNKbyxPalgI1A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VPmQlmsmRYglGwetF6rNo1Z9Qpgm4gKCD/SxoU9mcLJOmEnPuQ2LM9+j+bTnsP7klTTXsVP4RCU9UHEh3O1dVyS3CmlODnS3V+QD2qIANIlaiNoPI428MmpLXgCeCfgnJaRXFjXB5vInVa0RwL6uE3akpVq6BGfM+FY4/OG1lgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMcIFH3I; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMcIFH3I"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-139f1dfc9faso2982318c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782758110; x=1783362910; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PB2IwOFRlPbMAZE7I9mi2UMoTQZcWkqttAWbDM13wAg=;
        b=mMcIFH3I01om8cZ8ThOQT/pEAozzeOvAKRHqdFbrAjc/CHvWHY8/2gHkdWcCoYGMwc
         WTlmWAct52LUI8JormsQE2N3r1M9Khu6Md/KYtF5BoRkv6rs3zxrxkoqmLeX8KcNy8+u
         vjYEvtNRIA2k08i8zx0e7DvAmwOvyXrIUCLv9Op10nICOviCYYbhnvR9+/SMU0OXBymb
         lu+Mwk6esROVrD4NLoWmPPAhpW2Jeqc2OcGuNbqJC4+04trOmwAS+XTnEBlNAklJXc8o
         IpLwJ850033T6+UVVyDGckLFKssrEbXAMxdwPJg297xx0bCZfk1QmOXpyCy6KqxEUFpM
         Jvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782758110; x=1783362910;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB2IwOFRlPbMAZE7I9mi2UMoTQZcWkqttAWbDM13wAg=;
        b=XMyTujIQcWdoVXsEJ4d3f6Pdi8jfCpJcADEtX8mjSVwwE/7Cy327Hf/IYuEdDNWfyY
         jwxB37fHLPOY20DBRXwI7yARjmRfRlr1lMebKUb9aMHRgdpVrp8Ty72neYeB4UAVAojR
         7twmwmtFcjQMvIwxoWdJI+F6c/fZ1aTWq9ObSHkKP+m+10u64VlbzGNyBcVkzfyDFcMs
         AcDPBAkVfneztkFO2R2aDBj9BAWfyh3upQfiZiENzhDU9HeB9LB3Q4UaD8xPbXngyDfY
         ZguxvI6FZK4DVkoFXDY+Ii374UV4MCI3t/rcc9pLOD2SBFR8RTpBzJx1RivG7+FZPsM1
         qDrA==
X-Gm-Message-State: AOJu0YxGl7IFX0z942JxR1smKJi3VRkFrwg5P/I+z8ow98qp/Ptt/udk
	xEanDiy0bN/qYX1iRyTz7JhPYxn1GWgMeZ7WrSKtHz441adBsFYT53zj5aDSMA==
X-Gm-Gg: AfdE7cl9c17E7BSTpkECgx7Xl5SR6V679TIInlZrBUgQyf8R8GdBKgoMUwbfoz3qTAo
	zijAkFnlGzIkNJC8afz7XnuPg+Dk0+WKloWF4hWaDPWLoClE2rXHkYdL52JkD+xrjeZ4PrT95CF
	X4gq7LaI9sLN2c+9o2eVYDpkaR/NsMmeh8Ms6AsyXn5j7U2QX0LR/kg2N8RIcMgy4BpNabYguK+
	NnXINrXD9BgaHErVGUZdO51qBx9R8dOhFb8TQ1fbnrjSzTwiYZjRgvpazl3fvac74Ma6Wk1jyVV
	kSQeF8vXXX7GmWM6MlByKRDzaoeE8VrAxNeZ/l70O8dFbrDjC4BJ0YtaIh52mhU79dKlqWDhFpa
	HDOWC2UStGej5b3xqtwazjwwonvcmwhfyadSPR0tCxJL0SI6/oDXnkJBSP8j5Jn5Cj/tssqwZXv
	ikcCqFu5C94mRQkMdgpIIbHw==
X-Received: by 2002:a05:7022:1b07:b0:139:ed5d:5ca2 with SMTP id a92af1059eb24-13b2a1cc9bemr320024c88.43.1782758110151;
        Mon, 29 Jun 2026 11:35:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.214.234])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2abbba82sm272534c88.14.2026.06.29.11.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:35:09 -0700 (PDT)
Message-ID: <6a42badd.97bb2efc.2241ed.eeec@mx.google.com>
Date: Mon, 29 Jun 2026 11:35:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2022054955074689522=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: [RFC] gpiolib: introduce gpio_name() helper
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
References: <20260629135917.1308621-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2022054955074689522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118320

---Test result---

Test Summary:
CheckPatch                    FAIL      3.84 seconds
VerifyFixes                   PASS      0.22 seconds
VerifySignedoff               PASS      0.20 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 FAIL      0.20 seconds
BuildKernel                   PASS      26.40 seconds
CheckAllWarning               PASS      35.60 seconds
CheckSparse                   PASS      28.00 seconds
BuildKernel32                 PASS      25.79 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      490.36 seconds
TestRunner_l2cap-tester       FAIL      57.02 seconds
TestRunner_iso-tester         PASS      78.67 seconds
TestRunner_bnep-tester        PASS      18.84 seconds
TestRunner_mgmt-tester        FAIL      204.92 seconds
TestRunner_rfcomm-tester      PASS      30.24 seconds
TestRunner_sco-tester         PASS      31.85 seconds
TestRunner_ioctl-tester       PASS      25.76 seconds
TestRunner_mesh-tester        FAIL      25.14 seconds
TestRunner_smp-tester         PASS      23.27 seconds
TestRunner_userchan-tester    PASS      20.56 seconds
TestRunner_6lowpan-tester     PASS      22.18 seconds
IncrementalBuild              PASS      25.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC] gpiolib: introduce gpio_name() helper
ERROR: code indent should use tabs where possible
#296: FILE: drivers/mmc/host/atmel-mci.c:2258:
+^I        "slot[%u]: bus_width=%u, detect_pin=%s, "$

WARNING: quoted string split across lines
#297: FILE: drivers/mmc/host/atmel-mci.c:2259:
+	        "slot[%u]: bus_width=%u, detect_pin=%s, "
+		"detect_is_active_high=%s, wp_pin=%s\n",

total: 1 errors, 1 warnings, 166 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/patch/14651677.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC] gpiolib: introduce gpio_name() helper

22: B3 Line contains hard tab characters (\t): "arch/arm/mach-pxa/pxa27x.c:	reset_gpio = desc_to_gpio(gpiod);"
23: B3 Line contains hard tab characters (\t): "arch/arm/plat-orion/gpio.c:	unsigned gpio = desc_to_gpio(desc);"
24: B1 Line exceeds max length (91>80): "drivers/gpio/gpio-nomadik.c:		mode = nmk_prcm_gpiocr_get_mode(pctldev, desc_to_gpio(desc));"
24: B3 Line contains hard tab characters (\t): "drivers/gpio/gpio-nomadik.c:		mode = nmk_prcm_gpiocr_get_mode(pctldev, desc_to_gpio(desc));"
25: B1 Line exceeds max length (85>80): "drivers/gpio/gpiolib-acpi-core.c:			desc = gpio_to_desc(agpio->pin_table[pin_index]);"
25: B3 Line contains hard tab characters (\t): "drivers/gpio/gpiolib-acpi-core.c:			desc = gpio_to_desc(agpio->pin_table[pin_index]);"
26: B1 Line exceeds max length (93>80): "drivers/gpio/gpiolib-cdev.c:	hte_init_line_attr(hdesc, desc_to_gpio(line->desc), flags, NULL,"
26: B3 Line contains hard tab characters (\t): "drivers/gpio/gpiolib-cdev.c:	hte_init_line_attr(hdesc, desc_to_gpio(line->desc), flags, NULL,"
27: B3 Line contains hard tab characters (\t): "drivers/gpio/gpiolib-sysfs.c:	desc = gpio_to_desc(gpio);"
28: B3 Line contains hard tab characters (\t): "drivers/gpio/gpiolib-sysfs.c:						   desc_to_gpio(desc));"
29: B3 Line contains hard tab characters (\t): "drivers/gpio/gpiolib.c:	trace_gpio_direction(desc_to_gpio(desc), 1, ret);"
30: B3 Line contains hard tab characters (\t): "drivers/input/misc/soc_button_array.c:	*gpio_ret = desc_to_gpio(desc);"
31: B3 Line contains hard tab characters (\t): "drivers/pinctrl/core.c:			gdev = gpiod_to_gpio_device(gpio_to_desc(gpio_num));"
32: B1 Line exceeds max length (122>80): "drivers/platform/x86/x86-android-tablets/core.c: * 2. Calling desc_to_gpio() to get an old style GPIO number for gpio-keys"
33: B3 Line contains hard tab characters (\t): "drivers/soc/fsl/qe/gpio.c:	gpio_num = desc_to_gpio(gpiod);"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 2M                     Failed       0.242 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.232 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.862 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/371

---
Regards,
Linux Bluetooth


--===============2022054955074689522==--
