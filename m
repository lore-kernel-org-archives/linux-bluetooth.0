Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887711DB933
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424643; cv=none; b=sOIJkNH3NCr9zzdwP9RM5YJ6XfXHvcqcM9s0c+OPvTypM+ND4QLGyYoGcM3vtT7Bo9BfyHFzqAfWlqJgxXSCj/zeiXJGcMPMk+AzDg07PnTvWeo523hIIUyrRdmWzqIVk25dZ9hn1T9oA/rl/xE6VArCeItZLUFIuq88HWrdtrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424643; c=relaxed/simple;
	bh=cbIzU/Ot+qCHrgzdJnk07W7B/X1gBjokIP+6LeJ7aL0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PWQl3Mh/3grGTEHRaBugrCKi8gSd4SxXGgB/Rfd7tj01aFDWbS8h+e6c41QBfnmHuXADrcDwHevxU1il44Cv+crs9NSVLT7AzLjnYuC1ipZPnGAfGKMR+HG66OHyEktOLsdY844xfGul1/AnBfng/WqyNLqIlJQBALdfiej/YCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jopu2dRO; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jopu2dRO"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d8e8445219so44451706d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 00:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734424640; x=1735029440; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SPWtdwApG+yag0o7PsVv2fQaHA1mYBzRqOZ03q7+/tc=;
        b=jopu2dROV3vGN1fxnxR3tummYedxJn6yt5EsgrTUQ1YznSAJclWu/Tvef8m4ArIeHf
         EoNTJqnmRwt24ugRIzsO0G07P7Uy00bJRBWiNp1ifm3p0juJECzUiloeb/OmQW7rVkfD
         UrmGg/IPrJrqr4icwcxhVhhs36DtaOnU5fqs6UeHmpbwqokC8iYVZa53XHY5C/VXxG2J
         ldI+utO0jFW+jajMWuQY0B3i1hEGYJf1+V8/mcxVCkGSz8TsW1iONNyRjo4tPROE9l7K
         Vmkdi+Dq2euNilAmBhaBKIR4hsnnV+KIf2lFx6pRi9F/9m/2Ij2Q6Loaaz2yEOvbJ+eL
         5UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734424640; x=1735029440;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPWtdwApG+yag0o7PsVv2fQaHA1mYBzRqOZ03q7+/tc=;
        b=pdY6BZMf1xfqZKbO8KbkYMOucr3iinn2Le+Ye6af2wOhZyqLC2E2Xf4Z4uVLjLOuiT
         zrMiaEYktdAbEfCiunbC5z/qAj2zShV3hBAkNSJYcWlakjNKd0VNzCdc2KiYd3IDU8DV
         asI68xfu/wI0Ub8kwqH1VkwIh3ANU7ApUGYbS2vXiVLvq90gb24WD/et8/gKQYOFMvdv
         C9D9B/PZKt5sqFbaZJ4g+jRbwP18NGk5bkXOrmnQFNhBjyTt3EyYeq2fPZKUbwAacq5E
         EbIDGuq46ML5zxTwmYhynRT9Nhv0W+vcqqRypNxhQ+yrtMKtlW9dYOE2ogJQ4reBrvH2
         tHgg==
X-Gm-Message-State: AOJu0YxlMNgn+bGgjrKRbDEUeX3P5eRzWOOJ9RdkmINK3Ek4TsT4e1oe
	BnlV5lzil2PfQM6J79OT3VTfUvTSolIMyUkdEziavHvd4TS7wyHDvFe8sg==
X-Gm-Gg: ASbGncsYP359HVNtqbo1vCVtlOfKMOlxi0dSbR5jUa/dBpK4zN7FSpDKDma1CKdLM0w
	yRwxeI5ynKhVW2FP/iMxAIBy2mSy0lLDFzznxyz9o+68BBoQ5vckn2yU7u1yRMpQz/5ZQLmNrVX
	rBM6f0/B/ET9CK6nu+GqJKb3JIAoCZqNme9yl49DFW6vDZ01wsxrz+RUK8w/FaN6HmTr43poKU7
	lCWSOSizyxQRhEPvyRNJTcSNEv1LoWaLk+4tr9uCloTAAyfly/IDJ6ClSedOlo=
X-Google-Smtp-Source: AGHT+IGmIc12ATrFbGvz/lDX3H/Xa4bc3B7KqbITK+Fgy/F3I8wK10vWSFOxi62dC2Mmr5nX4D31MQ==
X-Received: by 2002:a05:6214:1c0b:b0:6d8:88fc:c0fb with SMTP id 6a1803df08f44-6dc8e7775d9mr302861306d6.35.1734424640216;
        Tue, 17 Dec 2024 00:37:20 -0800 (PST)
Received: from [172.17.0.2] ([20.109.36.210])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd38068dsm36126866d6.113.2024.12.17.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:37:19 -0800 (PST)
Message-ID: <6761383f.d40a0220.1b41f6.b585@mx.google.com>
Date: Tue, 17 Dec 2024 00:37:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2120867500691136684=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, avkrasnov@salutedevices.com
Subject: RE: [v2] Bluetooth: hci_uart: fix race during initialization
In-Reply-To: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
References: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2120867500691136684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=918554

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.26 seconds
CheckAllWarning               PASS      27.58 seconds
CheckSparse                   PASS      30.88 seconds
BuildKernel32                 PASS      24.67 seconds
TestRunnerSetup               PASS      440.93 seconds
TestRunner_l2cap-tester       PASS      20.61 seconds
TestRunner_iso-tester         PASS      32.16 seconds
TestRunner_bnep-tester        PASS      4.91 seconds
TestRunner_mgmt-tester        FAIL      120.79 seconds
TestRunner_rfcomm-tester      PASS      7.57 seconds
TestRunner_sco-tester         PASS      10.46 seconds
TestRunner_ioctl-tester       PASS      8.09 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.10 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PENDING   0.41 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.206 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.206 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.162 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2120867500691136684==--
