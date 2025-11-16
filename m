Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B009A22FAFD
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Nov 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763285708; cv=none; b=FoX2ijQPXOLAvFX5iZ1EjRGthVE64nh3zzm2Q6fBIPYC5qvpyJu2idCCuSxJZHOjyuOdHEQ8anJ7onzvhVauEtofM5ZGO6XvzN0Fh+0XWhiBwmHDgG9xu6tn8eUZuEzcMqU4j2DcULGwXNO1m1A9P5BRmsxjOiHwclk5whoLtqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763285708; c=relaxed/simple;
	bh=bbFijD4ge5snMQbMBONCHRBmq4xPuT4cgvxpPOUspsE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SrLw461kIAbD+IugiafEgfChd/k5HOL0ClYFbz501dPjv9t1XmSp0MRwXc6MQkBweiAEF8yJ9CcSt31Hx3pBXAtRY/VyRQUe5dq7miGwJmmat79LLy95LwbqPEaMaMNIc2hz/Cd1SQq91/ambDJKskj7373r08VBg0W12175dKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOAtYkxB; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOAtYkxB"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2627269d5so400460885a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Nov 2025 01:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763285704; x=1763890504; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BthSj3ZA1SVG0LjBdQQmc1DfSmxPHJtpNG2z3qlYhS0=;
        b=SOAtYkxBraIghJlCwOqJE/N4HoW1RfFeM3I/VGNEAA421bY3cWuajHEKNFPyzHJMJ1
         +5FMkwy99QWKGWWvdX3gcFTrnA/zM/h205xNwv0GujxHiGdjhE6btxAEQUiGvUkkR+Ny
         FSQsKb+VCv9dDgwrwWve0iXhzLtnE/F+BGDGjUztnn04yWNgPrg7mMIm65dMVj6Dbs3G
         xqCotJbCmbESWmGnOU02PDbZsRh6vn/VRLpIKOkjCi4SMtPrnxEHjrf+3nd9M7ts6aL/
         muS6/xWorSpBbKbIlRekuv0q/a3X3h6JofWbnir7JB0r6zWdTORNUL+7sUnWP1SsM7vv
         l4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763285704; x=1763890504;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BthSj3ZA1SVG0LjBdQQmc1DfSmxPHJtpNG2z3qlYhS0=;
        b=iw25VTgkxbh2j8vxLcJdVHr4tnE8/vhK2ba7++TLPYuImt3TxD2EbxjSjb+v/pF65c
         eZFOijwE8J2iMtWDITxpY0lrvSAqzgm1TVVKK9jWZ+qZfLBQJkAartDRiBEYgoCDoRrl
         hYlvnzcaVaTQCeNFes9avnia7QAilkPtwMkivPYZtftzIXZgMsQrYb3e1U0sqPyCDhaC
         iY9/Ti8r8FD+AZ9yfha4udTe6HlT+PB340VlgJG3Fn6IrRlhS2E/Z5xEtJ+1LtCvcbS0
         qU3t6Ff97su9TSsIC00+L2f4QvTnwGQZ/hlgsuAbebT6Z3b3LwJKNKuRKclX3Fj7nb/y
         9eWQ==
X-Gm-Message-State: AOJu0YyLr06A1viaIHP2Qc9uJVwIZzYOAjXFZhg2uzD37kMUalE7HXWD
	nWqzv98rYRoJDNaQzCwqgZbm/Mdr9q12PakLdycSBulZWua7JM9DBQkJGi1PMA==
X-Gm-Gg: ASbGncviCdEaeOEv6utCTtUmgPjLWkjuui0yXBavb2dx++9aoljh8chb3h25iP8qLZj
	XWNfaoizOELL/829CGK0iWVBrH2uv22Fzuf6mG4yOhfMulW46shpNOxEyAdqi54AQAIpP7HbFXb
	T0DW+Q0QCIY7E+CFd91PUM0nknT2rvJFskeTopmeR5fOUZiaVphU7B52vkbhbUu4o1vTF9xPius
	Z9Akb3mwgSPfBm5Dgd9Az/lFZ5ZFcDFKK6BUk0coWhDtVs8PAzFPQFdbgGpdjvKFpAFwDyD+wW6
	zwyjsF92edYa3vuNTDP3DLUUssdkpdD4mZkAqA5cvJ7D8Q7u2Z0zjpc986HkEav4RjHugmnL1aX
	ua0Dv4xbkaggzxS3gkQZebmoTqCxCn7lrdApfw8slQJM/e0qa5Pze/630NuqfwBXWAxRaklsMFd
	cn3y5bqQ==
X-Google-Smtp-Source: AGHT+IFGnPhImLa86AlimVbTZqLkpwkOV3Nuk0DgX/Re1daXnVFukRMBjUNRirnPx5alcO5uj7JtFA==
X-Received: by 2002:a05:620a:3728:b0:8b2:5af3:7ff8 with SMTP id af79cd13be357-8b2c31b4a9bmr1081203485a.50.1763285704254;
        Sun, 16 Nov 2025 01:35:04 -0800 (PST)
Received: from [172.17.0.2] ([20.161.28.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeeaf9d9sm718280585a.16.2025.11.16.01.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 01:35:03 -0800 (PST)
Message-ID: <69199ac7.050a0220.10dad7.23ed@mx.google.com>
Date: Sun, 16 Nov 2025 01:35:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1392699425741313831=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: Bluetooth: hci_sock: Prevent race in socket write iter and sock bind
In-Reply-To: <tencent_279508EB2AECDECC2C79466F582D896E980A@qq.com>
References: <tencent_279508EB2AECDECC2C79466F582D896E980A@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1392699425741313831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1023947

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.00 seconds
CheckAllWarning               PASS      28.48 seconds
CheckSparse                   PASS      31.83 seconds
BuildKernel32                 PASS      24.90 seconds
TestRunnerSetup               PASS      498.24 seconds
TestRunner_l2cap-tester       PASS      23.86 seconds
TestRunner_iso-tester         PASS      62.72 seconds
TestRunner_bnep-tester        PASS      6.05 seconds
TestRunner_mgmt-tester        FAIL      118.04 seconds
TestRunner_rfcomm-tester      PASS      9.11 seconds
TestRunner_sco-tester         PASS      14.33 seconds
TestRunner_ioctl-tester       PASS      9.83 seconds
TestRunner_mesh-tester        FAIL      11.75 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      6.52 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Total: 492, Passed: 486 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.101 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.148 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.264 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1392699425741313831==--
