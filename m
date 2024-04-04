Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6FC1C6A0
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260626; cv=none; b=S7qgwUqqjXyc23dgbWQBxzTFcE/KyR5ggPWjhKf2GYssM92oirrZ6Yi1M0Fcw3RnakwWvgYaA6WVODwwouk5X7ZHfH68YYaWlSlB9b9NaXT+ggH8QD6MDKQ5mW2INsKQeuU1P9W0Tk09rrNMbcZBwTn5ruPmpDNT2QUsRCHk5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260626; c=relaxed/simple;
	bh=lGCShbIWFwAo9s/J507dVCMKTD+OlwrkqL4enzK5/xg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QNy8TvmzIKUlXoCf/rLC+0byEphCgdcIrFp1Vu8TAmJ0z9Va2ePXoNk1sRTtAEFCpx0oONYkEze1LPcCo2OjOHNi6HquqqISYHfvYHb9WdPibQEtSKtCt6FOTlBkJZcm/adf4MV8e2Uwj+TEyexFuoQ8yffJgRoOg44bDSEaTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAAfvPQO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAAfvPQO"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6990b53a2cbso20463336d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712260623; x=1712865423; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aiSxwZkMIIqE43ykBjJbBaRkkPBhOlFMvbpRrl2aIEo=;
        b=BAAfvPQOmR/deIXJfGUtsI/S+ogAjZcvKi3QSTLonyrhW1gzuiE2Tiqidisdag0clx
         jtqKkOq/Ml5srVSslkA7cEOvxYoe1CrnU6+OZoZFRFxi9ye3DvvlwIDJMUlNPZrTUYsI
         +AbecCix8e/aQSs+bhxvFav0gnAFXbb3x+3AHfI6UCO/3ynToXXbAHI8blaGNxRpFsDJ
         6GXZZChok+glDfGWdJGKKuyqIfYrwQOU59ASzC2AiXF66ChOAS1IEY6q5if+qCXPuZTv
         oT9zw7dkdev+DRM6CIx5XvFMwKt5ezEalGOl+yrkzkUsViAIhIeNOXfaicrfSmEeTIRZ
         nR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712260623; x=1712865423;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiSxwZkMIIqE43ykBjJbBaRkkPBhOlFMvbpRrl2aIEo=;
        b=p3dBIOC7f7FoxJvkfbr4GMXJLEb7x73cqXOUa8JSbQsfWl/jfKaKK7TCLUZ5vT0ggk
         8whMBDqR7raV+olgKdIpLhMsSX78ruPg9e2q7eYCSl11IZoM+xOxtx/vXArCo7NfCOrW
         KSwniFK42e+0AyoC13J82rgAyVuyaXaOLQXfzEsR/rsvS4+BKUfrRo2iX+Hvwdn08yN1
         YAlxWTmpo+G1g08VOMLgbHz12qI0ie6kPligygkcA0n/0WK6y8QugNl0zZ9oh7Ixpf+I
         4GRqHbhOzTNkJG6SiRy1s4tRPPUy43XBC9ZtuacO9wEDHH3W6MHebEIYXMBguBt1aRtn
         eW+A==
X-Gm-Message-State: AOJu0Yyq+w5ODEYuV+iawPtxQoWaMCvWT94H4iAClWPeKK//Eq2EL3oF
	KaqOm2e6uzdhHAXmpTt4O84h90UY0iGC5WyzkyFIYvazsxs3WCJFdQwWxmHE
X-Google-Smtp-Source: AGHT+IGYNd2cl6f+1FZC7rj2ULqD+/iRs6oN4McNXPVM9S7ckJ9wtCKY/hMTK2QAJB2oBXllQVA7rw==
X-Received: by 2002:a05:6214:5002:b0:692:494f:f0aa with SMTP id jo2-20020a056214500200b00692494ff0aamr860948qvb.9.1712260623251;
        Thu, 04 Apr 2024 12:57:03 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.167])
        by smtp.gmail.com with ESMTPSA id er8-20020a056214190800b00698fe4f91edsm19955qvb.79.2024.04.04.12.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 12:57:03 -0700 (PDT)
Message-ID: <660f060f.050a0220.2cc46.02aa@mx.google.com>
Date: Thu, 04 Apr 2024 12:57:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8956711733111892015=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@wantyapps.xyz
Subject: RE: Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl
In-Reply-To: <20240404191423.1545366-1-me@wantyapps.xyz>
References: <20240404191423.1545366-1-me@wantyapps.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8956711733111892015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841553

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       FAIL      0.51 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.86 seconds
CheckAllWarning               PASS      32.46 seconds
CheckSparse                   PASS      43.20 seconds
CheckSmatch                   FAIL      34.86 seconds
BuildKernel32                 PASS      28.92 seconds
TestRunnerSetup               PASS      519.31 seconds
TestRunner_l2cap-tester       PASS      18.38 seconds
TestRunner_iso-tester         FAIL      32.33 seconds
TestRunner_bnep-tester        PASS      4.65 seconds
TestRunner_mgmt-tester        FAIL      114.31 seconds
TestRunner_rfcomm-tester      PASS      7.24 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      10.37 seconds
TestRunner_mesh-tester        PASS      7.01 seconds
TestRunner_smp-tester         PASS      6.76 seconds
TestRunner_userchan-tester    PASS      4.86 seconds
IncrementalBuild              PASS      27.95 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
21: B3 Line contains hard tab characters (\t): "+				const struct firmware *firmware)"
24: B3 Line contains hard tab characters (\t): "+		err = usb_bulk_msg(udev, pipe, send_buf, size,"
25: B3 Line contains hard tab characters (\t): "+					&len, 3000);"
28: B3 Line contains hard tab characters (\t): "+		if (err || (len != size)) {"
32: B3 Line contains hard tab characters (\t): "+			struct ath3k_version *version)"
36: B3 Line contains hard tab characters (\t): "+		const struct firmware *firmware)"
39: B3 Line contains hard tab characters (\t): "+		err = usb_bulk_msg(udev, pipe, send_buf, size,"
40: B3 Line contains hard tab characters (\t): "+					&len, 3000);"
43: B3 Line contains hard tab characters (\t): "+		if (err || (len != size)) {"
46: B3 Line contains hard tab characters (\t): "+	switch (fw_version.ref_clock) {"
50: B3 Line contains hard tab characters (\t): "+	snprintf(filename, ATH3K_NAME_LEN, "ar3k/ramps_0x%08x_%d%s","
51: B3 Line contains hard tab characters (\t): "+		le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");"
55: B3 Line contains hard tab characters (\t): "+			const struct usb_device_id *id)"
58: B3 Line contains hard tab characters (\t): "+			BT_ERR("Firmware file \"%s\" not found","
59: B3 Line contains hard tab characters (\t): "+							ATH3K_FIRMWARE);"
62: B3 Line contains hard tab characters (\t): "+			BT_ERR("Firmware file \"%s\" request failed (err=%d)","
63: B3 Line contains hard tab characters (\t): "+							ATH3K_FIRMWARE, ret);"
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
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 121, Passed: 120 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.209 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.606 seconds


---
Regards,
Linux Bluetooth


--===============8956711733111892015==--
