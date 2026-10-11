Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076DE343D75
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745683; cv=none; b=kgSjnDjRZyFqW/kdtiVr9kjBC7Swc1Ie9M2SrvhbSk1jR9eqcUgM+I9R6dSfgTdmsFFBaeT4KM1Ay6mLgd6vk/q1jkA+SzKsfLEtLp3+r0WsScz7l1lxSkX1sd+DJO/YZSSlL7rkEM+kwzFCz4epqTcEGMR2S2QD0Gn/0/g4dK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745683; c=relaxed/simple;
	bh=EEZageg/a6WhE5v6y2w1xyw9/SXjSjOUP3jgoQX9ZK0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZDzqj9NG+98dPbzfBScIA0vLOQuq93o9FK/ihw4x0ggyqDKvB/fkILrjQZ9bVcZnYbHB3zF0HVnfohqnKdqqRnVWexEg4pONc+3NX02tPoDagSfKHLTKmRDOBHXRZCwOkWxXZmcrgxHrdo+UCBl82bFY8kwWsiItL+g3LvmNu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INHlHgt5; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INHlHgt5"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-141395927feso2182329c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 12:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791745681; x=1792350481; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g0PIrduS8kn0X4WMrQljsFYa/fubH7MXT+cE4SBnuao=;
        b=INHlHgt5iZijWb6v8Q27xllg4v8mOAvZA1FfHwLUfuc7uxnN1Hb8T+WoLESwTH6gGU
         PehDFK6BKwMJVAA7K1cPCT8LIoBX73iuj01xwuIDIp/KyOHUPiwLmT5X98os0JtMlpxT
         cas06PehE5UvTbus6ErmAeCpqxT3c4FyoeiNxjoZXVb0LHwD9Mz9fn07NO2OFcszv75C
         u7Hz+NeS/nJolI9LNM48Oh8/WrDEXhW2TNwdtNkUh24DAXrrrL219mpNt46+q1hfn4YO
         fnuwORfWH/LnYtgUrBQu3G18lowu9H4OZCV4cTw5aa+zUgfAr1JmHY/E0WudE6SYy3/L
         NXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791745681; x=1792350481;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g0PIrduS8kn0X4WMrQljsFYa/fubH7MXT+cE4SBnuao=;
        b=FfoVdep43XdRVSsaMfIT7fvRhxPHzQ7nlghm4eqEJQt/hZEtlz0xeols7Cl1lT+pO9
         wRfmg54+2ercvkqpIxhDvVFV0fCq6TrzvY8Uio9EGcoZV9teVuMThSPo7iGBErY8Fjds
         JHTgOKjeW3X1pW91e5N+cHuiRm3tzY6mBZCI3/YNe+zpeppPemS6ycFB/PCVgr53+CxO
         V8abVaqbF/77Vw5uMHHq95Tn4cz8WEdyW/BwwlIqZPwxaB05kL5I+a+xd85067y23dRs
         YCkPwjEqESgVt0kOFUcx6RA2Z2SfMLQoBxXl3mxw5fKD2sQsMrECLrBnLLHL49ofFK8t
         TmFw==
X-Gm-Message-State: AFq9FYJJiSzfHE+RclNyFaxWDvMpeHz/7cahaMEpNlevoAfKKqXGQdQs
	nW0CKQVujtqurFUs91OCMp3li7BLjNa23SiC9lijkIBpICp7Q0VU+quCGfeVCQ==
X-Gm-Gg: AYBFou2KeIs1FGAs1uiudndijIu6w77kcaVc4k6MqLDR3qkhf8xz3Qx4NwElR0/gqAE
	kzyJtY5VULh9kiioKPO9LNOLpPgiIMEAHvC8KPuRJtT71S7y0DXCAl1HyeOEtrbPyn56jFylUVH
	GZfbC7g7DS5XU95em7f1VjvMIepv9vJmeqSATTYEsfCYbHSa2v7CwL8oPY60emehO3Gk9TBznql
	GJowdVVrQCNoSG7Lzni36DIx62ZEJZP9cxC+RkEFtA51AmhTDSTJn9ODnHMOponsz/JzIqbLWa8
	q5WFmZsrDWBZT0VuZ4oBBpfLLvwIyqaKTPeUpd4OXMtqU7FFECErQ3gekUlyR1JidSoVbBlt5Fw
	uwA4jLo7rw3yExdupjdzeK+RBIoP1oo8114U9SqjPRAQ6bbobFBH16EFkp8ElyOqhfqEhHIKON7
	VWOc5GvIeb0gx2vh/3Z8SDdvjQh4LBEHmu2XHO8BKOPAgncj/4aM5PaJyqWNJ2O0Z5vicgOcVNI
	ByGyg==
X-Received: by 2002:a05:7301:db84:b0:35a:15e5:2e04 with SMTP id 5a478bee46e88-35a15e52ea5mr2233403eec.21.1791745680810;
        Sun, 11 Oct 2026 12:08:00 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.61.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca329d9sm28485731eec.5.2026.10.11.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:08:00 -0700 (PDT)
Message-ID: <6acbde90.116bf87f.27c28.9793@mx.google.com>
Date: Sun, 11 Oct 2026 12:08:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5240709080133730392=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thomas.gerner@muenchen-mail.de
Subject: RE: Enable bluetooth on BeagleV-Ahead
In-Reply-To: <578087018e274b0dcf25a523adc0d5cc590cceee.1791720467.git.thomas.gerner@muenchen-mail.de>
References: <578087018e274b0dcf25a523adc0d5cc590cceee.1791720467.git.thomas.gerner@muenchen-mail.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5240709080133730392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183346/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.56 seconds
VerifyFixes                   PASS      0.25 seconds
VerifySignedoff               PASS      0.26 seconds
GitLint                       FAIL      1.27 seconds
SubjectPrefix                 FAIL      0.13 seconds
BuildKernel                   PASS      29.13 seconds
CheckAllWarning               PASS      33.25 seconds
CheckSparse                   PASS      35.80 seconds
BuildKernel32                 PASS      29.21 seconds
CheckKernelLLVM               PASS      32.92 seconds
TestRunnerSetup               PASS      791.52 seconds
TestRunner_l2cap-tester       PASS      12.72 seconds
TestRunner_iso-tester         PASS      10.80 seconds
TestRunner_bnep-tester        PASS      3.07 seconds
TestRunner_mgmt-tester        PASS      61.09 seconds
TestRunner_rfcomm-tester      PASS      4.50 seconds
TestRunner_sco-tester         PASS      5.63 seconds
TestRunner_ioctl-tester       PASS      4.63 seconds
TestRunner_mesh-tester        PASS      5.46 seconds
TestRunner_smp-tester         PASS      4.34 seconds
TestRunner_userchan-tester    PASS      3.16 seconds
TestRunner_6lowpan-tester     PASS      4.36 seconds
IncrementalBuild              PASS      31.03 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/2] riscv: dts: thead: Enable bluetooth on BeagleV-Ahead
WARNING: please, no space before tabs
#226: FILE: arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts:401:
+^I^Ishutdown-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>; ^I/* BT-REG-ON */$

total: 0 errors, 1 warnings, 110 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14880416.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] riscv: dts: thead: Enable bluetooth on BeagleV-Ahead

6: B2 Line has trailing whitespace: "used as there is no driver. "
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/896

---
Regards,
Linux Bluetooth


--===============5240709080133730392==--
