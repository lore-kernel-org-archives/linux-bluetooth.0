Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAAC3FDC05
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586492; cv=none; b=XVmKE647/z8rPUILoKZuv316IU+bOFrjnqrJv6mWnGSM8sTZdi/dJ4xO7AOy9WfdFd4EZ476Sujb+1rJvsTKJEUkTK9eG72bPmqPAxcDTCTAzFiS8PIbArRCrd+Fi92aCFDygAlKa1UMBd+JCsIWzQReudtgA94UN1hfacfrRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586492; c=relaxed/simple;
	bh=JMFwBVLQR96Po3vbLXDpc+8jfbxxhUtPkv/auoBggrE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=son6Q7JPKzbHDvX6s6TJ/MJG3DkjqEPlV56em0b8eV0pztVLOJU7dOncFyWmrW1+PuzRnZ+rWsBXWbn8a3cjd2d9m4mXKfo94NswHZ481LIXSbcaa/0FD9iN6ieDn+9EGNz8XhR6nJosEa6ZgiPGzBqlWSTmmvZ034KPQLEshH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsnHvgAc; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsnHvgAc"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-868a9c48f9eso40125b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789586475; x=1790191275; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zm4J9dYzJGKFWSNc5KoDYu8lYlnLOpeb1w+l6QF/KaM=;
        b=rsnHvgAclwB1QSF9VlQlgmr81Ky8dsal9tLcV4LzHHWshYQnRW4gmg0WtCvVD5/2Sd
         f3PPWppe0QU2Lb7jeulN5zUjg9P+2y1vgbUB7ynuimzuNh2GP3SgYhBZiNESmjAUjFbt
         T5lwm3j9RkTSthCiJB8ldPivJJg07F7IE8+lOBbJVxg/ZrXqwEnrZWNtTfm4IUUQ2RaW
         j4CE2oxzj6UZWulwGcdNaVwpL0gHn9LetlCvTlrDLVeyjr34vHrKFeVlFbuMUXGq8+tV
         0umOY5vXzK7tTJf8DTMlHXkabV+qFRbr5NQbhtssnusOeQ4ouwoEyTwY7Dn5WYtFTufn
         f+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789586475; x=1790191275;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zm4J9dYzJGKFWSNc5KoDYu8lYlnLOpeb1w+l6QF/KaM=;
        b=wKHE9Z+Obo3nJURxbGS8+e1GSCIjpxJqDoYWJQsyLJI4WW5vrpEimgk6HGt3cNDbN2
         RCy1S89eZE6SVXFUNtBzlxXADehJAgHfryjHJR5NRVRbEXYUAksSlB1IGm8Wtx60jPmk
         S/3GmtHZYpTrKuXzS34OZEcAxGYbIfd7zdidDGAz9jqJGcnZn48yo9L5V9U80wNDu1HB
         ywLgTSapX2cZl843h5RrL0HDyTta/Rf/wu36jETuXKlkbVOoNE70ly7DYw3SUWSLlXvv
         SKERzqf+sHqtQBKbuQBILHUoEI3EgSlKNxT4oKBiFHiHgP9ck6iNTzi0yL9YpcmoGE6d
         jzGQ==
X-Gm-Message-State: AFuF++k2vtC174mqBYE4tWoDdZVHA4k5GEoQon0rC53sKCgKoXrPF4RV
	znbaEaik/lU3YFAY3uqqzayDSemj683ad1ThBn9STG8EpTouYSvTNCUqi2e1Ag==
X-Gm-Gg: AYBFou1hSbLL544pItUYKPvd8wIOEwBQkSZ6FDeCzjxDizEG+QM9HETIbjK1uX/aDAe
	1rV5npUahtxJzkf5zHuDVc6KnS6z11zQoy8slpe4S5gUAz1JQSLd2pMgeQVOp7/gb9yvaC5kWfO
	7s4ZAw6/pxendFp6nDzvWGJ4nYT+gHejzAw94gbd64fIrrBtZUoXlW3Yk3KrD2yelGA4Hvb7vcf
	VJrPfJROFMj8lzs2hThoaTRZ286lvvnEqZzIPtRPR0S69VCDIabL/9Fd0/Mgu3WoronvCyAa61y
	vQr7gYSwmWpSHo0hkdLV5NryLuF3g8c6vrWssOF5H4JnRJreMFRxUtbfQIVD3y5oK8Cb89rVtnf
	55nAJlakJdpprMkKs6Mw9q9YoyoLn3Jo+G5krvdzDhyQKsMO7Ok63qDCtoJdLplCN/fjyN6Xikg
	WWEV9TYyGuDHyDI5QiB4/VnXtTCeNWmq6fZ1WFQcw0CNcLTElL2YVd9a7NttZPg+vkFRJy3PS98
	6lT4MxjbXXBSDi/fA==
X-Received: by 2002:a05:6a20:6a03:b0:3d3:ae50:97c8 with SMTP id adf61e73a8af0-3dd5f7a9bf4mr9140264637.21.1789586474816;
        Wed, 16 Sep 2026 12:21:14 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.128.205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b2753csm18879398eec.31.2026.09.16.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:21:14 -0700 (PDT)
Message-ID: <6aaaec2a.c21e2895.a2dd1.a494@mx.google.com>
Date: Wed, 16 Sep 2026 12:21:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0274290463873802421=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ngocthang2710.1999@gmail.com
Subject: RE: Bluetooth: af_bluetooth: hold a reference on parent in accept_q
In-Reply-To: <20260916153818.24916-1-ngocthang2710.1999@gmail.com>
References: <20260916153818.24916-1-ngocthang2710.1999@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0274290463873802421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1166624/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.59 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.59 seconds
CheckAllWarning               PASS      31.90 seconds
CheckSparse                   PASS      34.81 seconds
BuildKernel32                 PASS      27.84 seconds
CheckKernelLLVM               PASS      32.91 seconds
TestRunnerSetup               PASS      791.67 seconds
TestRunner_l2cap-tester       PASS      16.44 seconds
TestRunner_iso-tester         PASS      26.73 seconds
TestRunner_bnep-tester        PASS      3.10 seconds
TestRunner_mgmt-tester        FAIL      60.50 seconds
TestRunner_rfcomm-tester      PASS      10.18 seconds
TestRunner_sco-tester         PASS      7.60 seconds
TestRunner_ioctl-tester       PASS      4.89 seconds
TestRunner_mesh-tester        FAIL      7.80 seconds
TestRunner_smp-tester         PASS      4.39 seconds
TestRunner_userchan-tester    PASS      3.26 seconds
TestRunner_6lowpan-tester     PASS      4.46 seconds
IncrementalBuild              PASS      28.78 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: af_bluetooth: hold a reference on parent in accept_q
WARNING: The commit message has 'syzkaller', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14822720.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.019 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.448 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/783

---
Regards,
Linux Bluetooth


--===============0274290463873802421==--
