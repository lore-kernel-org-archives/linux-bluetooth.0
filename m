Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B0194A53
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jun 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593181; cv=none; b=Yio/Ax9JCXUMF8veSeyrg0REoy/MPKeAyrowEYAF0t7eb70sKuGngrE34hu6zM6GPUAB7hbsyMtUKfwjf5zz+6LUaUmUfCfv8fCbS2yYKWdKZ4yqv569qQ253GIT8FfJsNSKqlBn0C8qV/GzYQw3hmi0HlNGPfEyS/1M/ihTCF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593181; c=relaxed/simple;
	bh=xaWLg0jYxDEMFZ5ckEhKakU9W5NAvNld+JTOjn7PBYs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k5axcV+Mx3pcQaHcp5eHQ8CgJfmpxaN2EKwAR3oJTvmUkrRQ1rMzxDAYMxdnQb+ZaToqTrdnL6O3CgzfvUuWrnAq7MuKYj1nrGuEBtUSLjuPsKooh6ATx88Iw04Wy0rMAxQCf/WnNQehfKd+Lu18OI9CVG04iNC+cjLWKnhkTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLL7na70; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLL7na70"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b9c7ae2c98so1234687eaf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jun 2024 06:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717593178; x=1718197978; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dRuEhBSP8JpOWbeVE1ECNF4Ir5HAcGBuRVQPH2ErAi4=;
        b=mLL7na702JJJTzZy64Gp0kvNvTSjKbw2jUnHEAQehfgMp3yiAX4u3osNH5i6kl04Uj
         msosqHnq5or5ixp5y9/UWcISUfeglbMIz0NI0xbtrRivAM83qV5+frNpb5ajtN0UVMwg
         liu/m70F/cmpLKYNMyQwqiWHlHpYbbZp0IF1T3BSLj6VhYIf35lqw0QMtxgExud/6fJ9
         qO0mwwREFN8/2aWOP+PLDrQ2VlLjtj9GbnZwNxX2VUCTwRQVRT4f5o6T5g1GOFhXErcQ
         BbkKwEnEr9cnCKnemV1F5q2Z7LEW1cyBQ02a81c2++xRpGk1jNbBm/+8Ew+npwNRFFeg
         +eRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717593178; x=1718197978;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRuEhBSP8JpOWbeVE1ECNF4Ir5HAcGBuRVQPH2ErAi4=;
        b=YHGlk9IdqzYCAJG9gR/6c2GC2p8ThDp1oadU6+rSXjQ+HCcnoCMEYyeXCqILj263vW
         Mq83XjElXRcm1/yYTAog1aZubrfElaTWy7yRUAOCnbZTxRb96fMd3DnOlSf1bZE90iC6
         j8QSGJamVTyCwT62iSiHblH9k9RvuzCRnFQVuL/gTNVfZW1J6dX/YCX+hxgNwMKjXbSg
         K5YxkNYOtt+wGnxFuCATNd77W99DYdKGIMDXH9lgbuAZUYGzqqj2PDZoSJHgTmW7OPOZ
         xZqAbAIIGr50Z/4u6bGPouJwKn29w5GrV482LOCDIiQXgRl1/LGJHIS90ynFwY7BYxJu
         5KIA==
X-Gm-Message-State: AOJu0YxVICMdsm/wy0fp0anV6FhB5zk7o81JWkTll3houHOn/ivxfRWK
	mh9ipb+pIWkZ5m4HcSNbfNcJqRNW8c1ySIlSS7nkw+SQaJLReh1lvVMnXA==
X-Google-Smtp-Source: AGHT+IGhi3V4HaNfT/8dR0x2xkPBN4+1Zldg5WOpGuyf/wSY+g1/aB1RH7D/WVgYSf1pHRh+nQX85w==
X-Received: by 2002:a05:6358:2809:b0:199:2942:1b32 with SMTP id e5c5f4694b2df-19c6c68f609mr271578955d.8.1717593177935;
        Wed, 05 Jun 2024 06:12:57 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a5964f1sm48315916d6.0.2024.06.05.06.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:12:57 -0700 (PDT)
Message-ID: <66606459.050a0220.fad90.570b@mx.google.com>
Date: Wed, 05 Jun 2024 06:12:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8534803293047653844=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: pwrseq: introduce the subsystem and first driver
In-Reply-To: <20240605123850.24857-2-brgl@bgdev.pl>
References: <20240605123850.24857-2-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8534803293047653844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=859074

---Test result---

Test Summary:
CheckPatch                    FAIL      5.03 seconds
GitLint                       FAIL      0.82 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      30.02 seconds
CheckAllWarning               PASS      32.76 seconds
CheckSparse                   PASS      38.99 seconds
CheckSmatch                   FAIL      35.25 seconds
BuildKernel32                 PASS      29.18 seconds
TestRunnerSetup               PASS      530.88 seconds
TestRunner_l2cap-tester       PASS      18.53 seconds
TestRunner_iso-tester         PASS      32.68 seconds
TestRunner_bnep-tester        PASS      4.91 seconds
TestRunner_mgmt-tester        FAIL      116.67 seconds
TestRunner_rfcomm-tester      PASS      7.49 seconds
TestRunner_sco-tester         PASS      17.12 seconds
TestRunner_ioctl-tester       PASS      8.42 seconds
TestRunner_mesh-tester        PASS      6.08 seconds
TestRunner_smp-tester         PASS      7.05 seconds
TestRunner_userchan-tester    PASS      5.10 seconds
IncrementalBuild              PASS      33.20 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v9,1/2] power: sequencing: implement the pwrseq core
WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1374: FILE: include/linux/pwrseq/consumer.h:31:
+	return ERR_PTR(-ENOSYS);

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1384: FILE: include/linux/pwrseq/consumer.h:41:
+	return ERR_PTR(-ENOSYS);

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1389: FILE: include/linux/pwrseq/consumer.h:46:
+	return -ENOSYS;

WARNING: ENOSYS means 'invalid syscall nr' and nothing else
#1394: FILE: include/linux/pwrseq/consumer.h:51:
+	return -ENOSYS;

total: 0 errors, 4 warnings, 1274 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13686797.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v9,2/2] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#192: 
new file mode 100644

WARNING: DT compatible string "qcom,qca6390-pmu" appears un-documented -- check ./Documentation/devicetree/bindings/
#510: FILE: drivers/power/sequencing/pwrseq-qcom-wcn.c:314:
+		.compatible = "qcom,qca6390-pmu",

WARNING: DT compatible string "qcom,wcn7850-pmu" appears un-documented -- check ./Documentation/devicetree/bindings/
#514: FILE: drivers/power/sequencing/pwrseq-qcom-wcn.c:318:
+		.compatible = "qcom,wcn7850-pmu",

total: 0 errors, 3 warnings, 361 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13686796.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v9,1/2] power: sequencing: implement the pwrseq core

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (94>80): "Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK"
[v9,2/2] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (94>80): "Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.165 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.353 seconds


---
Regards,
Linux Bluetooth


--===============8534803293047653844==--
