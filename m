Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08393815F0
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925300; cv=none; b=IMQIRvuE677aquaa7dZYbKmFRMsCvdiuXzW6eEJUUHkYArSKoW6VWbMEXSlgzrAblB00Yn302UC/fgnhmnmkNjHkDLnYLqjdjlLJAvUB+VN+xVdC1hoe9JhKLKEivQMjF1HhO9TmZHVPz3cUH+gl3yOXh5KqL8aXeUUQpzSdrMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925300; c=relaxed/simple;
	bh=eq7lfAwCRGEFK23s7oV8ipl2PCQyjGcYOorRgUHtX8g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VqgAP7P2Q19ilJ4jpzdZEQ4dSRDRVIkQ+LvJqMeSsIj9s4PgxkGF0KNPTCyAjyytbXUYf2uH4RHE0yBNsarqXxkryIEfgW1tysy3GWpjhgFM214yR152+H7E/g5gpxo6GFHWnPYHxcicjEHLNz4yzgwOs8J2sV69U+fe3UUgQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5CXEujF; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5CXEujF"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4955cd5da3dso379645b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782925298; x=1783530098; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NZHmmDGMQAtW6gkQpEDt4RtjFLI5DIkbWR9bVikAl/g=;
        b=W5CXEujFoomzxsPEtH4ae2yE9i8LMasLYARPbk9pjwv3wcTbof89FqXvUW7mX6OEIa
         N8oio/HA90r6GUsUeQW+IlVbqaWTj8hF32xEpKR5QzTs9rFKp9jWIvXgQjWawuG1l0gY
         WEZi74kuQ+kB+hUpFW0shd3Yquyauho7Xld0PN6WFL3lBqRhAHj0Yvo+LT5oELgNda6h
         EGg8lBwry38dva8q6IBN42GWIvDa6zmQ5M6Qfk75qLBDRax/u7YsOqnqA73P9JM4l8Vf
         LwG9k4J5YI3Cc2w1fF5DHxiFwCMbRSKbTOTR/dvYanCtECjya4zwQnSiHhCYKeKEtcV3
         0QSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925298; x=1783530098;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZHmmDGMQAtW6gkQpEDt4RtjFLI5DIkbWR9bVikAl/g=;
        b=FOGyA3tzt4DIBXjmR3ks11cIJMQQky3uciK0vixt3kC3TODZ9+V5guDVHSriuZHvbU
         bg2OhbG/qnq1LY4lQjoqV3sWNu6ZPAdm4UJMYyGvqgvQXmGI7lYR+b+aJSni51O3mpc/
         165qrrxEdj3slG4FBnA1sK9eiw88BD5cFkt0f1bZY3U17Loh1u8deQl63Y3wT4lS2Eue
         HLrNpntNiNWxtdTaVNq8AIK0/OzvmSlpO7ZOAvw0NLSDcVy5c6OSI8bF6j5+wyhbkKQ9
         OniDREt9Wqfwzqgc35IX1R/4pNDY8QPSdeeeXPrXYRz0G1sGBZPf+Ha+u7f+ZKlNlBks
         NfLw==
X-Gm-Message-State: AOJu0Yyul7VuC2Wq5SSy69dOfX8viK1NHeP2yKXwTNNVOMQrcEQTOUiB
	gpbPiKGYs65XR5OaZ9xGY0sTUR5vQdjWg7dywVcdV7oIYzhoEz4UYhz1Hp0+8g==
X-Gm-Gg: AfdE7cm/XY1zqSsKrFW9yTGwpgU+beHhAILe6vBzG7ISTGTgPwWzYyW0GQE+juTa+RF
	Czez2IP6s928b5MfnK4tcwiURCCySpzS0CgpWFlsw5ZPcUzB/Jx6J7HyxToY046QXjLV3bkFREp
	AKMzGBCATeDnPgEGqgLV5bLuJnGdF4uMXKF8i37cp4D79qOLngxN3YIR3xbJW04fZdpqgTkeu2n
	G6+dKz3rLK4iPlKCsOGW7xhx5OCgRbRrzXduji2zKIYEvVDJ/UFjJ9+jhOyTo0xm5gTpNJxzQN1
	cA8NHT934IULlrheNlHAdZK/Z0KNJVMG8HLhCgQUlDNd40nfg3vJFEV4ukrvMOlXp6IMV/ZhEhP
	EQtQ8CDLH9R2bkVXMGSiTgLhatNTjTHNTyXsDG3EmVNUe5iIsGb9Z04yjmDu9bR+vC74R4iTZ4A
	/TQxjaSsv1cuwynUIikQ==
X-Received: by 2002:a05:6808:198e:b0:495:e16d:5d03 with SMTP id 5614622812f47-4960efea9ddmr1912170b6e.21.1782925297489;
        Wed, 01 Jul 2026 10:01:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.87.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9b1c4sm1804486d6.48.2026.07.01.10.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:01:36 -0700 (PDT)
Message-ID: <6a4547f0.46adc49a.f92fe.929e@mx.google.com>
Date: Wed, 01 Jul 2026 10:01:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0066528087043304972=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20260701-block-as-nvmem-v7-1-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-1-3fe8205ef0a8@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0066528087043304972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1119976

---Test result---

Test Summary:
CheckPatch                    FAIL      7.97 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      2.89 seconds
SubjectPrefix                 FAIL      1.10 seconds
BuildKernel                   PASS      27.20 seconds
CheckAllWarning               PASS      29.59 seconds
CheckSparse                   PASS      29.34 seconds
BuildKernel32                 PASS      26.43 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      498.54 seconds
TestRunner_l2cap-tester       PASS      58.96 seconds
TestRunner_iso-tester         PASS      87.85 seconds
TestRunner_bnep-tester        PASS      18.80 seconds
TestRunner_mgmt-tester        FAIL      208.06 seconds
TestRunner_rfcomm-tester      PASS      26.03 seconds
TestRunner_sco-tester         PASS      32.36 seconds
TestRunner_ioctl-tester       PASS      25.47 seconds
TestRunner_mesh-tester        FAIL      25.88 seconds
TestRunner_smp-tester         PASS      23.24 seconds
TestRunner_userchan-tester    PASS      19.55 seconds
TestRunner_6lowpan-tester     PASS      22.78 seconds
IncrementalBuild              PASS      75.39 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v7,5/9] block: implement NVMEM provider
WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines
#213: FILE: block/Kconfig:212:
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
#235: 
new file mode 100644

total: 0 errors, 2 warnings, 172 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14657089.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v7,9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

1: T1 Title exceeds max length (85>80): "[v7,9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses"
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
Read Exp Feature - Success                           Failed       0.233 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.529 seconds
Mesh - Send cancel - 2                               Timed out    1.985 seconds


https://github.com/bluez/bluetooth-next/pull/382

---
Regards,
Linux Bluetooth


--===============0066528087043304972==--
