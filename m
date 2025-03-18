Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8020F068
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315777; cv=none; b=MUd4B/a+yXDRtoKgi+3lMJIqPKb0NSQa7huYZoeXIrdgzqJOSeeb43CPVmj26LyUtG+iTbl/lhzWSPSSfF6NVLD5OXqd/cayZi6qmAEJ1IuS8YJ25KSjyHpwGzXp/VYavqROLzy72I9stU+2N6BY3pZu2QUzMJzi7R9ifLb1Dpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315777; c=relaxed/simple;
	bh=4H5DH01BtagQna3Q/NR7ejc+BCajrMZv0xpEtqV3pJc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Yczzo0lZZfZI6dkw3X7D/y86b6gUMVWcpP6/xQsb98HbJ6uPoujbV2x34UmGc08ZAxLL/5RP9MEdB0xz7pyQQhIjqfTtzl59ElEfyNNioXPxAOJUJyd4lUVevVioVET+4GgDbW3AXz7ozRq3EHHoxuBPnsxIEtsBT1UWtnGwijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs5iOaG4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs5iOaG4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22622ddcc35so49448285ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742315775; x=1742920575; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TfIKR9rUFMp1IYqJFmAj749mAyZirkpFmhYPkrBF640=;
        b=Hs5iOaG4oKjsl/XQyM+rpvsPILHmvOoMsrR3xVIASps3h8+6dQSW1x493kHnEgC1RT
         PuepW4ZPT3z3DmRZzZzM0K9dywfMaQpt3cxtQZ5GcrIGP46Mj/8y34AxjNIz2ulqiivz
         Gd0m3VQmvX2T5v+Na5depEHSB4FLgkWQR1yV58w+r2+uJs8nGsfiTjlJoRm3sjZOWCDD
         HENsGPp3W/OADkAKHlDiSuMFGltMpBEA53qtfE/2O/vksfJAzmEc+0Gglpl4G6MNoNmP
         UwpuYXqatICiixeKJyMA1A590gIZ4P44Gr1zLDJzX0iyybeXaAaULBMtseSQ3LpCwY5B
         1tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742315775; x=1742920575;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfIKR9rUFMp1IYqJFmAj749mAyZirkpFmhYPkrBF640=;
        b=nMRyaOTeBObi0l8ZGAd8CbaeI/94jLwi2xmzzEyZf/GX2aVF/iBWfiT2kDPaKxrnNW
         7Gml4hmGSmfVu9TFxwxPvv5BMG5iZsVS/hePS/+suz2MtYh1CAwuQNDNY1InJBsDbNKr
         aqKFpztbdRI8T0F7lGVnLMVZQ9I9xVLNIqDqE8/T2POVvhv286W96abc8/9dKzztaAbx
         sts5llsiMInsyeNfnXXyH6HoDQT1rSqA4z5VuEGwJtaZyyKyv9/wAFCwHXoRR4P3fa5/
         SAJkdJqlX5NrrHfpEgtacBH4O/M77XHxfYep7d/BkNOHVDK8PjOnQqjX3N4M3iMJMyQJ
         1rnQ==
X-Gm-Message-State: AOJu0Yyv3tSRsgB99e2fCsKyW7HAdjIgaHXWhC/WSUvLihsp+rG8G2y7
	ldG2sO3cCz0/Gnzz/tsb/Txv8u4BiSZ3LaWMI6O8i/6ZfWCsbc7Kk96lug==
X-Gm-Gg: ASbGncv2ZrPz+vpMrbUxKqVwPacDAYRHCdVkmrLf16YKGPpyNG/gVFvKM8w0GseQGZA
	HF8KTgJuiJQEN2Cut36yNsI8Unnr3IpLnpgRpdhKoRPvq5WLsa9nm4EbyywdlghYIiNi46EEOZ9
	5yS7Mh7PdmyfOSGR9Trxe1TpIlWGci1LVQ8cAilcvHqSgd9xiTAcJCWuWSth7T+cT/cfa9b1O97
	cOqj2FsBWUOa8vfJb35P5Pg0o6NfeliCmCEaPOLjESeIdlc+0aAMF/DUntdfujZwkV/Uvv8luA3
	JEwirb6OcAA2EKLJsRtPqyCynQe6yf6W5A4G+EY2GiniwjJ0q+4=
X-Google-Smtp-Source: AGHT+IE7+vdeQU3muyc/kSxON7r98riMvilPipJpsYPu1b0KWYrZ6oJwYy6YUmcYLSkfIFeLw3+pDQ==
X-Received: by 2002:a17:902:d484:b0:220:ff3f:6cba with SMTP id d9443c01a7336-2262c5ecbaemr66923885ad.38.1742315774504;
        Tue, 18 Mar 2025 09:36:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.42.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbfdb2sm96590775ad.168.2025.03.18.09.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:36:14 -0700 (PDT)
Message-ID: <67d9a0fe.170a0220.3b65ad.46ff@mx.google.com>
Date: Tue, 18 Mar 2025 09:36:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2978696261632996759=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] HCI: coredump: Log devcd dumps into the monitor
In-Reply-To: <20250318161414.780565-1-luiz.dentz@gmail.com>
References: <20250318161414.780565-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2978696261632996759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945229

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 FAIL      0.40 seconds
BuildKernel                   PASS      24.11 seconds
CheckAllWarning               PASS      29.35 seconds
CheckSparse                   PASS      30.36 seconds
BuildKernel32                 PASS      24.02 seconds
TestRunnerSetup               PASS      432.34 seconds
TestRunner_l2cap-tester       PASS      21.31 seconds
TestRunner_iso-tester         PASS      33.28 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        FAIL      122.51 seconds
TestRunner_rfcomm-tester      PASS      8.11 seconds
TestRunner_sco-tester         PASS      12.32 seconds
TestRunner_ioctl-tester       PASS      8.53 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.35 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PENDING   0.82 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.181 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2978696261632996759==--
