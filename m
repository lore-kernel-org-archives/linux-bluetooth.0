Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F6426EB6
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863755; cv=none; b=LkE0Ye0/tJdlsQcoVz2avZGGM1mv0pP8pPKUlRz/Oau9odhuGBo3uYMilXYC/R/onDYsTj2nlf95Pd0bPIccCBIwBWAPu6oS/WKVUvoheXXXIFhqnTAgi0EwiFRQov8EYIvIkaMVyfZf8lfJYb65uAs2AGQXYaBKyBSztYcLeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863755; c=relaxed/simple;
	bh=6xYQZtXJ9MysJbpdwSk9HtVk3/ZZyHotJtb4v46PWoI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BmoCcXVNVlZPHdoabWDKaY6iTsCHbzpdRlSJYt7ZyrxCg/tqzC7Z03YWFieHlO3RRva06Mf1UeGbwHiS50EKs6/waDdOQmPc/yJ4fkVlin52+F+fpN1ZeJcSxFekav0XIxjU7GYjAt2qaj/6iQ6ZUvIxvCO5YxQLfmJE8jTIBD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ihb9BD1S; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ihb9BD1S"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-45392215f74so1450404b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 01:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767863741; x=1768468541; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OPNnLTIZe3ZswPRbToq+HOlPQVTr55ZxhaFLmv/hVuc=;
        b=Ihb9BD1SFJfBK86kp4+pNX+/6UO0nvyAovGIfKbO4ZvS6UEmaqjdbLsd/vh+0GCgGr
         /ilT3lU2p3/9NqJdf+j2281naG2EYOhD8p4TP7S9HI8rekTzkqDXA8fen+RNSYwKQ+3E
         VdZeEDwlKkSyTn3i5vhd+7UZLk5PhXKjBX04nsT2jfPhv0yualbfWxW78SYTOwQ6K9jF
         fbG7K7xOaPfPJHGuWmvBegOsKhEDHuuY3VgWYy3Vu0PAmXG3/gxdo/hIsJ1Ulrn1hBM3
         HBMGVZScbjwiMYD5JJX8Ier0wPAPCqqA7eZt6BEJWRrDEKiz4Ibi0EONY+VmzpZqSKBQ
         Im0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863741; x=1768468541;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPNnLTIZe3ZswPRbToq+HOlPQVTr55ZxhaFLmv/hVuc=;
        b=cyk1PqPqx/+TYKYLu+GSkidIAAEd94p0aVLTA27DqE/yJKpLih7zA/+km6jUzHZGAw
         QkJ23NWvIdF54nms+FGAkNVEVDKqRjwiXeoR/ivyoXFkU4KcQcElNdzvB6o/mAuScKob
         jCCALVTtMfnpxmPPOMTBpCgUFpP7shHJr0nTWDRDf+AgQPR5mh5XqPitRsqbrGzwGMeL
         AkRfi4a0DflatALH6LDDHRhAu1wS1oUIEiW0N0qYaO4/1uRYBQEU+yfU6gSCUsESMVsg
         fRV23KxzYs8SBPHNA99neNZ5v7ZXGz6XbUOzHHJdOignOs5ikXM5GZXeR921Ixp5HgJ/
         yuMQ==
X-Gm-Message-State: AOJu0YwDRRyqoJcQJ43O722DRuiPeNmssamePuFccjkKNQeR47mJc+wf
	qXBkRwjNz7xh9yRI+P+m/TLoKxk45WcNkxp15jmgrZkCVNONfhea3kpZl1L853Wf
X-Gm-Gg: AY/fxX6OAKv4jGS44E+ApAqmf9T4npWj82Wok302GnXDn8gRUH7fj5OambgkdYmko3L
	DRLFxxb9ZSWLl0LxMOZTW91mQNvhTNZ1KR1mL4UiCOQsl22mBSC34CsXugsAKed4eEn7AsT7U9X
	s1ICtwp5XOVjveXHwPnCC1FQ4H4msmBdbLW2fzfkMvCC6KWR84ztuVlE/OEHH+aXGS9MRnQATMO
	m3Yy9coYThttwTXMGOKZQOFAdTd44FaP0Mtlp2buVY/TJhbaT2Kr5z3WdjlJmxQkzHkC4+XQMTr
	6Fp1e2R9uexnm1MkPTBRNxcATzuPvUdbh+JbGPeaIhwZVGIpEj82H+HuY8Jn8WYsX/qn9jENhHH
	K0AjTtxHw0KZfy87orIbwm9ZwAJAhBU00m/D+Hfs+yhYdg2Fxlnvr/tJVOGpmCTaDFuqPjkHaHS
	20LPLpbbVhI1AFS+nrZEnm1tOo72AX
X-Google-Smtp-Source: AGHT+IEoqNpXj54NcuQ0yQBbsX0CVEQSLxfvjyiZpUawkxAuNles9DKiTUJQHsUI9X+T8x4cSMu0Pg==
X-Received: by 2002:a05:6808:e87:b0:450:caf8:ebb0 with SMTP id 5614622812f47-45a6bdaf9dcmr2477009b6e.25.1767863741232;
        Thu, 08 Jan 2026 01:15:41 -0800 (PST)
Received: from [172.17.0.2] ([52.154.132.164])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e17cd0esm3414458b6e.3.2026.01.08.01.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:15:40 -0800 (PST)
Message-ID: <695f75bc.050a0220.637e0.f1e5@mx.google.com>
Date: Thu, 08 Jan 2026 01:15:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0757877845064783638=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v1] Bluetooth: btusb: Allow firmware re-download when version matches
In-Reply-To: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
References: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0757877845064783638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1039730

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.03 seconds
CheckAllWarning               PASS      28.43 seconds
CheckSparse                   PASS      31.81 seconds
BuildKernel32                 PASS      25.58 seconds
TestRunnerSetup               PASS      560.38 seconds
TestRunner_l2cap-tester       PASS      28.72 seconds
TestRunner_iso-tester         FAIL      68.50 seconds
TestRunner_bnep-tester        PASS      6.32 seconds
TestRunner_mgmt-tester        FAIL      121.81 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.78 seconds
TestRunner_ioctl-tester       PASS      10.59 seconds
TestRunner_mesh-tester        FAIL      12.42 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
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
Read Exp Feature - Success                           Failed       0.124 seconds
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
Mesh - Send cancel - 1                               Timed out    2.780 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0757877845064783638==--
