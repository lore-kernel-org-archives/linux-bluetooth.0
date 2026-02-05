Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451052405EC
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Feb 2026 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278054; cv=none; b=U/h4ps9wqFkE3gGgqhwtLh7wsG6uOj20Tlo5AjCWuSUEtfheNcSvaj6mTmkcTpiuwNMbpGQhCOzL+rXoxcP7YJsLig6AKHER7KthHV256nJWfWXt1Rwbb6F2frZ056haSzE87soDYFb6PtmB5mZHFxjMqiwF383C7U/IXFz0AMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278054; c=relaxed/simple;
	bh=RcPGvtm5fUPd4S9bv1bFK5cGuPgpAnvRc+bX1LKqy9E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KkJYCEe0yLJCo9rR0jHX4UOW7PVDi7UgF53dBvoAyc61JIK7vMNfOjgpgaJ7r8fHqMvKlXh0/7Lq9CMRwo4P/47uGKaeHBLVQWf1OVF34EiXt+St66HQrV3+sS9wVREbWXgkuu6KAwMG1ASxIuFHxf/LONjOvRa81+mrp45mvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN606xiR; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN606xiR"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso10010276d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Feb 2026 23:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770278053; x=1770882853; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MMkvBIwHVNt7LSgQkh7DMxXe2TcQqbQje8sdMk18yYk=;
        b=MN606xiR5fmMF3ln7NB9FrhkLEa+flBUF3bWSgKGa8HhrbR9UNxFRmtkNb+PZWmWpk
         9U7z6Gd14cUg8cLlb5V1Brlyu8OEWGBy2xAxixjgmKgYDRzbHsKwGmLk6TtUk7VffyNR
         iSWDKl1XsB5z0ZR+NDqudF3gT/dCMxWyaZ4inwdOIu/rJ+vRLmDhSrU0eyMTaCwCwT5O
         Ftp/gFjenaTk1nNbPBWt8rg0HRtHwo2AxJd5be1HvA0nL1BBhDW7N4wCCKe+9EfRXaH4
         P5b3un9w4L37SummZp/VsKdvBM6v7laqldwdQEkEvsfseDO5afoRN3PR/FhakxFXVm0w
         ncUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278053; x=1770882853;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMkvBIwHVNt7LSgQkh7DMxXe2TcQqbQje8sdMk18yYk=;
        b=NwyIlSyKrh9K1dnsWwQygGTktKfEJPshOEJzKlJFd20cHR5yGRxUTKQw4O3oNCeqO+
         PoxzueW8bLIbm8iKlOMaYlL5D+TNDjOHLngDBeKEy3e7gWdfzQE9ULc2F8C/nDJZZzbG
         wdDhJ3nI55wj1aI5CaPX2Cf6/loMDB//VeXkGER3ZSQ1tqChbztyyIlp+mhstg2Hd1fa
         X+iJnP9GAEtO2H8KUgpN+bJb8ZGWnYO2PPLg7eK6Bli6Cd9I+DYd+RLInWT68jwX6SY5
         aDfRV4i4SYGQg9SJYS85o5DmqGFgguAwhUP25M6vNhWElukMYpmX64yi7/XsFnZCB64I
         OZtA==
X-Gm-Message-State: AOJu0Yy2wvXGhSlL43C9+LPjKekUQikGJ353cc2gO556yXQk5oxy+uPR
	9WZsgQiki4MrlrBwzpue3PCqn9EU6o8br3cTgDeqnUGC2QOrxqqHSbwpajg2wz61
X-Gm-Gg: AZuq6aJ1+YHNRUA6MWxrl8wwVmqgh9UAgSO8U3mXLv8vBJxoaHdSWNy/8UgzmLdL6E2
	MzZwW4urhFd8EgoeMNV3ILpMxIr1vXJ+mwCk/mzFqEucHoiVDHeltG2x+ukweBbFizLEJOyZruF
	xioreQKC7iJrnGDnMAorplGzwLujAI5pw+gto5OgMs7OOvX2fmgjpV1DOEhHF44g44DahplFZ99
	MXpn/em4l3YWD3S9+7DbKKfijm1dm8/LgIpBvajwFpb2f+Z8walS6SwMPi2wEoJRq16JcNSSYhi
	54wDse1v/QRwXC79TQzOeo04ZlUWRuZjByCOYgE7eoXEpNkV+hrEpqSngNhg1NWjSLZNCWbOOv7
	4RkkyRvlsGwg6pU9gEBwK61ZffFMi+On8+psJ9kTos7RIASr+65K5PquYrB1q2y+d3xayvuChzX
	/ue37TMzWVvDvi/c68
X-Received: by 2002:a05:6214:3007:b0:88a:2d2c:3b4 with SMTP id 6a1803df08f44-895300f45femr23612196d6.29.1770278052984;
        Wed, 04 Feb 2026 23:54:12 -0800 (PST)
Received: from [172.17.0.2] ([20.109.36.225])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c147e06sm33245711cf.4.2026.02.04.23.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:54:12 -0800 (PST)
Message-ID: <69844ca4.c80a0220.9453c.3a07@mx.google.com>
Date: Wed, 04 Feb 2026 23:54:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3755132204966194839=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v5] Bluetooth: hci_qca: Cleanup on all setup failures
In-Reply-To: <20260205062600.590342-1-jinwang.li@oss.qualcomm.com>
References: <20260205062600.590342-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3755132204966194839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1051008

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.87 seconds
CheckAllWarning               PASS      28.02 seconds
CheckSparse                   PASS      31.45 seconds
BuildKernel32                 PASS      25.21 seconds
TestRunnerSetup               PASS      561.79 seconds
TestRunner_l2cap-tester       PASS      28.74 seconds
TestRunner_iso-tester         FAIL      55.26 seconds
TestRunner_bnep-tester        PASS      6.51 seconds
TestRunner_mgmt-tester        FAIL      113.82 seconds
TestRunner_rfcomm-tester      PASS      9.55 seconds
TestRunner_sco-tester         FAIL      14.60 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        FAIL      12.46 seconds
TestRunner_smp-tester         PASS      8.83 seconds
TestRunner_userchan-tester    PASS      6.74 seconds
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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
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
Mesh - Send cancel - 1                               Timed out    2.664 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3755132204966194839==--
