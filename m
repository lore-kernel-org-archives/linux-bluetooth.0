Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745644DC522
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647321; cv=none; b=F3MWAwS2KFqNUVgFikXMhN8sIWpUEGn71ebSE+5QrEM2f9fdhSOSYZPqYa1+DLMlYpu5tS7j9AziXp9t9btWgy4UyHAwpoD8q2n5rI9wsRKmS6abnXnR53NXgcBFNR5JRjKfZr8586wxnzeBFVg7wtfIT1AmsSUdvL0r/Ehg4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647321; c=relaxed/simple;
	bh=qaTRHBEtObBK5L26WZ4xSDYhQdD9gP6UNdFZm824oRQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lU9J+MB9WR4hElsOYLNNXTwVE3ZV/V4EcLfJNDrbXEKdvA89/smB94H+Si2JFX/VwlWg1NKZf8p9H46z7TH1miztVnA49/7IWUoHihJT+dqoeMjXxyyZCBKkNiy08c1IfMfbJ+wJ4+yycCZaTMv8nzqchuaDXhCrLY9j3/IHQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLMCScLv; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLMCScLv"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c0cea8883so60768521cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784647319; x=1785252119; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EGtXXlRT1Kv0dZVAFP0gsw1YuZ2VX/UhkkynDvkihhY=;
        b=SLMCScLvztN2P4gU7DxhDmV/NSsowB+7/62CRsoDAZBYZHg4KKq7NWJdcP+cPxpXPz
         Ap00KU085P/50c9EDlz2GkFb4z46KS3yNeu8GgOs3UIP55X7VJ+hZDRGOQBxDqBD+FZ+
         1JwUPbyY4BT6vsHejFG+76O6A/AxKq2uvj0QMZL9YpxhfMpeSeD3pHfAjVrY0iJK/Vel
         6JiOvnkM94Pc7xRV3Ud8a3013oKBc4LEQ4GHFPVjsQkcNn4IMO5px1i1XCTQkvQd7mqn
         7c+pPM2DVYb5Mf9crS/expRZhXcf/uyG6lp+FLTKuvWj+l/DvE1CoEmIT8zb89C3Isv6
         jBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647319; x=1785252119;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EGtXXlRT1Kv0dZVAFP0gsw1YuZ2VX/UhkkynDvkihhY=;
        b=TDrKl8Uz/KXcGJw/t9JiElWbyF+UdShPFWb3ZspvdarVsalW+YN3saAVD/H+JP2I/4
         nE0/IT9Aw6kw2XtAPRrpeCxaimGtiEvoEPRF9vaQh0oUcSjYsLdhHmiSWk4J+yThLvVo
         V7Ftf4BrShc8uPkfYKZ0r3sZd3Tu3adj5pKCXSec4GUKTxhVK7TuaXXMPas9dTSLz/a5
         Ge9ccCG3nunocBies8pCqLbyuPVY79KWZYfqou0rFgrdBifm3c06mqzlIhwlbC9Rfumb
         1xJ+/2/0TBdhx6Mo4JihbqA1UZ1DmZ4X+Ex/wK6OG2u7+zUg7Ck8ne0OPZBK+JGVTtJQ
         fIkg==
X-Gm-Message-State: AOJu0YwBOOhFRtQoLL+2ug04rNouPVHNtOth+J+8xLNA+8AgGUBNInam
	0CxelwIgecNh1H8hvIbDeTqm1PxRM1JGfuMrfCMwJhKCWWpRI0rwWe+f69hK4Q==
X-Gm-Gg: AfdE7cnA7kIMqkl3QM8Fx61Q7Z3XUj5E6wyMAQvgxFST9dNq6oZIr2HSF9m3/TVWC1o
	E9XdmvBuTHF9Aw+bnGtq9XpZ2L6uoKWpwnjTX/+ajc7IgKhSASfMS5vQyq/HirrleYE61xUw4da
	oY64rHdqRZdyLGb4isRD166gAsiX+3ywB5lbI0IhLzdyp0p2G5rO68LqUFPlKXRL6PKzS/GcKfN
	sbnzY+LIjC7sYNe/gxy+c7ByNDvk63Ij5gH1S61mN5s2YJoeh12tY0GDODngC4uE0tEgM1KPTx7
	FUPZnblCQZo4gSNjSrPlbScLngeIZxVb150//dRL4OxhsYTeeZjhxMCkanJodxZUW/VW0HujsAv
	wX4zNkyjXwrE3a04AUMbr/9pjn9dKTdHDo9iX6oXr18zOAlb3QJd6UfnYwAOmR0YUOjp0Ftl/Lg
	yI9y2yCOIKrw==
X-Received: by 2002:a05:622a:1c05:b0:51e:c911:a704 with SMTP id d75a77b69052e-527a6de496emr909301cf.16.1784647319194;
        Tue, 21 Jul 2026 08:21:59 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.72])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214fae3268sm95588801cf.24.2026.07.21.08.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 08:21:58 -0700 (PDT)
Message-ID: <6a5f8e96.043ad0dd.2200af.a8dc@mx.google.com>
Date: Tue, 21 Jul 2026 08:21:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4466382693602889916=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enjou1224z@gmail.com
Subject: RE: Bluetooth: mgmt: fix pairing command UAF
In-Reply-To: <5f62804883f405b432f3b72656cc07dd5223e828.1784492458.git.xizh2024@lzu.edu.cn>
References: <5f62804883f405b432f3b72656cc07dd5223e828.1784492458.git.xizh2024@lzu.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4466382693602889916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1131750

---Test result---

Test Summary:
CheckPatch                    FAIL      0.73 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.46 seconds
CheckAllWarning               PASS      29.96 seconds
CheckSparse                   PASS      28.66 seconds
BuildKernel32                 PASS      26.52 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      498.82 seconds
TestRunner_mgmt-tester        FAIL      217.43 seconds
TestRunner_mesh-tester        FAIL      25.90 seconds
IncrementalBuild              PASS      25.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: mgmt: fix UAF in pair command cancellation
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#128: 
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4

total: 0 errors, 1 warnings, 0 checks, 147 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14701143.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.246 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.954 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/470

---
Regards,
Linux Bluetooth


--===============4466382693602889916==--
