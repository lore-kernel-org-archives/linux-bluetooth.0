Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A4657CE
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463926; cv=none; b=rWKRozI7R91DwaILaGveBss1h2kUanRQjTDkS0rre2zlHtiVXiLPpZyras9EvSXrKFMGPJAzTam/PtK5Jj2ig1ek6BezvIi/6MjbwmsD0Owgo+Jyz5WCArrEOilU8LnioxFHPOEf4Slc/fGIDarWBnRlIOvE3MY1AtDNDM1uEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463926; c=relaxed/simple;
	bh=guiktpwXczqgxntjyWV8p4mbEZkPOlhWdY7vrvlbu0s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WcQV9jEdGsPiGBgdftFXVGRxvy2z3Rsf35H+KTLMXLic4qMN9STYZrQZhlZ3vafb6apVTgIgqaJAhqIPa/RG8Z9/l9Puye8eESvLmRUrdeVUoaJPKuZgbdvM87+3HVleUF0HicxN4NeZTb/WPTWsbmWl0aJH3L4Guy6wVcS5phM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl1ovQCQ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl1ovQCQ"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c0245cba99so228084e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Feb 2024 23:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707463923; x=1708068723; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0/b9/hyMwthiYPIv9kmWQBeAXITT37Vf//li6dGpy9E=;
        b=Cl1ovQCQIAkHjICGVuVfPWgmcH2bDTVsFJrrFUtcVf2wIepMoCXfApTyvsqmRauWsq
         sKo4dsH6ltliNsE9oK2lW7Ju4M/FAlofh94U2mSlcyodvm61Ekvf1NjHuAd3RnoRzuP5
         zBqUBXbpGrfSmvOI82nc2FT51w2YU794whUyE4s/RVhknlPi4j9vIEU17fz4d8DFfTu/
         KdSpvHRhhcJAPS9RyH9YjwqomXB0JOZRf2upy5Enmnrb9TQSCr6OFe/wB0StUEgktSaX
         LJvQcSTFeYxQL/soTijgiMzsKoDjyEA/XhM2gAFeSNa9ufkknHfPlezIU5vEfuDMiQEj
         KJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707463923; x=1708068723;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/b9/hyMwthiYPIv9kmWQBeAXITT37Vf//li6dGpy9E=;
        b=XQHyU2SATXL1co/0dlPq0G8D5Zo1PUB8P7AchK2LtfLh+aU6eoHmXyp+bIFKt+TBjj
         DTOAcLcwCqUPtd79qWUlbIKugcfA1JxSQbSMVrtprzMr61j/WLulNaC5nypMdKz2Kcwe
         OovslTe0l9tV21v6hlCO1BzcrO0P2CN5xva91Q7TZqZfM7S8brH5qqj+0+GsC4v3/JtC
         YRx2gs6u/2jIt0+nkrrZdqoRS6LfQF3+OTsxQ/sjr9K8pRJGdrGRNPD6MndMRfbsc+lq
         t1IuMP7aMVCy8gruXgy2Wq8/ra0Uuz11YItDDqPr2RTHJByq1J05hZNz1087y2dYSn1U
         jxDg==
X-Gm-Message-State: AOJu0YzCeUho59Jm73nusoqcsuX7mu/A4t+xiMKvmUsqJBgCMAXglkUk
	B1cyHN1j1H27FaIfQWV3aRh2aGevP1Lt+oOXjtokBcRCC/0F0QIy6+lqfEaC
X-Google-Smtp-Source: AGHT+IFsuDnleQhQks/ufQjHr341To+Uf0VBMzdWC54b85/mBtLo4FBBk/zZoCCJjrUFK8jLUg7LFw==
X-Received: by 2002:a1f:4b05:0:b0:4c0:258c:e4d9 with SMTP id y5-20020a1f4b05000000b004c0258ce4d9mr826867vka.4.1707463923170;
        Thu, 08 Feb 2024 23:32:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRk0QFmg1BN+R61JnVnJ/ooI/i/050N7BOVTxMHYaqmJ+NFNzCNLNkJ7KdAVzcC0OPVCbkgryHB63CD31hmtNI
Received: from [172.17.0.2] ([20.55.126.64])
        by smtp.gmail.com with ESMTPSA id k6-20020a05620a0b8600b007853eb72c49sm511437qkh.46.2024.02.08.23.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 23:32:03 -0800 (PST)
Message-ID: <65c5d4f3.050a0220.7d74d.2c79@mx.google.com>
Date: Thu, 08 Feb 2024 23:32:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5395317661826391122=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: add missing checks in state transitions
In-Reply-To: <20240209070443.3617790-1-iam@sung-woo.kim>
References: <20240209070443.3617790-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5395317661826391122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=824554

---Test result---

Test Summary:
CheckPatch                    FAIL      0.92 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.45 seconds
CheckAllWarning               PASS      30.10 seconds
CheckSparse                   PASS      35.81 seconds
CheckSmatch                   PASS      97.10 seconds
BuildKernel32                 PASS      26.71 seconds
TestRunnerSetup               PASS      493.02 seconds
TestRunner_l2cap-tester       FAIL      12.06 seconds
TestRunner_iso-tester         PASS      30.11 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      166.38 seconds
TestRunner_rfcomm-tester      PASS      7.35 seconds
TestRunner_sco-tester         PASS      15.17 seconds
TestRunner_ioctl-tester       PASS      7.83 seconds
TestRunner_mesh-tester        PASS      5.87 seconds
TestRunner_smp-tester         PASS      6.83 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      25.70 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: add missing checks in state transitions
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#97: 
https://lore.kernel.org/lkml/CAJNyHpKpDdps4=QHZ77zu4jfY-NNBcGUrw6UwjuBKfpuSuE__g@mail.gmail.com/

total: 0 errors, 1 warnings, 0 checks, 28 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13550940.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: add missing checks in state transitions

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
20: B1 Line exceeds max length (96>80): "https://lore.kernel.org/lkml/CAJNyHpKpDdps4=QHZ77zu4jfY-NNBcGUrw6UwjuBKfpuSuE__g@mail.gmail.com/"
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 485 (98.6%), Failed: 6, Not Run: 1

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.115 seconds
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.115 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.142 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.143 seconds
LL Privacy - Remove Device 2 (Remove from RL)        Timed out    2.184 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    1.846 seconds


---
Regards,
Linux Bluetooth


--===============5395317661826391122==--
