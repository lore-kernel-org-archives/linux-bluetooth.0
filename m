Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD39B3128AE
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293971; cv=none; b=qvm8gTObkf/HIH2HBdqs8501lqYE0Oad5fAsyZztp3gcFM5EBO+BNruab4xaZoFeFOTPpSElQy1NlJEHWE0jUG/5Yt8ttV8rApAt5yXJrCrPfcdF6dso8BEuEmJ9PILletLl9kqD9eQZrj50+h9rfCnD0+4eTJWbiTU3El1LSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293971; c=relaxed/simple;
	bh=GHtALdjMi5rk4MUblCwwPl/vQiblJRZc5jyYRhEqOjI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Njy6rWPgyNnOgtr5LE4l0OpmqGDOI7IQanoZtAnePh9LSicqlKaXxzbtqg4c97viD35VVMxL2/evsMfQDjz0OsGoaMbGCWTNHpc1iokj6Ayy+TM1a4VCoyoFxiZHuf+aPimmrH/wXhiT/pWNNr8BCLq0Z/cf30fwk0QlBnqUtYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ064etX; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ064etX"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7cdd651c884so4483909a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 00:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768293968; x=1768898768; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ILMXWPlxJsTqp9+awdRYwyv7FuQh3OkfrxmmM8I/sHA=;
        b=bZ064etXkx+HxVQqApPIRfN4KGPBN1Ip6NvNJQHyb8JbKZyWIKBqkodgn3WjjO/PXW
         mKnjStlmz2JXEinjdP5iC8ktogvHFtL7z3D1RF+XAGN2rsRg2kys7ja/vy0q6L7coJ5u
         7tATAXh+TfatDwnM6G2PPs5/kUgYsFhUbOu0IxPhdekaRdqmpPj0wY6KBEKL41s2+8j2
         a25mOOITdXOPCS8jUO0y/LLAKL0C3kMv5unD1yy2ALKHrOxiF4055cQJsE1UGKflZOiM
         FknuEEsvv31tihp3am3gUthsnLwQS9nCEPB7SfJy8/yFV2tZpZrJSRRpbLDRqdFfMvLK
         CG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293968; x=1768898768;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILMXWPlxJsTqp9+awdRYwyv7FuQh3OkfrxmmM8I/sHA=;
        b=UvLnYMaUWrOQbH6WIF5lfRhH9CzaH0ZHCpp+ajFJF2OzI9PEI7o0XZqn1MWxXMewzH
         PM/WKEi09Q21IeyceyVFjoqSdXWFpKJ6tJoSIgEB0hfkUeagsBEcKGnRJCIjO2Gpg+eK
         tme+Z9LRlt1vDFYqOrbmJQZ80WCrXf+d284+VgvhsYw5x22deRhKvi1gxGYRRopo6avk
         NSsMER8jpN5CQGc2AYh+cQqK773kqkgS6phswLgFeK7TDcGi6t4rxL1sJbzEWJDIXwrQ
         PzTJw/43qnQBkYykn5wi2wVlv+VpL9OTlBHRzYrRj7YdbyUtukYEuKe+9SXfjYqOiTAA
         Ni6Q==
X-Gm-Message-State: AOJu0YxDW6fEwku1Uy7RfTXpgPy/35v0EcRS16TIM/eKTSnULTfoPC3q
	xrnVrVNU40ha2SOfQo2UBABOHUuDg7sSbI/hipuK6EHQqB7vBsuEAgAlqkmkGo6q
X-Gm-Gg: AY/fxX6g3Cvvj127A665iboZn9fD+Pk3hrIcyQV1Aq9KurYsh1vITxdMv6WFM7pH5gC
	B6YehNZnxA67QQuj7SI1g/OmSEKA1GUIZGK/Yh2tSZpNzAB/elw/B5ZXX1cU0WwI96w37IMahbU
	eCmn7S/Uegj7AgsgtnYaFxvwE9pfzIskyX1Al4NF98EM63OI7SHx7JYADXTJW6Usv993wUNbm8o
	IjNgRF7VXCF3OiR0FCWhiAem9/6GT9bQ6OSKd3eqTMRUFWRkG+JYTsUtNb+O5oVqNdX/UyqiTSY
	zcNsq+BiaH9c6loBClDa5XYpMbhexrdJX/u7qPMlgxOoWFfpg/lXCDnRU/3GcrPv7H8SBMxjgGQ
	26Pd6rxr0jew2RSc2eVk49R5xr3uUdGagn8evLzi69KdTSoq57Zb0DY969/GlZrYsvG+k6DzD1a
	V/Seh+1KSpPtE9+pJGxQ==
X-Received: by 2002:a9d:5542:0:b0:7c7:ad8:68b3 with SMTP id 46e09a7af769-7cfbe4964c8mr1043450a34.14.1768293968377;
        Tue, 13 Jan 2026 00:46:08 -0800 (PST)
Received: from [172.17.0.2] ([52.173.237.215])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47802551sm14974701a34.1.2026.01.13.00.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 00:46:07 -0800 (PST)
Message-ID: <6966064f.9d0a0220.2ffb04.5285@mx.google.com>
Date: Tue, 13 Jan 2026 00:46:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5957281194714510361=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Bluetooth: btnxpuart: Add secure interface support for NXP chipsets
In-Reply-To: <20260113074718.2384043-2-neeraj.sanjaykale@nxp.com>
References: <20260113074718.2384043-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5957281194714510361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1041603

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.91 seconds
BuildKernel                   PASS      25.06 seconds
CheckAllWarning               PASS      27.40 seconds
CheckSparse                   PASS      31.77 seconds
BuildKernel32                 PASS      26.42 seconds
TestRunnerSetup               PASS      547.48 seconds
TestRunner_l2cap-tester       PASS      28.02 seconds
TestRunner_iso-tester         PASS      99.03 seconds
TestRunner_bnep-tester        PASS      8.37 seconds
TestRunner_mgmt-tester        FAIL      122.75 seconds
TestRunner_rfcomm-tester      PASS      10.62 seconds
TestRunner_sco-tester         FAIL      15.84 seconds
TestRunner_ioctl-tester       PASS      10.97 seconds
TestRunner_mesh-tester        FAIL      13.42 seconds
TestRunner_smp-tester         PASS      10.56 seconds
TestRunner_userchan-tester    PASS      8.68 seconds
IncrementalBuild              PENDING   0.65 seconds

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
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    1.853 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5957281194714510361==--
