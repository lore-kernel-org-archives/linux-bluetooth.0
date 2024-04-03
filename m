Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8F1429A
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154685; cv=none; b=qImhNHu0g9PpnrKkWP8qKkCnvlNE5n8OAdcYu+FSoqUZ7yfKB12HPPwc8s17sxDGQ4avvOGaaRE2z6HNOlFf65os4dxLT9EH0GmRIsQKm3076QC33Hzqw4Zib8+q1vEsp77Tob2uO/SG+8ce6jYWUVAtAXGggP1Kan4FZ3xSios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154685; c=relaxed/simple;
	bh=jvLsY9a1nkxCE5BCCbKPtWVd5Kpnbbyv6lLhrE13Qe8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JI2E546O9BbwHSMpGVcbhA85FHwXPoz9Bj8hcRXKqUHdCbGHUdkhMQPzVTf7Pk+LbNrZX0yUPmF+3CIaNN3M5PH94O+FTafSbP81v9QfApzKJEf/tJrJfpENUrlyzTBYjBtsYN6WF/9VG+S2vrZVk0REdr65yii9BwxyQsOK4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYtqu+9Y; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYtqu+9Y"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so728312a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712154683; x=1712759483; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=birAYp425XEmWG/uvNkW2caI0/FFMPlzCJNEVRCM8vM=;
        b=bYtqu+9Y1sUu1w92kH3wV1usmdLnbHhkzH5lcGxqO/DRwI3Zfq/gfE7n0VGfkmWuIl
         6UsIuNLcTbdHF+NThoiNfq9AMBwLIE+y8LcjwEEhVL1s1gLyyhKMtt/bTPm8j0z8RLMC
         r4LyV8oJ8SCND8M6OF/t1yZmdlwRBy3UpLu3o5S31JbsmeJxa3WpG9s1bNNVWmOmJrLS
         +qJfoapvHwIwAhpKtL71lAKprL13jRFC7aZ7+EKK4e/WS3A83ARbMTCiX6XcQ4GyFohN
         XYXSuoEEzOww+OmS6RBoke81dBRjEWD7N6h9EOc9w+W4WqO7qQjPByCc/bFomnaCqoAL
         pD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712154683; x=1712759483;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=birAYp425XEmWG/uvNkW2caI0/FFMPlzCJNEVRCM8vM=;
        b=dnLRW28eJQQvU33SsdOVzhjN8cA7AiSjogwFatfZs0R4n1uGAU0gRqMFYQ3050IGWN
         nOnPeq8NhoQoKtncwoTtx+NPLFbyp5PC5jdMuuPwkulrEWt6UMqUFobsJyqKJNPRua03
         +C/m+b5NM82HMGiw93rcY4XKTVY27pu/AH3rYC6pTzx6sZAOaykEX+MrcPoc94v7pRDA
         aWsq0iLnjDBjHSObSgcsfCIKntBzUBMAQ078fmbAcfwtf5QDRmWcXGNoysa6jwRZo4MC
         gxpJZwUQ04Sr1pxJtENvP148PJ9oW52O90m3ory0Z5IJIsNdKRTcw1Edd/lrbMHqpeIo
         wuQA==
X-Gm-Message-State: AOJu0Yx1/AWZOAteOZYEY7VkzdUzmWX2QTXPiK26+kWUxCM9g6JYL8yh
	56XM+qAi+DPXmbfpEDoNkkPkXhpTEdShHZUDZVBAWpx2/IrT1+v8a2jbRGcu
X-Google-Smtp-Source: AGHT+IF++4/aZxe4GOKmc3bjYzol0NhHU5B3HdmPcc5RQ+49Wg3JWxZhqsutkzlvpOVNlX2st94Lgg==
X-Received: by 2002:a17:90a:f50b:b0:2a2:9e5d:9bf9 with SMTP id cs11-20020a17090af50b00b002a29e5d9bf9mr2217045pjb.8.1712154682737;
        Wed, 03 Apr 2024 07:31:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.29.180])
        by smtp.gmail.com with ESMTPSA id mt11-20020a17090b230b00b002a29e717991sm1393289pjb.22.2024.04.03.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:31:22 -0700 (PDT)
Message-ID: <660d683a.170a0220.ec1c.3102@mx.google.com>
Date: Wed, 03 Apr 2024 07:31:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8709429658267043776=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, schnelle@linux.ibm.com
Subject: RE: Bluetooth: Handle HAS_IOPORT dependencies
In-Reply-To: <20240403135154.905614-2-schnelle@linux.ibm.com>
References: <20240403135154.905614-2-schnelle@linux.ibm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8709429658267043776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841098

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      30.89 seconds
CheckAllWarning               PASS      33.71 seconds
CheckSparse                   PASS      39.12 seconds
CheckSmatch                   FAIL      35.41 seconds
BuildKernel32                 PASS      29.45 seconds
TestRunnerSetup               PASS      534.74 seconds
TestRunner_l2cap-tester       PASS      18.29 seconds
TestRunner_iso-tester         PASS      33.41 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      113.70 seconds
TestRunner_rfcomm-tester      PASS      7.38 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        PASS      6.63 seconds
TestRunner_smp-tester         PASS      7.24 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PASS      30.27 seconds

Details
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
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.180 seconds


---
Regards,
Linux Bluetooth


--===============8709429658267043776==--
