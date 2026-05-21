Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761825DB12
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 04:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779337681; cv=none; b=uK1UuIGfrMjiRzCWGwTxo8k+nbOGo8UGP1AHFPgPNgpgenir0JPmjfg0FWVLwd3gGWeYfFfCxSdEdtTmBc5o+lH/pNHUTsg7ar25wXyGbHR2MpoAqDcVbN80lff+r/U/2nQaQiro1T4UfoWfkFBQBLa5LR2hogaupnwz+xPorTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779337681; c=relaxed/simple;
	bh=Ag2jkRY3TbBTC4LD0PikYHmDiviSHNn9GKJawWKQvuQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q8s0I6CAaC4NlcrNyk9/9ZqBncWrJcCQU+Gu85/tYfDZ8eW/mbua4/MpKgBHTnxMmepyM3d88EqUxb7FQQkEkwmfFLN6mzJL57zafrkjoQwWM+No/krEBolWpvQ0ZtfiMVx4J4jGFgqH8WVJddMxFc7G3OqVl0zrJcVHlU9UrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMCjLHET; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMCjLHET"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-91066394ef8so447473285a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 21:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779337679; x=1779942479; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/6PPBwBTROA2b0gMltCIvBMiBYnzivhFgQgiuXLGaXo=;
        b=OMCjLHETV8830ZtiLsR/GXW/GmrE0sSHrR5v7tS22RJokZ0hG1hzXzoIZHO+qfIkMj
         tkyB8CGl5eq5YR/QVVyHHhyY+X7owFuTEW6bcIpnpmdBR/HiuoFRGFjAsTg/xHOGn6jB
         w8NtvVCjVzRljn/mVfhYVI2lQGWqJsV0hYtNOUkn2eewxr702o2tUscjXBRmKXeDtEeE
         Kbur2lSt754zmNljp89dV1Wk47Dej/XEsRcSUPC7PALcgl0/J/pz0NUMRtnkFD+no08S
         3rqC8qTeYPuewXkCdt9LVnMKDhaTo/FcDDItCRIil8Eb9ntzkalUyvsGqm4bYQ18C8QY
         IK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779337679; x=1779942479;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6PPBwBTROA2b0gMltCIvBMiBYnzivhFgQgiuXLGaXo=;
        b=UBJluv4Rc09wTbaPvdkp+Hxry3gQ7V4drxE9ebGDcrlCuI+s80i5MsjTftNCu2bb9W
         +rExgeFcWNVNm1NSMkjVThKFeNeOPaw3IEP75doc5ZXwwhMnp1xPyRBd8NgD5UjAValt
         j5ixueM5Bxs29Zw4/OFiwVWWClxmo2HN1/QsZxNNQBjFOqIbU+G6gVPWWdx3NOazUQKX
         K8iQSi+3pxsoNVUqs8Bt8H0u9Iyg3kLiG95Pxe0veRrS7RC/yHEszY5ZomFyiD7ZWj8s
         aIK8HSRryAye+W51UcLXHCV0909k60fgyGy4pBcT56VUQ2JbrfinfSyjTj2p8OzYLTze
         gJtg==
X-Gm-Message-State: AOJu0YwMPldCeLuwfRx43SI2g4NxKbvjwEpnQUU5U+AX91E7790LYIj1
	2B85zM7N2UgBfdYUPIzxi/gu7osYSZ13uO7j9VtINjT+MjSG9x4I28cwFuV1qw==
X-Gm-Gg: Acq92OGkGri7X/UhmUs2tk0lvMYqQmn8/34kjq/xkyY+20gf4wijrHJsu15HS6dPbo9
	jrDah/4NN8xffjOVBh5zJwRdRdKa4U3QtzpHmpGnWgPl27Q/ZgtI83dr3ilJpmrowLqDifyoL3O
	Etxpru2y4e3hDdijHjfWd3YuRRmrHEZaODZGuMLloDlGcxSIWP6aA93f9JWbWpKIKFaLGc0QFq1
	0OKHUmlhCUCHHj9W9Djr/rQR8v+hAY9W6NPQz4ckbGbeilCr8bV0trkdtpG7hypEABPeGvmzqv4
	mf4PPlNA7m7xHFIvzZIwPSznoPzC/Ty4hj3Y//ZpWVjVqcXIa2t69jkutqAhYqNDBKw7ru+l4dR
	AlqB4A+qF6UafMKDPIqZ7CJGRWHPu9K0rlVk9jb0gISNvuDJ8RrT2KxugxDEK5r9nlt+perwF8l
	CqZsTj7I3t8Ks5z2Gdo3+kSTIi14FmVQ==
X-Received: by 2002:a05:620a:44d4:b0:8da:358a:c4d4 with SMTP id af79cd13be357-914a2d37b5emr152832285a.55.1779337678617;
        Wed, 20 May 2026 21:27:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.175.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83ff00sm2326417185a.26.2026.05.20.21.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 21:27:58 -0700 (PDT)
Message-ID: <6a0e89ce.fb03d9b9.1423b6.052d@mx.google.com>
Date: Wed, 20 May 2026 21:27:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1681377755566995455=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
In-Reply-To: <20260521001327.3729880-1-michael.bommarito@gmail.com>
References: <20260521001327.3729880-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1681377755566995455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098364

---Test result---

Test Summary:
CheckPatch                    FAIL      1.00 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.25 seconds
CheckAllWarning               PASS      28.83 seconds
CheckSparse                   PASS      27.41 seconds
BuildKernel32                 PASS      25.53 seconds
TestRunnerSetup               PASS      526.88 seconds
TestRunner_l2cap-tester       PASS      376.33 seconds
IncrementalBuild              PASS      24.88 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 66 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14585530.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
38: B1 Line exceeds max length (84>80): "Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com"
39: B1 Line exceeds max length (84>80): "Link: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@gmail.com"
73: B1 Line exceeds max length (82>80): "v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com"
74: B1 Line exceeds max length (82>80): "v2: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@gmail.com"


https://github.com/bluez/bluetooth-next/pull/225

---
Regards,
Linux Bluetooth


--===============1681377755566995455==--
