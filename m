Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777B26ADC
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770906616; cv=none; b=BL0RexeQUN9qOqa+gKke5sde9MGyT3xM8zooj6Gwp/e23R67jXIxQi/LGjxYrXfzzZq4hdjWsH5gLb/zVsLodUYCYFQTEYGdHi8L1ugu9keMw4sdWv8azR7+VAARKdr1rZyXh+5NwwZxutQA8R9zHCLoaZsHY+TgSJjbiiHjqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770906616; c=relaxed/simple;
	bh=dIFxdXcBPMHv7BIzs5Qxv7lt72LFq8tSbIkPsH5aB1A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hnAc0MLYrOiHT5kRgcO2US3a0M9uM6oYasg/3xlPnSD7gWzxpwpmzuHEzHI0yG7WUPOFUQX6wcoyiFIAq0jD7DqgxolfGeMLoGe2yEvjQebVpqckP5jZHiAmKi7+yo+Y5coCIM8rbDMO529RIm82rFkMHEkvyXosQcI19+Mf7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KegjB05+; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KegjB05+"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-50143fe869fso81970691cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 06:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770906614; x=1771511414; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ae2tV2MTvF4QMZ9OK7H09QVE36xQduHs2T6k6e6Um8=;
        b=KegjB05+uVfYEeRec40WJdy++PLzEJvFI5Y8Riwd1CR9TKDU5mqL4980psw2Ue5csC
         SQhpLuy8KPCEAvBnRr7i4QuwQdAMnRp/mrbMi/PkfeHztEfiwQDgIV30SIYsKu2onIth
         q5PSVy1gdHmVGTyyk4Ja3obqY0o5P4PF6NmDC27BMaQdeNLV3uRbYUzSZhvKp9JmpRNp
         Ibng1imMuv7M531Sx4SBx8dm6VF9M0aWbyEFYe+EkOdVbZxo1BQIeIs9edhPnE9tp2YZ
         acE3+niE+9107Z5Oz86S1NumphmuesgzZM4JBdFJrIBzy7OCNpJxfKdqVQ4CHSpPzwrZ
         N4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770906614; x=1771511414;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ae2tV2MTvF4QMZ9OK7H09QVE36xQduHs2T6k6e6Um8=;
        b=Mt0BQDP2Qcz0tzQU6acZbx0R/jFmg77MB8FcxXAZiPYFf5UJojOOBil68P82o3K1by
         wKMHzNBHb5mmPCw9Y0G09zDMYOu7yPlGTWKJA6onAE5BymWXpcMTcuoyL/ra51tmEaPQ
         sDf6b8FVJNcAkB22hxvRFP7FdYN6rban2615QB8VHkIsy4KTB6TB6/Jb4cQftKY8BFkT
         KRT+EKJjnQSddo5wTHD31IR3wNkrJ0bEM95XZYA6H7Cz9nbL0Aw5gnDpAy2ORFJxECuQ
         jwyQdj82NHwxAk5Gio5NuyossPIJDXI+TlUF3sTQtaweqvRay5Xw266s1WiiMYo8IqOx
         UtYQ==
X-Gm-Message-State: AOJu0YwM+aQ1E+od4riKAOAuBzJoHRceE9FR/pjXmp+kuH0dIE7L3qaj
	Y3X/66YQ0QWDd0A8JElwngwmSTwwDYFl+5Vu0xGmkALTgbYHBJU0j0fVjFfECoeG
X-Gm-Gg: AZuq6aKe5DQPa1XpM7OZIydrfT3JfMXGAw3WcMecVlz7k9cG3+GovHUpsiJwIeo5mM8
	Wj8vz8eKaax7KCUQ36R29HZPIJAndHY+njS2pKNQpjN9maFv1+mKgTqU9clmKy4sXM1ckeJJR5J
	Afk6o0XXDYGbIKowqmhR6pnCbzQVwaqXGdZklbS2G13LavEr82NXpN1tTTkWjA4aH/SDApJLWkp
	jDji0OYaNYQyaYFi1MGgDkhfGrpGB/UDeY/vhIa29Po+uHkZIVTPe/WDki7lNBOEvVvg5LJpxi+
	+ZVH7G27XW6W0bXxWidpYeRp5qFRfjbBpNL1u2YkERSC2w6Ik2gKQJUgi4TThQXJ0U9e6jruvp+
	E+S2NoRC5APKsQWRX55ENdVBunbptqKBWaZT71eO5gJjsPZV/68lg1FZPtQnXnLmApRXFtNg4ez
	1Th9Ca7jdxqOPBQAeduHXNBRIDUDW9
X-Received: by 2002:a05:622a:507:b0:503:41f2:df94 with SMTP id d75a77b69052e-50691b9ac05mr43448771cf.52.1770906614233;
        Thu, 12 Feb 2026 06:30:14 -0800 (PST)
Received: from [172.17.0.2] ([64.236.160.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847ed9c4sm37267011cf.8.2026.02.12.06.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:30:13 -0800 (PST)
Message-ID: <698de3f5.c80a0220.2b331e.49ba@mx.google.com>
Date: Thu, 12 Feb 2026 06:30:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4402699043518879005=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johannes.goede@oss.qualcomm.com
Subject: RE: driver core: Make deferred_probe_timeout default a Kconfig option
In-Reply-To: <20260212134646.66433-1-johannes.goede@oss.qualcomm.com>
References: <20260212134646.66433-1-johannes.goede@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4402699043518879005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053567

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 FAIL      0.46 seconds
BuildKernel                   PASS      25.89 seconds
CheckAllWarning               PASS      28.03 seconds
CheckSparse                   PASS      31.97 seconds
BuildKernel32                 PASS      25.10 seconds
TestRunnerSetup               PASS      560.28 seconds
TestRunner_l2cap-tester       PASS      28.86 seconds
TestRunner_iso-tester         PASS      83.77 seconds
TestRunner_bnep-tester        PASS      6.36 seconds
TestRunner_mgmt-tester        FAIL      122.93 seconds
TestRunner_rfcomm-tester      PASS      9.59 seconds
TestRunner_sco-tester         FAIL      14.75 seconds
TestRunner_ioctl-tester       PASS      10.36 seconds
TestRunner_mesh-tester        FAIL      12.50 seconds
TestRunner_smp-tester         PASS      8.87 seconds
TestRunner_userchan-tester    PASS      9.30 seconds
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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.113 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.515 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4402699043518879005==--
