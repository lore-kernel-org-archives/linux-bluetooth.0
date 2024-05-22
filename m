Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57966757FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379062; cv=none; b=S/zMf7bbR0VpFgQOQJ1wVnFq0Fs03vrLKomGdFkt2z94W8kS/z1cf6W+u3zo6W2aChuW1NiuZ0An5FHJJlw5fjJbPjcsU5zLuCPN520ObL3kqpVkFq+IHXih25r2lsqExQMmuF3qklvu5n4qSfUNRsySXTuJh5Z3RCqSiDbzwoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379062; c=relaxed/simple;
	bh=yuKesnpOslZBxHtIanBnfz1Qw+gzTZL1KHiWi58Zkkc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jLAiCNsmNTyGAFHBu86cjaoAmyJHABE5r96aOxQ6bkhPBFy5FrCgwPq1RHw9J5xyvI5gLWGQxV6WPJUecTn6HLfa1Vj7mriGN1+KZaniYokZcmBsXg6O8M1ZzhH3/J8ZWdBgFTTjdSNgVfsoDpwhi5TWSkX5aAlOyywSXCYg5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9+dYyV/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9+dYyV/"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43f84f53f66so6213921cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716379060; x=1716983860; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uQkB4Se7hiAV/VXTxzNAAwDN39LP7bDxZNQMNEioeEo=;
        b=G9+dYyV/nqgWwZ7zSWi8vSQY7H9VhBH/xI8zo5D5J06uzM2hlB7cJr4GoV4i1ouqCP
         DWvhPuebgLvcEDwciTHIWjd8goo95PJIhKZ/9EczFUvRWP6bVwTvaUk9fDwN6VsRaETI
         Xetv7y/pO8qlKInTHsF2PBp4TNGrnsBOm569/hd7eWWu5YrOlKy9ruGKRG5Cn46PfCPU
         cWy0wXndX7QujTkhKuTNpEEjTGOCiPDgBhaeDsNpnJ/pN14eLseFLrACQNAW63ZQSDoX
         9/4HccxLM5pRQvub+gRWD/E0eBQgbJE+PmuOXqUPGT7sgB66vr5PFZpYR5lRJHXCA0bp
         ec9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716379060; x=1716983860;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQkB4Se7hiAV/VXTxzNAAwDN39LP7bDxZNQMNEioeEo=;
        b=fOsxzSAP3Ml0IzM6QvTtFJT86oEtSfuVrRf5HguE0rVfdq4KlckUxidDF/HvCr03AU
         4MtRAx5iSaCM4vLnHzSg27USM+Fea4tkvywHY85Nu7mqFyhtO89qZJeUjb3TsinCPKRJ
         zleI1MahuyyLTf/flnTER0ZXO7JLu52kusYjPynw1g3bWq6S1PdySoIU6XSIqnebZDJW
         jZKAtssltbwNqOGxGf7IFx3g9UJBtdTXlAKc5oC6y3RbRoojCfTAu/DbtkYpyjVENBcH
         90F7iNcrasdG0axWxLBbSIR4mnkmpk+CFpxTU2knrTf7s/+B0vDJlTIadBoJW7VMJQvh
         Ddag==
X-Gm-Message-State: AOJu0Yxk98gkEnw5T5rSaWLC8HfQC6WImLYFMhI3lCoWO+p1KbDCePP2
	MZbASyOiI/pXxgZhTz++v1BGPC1gO8H/hiPUAZm9Aw9NuPWeva7OMNlytA==
X-Google-Smtp-Source: AGHT+IFhSetUr4NJRqkE1URL+uy4nVyK2seYIZRWPzf3DGbzLbkU8v9+LF7kiltBoq4IKRKCBb0GoA==
X-Received: by 2002:ac8:7fc4:0:b0:43d:fd4e:b893 with SMTP id d75a77b69052e-43f9e1ababcmr17847471cf.45.1716379059952;
        Wed, 22 May 2024 04:57:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.75.94.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e046467a4sm154768861cf.83.2024.05.22.04.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:57:39 -0700 (PDT)
Message-ID: <664dddb3.050a0220.aab7.1a0c@mx.google.com>
Date: Wed, 22 May 2024 04:57:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7168230585094234787=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Bluetooth: vendor specific ISO data packet identification by handle
In-Reply-To: <20240522111139.2612601-1-yinghsu@chromium.org>
References: <20240522111139.2612601-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7168230585094234787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=855020

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.30 seconds
CheckAllWarning               PASS      32.73 seconds
CheckSparse                   PASS      38.52 seconds
CheckSmatch                   FAIL      35.58 seconds
BuildKernel32                 PASS      29.17 seconds
TestRunnerSetup               PASS      527.00 seconds
TestRunner_l2cap-tester       PASS      20.46 seconds
TestRunner_iso-tester         PASS      32.82 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      113.45 seconds
TestRunner_rfcomm-tester      PASS      7.40 seconds
TestRunner_sco-tester         PASS      10.93 seconds
TestRunner_ioctl-tester       PASS      7.82 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      6.88 seconds
TestRunner_userchan-tester    PASS      8.56 seconds
IncrementalBuild              PASS      29.36 seconds

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
LL Privacy - Add Device 7 (AL is full)               Failed       0.198 seconds


---
Regards,
Linux Bluetooth


--===============7168230585094234787==--
