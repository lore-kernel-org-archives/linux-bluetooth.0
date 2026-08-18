Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C23403EB
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787023180; cv=none; b=TqakEKzO1IWukdMAWwXJJlTENybp3l/cwvtgXkT6W2gy+iFd7JU0cP9lT/VZQppbJZiPQIensxWPXUMPK5C5+hh/dsBO5KkM/iGtb8krXvz77ZYQp+/rTxY8muHxfoN97hcbmJkVDquVoDxQfkHlssH8C9MNHNS9iYRopTcbTww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787023180; c=relaxed/simple;
	bh=yP8TFGuL235t3pBjl+KnjpYspG8bpl19rP3U6Oxw5BU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S0cQd3aSVY68kxPemerRoyxe/gZEnFCQVzw0IcEGQY7PCpr8YDmQyakwWZyaNQ26fs5ts/GsZ0vh8eDEJpe5aryxvVFJDv+ThpkRY7Q/b2DcSylfIlfjFwFXP7JS1Sm76C1E6Y3qEiuCRZKKC50XLziYfsZyfLeVHhD4YeB/5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EME9uz4N; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EME9uz4N"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacf197759so57091515ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 20:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787023173; x=1787627973; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gYCwl4isb/dFcyKHEBu1ILx0/Ex1aC0AaOMIRi/IRGA=;
        b=EME9uz4N52kYckjvktDjAoB6f73MizKxvJM1TVcBrupbdesK9X0NJt6rsRQEi2vdk1
         A4qhO9epiIs3oTtXNlWyETHu8j47h5DQ40vAxT1ZRZOzPikDjdfArEnv4HWawLmweIQE
         mXKfUG+Tmwju6itrF8BkLeB1VW9BkKQ+/koW9eL91zz1kj6fZTUfmkG7F9OpQCFJl6rA
         Rcx6s/MamlRETkozzr089vcjnvL1WgvI+lyr02X1lYmsZeYapOVQlvKJBR4/PUrx92cW
         dKmOZhqG/vKKaO09xGo068EiJTDGkDTgnKpylswqlYQ3r/ha/2ND/vc1XEevGZ9b2mG0
         JmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787023173; x=1787627973;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gYCwl4isb/dFcyKHEBu1ILx0/Ex1aC0AaOMIRi/IRGA=;
        b=asBDCsJuDmfgCOVVHdi6jkvoLd8nc8pa65Ow+JmzLYxLLk5S+K4veN3ct8wq1ufY8J
         xo2XW3MZEJJY5qqsUGzoOXP49zzXtJxcqAhbrFavgNEAiKAY88qPvqU6p4eAal12WrQV
         toNUfSSaz6Y4G1YnhSQ3U9U4lggx3j5JkT3UQviqTE4vzjxw3FknDCe5XsZHXpDIKYBf
         3YdkXyvrJS2Wgn1udr3v74eTdVGRrAmLwSjPZVME4wfyxla4AqkHxsQPPWtRy111GWCb
         AUzU2ZGme/T6mkuqeU20f0YGM94oYP4iEP5aWR9vuP8qg0UEYBQqvmFrH5HLoESLFjgT
         q+xA==
X-Gm-Message-State: AOJu0Yw4U+vrXh/K6rtE9Rv0y6mb/prOnLpNr4eZX6VQO4+9j79RJyRI
	V0v4IaC3sJgj8jMpLtCHB50Uxmum4wcQwZF/iTiHL6L+2EkGkxURbX/eQH5YXg==
X-Gm-Gg: AR+sD12zh51xcAo+7h2EYbh5NAIevDxRqJCrNPzyCSZP5oJAdFndyZuTGJDJcB9E6cW
	MjRfpgunKhlEYmFn/arwQfTz9ZVpH6stMxagAMfoPVnYptR3mqKjkpPLNZtgM39/BCuleNRVuqN
	FrrCzCoGrQM63RXp1tMwBBso9RebMe800J40qcte4EqztF1soBrco8ZLq5Kmm9XKB4nBTUIInza
	35hl+a4ewB+/sbmwSXK0VeyaebEKON4UmmZ4cE4rWmKH/K7CiqBZqPAnJTyz9hHnsmqUD1ESFtL
	IZuRwTGPRVwT2Z79obWB6Ly1Cycdy2/GV2VB8A1r/bL74V+vusvlENSfkSb+xtVryXd98uIX/xD
	HN2Y7s5b2W+g4p3inb/Ury5Her5BLQd1nFkN+Kc3vDVqTlPP6NDTTq/p9zeNP1kZVjBmcOdwZFt
	GDpThBS2lv84hhzx6YEpVAadaxuvczWtARqobcqwFk77g88JjIRj9DrDCImmdO0Lwj1ng=
X-Received: by 2002:a17:90b:3803:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-3933b74e16emr30806774a91.6.1787023172614;
        Mon, 17 Aug 2026 20:19:32 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.240.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32678dd22f7sm17105576eec.1.2026.08.17.20.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 20:19:32 -0700 (PDT)
Message-ID: <6a83cf44.27e38385.1ffa8b.26d4@mx.google.com>
Date: Mon, 17 Aug 2026 20:19:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8423025307248696872=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: Add support for the Synaptics BCM4384 Bluetooth controller
In-Reply-To: <20260818014948.996739-2-kaihsin.chung@synaptics.com>
References: <20260818014948.996739-2-kaihsin.chung@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8423025307248696872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147486

---Test result---

Test Summary:
CheckPatch                    FAIL      1.32 seconds
VerifyFixes                   PASS      0.58 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 FAIL      0.13 seconds
BuildKernel                   PASS      27.22 seconds
CheckAllWarning               PASS      30.06 seconds
CheckSparse                   PASS      28.87 seconds
BuildKernel32                 PASS      26.35 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      500.97 seconds
TestRunner_l2cap-tester       PASS      64.94 seconds
TestRunner_iso-tester         PASS      79.01 seconds
TestRunner_bnep-tester        PASS      19.45 seconds
TestRunner_mgmt-tester        FAIL      221.21 seconds
TestRunner_rfcomm-tester      PASS      25.63 seconds
TestRunner_sco-tester         PASS      33.36 seconds
TestRunner_ioctl-tester       PASS      27.10 seconds
TestRunner_mesh-tester        FAIL      25.88 seconds
TestRunner_smp-tester         PASS      23.38 seconds
TestRunner_userchan-tester    PASS      19.85 seconds
TestRunner_6lowpan-tester     PASS      22.94 seconds
IncrementalBuild              PASS      27.68 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/2] dt-bindings: net: bluetooth: add BCM4384
WARNING: From:/Signed-off-by: email address mismatch: 'From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>' != 'Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>'

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14754426.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
WARNING: From:/Signed-off-by: email address mismatch: 'From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>' != 'Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>'

total: 0 errors, 1 warnings, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14754427.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.245 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.226 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/603

---
Regards,
Linux Bluetooth


--===============8423025307248696872==--
