Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F491127E25
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499001; cv=none; b=UWvMkRCA7KOsZbWY7sXRmm314iJEb7/+op9sISfQBqdOlmN0stB4IV55E79kFKTL24yu3R2toJqDkVva5VZgM5O+jW+7cqqh7ysfXHG8FUU+/w5ikxDAkzFyzxsHJuxbwtetQR6FKubTHCuomgvrVFWOYONK8oOuBss22PCUpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499001; c=relaxed/simple;
	bh=+0NBOmAOdSlD8JBTV+P4zN2CFLFBTfhknsRM1noODK4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lSLYUUrvW73gqARpH3fT5KUfNcVwnBP/sdQv9tgeUBNQNgu6jThOx54PQ9VKY0ZnWTzS//Xi5/71GSzSoyCg+aq8qKQq/kNVnNmEjt8/96g4Bnw+8W/XgMEoiGsekClGmp+uEZ6qqMF002LGHh9TZLRjtRFsem1kyQNc6hEl2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLdSimwJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLdSimwJ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-53fa455cd94so4599486a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714498999; x=1715103799; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LKYjB8tHxwkJBenU3PmKeBCHujQQtIarsMhX2nu/dj4=;
        b=hLdSimwJgBnZStAb9eaBgTCn2riiABsDb2PhCW2byWQHUYiGQWlpuKbVCgOTNToaLk
         bJ6bN1sY7lQIpDse2Q5sieUDRmGu+JeWgJr9cvWHq9ZtNHBuJDAV5KxOJDluKQa9E2+A
         oQdNIGzGgosEPZBqNOfQu/wu7h/Q3j4t0KjBclWNk9qS+qL6sfbkpYEWiLcJ9f8QJJQm
         NqamZzeN0KH67mJAVuMlXv92o6aPgd4QOpZTXglvduHKCYgO3+fQSOLWpQ3PowGAFx26
         pmSnqknugZnSeQFqdgBm5RU0FERvoHGD/T/cok+6+PQ2obBb08QzeOI944FbR+CsfnZ6
         1JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498999; x=1715103799;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKYjB8tHxwkJBenU3PmKeBCHujQQtIarsMhX2nu/dj4=;
        b=JaPk+dRz5g1yaDCYGRjQ/5pPCGPIldOKX0p798qTt605qaYZfU0i51cVdmKR07Mn3t
         hjpnBHvu8tQBi0V/CiXRp9fSM90ar9aJw6RFY24G17S/p102Exs44tLizOOK/Y62ZZMi
         g8TDN0/AuumpbDggZum7JqmBqasRBVt9VeNtUJ4SNPUHNPzOkweFRooZLTGvpN2S//t7
         jWzb2rqVi0wTFMmal2SFdeCXUY0YTAr7n51edOR3II/TcnoFpeylczo+mwURxBJNRsEK
         vW0Uxo5NrkB8AUac5UwEVKPTLcy9IxA3QR5XS9BkkUTX7I3CKbjDIIiXilpy6y2n3Wrz
         WtVQ==
X-Gm-Message-State: AOJu0YwuY85oS3QmewcJ7vMtE9VDQ5sSXmPCd6fwin9apd5kW+XDArUg
	cY7w9qCuIMElnABJ2yeQfi9BYCxYXGortAtKSSZaHBDHSE5vggireRfVkg==
X-Google-Smtp-Source: AGHT+IGNcXScO3JASS98zLpnrbOZIVa+ZS9kT7awQDNNl7T50WJi7OfoZlTZgqDsmD/WovNsVC9VlA==
X-Received: by 2002:a05:6a20:f392:b0:1ad:2016:dfeb with SMTP id qr18-20020a056a20f39200b001ad2016dfebmr617368pzb.11.1714498999165;
        Tue, 30 Apr 2024 10:43:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.24.215])
        by smtp.gmail.com with ESMTPSA id gg21-20020a17090b0a1500b002adc80dab50sm16074234pjb.18.2024.04.30.10.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:43:18 -0700 (PDT)
Message-ID: <66312db6.170a0220.1e04e.d249@mx.google.com>
Date: Tue, 30 Apr 2024 10:43:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6788276192886125317=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: qca: generalise device address check
In-Reply-To: <20240430170741.15742-2-johan+linaro@kernel.org>
References: <20240430170741.15742-2-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6788276192886125317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849404

---Test result---

Test Summary:
CheckPatch                    PASS      1.83 seconds
GitLint                       FAIL      1.01 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      32.71 seconds
CheckAllWarning               PASS      33.33 seconds
CheckSparse                   PASS      39.16 seconds
CheckSmatch                   FAIL      36.83 seconds
BuildKernel32                 PASS      29.51 seconds
TestRunnerSetup               PASS      534.15 seconds
TestRunner_l2cap-tester       PASS      18.55 seconds
TestRunner_iso-tester         FAIL      33.93 seconds
TestRunner_bnep-tester        PASS      4.68 seconds
TestRunner_mgmt-tester        FAIL      112.65 seconds
TestRunner_rfcomm-tester      PASS      7.35 seconds
TestRunner_sco-tester         PASS      15.05 seconds
TestRunner_ioctl-tester       PASS      7.93 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PASS      38.57 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/3] Bluetooth: qca: add missing firmware sanity checks

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 4.10"
[v2,2/3] Bluetooth: qca: fix NVM configuration parsing

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
32: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 4.19"
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
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.235 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.162 seconds


---
Regards,
Linux Bluetooth


--===============6788276192886125317==--
