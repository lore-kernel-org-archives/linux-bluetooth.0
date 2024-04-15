Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B6F78C82
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195193; cv=none; b=NSRtKE2xfLynsV8iaxxBzCIhe9yaVMpHOcSVlCLPkkuqheTHVD4l/gy1Z39rppi7r2FbAIgLGPhu5k8MuW6oIAP885W7uUiaDsXZ8PK0C64YF5TNTRBEWFQaZY4xpXbfSSe4TPsExkWEzKh74CRI6knm2W3W08hHl4FFEVsAYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195193; c=relaxed/simple;
	bh=Jw0Fn+4YxScOEoGuahMCNDnq0o5n+o5tdJkAHeYHTZ0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gi1RiUXLFumyvUjqhZKp1kfYFZfiD1/yeM5SNdpCyJaX3rKPM8ni9gC/lur83xNuaw+51Y2SCmOFgDcPoFEPV9+em4gzkwFWNrW+itWZiRUzo7wv1xXdrJVuwIFQPPfoobRCyk7AgaFyw8PVaG4MBO2l1JDAfm1JzPRGjuYYg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB6IND3s; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB6IND3s"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69b40061bbeso18450126d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713195190; x=1713799990; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7/M93aK10AMP5cx4H/+MRO5nvqA2NnOWQGt/PT6FyR0=;
        b=VB6IND3sfQvTueA6wvxxpuNs7zZMQBxS7KtOd4rsv3Rahkr2wdA36RnHWVkgsqqdie
         sH1jkSn4+HhbeFvJcfBCI1R620CyY5pt33bU8D9dwG45Lf4ihz9P4o4Pl4UDWSR/0Czg
         nK6Xvmz+5meAJWho40h2Lwd8oaoC85adWywJ2siOM5FRndci4Umx2jzHghdQV6rq4+8L
         CJ6qvjzuFXyd2LnG0ELTk4YGTYgoL2YULj1LjoQEqbIkI2akqR0+wfFHNf1P9OD2W9TB
         0i2hzcx/7F4QvyO4R9LZtRGW5GZoxMIoHtkd1C3Graxi1fy5JO2D+JW/XaWFFWR+dibx
         kyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195190; x=1713799990;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/M93aK10AMP5cx4H/+MRO5nvqA2NnOWQGt/PT6FyR0=;
        b=eSV18QJaroyCa7rtLUsqO+MwN4ueKRnSHGWXEqYezxyNmRPRjlmVxzUO9r/LHXq8IR
         FJ/Yab3WCGQaAH04IKvGsDfTI+7oQHtcaPSO/EcbT0ex8Vg7jFPySmjWiQWiGnei52k1
         ljNWUTPry7uGwUs7zUjCkvyVaGIv98lz1tmiX1JCJavnqHT5Vb8zT3x2G5fpKxTR8hXE
         POuQx7YKqtaOokUwQbaVkQJWirriV1LUcQ17q33wO0A5PzMeQPpPUl5gCfkWVRplX4eu
         ddV4hJic4O4MZhdwJODEhx3cbQYDRnUUsOm1Sc7/ODJs+86Np/0rBq5wmvW3UWpRVCQb
         G05g==
X-Gm-Message-State: AOJu0YxTptiY/cw3VV5s/zzuOBJjIDSfLWha8CegwW/CYNOdwZrO5dHv
	Y7lGZ2TG8acQw1A5AbwazQ7aq+tCinlQJp7MaYFn5RMaY/GWfNXG1V0k0w==
X-Google-Smtp-Source: AGHT+IGzxH3GbCuwpz40T3a5YU5Jxr2QFo54EgXGO+nlF3Z1MoPq35TrhauLXPingZQRa4vsdmQrCA==
X-Received: by 2002:a0c:fb08:0:b0:699:3025:566f with SMTP id c8-20020a0cfb08000000b006993025566fmr11218740qvp.38.1713195190281;
        Mon, 15 Apr 2024 08:33:10 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.238.221])
        by smtp.gmail.com with ESMTPSA id j2-20020a0ce6a2000000b0069b61cda71esm3875742qvn.84.2024.04.15.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:33:10 -0700 (PDT)
Message-ID: <661d48b6.0c0a0220.12969.772d@mx.google.com>
Date: Mon, 15 Apr 2024 08:33:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2307628980710187087=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Bluetooth: hci_event: Fix setting of unicast qos interval
In-Reply-To: <20240415144430.34450-2-vlad.pruteanu@nxp.com>
References: <20240415144430.34450-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2307628980710187087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=844684

---Test result---

Test Summary:
CheckPatch                    FAIL      0.90 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.88 seconds
CheckAllWarning               PASS      32.46 seconds
CheckSparse                   WARNING   38.05 seconds
CheckSmatch                   FAIL      36.47 seconds
BuildKernel32                 PASS      28.89 seconds
TestRunnerSetup               PASS      519.60 seconds
TestRunner_l2cap-tester       PASS      18.36 seconds
TestRunner_iso-tester         PASS      30.67 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      113.50 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         PASS      14.93 seconds
TestRunner_ioctl-tester       PASS      7.60 seconds
TestRunner_mesh-tester        PASS      5.72 seconds
TestRunner_smp-tester         PASS      6.76 seconds
TestRunner_userchan-tester    PASS      4.86 seconds
IncrementalBuild              PASS      27.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: hci_event: Fix setting of unicast qos interval
ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 0 warnings, 0 checks, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13630191.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
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
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============2307628980710187087==--
