Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B8BA26
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469583; cv=none; b=BtCngp+Hn++1YnDQYNDE/OcORvSVaVZ41GG4cSyyXzzjQpizbuMe+/FX7CK55km3UJg26vvimZCtZf+8ztAPk3MRhRxr0GDKwB6avPPz7EzFglxsFYrBSuExJVH1vKGY18WAiJdvrYLzOoxVhvyqjIdEbihorXMzhRJd174A5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469583; c=relaxed/simple;
	bh=HInKCgwlAVs08F4E8Qa2p3M0QP9vXHsbqS5wE1XsLOo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References:Reply-To; b=L1+/s1mKENT2e6R/Q96CFyaxUoYoMAy5P77dP4Yxa/jj4woGcaLX4voemjlwM74SzT7LCmGdn1fJF2KSFoSUb6akvkSQK0S8Y22QBG5jb0s5J9hkmgTrAtajhMfhSALaT2HFh9bhnadUGNXaujekTVCASPhdJzGiZ0pIYYb5CGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z091Qima; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z091Qima"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68174626bb9so8463686d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 21:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705469580; x=1706074380; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e0V3QYFzp+F8zT067QqW6lMsnYlUDTyDy3w4jHdtEyo=;
        b=Z091QimabSvb9TQZ2w0jDGPLJS7EUjGCU59J9XUgvpoEq0zmS78vSvLdXA/VLEwV1t
         UWzbrVs6c3JdSVtz1qt+N1/16yPU8bUjJsJDCamC8d3gFk6hNLPDcoHJvYmTWq3DQNrC
         u0H1tm8A6sv6lDsEvT8q0b7cSPk/nX3nvc/LbKnvUNIiboDXL04SDtm+8V0QNK20hFGT
         t/nxIzACx2D0sDVafnukA/4EXEDE9gUJkf6ys8bTFnme2xZKRwfLtEPXC3jPWi0Fyx1g
         K3Rmb3NIFTRSYlYo92m4K7cXhZ1xAM+OpNQdGf+xtnzouatwHbgzUoX62vtrftqddVxG
         tvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705469580; x=1706074380;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0V3QYFzp+F8zT067QqW6lMsnYlUDTyDy3w4jHdtEyo=;
        b=LQRa7Crj1CbOr9gzjgku/Q5ugKhT+1+yzxOOBsxHEcGTS2kbHp//qAc3UsIiLeOgzv
         BORHftFPTYkMkY7WTGww6U5Dyvobowol3OBAudXbhbvx81qWNXw9ScSEDFU1lzMrhWvj
         irl15XQpDjrfN8TWD+LIWbxiLXALDN3KiLG5S5U1eeEmNtmYnqLA6/UhjDkTzEnrt4vS
         55WzF1DpSCRWIRZsQQRVz9uNFhkXEaafTec8DFID5AKchynnIDGQqirZGMJEm+1eZlNF
         2xm8++VOU1/SDx06VULhdtqMCHEJF+UqcQK7lmDKVPKi4yrU1vsGdQNWafWxlaMMgoyH
         TPBw==
X-Gm-Message-State: AOJu0Yy9iiMKIpuVVwyMniyxATcolkEFJXsUt9L+YaXUy4Zn69G80sLe
	2JMK2dnaTcjaeuFm9TbBfbSHWXDw1X8=
X-Google-Smtp-Source: AGHT+IFnuQ1AVvfRr6mFPmbY2TK/kOnaa8f6SLerOdAGVwmD0IjhACjiSfzQ3EH1ftrxXc2KGvDf7w==
X-Received: by 2002:ad4:5f85:0:b0:681:182:ffe4 with SMTP id jp5-20020ad45f85000000b006810182ffe4mr13118748qvb.48.1705469580620;
        Tue, 16 Jan 2024 21:33:00 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.77])
        by smtp.gmail.com with ESMTPSA id x17-20020a05620a0ed100b0078322b61e88sm4285055qkm.78.2024.01.16.21.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 21:33:00 -0800 (PST)
Message-ID: <65a7668c.050a0220.e8dc5.371b@mx.google.com>
Date: Tue, 16 Jan 2024 21:33:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6118523923413238676=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [RFC] Bluetooth: btnxpuart: Fix nxp_setup in case chip is powered on late
In-Reply-To: <20240117030501.149114-1-neeraj.sanjaykale@nxp.com>
References: <20240117030501.149114-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6118523923413238676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=817400

---Test result---

Test Summary:
CheckPatch                    FAIL      0.94 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.66 seconds
CheckAllWarning               PASS      30.76 seconds
CheckSparse                   PASS      36.11 seconds
CheckSmatch                   PASS      100.29 seconds
BuildKernel32                 PASS      29.32 seconds
TestRunnerSetup               PASS      443.73 seconds
TestRunner_l2cap-tester       PASS      23.51 seconds
TestRunner_iso-tester         PASS      44.05 seconds
TestRunner_bnep-tester        PASS      7.04 seconds
TestRunner_mgmt-tester        PASS      161.26 seconds
TestRunner_rfcomm-tester      PASS      11.00 seconds
TestRunner_sco-tester         PASS      14.66 seconds
TestRunner_ioctl-tester       PASS      12.12 seconds
TestRunner_mesh-tester        PASS      8.97 seconds
TestRunner_smp-tester         PASS      9.81 seconds
TestRunner_userchan-tester    PASS      7.37 seconds
IncrementalBuild              PASS      26.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC] Bluetooth: btnxpuart: Fix nxp_setup in case chip is powered on late
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#163: 
https://patchwork.kernel.org/project/bluetooth/patch/20231018145540.34014-3-marcel@ziswiler.com/

total: 0 errors, 1 warnings, 57 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13521411.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC] Bluetooth: btnxpuart: Fix nxp_setup in case chip is powered on late

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
37: B1 Line exceeds max length (96>80): "https://patchwork.kernel.org/project/bluetooth/patch/20231018145540.34014-3-marcel@ziswiler.com/"
41: B1 Line exceeds max length (104>80): "Closes: https://patchwork.kernel.org/project/bluetooth/patch/20231018145540.34014-3-marcel@ziswiler.com/"


---
Regards,
Linux Bluetooth


--===============6118523923413238676==--
