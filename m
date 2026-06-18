Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3D2BDC28
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788915; cv=none; b=bIqtqQIjqYOZWVZmNcEKrrEMEIDHfJ8zA2x8YtpxS3kfXRm+dR46Vx8fy6Fp4VL7nlUTD7yYGBTMRES/DNpjDn9dSdE9cpI4IDb69B2aLEEAekpMxUC4eN6oECLvjff1VtbD7fE+KGNR2KKLt5oI60qIww3iUH6kNUeyE2+XtGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788915; c=relaxed/simple;
	bh=NuDsWTTSOHw1MYKjc/781Lv+l40uKmcJKgm1HOC+I1Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YPhBHjOL9RalHWKxz6E+KpufmkEpiLYNbNbLotbUcZbXgZAIAU2XeCm4aQNpmfpswLjnS2DqLAKQuGF/IUncsqEFHQrKVJfwmJ4beZJQGLucA4lncF39AhYX2iUle82llE5YWVab0QSWuBptWnmyYI5nzIUm7/yMZVdtZJE8wVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KincbdO3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KincbdO3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6bb8a5980so6663715ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 06:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781788909; x=1782393709; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=37gsTtRfDMdYZj+M43X8Yv/N4Y6yoX5EdctiVVRw8YE=;
        b=KincbdO3zEMRanBVp9zfiP2rcQaF4F4HiB72Cz+e1L8oSp8Yhe+NexmBY0n2octkWP
         V/QPqU7a8pLKTR8VfK99wyYB9c3rspYDB2ENqKt3HhCVxh0ujrhVev6pT8lby+khHRPu
         gdtgWNaShUN18gV8LxFngX8IqPFcuL0acSZIfsmozlsv7VcH6YBD2SK197ld/obBDFce
         Rbf729c3PAqEc0IX1UvhIASseiQySdPopcnPyDzzGctuqVCW5j9VHXcE0OszgpEBCpv/
         l0GVdp0Qu5xkxStRfI76C+GtBSUH/M/wEQu1Sn7LWljQv0ebyMBHDKxrgD8TM3ACCDuI
         kjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781788909; x=1782393709;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37gsTtRfDMdYZj+M43X8Yv/N4Y6yoX5EdctiVVRw8YE=;
        b=FySlgEf7jq8B82hCpZ62KkKJW6wMdYK6HnH2PaXFhTGmm26PZBEtMZhBktrZ3LlHQD
         cn10XknQT+f4kQd2pyOlWT0Sqwo49Ny7NI2vNHRFeXH67Lqb5T13Jo3rN2mty3K/BTQ8
         STAt4iCb3jOuiRNFHxYJKqPlqFbECLHz7UnigUOTOIb/7Th3UHdcwM1F4KOaoMSvbfWE
         odvV+8vjOlj1mVUFrQNIy0yUWRsbrnqkjU6ISffqjpepg28GWA02Q56t4iwLmjI+DqYE
         +RwrsIiX0tf7E6CJta+c1suAmKN9+UAhERRJmNyjuL2A527RKJZkY/W955P7SkvGm0cB
         ixdA==
X-Gm-Message-State: AOJu0Yz9KA5KILn3n830OqmshocubTrNb073bxJj+w21jzvTsoAivqy8
	dKaDQ6i9rhBP9k/gPueEJb3Eev2kMp+qiHTcYgyZG+2JDn7vIAM4q3Jvbx/OIg==
X-Gm-Gg: AfdE7ck3ASgqUIVrT/qn72xelRRR3nGzEjpcRrzkKUr+l5bCm4ul9dVo8Xf5NovsyXz
	k9Shsp9C+23fhKLVH1uoTJtcaG5PePZrLDz9+QynYYaat9IEv1vzKhCoraYa7qlItyPDagfGJCm
	HxoqcwOspzjq49zSx4gX/tmrNlqVUg1g8oTC373nzO4UcckNDD7lirLcEtetacrsC9YbsvC9NQK
	G59AnJplW5d0jEOh6poPEAP+PB69ZDHBOnIUkOD+iZKp3R9kYmYmKbtyzF4i9FY+ivkaduGw1Nk
	SAPr38OKahw1TVqKs6wIJNNskkUlOoKFchOPzE6p+7qvGul1wUBiyYqqXRoH4EC0Rz32BXQ6Nq1
	1oAtbZZDmLUC3Zu8GcywICqCV9q1mrYsRIs/3wsXMY22zJChkh4kCy15d81tdzhgA3s9rLzdiaY
	/oFbcILuWf/ExT8cJ5
X-Received: by 2002:a17:902:f64d:b0:2bf:1e59:d99 with SMTP id d9443c01a7336-2c6e47253b2mr44925755ad.8.1781788908440;
        Thu, 18 Jun 2026 06:21:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.3.166.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a4c1fsm198748175ad.53.2026.06.18.06.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 06:21:48 -0700 (PDT)
Message-ID: <6a33f0ec.63d39acb.391892.7d5a@mx.google.com>
Date: Thu, 18 Jun 2026 06:21:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3187415787861256773=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: hci_debugfs: serialize force_bredr_smp writes
In-Reply-To: <20260618102150.3340673-1-zzzccc427@gmail.com>
References: <20260618102150.3340673-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3187415787861256773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1113387

---Test result---

Test Summary:
CheckPatch                    FAIL      0.53 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      26.74 seconds
CheckAllWarning               PASS      29.66 seconds
CheckSparse                   PASS      27.99 seconds
BuildKernel32                 PASS      25.94 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      581.10 seconds
TestRunner_l2cap-tester       PASS      60.19 seconds
TestRunner_iso-tester         PASS      79.55 seconds
TestRunner_bnep-tester        PASS      18.66 seconds
TestRunner_mgmt-tester        FAIL      212.01 seconds
TestRunner_rfcomm-tester      PASS      24.97 seconds
TestRunner_sco-tester         PASS      32.66 seconds
TestRunner_ioctl-tester       PASS      28.46 seconds
TestRunner_mesh-tester        FAIL      25.84 seconds
TestRunner_smp-tester         PASS      23.43 seconds
TestRunner_userchan-tester    PASS      19.82 seconds
TestRunner_6lowpan-tester     PASS      22.93 seconds
IncrementalBuild              PASS      25.13 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_debugfs: serialize force_bredr_smp writes
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#108: 
  2. test HCI_FORCE_BREDR_SMP as set        2. test HCI_FORCE_BREDR_SMP as set

total: 0 errors, 1 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14635033.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
Read Exp Feature - Success                           Failed       0.245 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.549 seconds
Mesh - Send cancel - 2                               Timed out    1.982 seconds


https://github.com/bluez/bluetooth-next/pull/332

---
Regards,
Linux Bluetooth


--===============3187415787861256773==--
