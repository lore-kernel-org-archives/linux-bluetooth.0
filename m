Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF371E3DDB
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Nov 2025 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764437815; cv=none; b=BXJRgb6Aes7IdpnOuvhpjGvi00CkLkmJV3EFs6L1m7ATbMxOdJVQBTM9Dn6sg52Hh0OafUTCP2A21fjqiH17vMr4AvBlnfSqGedNXvZ/6NdiW0w5Z4YUqaKOvU9/Dz2eoURaC51zBHJUb0HT8GDkH095SBR4JPHxxBFr8mvQHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764437815; c=relaxed/simple;
	bh=Qow2tIaiS04GjSQiI9e49BBaBtW9hCfU6Jp5giZ5y20=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=akRJheTY06JzJkPICAYI/ptFKRz8yCaAkTuOOFO8tn7Hz+8Sa88yeAfC0f5TUsVI9tqnkh0ZLZ3XOTmi2bOc5he+709WyUFtvQJxe7ygYsaS9iswU2GwJtKpLAKOOHME4wTnRty2+k3jutCA21g+dO5JuLw0BpGVLALS5FeyHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEPN4kD9; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEPN4kD9"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8823e39c581so42663606d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Nov 2025 09:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764437812; x=1765042612; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jbwiw1FxwioOWklZm+BHOjuRTJpeM6Dztt3D4wRQET8=;
        b=PEPN4kD9JtrXGZkb9qDH7sJFFDUW9cqNBM35Td/QO7zpIRTbEZDYMfaKj1pZXwxHxq
         PaL34UfUI2TIPngVo2cd/zsoOpwIlt+wRdxLGZHm4AJx6ltmCG1s/m04bFuikN7EsSYL
         fn+psJxoNqa03t40gf4Qlobgd7NsdgkEBtitKefUrFj0x8bb9gSTPAvW3O0w+KJAC1ql
         EeMHCsiiT+9TMjXkO8/AgGUCr42MkcvQrpVWfu2FckWvjxghu8lE9/LXEkJ82+YyWIbr
         aokimqMZeOzTH63IePjWPVOdomHdN84Hj8D6aIDaX4x4sG5MF5b+u8EAB2v5jp8a+vBW
         Sl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764437812; x=1765042612;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jbwiw1FxwioOWklZm+BHOjuRTJpeM6Dztt3D4wRQET8=;
        b=uE7tNTNc92C4OeE9tl2qBwEiJ2dRxtqrr2zRje+yFHzGUgEnvoyBmPyaQ3AbxZgl15
         8Jh+SlWS36y2HgKJIR48pTkNy06XveVK48G8sDc0NdyIHx1aRYZrmMoOEpgtY2H7nCsI
         boPyauy58aNYQU5rGbA2e1o2DcgfaYB6Ku5RA6PwAw3v8xkNGBnGd1eMzOKdwnLpa5lp
         6xzz2tGRT6Dg2dVljP6OUARky0OOqndbQeXO2fgU47VVroOjeVPiSX0B5Q7kxVyPW5Vq
         souAzkzCNQaazBD91Y/BS8gPT+UBthfwSjzEToR/eHH4WXSfW71ZPFzv1l4pnt1chsP2
         ODoQ==
X-Gm-Message-State: AOJu0Yznhd791AI4BBXOVe3yEEDuEmD3mlcz2Zv5fC+inenowPxoXPjb
	yOODwJDZdBLqL0VgOkULglhsez1rX1Sh3ND26D0dHZu5S9MSDc1hBMCXKsysGrEd
X-Gm-Gg: ASbGncuyGEFircgWt3vUCYSJyvT/Eadzx/kOzgA5NltnDhPsuPmAbFKceP1cNZ5E/Ze
	LFhgJbcmAIupcf9rkN6RhrI0gjQxPRkcLkHQSsypvx/0CiJ+iNsuK/j+eyR1uDWKLn5VTeAdJ2f
	1T/8jdzoUFPigpt+g93mw5vXEnyZRG2+D6Y1jy1uH0+1BtrRX1Cj91hHh0DvK8fyGD5Yy/kgH16
	1X0xtsthkMWUn8ygPB03tBdNOP/9u2XSMdNDR2AqMc9fhvaQZKSxM3B0egB7AUKK3EpaN5GyBST
	Vdnjc4lYVOnw8nmhuAYrl5d1zfIXYPrdvy7tgo9QBcofjuADhfWnL8mtLg1hzu4T91VLjH0vykT
	CPpHG0boLosA7Sav7Fe79k/g+g7OxSFCo8eJGTVUKTM7G65bPK1xuf+YJGTJ+Hhe3/N9nRqRiu8
	+QtDUjojWQVf3ndDAyvA==
X-Google-Smtp-Source: AGHT+IEQEoPpgbXPJZkoDuSlPg/PujHRZ3Sua9Fpy8dTliVyzqZ45ysTe/7zrf79gFJ3u8SJieEwTA==
X-Received: by 2002:a05:6214:501c:b0:87f:ce10:e799 with SMTP id 6a1803df08f44-8847c53615bmr475740006d6.50.1764437812250;
        Sat, 29 Nov 2025 09:36:52 -0800 (PST)
Received: from [172.17.0.2] ([172.208.126.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b93b0bsm50874456d6.57.2025.11.29.09.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 09:36:51 -0800 (PST)
Message-ID: <692b2f33.050a0220.37147f.dd59@mx.google.com>
Date: Sat, 29 Nov 2025 09:36:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3657458861529559531=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/4] sco-tester: add timeout / close during connection tests
In-Reply-To: <ab1a4fceca2948a2844dbac64fbca08ee7514f3e.1764434454.git.pav@iki.fi>
References: <ab1a4fceca2948a2844dbac64fbca08ee7514f3e.1764434454.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3657458861529559531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1028907

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      631.48 seconds
MakeCheck                     PASS      21.83 seconds
MakeDistcheck                 PASS      239.56 seconds
CheckValgrind                 PASS      296.39 seconds
CheckSmatch                   WARNING   344.60 seconds
bluezmakeextell               PASS      188.61 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      970.87 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structuresemulator/btdev.c:470:29: warning: Variable length array is used.emulator/bthost.c:700:28: warning: Variable length array is used.emulator/bthost.c:701:32: warning: Variable length array is used.emulator/bthost.c:918:28: warning: Variable length array is used.emulator/bthost.c:952:28: warning: Variable length array is used.emulator/bthost.c:953:32: warning: Variable length array is used.tools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3657458861529559531==--
