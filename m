Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31E2DCC01
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Mar 2026 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512021; cv=none; b=HuDazkpg1ttIDX7p9osFNd+fu1tP7kdhMt08vqB4vmGdeqbz57wtc2og8JTYRGwRG/AbRq2Fb8yqCH0MW1fJ0fekaNztB1o+WWAW/SOP1EaOWDhurMR3MGTfU8FhlxSl1Gx2VItQaHQhUu6b+FN1me0E5JQxwlkl1E+dEJ+vRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512021; c=relaxed/simple;
	bh=kBaaMBbieZEYlzVEjbjmC//2l6z4FNwH57nhkJ4c/Hw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tjXLiPqQKS1y01kklVElS8ZcstMNhz0AFSmpEVnwEPd+8e77mZXKulgRBEpvT7apMv5mkYxX3+XaxVJhdPmp13nnRO8XrSYR4Z4rPwA2LvoL6LE75jRUMDPyl42Nj6zQ7t1o10GB8BKJGUQkPTvt0JINEB0bzPLmk5mIEpXjF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGKWqAyG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGKWqAyG"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cd8dbf4f2eso311542285a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Mar 2026 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773512019; x=1774116819; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PqWEFs4lrhxVZeeoVKYCAFTwACwYYd/hx7zhLiA7H9Q=;
        b=VGKWqAyGVuqfWJFkUwIjCt9Q36/6TrGgRR15/L6U8lQi8EU66bYLkfPDBNfY/v+MOA
         CkbSAPN5iAwtHNJrYMlXxlQ3C0Vp+mesG5EDEf9mn6v7L6Z9jz/2vfy4dTTkd9TCA+bM
         cuSkqMqsa9+QB04tCJY2CwmzN6kb3HULLtbgrOgA93Bkqz0kUi3sUwBdyvfdUQcB5RoR
         6xwA5ybOjVJDXJaQ1Ptnk/jAd3pV42hZv0SAOUGSjlCgKKr7lI26NtlDR24o2D/FEmE6
         530WY53o3YVulc2jCtueRxIcqNj4WRQKQxcIQaUoXd2ULWQCndZiUTwpy5Gr6DIOHF44
         D3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512019; x=1774116819;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqWEFs4lrhxVZeeoVKYCAFTwACwYYd/hx7zhLiA7H9Q=;
        b=evQApmYdA/uKEqEzPSFkfqzE0dKletb0r4SQFrw9iFGeEPKPsbBrON5jZ6ph8tdzB3
         8Ur0km6lB+y+x49rkJECCxE2fIGLSO4F323aEh5PJcWc3Gvv8tQIIxEBS4KmsTYiBmrm
         1r0Xrl8cWjFif4rloEYtlVsEE8mj4Ezza87DiNFOMtkfd/fARuJm2elQ0KvOYJcEeeva
         0iwxak9nvOeWPR9GovOW1++ETP9vDwhb+Etd1F937d7CnHggB2rShphoEjID3T1tNH9f
         aV3RdHE0YyocIrC31RRGPl/iZvHSAyEHL2g+Lx/za3FOj8+hI7yVtDSmj2pdGsI4QszB
         qQ6A==
X-Gm-Message-State: AOJu0Yw/g/mXDoC+ovDSXOtbksf/cI5YHgnTd2EiRmAxelKFacn0Vaay
	mIjMdUrJM/kRq5MOGD4DLlt5hB287ztWBxtMA13mpcxVHc2oC5Sfb4bwU99+og==
X-Gm-Gg: ATEYQzyF8h2L147jpzBW7WnUNCJSc9atNaAmhYhK9XtKDrjz316LHnxE80ruGAW1Ywc
	iCiDCJmXsJ30eKbzcWVQAHroZsnPnAlws0IZ5p1P7un54QlUUTLe0S9Q6vCfPtMtaZ5IHffHchU
	i6mdTKWLwz8ELNpcwJlMEMpgbFd46nLbvGRk8iai+4+GQ5hPkNiXCCgcnQr4JMzHVH0hTDl+5rE
	7JaQGZ2qjjzxZWsYc2nvom8OBeOBRJ4S0/OYVbGhpJ3Est5dOkzNtQEXx0RSPY4D0jy74EYkXVb
	PeA3+6/U9vG3cXgnhP0FnH6HZBxGMTRpB2wmc44KEfIytGQ4WfD4a2AD+85R9x8u6lgXRxsHQmy
	ERGjGf/lQ3nMs6HxZv4EUmnS7Qy1bXPi7m/LHxGPeIVQ9oUnNfy7WmWbnOSxU6X7TJhHYm9U+lp
	mUyH9m9wFrtUSebQWOtxQ8GCbVq/I=
X-Received: by 2002:ac8:588f:0:b0:509:764:2f02 with SMTP id d75a77b69052e-50957e22ef7mr97378681cf.45.1773512018678;
        Sat, 14 Mar 2026 11:13:38 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.169.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d1579asm85345576d6.47.2026.03.14.11.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 11:13:38 -0700 (PDT)
Message-ID: <69b5a552.0c0a0220.20d497.1f1e@mx.google.com>
Date: Sat, 14 Mar 2026 11:13:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8528098056435510920=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mohd.abd.6602@gmail.com
Subject: RE: Bluetooth: hci_ll: Fix firmware leak on error path
In-Reply-To: <20260314165639.180559-1-mohd.abd.6602@gmail.com>
References: <20260314165639.180559-1-mohd.abd.6602@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8528098056435510920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1066761

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.29 seconds
CheckAllWarning               PASS      29.88 seconds
CheckSparse                   PASS      34.26 seconds
BuildKernel32                 PASS      26.62 seconds
TestRunnerSetup               PASS      576.28 seconds
TestRunner_l2cap-tester       PASS      29.71 seconds
TestRunner_iso-tester         FAIL      61.50 seconds
TestRunner_bnep-tester        PASS      6.49 seconds
TestRunner_mgmt-tester        FAIL      119.04 seconds
TestRunner_rfcomm-tester      PASS      9.99 seconds
TestRunner_sco-tester         FAIL      14.98 seconds
TestRunner_ioctl-tester       PASS      10.78 seconds
TestRunner_mesh-tester        FAIL      12.46 seconds
TestRunner_smp-tester         PASS      9.16 seconds
TestRunner_userchan-tester    PASS      7.05 seconds
IncrementalBuild              PENDING   0.84 seconds

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
Read Exp Feature - Success                           Failed       0.117 seconds
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
Mesh - Send cancel - 1                               Timed out    2.468 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8528098056435510920==--
