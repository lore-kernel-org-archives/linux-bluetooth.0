Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74723E320
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207215; cv=none; b=ha1uB3wmZNmIEFKM7sd7+Ttl1Lp5K5BkgrpOO9symH1pjveu7J4NE8PngY+w3akvSnTvraEcK9ZqfLPWKhE7MEXfiXX7BMtqWwQv4MwVKl6JcqSG1i1anFAVybGUgpqHqf1uYhlFM2CgeCAJoT7MeEJhDtWgUulKKK+lg6C91uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207215; c=relaxed/simple;
	bh=5N+qVTYbQZMblj2MFQLBaKFEHQgjExuPcojCu+y92rs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=O29WRKsKgzmha/YXkeNurzH2VBRgCYg/BnM66OU9c8aBKRINRmJNdVCkt2ubeVk93yKFmeMvCD7hTqm+GAPVAA++MAtoooxvS5cNI6vyb32T4mMRjzY4/xkDgcFYvqD4QEz5xA5myRd6jEnqVT9zYz7E/qR9iOFE1nZ6kFYUVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITyxX7Kt; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITyxX7Kt"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b29c4e554so21673941cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775207213; x=1775812013; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wsqVEiGTvzW+DCckiNifMIOSQbtpI1jPn4Fof6+4OUY=;
        b=ITyxX7KtnOuYqle+hIePfWNbl8cNwTAnSG7+0EnF86IGvkOvvL6T6vCNnl2MPxIddm
         ZBLL+t0v/OQbO/jpmrrI6KJzN1kkmbzpsDifExcV2gWHzC4uB2kru5CgRjOkR/MC4r53
         ElaXVietOEfOuukWofAyGV7PMtSgu2plfBwSW61zws94HfrURN/C4c5pasBY9kLbSrMW
         2oT5HbxWqN8waqq1Dsd7r4mgQRG1pVbqWfDcTuWEy9OgoyVzrC08ReUi+GZMESISMsNg
         5KaebExBGlESzTJouw4G/cc+s4MUrNCcWoUKNF2FAICPg35JtWNr9G6qJ612nnzDlPqu
         Kiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775207213; x=1775812013;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsqVEiGTvzW+DCckiNifMIOSQbtpI1jPn4Fof6+4OUY=;
        b=N9SdZ31l7ffxTo+qCt/nCTpImW1xxi+s2CcqI4dLT4X2hBz5XEWMl78Kglr52CFQ7X
         8l+K3Khci7rRksV0zY/yGlJgxSFXORHhdI124wOFBCEOK6g++Ns7q/6IN2Qu1UJBbzCR
         GMjp2wI44XelGk/g7IKNfQ3yh8s8eck9z16EInHoyglazHpeVsoK95Jm/JZmAgPzijbT
         hNSUPgvxAipvX5FBxgwYxGuMtSXUBqV/nI6QE12re5OF0e5LwV1tuE9C7kfEdaH/fhtg
         W1gbRYZDDoDV5hKuAoRXI7vNii/3k9JJcAKUPHq8Y3ORxVOdRErSahhIoiNyRxFsVSrB
         l9AA==
X-Gm-Message-State: AOJu0Yy/mSm53glesFbOTfKhismVWFgnhbjBwx+K14h8TWmUU/QBFsX/
	3BfylghYrFC1v02lwJVaK/aNuwtRbk54Fzi6w9g2U2XRsvHGd7lwDKWqL9+WPg==
X-Gm-Gg: ATEYQzyVqE/gU0x00z7d2zoN79PcUbB37n+898kwwAibbZ90OX7Tp78yxuDWW+OJV04
	EyASbPTmO/K7URHrt6Ljwbv5ckxQ/PxcOA4vpKXhgPYheWwTc9Jq78/8oo6rVJOAPc5NtudeL8u
	L2S2g6wd6OzTVsrZOcTk2fxZFAqUhCZI4n6Y2beewstn711SAw4BWSoxGm48087F0pYutAmmh3x
	JonU5YrUCfud7bS+80wdELROyBhSVE6biBBU02guulw1qnoKMwel2lMRMY6hYhKsSxage95XO+q
	s6GWgv66DV//TACP9x/Vt+vwQ55NkbaPzfEm4jcYMaVwjLcAWYM3BkuBNNlBZFwKvXJ8MUfU+3N
	Mrx1dWY10ffpNlDB0V1b74+CnvKSOdFJhwuHcGpxGbtmNER1Ev4gwDJCbmAXXLxEu99HUmrD9hU
	4nmXQCYWKSOiTCxp+Ek+ZHDbLIlKnTNV8=
X-Received: by 2002:a05:622a:5c17:b0:509:3098:819a with SMTP id d75a77b69052e-50d62a41d5fmr33454511cf.44.1775207207983;
        Fri, 03 Apr 2026 02:06:47 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.235.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d63962c30sm13834281cf.10.2026.04.03.02.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:06:47 -0700 (PDT)
Message-ID: <69cf8327.c80a0220.3d5bdd.56e1@mx.google.com>
Date: Fri, 03 Apr 2026 02:06:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1668282800335777039=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, n05ec@lzu.edu.cn
Subject: RE: [v2,1/1] Bluetooth: serialize accept_q access
In-Reply-To: <06a6b4549acba207847ce532dedbf1c95ab22d13.1774925231.git.wangjiexun2025@gmail.com>
References: <06a6b4549acba207847ce532dedbf1c95ab22d13.1774925231.git.wangjiexun2025@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1668282800335777039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076861

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.60 seconds
CheckAllWarning               PASS      28.35 seconds
CheckSparse                   PASS      27.45 seconds
BuildKernel32                 PASS      25.56 seconds
TestRunnerSetup               PASS      566.41 seconds
TestRunner_l2cap-tester       PASS      28.80 seconds
TestRunner_iso-tester         PASS      34.40 seconds
TestRunner_bnep-tester        PASS      6.45 seconds
TestRunner_mgmt-tester        FAIL      115.61 seconds
TestRunner_rfcomm-tester      PASS      10.75 seconds
TestRunner_sco-tester         FAIL      14.63 seconds
TestRunner_ioctl-tester       PASS      10.42 seconds
TestRunner_mesh-tester        FAIL      12.47 seconds
TestRunner_smp-tester         PASS      8.86 seconds
TestRunner_userchan-tester    PASS      6.87 seconds
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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
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
Mesh - Send cancel - 1                               Timed out    2.703 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1668282800335777039==--
