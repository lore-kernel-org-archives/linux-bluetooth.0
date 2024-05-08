Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC131818
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164449; cv=none; b=ejY1LEXwIqtcNxFSeoh/uOUaK+rkrScVSMZ3nHHsXEH4h9z+UGqM1wc/d/6ypQTjtn+ZbiCdHihOHioVvqlzCGXTS1mrZd3dCgeE7vlTZrPC+bGYfNAydQgKU/HVJJDvu8qVupI0+lqewCVJGetjpTWyFAkbCof4X5yP72Sflv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164449; c=relaxed/simple;
	bh=RanUgLYAV0KtHMRNZPpwpuV6PL3Tpr4fSpwD8mydWU0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Txaa9XX2TwDcgeohAYZOwpHw+f25isx3F+NEXqrWhuFZXpQhDPXwcSNM0C0W3oZvasf6UhH35Zpkru3+rWO5bTvYRiNAqGgfyWq+cXSm+N5KDpK/iDj1DXQbQzNdxLBBHc5Pwar06HSlVce2Zy8/NZiGtGcpAAgpzVDZq1WTZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1ouawEg; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1ouawEg"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso3838788276.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715164446; x=1715769246; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hVrH4nWDpy9303nXanJ/BAxnj/mMx1Y/GDqZVc0Fp1Y=;
        b=N1ouawEgFvmP1UqyABleuqO7z1fVm490gHKzUaEwZxcy3l6r4/T+WsINmEvQ1My+Ba
         Es/Za9DQ9HtlZYb62RzT5zarf1/fb+J0lszr1jm+cND0KHAQfuNa5UHuOA18e4bd2kXS
         o60IMgCFe/WaWFNCCF/JgB8lXwjB0IZbRu7Wgt9Ph4D6d0wPJ884aMK65WJgsiPlqZEo
         b0E75nIm9u7RawHl31KA9PQtqHGtv7WrpG/gf4PynL1vGrgfnqC28MKiK41d+CexdXt1
         VFI9XNOFTh8UPwtsxA2IQ61idJlSTRCpP+zGl3nCl1axekDjubcv2T7m1On4aBub1csO
         uosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715164446; x=1715769246;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVrH4nWDpy9303nXanJ/BAxnj/mMx1Y/GDqZVc0Fp1Y=;
        b=fpzuXFy0jGcTpRwoUU7sL8oCP9Lf7gzIwq7r50TLuDmJatVdUX2LuUmZMqaVzSAYcS
         fIW1d7TVAgvO1TajCoCFFnNvMFhq20Mcb+6M9Zz4D6B3yLlX1nDCLxXcjUtn5E7JisFE
         0EDr4OVju28AQGNHLtIyRsDgqXRu12qSs9OHKJTIfqudzeGGzsBn6KQ3678GNv4f8lzh
         frligVKiAzfEUw9Q9elYq+gpOaWNxek89343pYkY1WF0gKphTeYoLC9zgZXO9UDCMl8h
         zFsVmjVgf26UZdXKMFbrh27gBfmVGtLzGiXe2O3YEKk50mDmm8ae9oVVnIis+NSTmxk+
         X8pQ==
X-Gm-Message-State: AOJu0YzbmeokuaLS6mQ2W/eBgfUfZKi8yhn5tQdjjzSjPg2uViu+cyQ2
	9Gjk2YzIO4SwuN/ZD16dm0wm31XUnB28n+LjzWnZdzzcwsvZflAZFFkDjw==
X-Google-Smtp-Source: AGHT+IHEfnJweDObJT0ZJQSa2dKBMG5Mng34QUkI3HLJQaLgdb+wsVMT+quR6fBzdZsssguj0pvr3Q==
X-Received: by 2002:a25:8d8f:0:b0:de5:61d8:a21f with SMTP id 3f1490d57ef6-debb9d20f08mr2154414276.4.1715164446560;
        Wed, 08 May 2024 03:34:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.199.104])
        by smtp.gmail.com with ESMTPSA id ge16-20020a05622a5c9000b00437543e5307sm7501695qtb.40.2024.05.08.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 03:34:06 -0700 (PDT)
Message-ID: <663b551e.050a0220.90358.a1a5@mx.google.com>
Date: Wed, 08 May 2024 03:34:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2889644770819577745=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel_pcie: Fix compiler warnings
In-Reply-To: <20240508095927.155528-1-kiran.k@intel.com>
References: <20240508095927.155528-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2889644770819577745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=851491

---Test result---

Test Summary:
CheckPatch                    PASS      1.18 seconds
GitLint                       FAIL      0.81 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      29.94 seconds
CheckAllWarning               PASS      33.17 seconds
CheckSparse                   PASS      39.02 seconds
CheckSmatch                   FAIL      35.77 seconds
BuildKernel32                 PASS      30.57 seconds
TestRunnerSetup               PASS      529.60 seconds
TestRunner_l2cap-tester       PASS      20.43 seconds
TestRunner_iso-tester         FAIL      31.30 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        PASS      110.32 seconds
TestRunner_rfcomm-tester      PASS      7.26 seconds
TestRunner_sco-tester         PASS      14.96 seconds
TestRunner_ioctl-tester       PASS      7.75 seconds
TestRunner_mesh-tester        PASS      5.86 seconds
TestRunner_smp-tester         PASS      6.78 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PASS      33.93 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/2] Bluetooth: btintel_pcie: Fix compiler warnings

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/oe-kbuild-all/202405080647.VRBej6fA-lkp@intel.com/"
[v1,2/2] Bluetooth: btintel: Fix compiler warning for multi_v7_defconfig config

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B1 Line exceeds max length (104>80): "drivers/bluetooth/btintel.h:373:13: warning: 'btintel_hw_error' defined but not used [-Wunused-function]"
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
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.180 seconds


---
Regards,
Linux Bluetooth


--===============2889644770819577745==--
