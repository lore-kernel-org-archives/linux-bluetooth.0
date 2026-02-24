Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366221DDA24
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971662; cv=none; b=QOlAxOh2zuNG+fOxijPv0m4NCsxkooLp3oPUEgPu5fR/uJX+k7dsqOR1uVnfbQA69yxGOJ1Sa54bOLe/t7LUL0KtdT8ick1B7+IL0Gt2xoHqOzFF30w/FA7dlI96A+m5Nw+IntwP3s58tZQu2XvE3Fgb+36a+Lmj6P0dSKblhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971662; c=relaxed/simple;
	bh=rErCyyVRPI7P9d8t+u+Vo5/9fOHG/vf24DV25ZEolEw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V53zVMQRhx7t0cFLD9XmOEHTP85k1DRu4bQqY1TzRdXsg6xMTUqxEX1NtuiKLueROgo95UZY5qOjYQuYeigo2AALeUBu1gOhzw3RFBceIE22gghnlgmT1r8B+CpkfYttQ7bx1plS+iZZtMPEZkCxySZAlPVLiwsgGwnZlTqQirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNzsxL8I; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNzsxL8I"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-503347e8715so73143521cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 14:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771971660; x=1772576460; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AHjLAAOLaHlow7UcQGlLeU9ksRkSki+Ph0+iC85xzF8=;
        b=BNzsxL8IGO/2Hd+BH/74URHz/XNX79yp3KRJREVZKaofcmBDgEL5uTDWxP7Tq/2Ecq
         mDn0ddUXw1gRCZF68UfsNDklHApbSSjAzCKVCw3Kb3MM2ifTtvIlcVp/a2xpVrWBoRTP
         T8qDwfwfLQFJ8yNks9141JXbho+CRxcJe6C50UQoVINs48KGWlE1ttuOyp2iHYwvgyDW
         s4w87VXzC7Az2/NeLDOr43i26Yh6wylkv7NtJiiz5FvA02hLPLZU0pTUF33G+kyCxaZu
         ZwXyP7vpYF0jYRz9IfadXJpTf0lrQDnL4H/F77qWoR66hdRt+ETHg+7Hr0fe4BzH+IXJ
         keRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771971660; x=1772576460;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHjLAAOLaHlow7UcQGlLeU9ksRkSki+Ph0+iC85xzF8=;
        b=HDzRiJQ7uNbRcMax0K1QBSRuhQ/Pp4JUuIZ8KM1uyrrn5zSpcNyz+DVI3cky+DRhXZ
         yPJkrlD1fZmcs/QFrOrcJNmh7ycUKJWur/gn91K+H6JbCWvh63aQTptcgYMMRZSY3Ih+
         bqYscQfOEqAVU4bl1zCUM/dErnZeOEWE30rNsgawPya3scggPPu3EWqoldyVwHjwagPg
         tASLmy9b+Aosa42MseguzRQOQUeHAe10j7aouoHpY0OKeSTx5nIWqCO+1XJC1C2AJACY
         PHvfd6jpNEURVOBR6f1YaDX0pkrSSNS0c2ymSghPDo4AiH3nvz47PEucVCu6hzqrDiwi
         Mesw==
X-Gm-Message-State: AOJu0YzqTjKTKX7QMQfV7rOTwkCnzlAzRpGJhJqyLLYHyQC4ssOe7QyY
	86Ul5BrpTAQeQqjtkf3gqfX0P8slgz+NYl1XRKFxi2KCgkl71FpCK0r6Dsmrhx21
X-Gm-Gg: ATEYQzzYknvbGXX6SP2/culfyfX3dvvXz11vBsfe/CB1SbbrDq6qGGhb9WDSQ/mU3lz
	XpbcNvpaptSjOwV2njrisBohv66NK1AOy9L4jDNfaclsvoDfWwVsQjgJLMrIkxpUEHFpbPeNrgS
	38X8ilW6rmlalNMRXKjTgfw0AYUAF5p5jGyTatumTCSSt7vP9zPUKxkIaK7qrYq6489BW4/Eygl
	16qbjvC2N4CrSvs3vxE+q3+jQpujKl23DzBdE9gGjFZQkE2U0JJEjZK1SPYkOHmWP2aX4St8/Ds
	pM+m2POPriO4xdQBPpWfhrqXSrZzE1Y2EynonstJ3tqts1BFKUiGHmAbtkpe5iXpLZe4OO0kt24
	B30nPSNKx+5lvKsxZvKU3WSgcfuA5Qnm/hynP88xc+b9BJyztflplur0VdlN0Cx+nefqN3aoPGz
	Ueddzo1GjRz8LuQuCax6t1L5lM3/Xw
X-Received: by 2002:a05:622a:15d4:b0:4f0:22df:9afe with SMTP id d75a77b69052e-5073a319410mr4446821cf.51.1771971659936;
        Tue, 24 Feb 2026 14:20:59 -0800 (PST)
Received: from [172.17.0.2] ([64.236.201.38])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d50cc3fsm111198111cf.3.2026.02.24.14.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 14:20:59 -0800 (PST)
Message-ID: <699e244b.c80a0220.155cda.b4a2@mx.google.com>
Date: Tue, 24 Feb 2026 14:20:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8584662885508684976=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gustavoars@kernel.org
Subject: RE: [next] Bluetooth: hci.h: Avoid a couple -Wflex-array-member-not-at-end warnings
In-Reply-To: <aZ1FrL8qvvKuktBF@kspp>
References: <aZ1FrL8qvvKuktBF@kspp>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8584662885508684976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1057406

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.81 seconds
CheckAllWarning               PASS      28.38 seconds
CheckSparse                   PASS      31.61 seconds
BuildKernel32                 PASS      25.21 seconds
TestRunnerSetup               PASS      560.56 seconds
TestRunner_l2cap-tester       PASS      28.81 seconds
TestRunner_iso-tester         PASS      87.99 seconds
TestRunner_bnep-tester        PASS      6.47 seconds
TestRunner_mgmt-tester        FAIL      124.94 seconds
TestRunner_rfcomm-tester      PASS      9.74 seconds
TestRunner_sco-tester         FAIL      14.84 seconds
TestRunner_ioctl-tester       PASS      10.59 seconds
TestRunner_mesh-tester        FAIL      12.51 seconds
TestRunner_smp-tester         PASS      8.86 seconds
TestRunner_userchan-tester    PASS      6.93 seconds
IncrementalBuild              PENDING   0.71 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.114 seconds
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
Mesh - Send cancel - 1                               Timed out    2.528 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8584662885508684976==--
