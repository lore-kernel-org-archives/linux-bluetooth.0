Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466C189B91
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365612; cv=none; b=Xloiw4lPUL/HwVdUKX3O9C6X37DrvcW5lPhb8wur9Z664XK9JUKnolvqoeIMqdr0u4T0HFMybGIiNQxZD7W8+zSVQBj0T7AmoW4xek5a94sxhawKYNGM0/JPZxwLS6GiaLExFR/EoICd/OxwA7gFEWwsoQ7qO8L6lDsaH91ADI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365612; c=relaxed/simple;
	bh=v1qR0vYTsaqrkmG949DlQfsf4fktK5rOwUTmdJ+Ijug=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rp6XMM2WKrA1zg/waBNv45sPqpOApvUzk1iwjtC0sAUQ4+JSj9nqj7NpL68CL9dPszun2+t/C0St5AoXPO0jimtc2hXYshmnTF3nx5H/iKIT4oYusWeh3SUqPGw37gJRk4hNOUn3GXTPMNIEmxw7v9UqxHDqtQuTfHy1+5Cs0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgqDAjvm; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgqDAjvm"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so3025885a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 01:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737365609; x=1737970409; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JSl2P+ynC0nTTNrj/epnglZu8wlsyaTXCNsbtO5JOlI=;
        b=AgqDAjvmgp1Bq52DmDHrwmVaVNCd97qp5TGMjJDg01ZWMguTc+WKm6TvaQzBtFwn2e
         eWapoZCsEZlgiXTeD49ewD/Np689j/LhdFO5D19H2eu8gftVgEG/raVy2SyoOE4Sbozx
         ZHPTr5DB0fVCZiGD2zdl21uf6n6BfluqFc857bemJ1ZzliKixX1oePNTLqGHHUOqipDq
         YBcTpGtmB4hOoJd23iD/xqL5w5fVavmO3dud59tlBPo5DU8k65JOgeytdl6LQ1K0w8C3
         I2v3kABtM2iGGt1TgPB/xfmqIF7we6YJRmuxda5reAs+tia3KR83igGeyc8cqfxDalyL
         0zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737365609; x=1737970409;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSl2P+ynC0nTTNrj/epnglZu8wlsyaTXCNsbtO5JOlI=;
        b=rnw2nWb8+YKqurXvTrVtgKskLCHwgcdtAOs3wwQPAn04GsSfUwQuS9JmOSY16JdBYL
         l7X0ESedeeg1Gi2cjxhpJ6fUYsfVwj+95oLlbkRwzB+isBzSfWIUhWq4lF/LapQSbNDG
         8QexQRghqkbJ9aSlOMja0y4ZC3zBFshIBuQ+l1pjznoWcNNZ0VEG0mYJgmywOLTpxj5t
         tajELjj92P8/5z3nvGivGD11C2pd/onQVnAE1maJb3uXBlcxVL5lEkzMMrmIe6Dfpme8
         D+ALae4sGsMOMmRHHVz+MkCkPYYQX387NLWgQbR6BLjfg2+TOM1yY5d96/ieJ3x9568I
         Iiaw==
X-Gm-Message-State: AOJu0Yxv90dllAAO46GtFdEx4Jrl2CgfYlwpzlLqB4WrAr6/5UcotEdP
	RrIwVKdy1PI/q6ZTbIEOTyba5WMj5pG6QvwAl5L0J/iomP6yBunN0S6D6LrG
X-Gm-Gg: ASbGncsTxg3CktJ0IJDEo4/AtLqy5pRoRKdmUX0etkh2rea02xOKfgARzTKWrxGj7Pg
	HtN0UpC6wHDG1nPJdEdPepA9CdZKDeSwHsPAhkjyB5dMJQ1mrLpvWrIAHQGBWORdl49mscC9kcv
	a3EvNp7Oo0ZJ7fEr4uIEWuYi5flvXwQpFagRwth64ahtYEZ229lhIIWV1FBOSCevexDhnTxmRLy
	UfgbgMXtSP54Z/BzpUVxl2Hg64zJ23TN4t+MWXdvM1wfyNpx4uuchpN1SXEk/1bUB9E2JmU20D1
X-Google-Smtp-Source: AGHT+IFHvzioJqp494dtbcjAMhvsDbYfTRqHW/yE7mFJKFxXNLXXauuRUsJ6E/kDRmWlvfVfpzdB2g==
X-Received: by 2002:a05:620a:d96:b0:7b6:ce6e:229c with SMTP id af79cd13be357-7be6325df39mr2364831485a.55.1737365609358;
        Mon, 20 Jan 2025 01:33:29 -0800 (PST)
Received: from [172.17.0.2] ([104.45.207.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614ef242sm424059885a.110.2025.01.20.01.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:33:28 -0800 (PST)
Message-ID: <678e1868.e90a0220.25457a.f9c7@mx.google.com>
Date: Mon, 20 Jan 2025 01:33:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2690452017556513982=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [v2] Bluetooth: Add ABI doc for sysfs reset
In-Reply-To: <20250120164732.v2.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
References: <20250120164732.v2.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2690452017556513982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=926862

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.14 seconds
CheckAllWarning               PASS      26.62 seconds
CheckSparse                   PASS      29.97 seconds
BuildKernel32                 PASS      23.96 seconds
TestRunnerSetup               PASS      431.16 seconds
TestRunner_l2cap-tester       PASS      20.30 seconds
TestRunner_iso-tester         PASS      34.57 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        FAIL      121.34 seconds
TestRunner_rfcomm-tester      PASS      7.64 seconds
TestRunner_sco-tester         PASS      9.48 seconds
TestRunner_ioctl-tester       PASS      8.25 seconds
TestRunner_mesh-tester        PASS      6.17 seconds
TestRunner_smp-tester         PASS      7.07 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.204 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2690452017556513982==--
