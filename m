Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30DB30FF26
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668648; cv=none; b=qDEBX/dA42iAsg0M8bbnJPrWj+c4r0UbDt3EV7secnOFJSvl7D5kPPDH4YRnlfEDDk+LdsxSL4SBelSnd3UJ9FoDdcqfCUnOEUSG+s8BRb0IoznvGjXBINfery5FU1Ha/LWnJza3KbhZzjFAAZn9D59YrimpLO4LG9Us2icDzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668648; c=relaxed/simple;
	bh=n618+pUPtaXoa7ki+mrYdm2jC2CvLfE2QHUMMEKVlII=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KRcwI4SKGe7JixJoYZuvwBoZsjxOHCEKgUS4gVUpdayQPzc+4HbJmnRM49uKiwgVeujDvopkldD4mnKBT5FOMyci7Bjc9Egh8Y5V3Q3EtLWOCwAIg6GGsoHNv/L9JN6f/bHuUOcUq323rYrHWSnLj6xWQnN7o89mDGvcrZGPL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbvQY4AF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbvQY4AF"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89fc4147f2eso35906d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 10:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775668645; x=1776273445; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VVgyoPGr5EQzF2eyfAwq/vkhfjBWVibj2Sl4KdkQGGw=;
        b=nbvQY4AFxlyZVB1srdgqAW8WWwXh5DhROaWb/0IrgA0GAvJ4CM3ifqXnM9xiDMv8OU
         4Fsn38U7sHZbIIEMxujv1yMgdC7AkLCau1b1z3rUMDT5H4EbJWE6PWrItl1Vzv7DTx8x
         m6CRt4BlVjvHIZuadnjbkzW4ExZr9E2ldeT5PKv+buidi3pNgPlaixwLYVNyAn3Ed6EI
         b+XQqLlmxLR9Rn37WGsky9gMsffwTD17nBx1+FsPtLOsb0N8GvYzf8O6uc9pR4RlAgbv
         CnWswEQdhis463PxbYWhXSov9o3sMCvPkPps7WTrL/B/vUtpKhzkw5Y/Fp7mgWrVoj3V
         X+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775668645; x=1776273445;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVgyoPGr5EQzF2eyfAwq/vkhfjBWVibj2Sl4KdkQGGw=;
        b=lzC8QJNmIFtbgNv5dLwqiBCc4oLGpBRBO+SYT0m90ynNVr4pp4YoPlBDALjGNTDUGM
         3uOjl1jDIveIgs143Ycxm5Lmzt7Rh0hamgN8jyvxJFgXzymUGj5jWnB0ihxf+vdrHsZJ
         k8V77/MCRRoNJDw54l0F42z5oNtTZzgXh6JKM+1DKAVX7P1dgRcVI0rL9tQ9fkoImCKs
         1BTbNZaxd1eiNp7MzJn7UPUSPoMCjHkoTr8bOpu0/Irew9Yq0MjllBqHuPtwh0jK0YjQ
         24Z2BVx3cH+ClPC8NDQ7Nv69mVxb8qvl54moPslSZzusoGK1jffBzH8AUaD95Vgaa4pg
         Igug==
X-Gm-Message-State: AOJu0YxAUnNx3CDoOJq/Qf2LMg0kCDF3LA/JJ7F98yOAUd0YqTN3Kh56
	pFQlSC3uPkEC871hauD2jFEeYnDdkll6IlM9ku1qr+fNJnB068GXNgJyVBmhEg==
X-Gm-Gg: AeBDietz1s/wxH+XyVBF+psVw9c2aRPb3L02PVJP55wRAM2WBL1IX+qUzih3hmU61TE
	D4dDM6LdNovkN+q3mhdTT/vsShgSbmBhdxL5Ho+Gv01PSTu5mtJcbb/CE/ngSDmy+raHQb5EOY9
	QIV6Yb7ceoIyVH/oNLMe5Y/vAdoGt3tDGrSfnzO3NbqA7cih+0rPTuWG5qENT90uCG9UuH9VWGs
	VRobhrhY85Ke1+1NVtb6OJNzkvzCmR46aZC+a683QGy0r327My8pxsTFhh2sw8pJrFlak3XstAa
	hD05KJsZGXE5LLyYdq17hX5I+cEMPUj8bu5Vx0aAYO85amzGY8dKg6+cv9OE/GwJTWm+dGF7Lt9
	hBqshOsACMvx2EnBmIh6M2PQBvyJ7ZxsX023AycMygK0i/LzVjinWUTAYZpWlWUt9B4HlooGywI
	QoBNHzkG4pzHsEltUgnmRztdpc7IlApEg=
X-Received: by 2002:a05:6214:4883:b0:89c:518b:9dbd with SMTP id 6a1803df08f44-8a704da7fe5mr392117656d6.46.1775668645327;
        Wed, 08 Apr 2026 10:17:25 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.200.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593906450sm173387436d6.12.2026.04.08.10.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:17:24 -0700 (PDT)
Message-ID: <69d68da4.050a0220.2d16ee.4694@mx.google.com>
Date: Wed, 08 Apr 2026 10:17:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6430000612569165557=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnexen@gmail.com
Subject: RE: Bluetooth: hci_conn: validate connection before BIG creation
In-Reply-To: <20260408155638.95927-1-devnexen@gmail.com>
References: <20260408155638.95927-1-devnexen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6430000612569165557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078747

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      3.11 seconds
BuildKernel                   PASS      26.33 seconds
CheckAllWarning               PASS      28.67 seconds
CheckSparse                   PASS      27.91 seconds
BuildKernel32                 PASS      25.27 seconds
TestRunnerSetup               PASS      571.37 seconds
TestRunner_l2cap-tester       PASS      28.16 seconds
TestRunner_iso-tester         PASS      37.98 seconds
TestRunner_bnep-tester        PASS      6.50 seconds
TestRunner_mgmt-tester        FAIL      114.33 seconds
TestRunner_rfcomm-tester      PASS      9.68 seconds
TestRunner_sco-tester         FAIL      14.67 seconds
TestRunner_ioctl-tester       PASS      10.61 seconds
TestRunner_mesh-tester        FAIL      12.68 seconds
TestRunner_smp-tester         PASS      8.82 seconds
TestRunner_userchan-tester    PASS      6.79 seconds
IncrementalBuild              PENDING   0.52 seconds

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
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    2.705 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6430000612569165557==--
