Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE333FB89
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947026; cv=none; b=VC6MLI7C7/LOsvJrEhrfxzcVVaOTgKYvo8BjkOWjRIRuuPfiJ8GgSNfd8qnydKP+3WYTxBUKVhXOMo1SOd1aRhSLLoenMI1Gz+hHr3QG6b/MeBw8ZfaE/omrPa3wNoT+qXMLzj8azyDje48i9p4DbHX3SJXBA99FPgqQ/Y74wIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947026; c=relaxed/simple;
	bh=R++4t0I2e/5v6LN7AHj/QnD6Zp3cWAVD0/S0Zz2X8po=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=h9d0xqvQ3KPveTZ3zkHTL2OCAUt6t8PEoqn3sbxuQYJ47dmCep702e5W/LxQBxB3waEuWNL8x7ZmgW66wIcLE+7v6N3ZIpX3mRcHw8hyq3VA0IGimN9rfKB6VAayIALUIvBHzxzYoOpGVRIPO1Tp+MN3H/V440KcpNTw7v3Pu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0bm8g+b; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0bm8g+b"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9b94951cfso29909b6e.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715947023; x=1716551823; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4VjPulxBAqV1Lxxs/sOjw32UZjT9fo33xvwBwiOqWZI=;
        b=A0bm8g+b9mdkmP2HiJcjRY49ZXYQmKmVl1wUl418sooIzTNxVe3UOQvWzlHsEOFSvQ
         w1RabI9rmXJOXlTJ2mrMwkUFmHKVbViBDf+ugoOxKl5OUuGIaacS/JAVld58tDzIlQHj
         +54BLMGoi++KM2IKXPr4+YNX78Wp2Va2T6JPUZCE9SdKWlEWfAbxhVnu/UAB0ek0DShs
         KDUWZACKaFqzLWTPJCsBAuxTUxm3lbYEsTRCiX/7gg39CMFC84gFW8P+llW4XCBdUsMf
         AjrBa4Z/GfNAyxcW1MwTGmjwl3rrNU88kWdHEQZP4QVttPAly8DPdCMAM1Jpi4c1Ff4C
         WPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715947024; x=1716551824;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VjPulxBAqV1Lxxs/sOjw32UZjT9fo33xvwBwiOqWZI=;
        b=fJvdGRFoW7nszaZ0Uop/BUpWvZU4/jaMK2smrAxff5K3JwtMP7zkyd88vew23Kt/Re
         HBOvY9j78AlmnnVCAXkgbtvm2tz8SpRoUcLODJ1lk0rOrLZiJs8VuNXouS7gjA8T02pt
         kIZ0z3RCMhvqg5hnANfOcNQ1IZN05BseGiepb+ASqKiFvUvWoIvpWvVkNdptEhaSKdle
         ed897HHcIOLdSb0iDW7EP323DcP1PYWjv1LbsVGeTwA3IKEujB1iLeKogOUJSZTIyse+
         DJkerng87ReWOfMy3neE8xvZTmrZZSdMVLzDmUeB0IDIa0br7K4CXmt9IfjB+FS/SGNY
         uqrg==
X-Gm-Message-State: AOJu0YzaKoM91YACnjDs9IB9n7oziA1dNglg0K9HWPGGDWocQfPk1hwK
	t81rdW65pZMtTgccWlOc7Dfg0jK6ByNyifSdXF4j/Xolw+zH/Jyu1oBoAA==
X-Google-Smtp-Source: AGHT+IHjSvf1AvLvYz3z5VoBaXxy/27oDlsGCwpECf4RUiQz44XFyONUXEDcg8Cj4Pw8CwGwwxnwBA==
X-Received: by 2002:a05:6808:9a3:b0:3c9:6f4b:f825 with SMTP id 5614622812f47-3c9970ba1ccmr23531438b6e.39.1715947023602;
        Fri, 17 May 2024 04:57:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.214.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2758c2sm895848285a.25.2024.05.17.04.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:57:03 -0700 (PDT)
Message-ID: <6647460f.050a0220.a8c85.e941@mx.google.com>
Date: Fri, 17 May 2024 04:57:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9053088887075429093=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ziniu.wang_1@nxp.com
Subject: RE: Bluetooth: btnxpuart: Shutdown timer and prevent rearming when driver unloading
In-Reply-To: <20240517111535.856723-1-ziniu.wang_1@nxp.com>
References: <20240517111535.856723-1-ziniu.wang_1@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9053088887075429093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853957

---Test result---

Test Summary:
CheckPatch                    FAIL      0.90 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.40 seconds
CheckAllWarning               PASS      33.07 seconds
CheckSparse                   PASS      38.99 seconds
CheckSmatch                   FAIL      35.14 seconds
BuildKernel32                 PASS      28.50 seconds
TestRunnerSetup               PASS      518.25 seconds
TestRunner_l2cap-tester       PASS      18.12 seconds
TestRunner_iso-tester         PASS      28.05 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      109.20 seconds
TestRunner_rfcomm-tester      PASS      7.29 seconds
TestRunner_sco-tester         PASS      15.88 seconds
TestRunner_ioctl-tester       PASS      7.66 seconds
TestRunner_mesh-tester        PASS      9.11 seconds
TestRunner_smp-tester         PASS      6.80 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      27.76 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btnxpuart: Shutdown timer and prevent rearming when driver unloading
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#125: 
  Modules linked in: algif_hash algif_skcipher af_alg moal(O) mlan(O) crct10dif_ce polyval_ce polyval_generic   snd_soc_imx_card snd_soc_fsl_asoc_card snd_soc_imx_audmux mxc_jpeg_encdec v4l2_jpeg snd_soc_wm8962 snd_soc_fsl_micfil   snd_soc_fsl_sai flexcan snd_soc_fsl_utils ap130x rpmsg_ctrl imx_pcm_dma can_dev rpmsg_char pwm_fan fuse [last unloaded:   btnxpuart]

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13666877.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btnxpuart: Shutdown timer and prevent rearming when driver unloading

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (364>80): "  Modules linked in: algif_hash algif_skcipher af_alg moal(O) mlan(O) crct10dif_ce polyval_ce polyval_generic   snd_soc_imx_card snd_soc_fsl_asoc_card snd_soc_imx_audmux mxc_jpeg_encdec v4l2_jpeg snd_soc_wm8962 snd_soc_fsl_micfil   snd_soc_fsl_sai flexcan snd_soc_fsl_utils ap130x rpmsg_ctrl imx_pcm_dma can_dev rpmsg_char pwm_fan fuse [last unloaded:   btnxpuart]"
14: B1 Line exceeds max length (101>80): "  CPU: 5 PID: 723 Comm: memtester Tainted: G           O       6.6.23-lts-next-06207-g4aef2658ac28 #1"
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


---
Regards,
Linux Bluetooth


--===============9053088887075429093==--
