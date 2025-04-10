Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3443AB7
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274288; cv=none; b=urACRZ8Uo4OBOSCOcSwFQuI7dTJh862oJragWJD29wvDok2HJukQSxzXnHFkFK+Tdd+55352Qi6+o4MIRhlpM2I9d1P/GG4iSFDdSaKpU+4jgsfzUbnUQwOnjr4OAndi1RdzaEol6JrgwjAJL5Ox2ub9RCwHT98bNKny+FKu9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274288; c=relaxed/simple;
	bh=wDhgiJAv04xRpDHhG1YSFTMS7nEFzdiVAk4w3dV+pE0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eskTW16a6K/5pyeXMAJqxMz028TL+wvgFUk08dFNWUgAx66mAl459VntpoYHwmvEWpzXjPxNE++gX5t04FJpkyQ78LwroU69/eUYDD/jCz71K7MvEwbRa87zXveWseYomx109Wo5H4v1bBnyMykY33qoFoi3dLG+UfPG3uzBXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+F3hbSz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+F3hbSz"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736c1138ae5so492472b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 01:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744274286; x=1744879086; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=38xI87Q0q+oD2G4Vh4UkZ+/ntOP2EaClPJHre+no1+g=;
        b=N+F3hbSzQELzbi2uTCBmZkLBt48fkFYLymwumulc96Eq/KCsfok6tTF6HOJemSs66y
         Z7zerIXMPVSvicSuIy16h7Ohf4w5GmdiLqmsx3AegfQq4qbr6Chsz9ytqw2cBSphy2qb
         /teu2qPUug7pX5FW+quoQIhEoTVRPvZjIb7i8CkRTwap7GwALnjlPz5NpmmVAFqeJcyx
         T28axe2/bdN1nmOC20FjepCXU3VezUVP/fNBB1mrm9bkFC/Z4fRLb9KD0evlteVQVNYw
         A7Al5DSQ/vGbz92GCpshYecXn5S+a2tBRsp7uZJCVxsq9Aq3OgfqJqIQqoijUEVCOQ3B
         eONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744274286; x=1744879086;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38xI87Q0q+oD2G4Vh4UkZ+/ntOP2EaClPJHre+no1+g=;
        b=XeQJ+zHNwdUfuCBsefwWwvjGq/uK9N8D17ns0rIs/ZsnLWAMoLI0pe05VHOIb9YHqX
         pCTcke179HXtJAxBHIaNp0BedwO/hE7xew8xNrwYl3j4Ia/t6mfEPUuGFUY683xVmR8g
         3Lz+22WX9zPsAZLG2GBHoM3Jz4PARvnvl4x1qg5h4ffcus8sI7z2ds0AfEJokm2w6JPU
         Pywkha2qbt+hcDt6psiLbbp7AfJ+sIkGwXxUeK0vIsYKu8upNLh0YbTDG/RtDmr9cIg9
         6UTMnRr6TBWSEVLilVaqGg8JZAmsA+ytivQUxV3gQljNeoHliYwwIQTGSu+M9FRBGhDe
         /Q4A==
X-Gm-Message-State: AOJu0YzpJtZWcF72LRP20TnjuMyKKsfCa5gqMsH7Hqj5lxOWPor8gx6A
	wP0ZkWHRMgExGqqeXym4VgkYxFkPiwrB0jWjQ8tJ+lOY2YZIBkFJ1IgBWw==
X-Gm-Gg: ASbGncsHLTXAzM7qMV2s3nI0MHa99VLiuO605FJZzIq1heZ0vhix7HVp+ZfOFLtlnpd
	2G4+AbznkcsB6pj8lAIE0AW8p1LPYxLsZOliA0hCFpOy6VRw/xEIWizbvDUFWbtRgMmA00mZGgr
	jRKndm2VCLK7nuDSCIpLyBg6TA45vIhiCVifQSCKvZKxjEKglsoCgGNsHjiXPCghAaRZOuAJkrP
	adMa65jcBRJQ+DFaAMXtY7RfM1lP4gPrGflMQa0UgP2kuisQjAh/Pt0oKDrLr00R/FUdr4cdzyI
	DNcfIQifbH5LrvZpdpbF1NB3Cn7gfirfi6PktnFK6nH7Rx8=
X-Google-Smtp-Source: AGHT+IE7S1AbX2YLQq2LmprvQcmGdxVJEByBGXuQc/K7Z2ot+qbXdywnoszfFaKf5jh0p0ZrhoEEdQ==
X-Received: by 2002:a05:6a00:399e:b0:737:e73:f64b with SMTP id d2e1a72fcca58-73bbee31538mr2467734b3a.1.1744274285350;
        Thu, 10 Apr 2025 01:38:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.28.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e3833asm2690345b3a.85.2025.04.10.01.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:38:04 -0700 (PDT)
Message-ID: <67f7836c.a70a0220.6530f.95b6@mx.google.com>
Date: Thu, 10 Apr 2025 01:38:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4109417951225198623=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nichen@iscas.ac.cn
Subject: RE: Bluetooth: hci_uart: Remove unnecessary NULL check before release_firmware()
In-Reply-To: <20250410073456.3558507-1-nichen@iscas.ac.cn>
References: <20250410073456.3558507-1-nichen@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4109417951225198623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=951891

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.23 seconds
CheckAllWarning               PASS      26.49 seconds
CheckSparse                   PASS      29.90 seconds
BuildKernel32                 PASS      23.76 seconds
TestRunnerSetup               PASS      458.32 seconds
TestRunner_l2cap-tester       PASS      21.04 seconds
TestRunner_iso-tester         PASS      34.61 seconds
TestRunner_bnep-tester        PASS      4.66 seconds
TestRunner_mgmt-tester        FAIL      119.21 seconds
TestRunner_rfcomm-tester      PASS      8.58 seconds
TestRunner_sco-tester         PASS      13.70 seconds
TestRunner_ioctl-tester       PASS      9.06 seconds
TestRunner_mesh-tester        PASS      6.02 seconds
TestRunner_smp-tester         PASS      8.14 seconds
TestRunner_userchan-tester    PASS      4.90 seconds
IncrementalBuild              PENDING   0.54 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.200 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4109417951225198623==--
