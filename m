Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B28208A9
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738429014; cv=none; b=omSYheaQ2zWtIUlrFJkk+uRCva1Sm8MeizMV3DVcKmRrFCp7jGIbJeXjOTJGDIIId9eoLXKMbpBA8uLbGrjXCqU8ha4qPBya83TPB6DgOfaFa59UV1hNzFvYepqFBD8WYgfOj5PuZUiuxWU9EkioFKXORyXHylbu3IaDm+XeWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738429014; c=relaxed/simple;
	bh=VvzrziMbypnZqlB7JAwjGevBelgALqAgEqvbBXIV0bs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WLuGB7sbFFaby7kzeWS2SzP2C17GEtCIktYuVipyhAvLUwW0lkzehw7tFKgP+CPLcswTXxRBccHRQXyN3frPeyPW0Bfr3r4hOuXekjDVrQONoWxXkFNlgnVK61sSxyJrDcxCWaZgHFFNh7HlPd4ZAV1t4X0CRD43CJMQT9aqYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBgzteHb; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBgzteHb"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6ed0de64aso257534585a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 08:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738429011; x=1739033811; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8abdbHHBhBa7uz1uBTPoLALgNm2yomgXs6FKhMnQIrw=;
        b=DBgzteHbGlZLClroL5Baopl2VE93x5qlHXMmTNdy9GKxbYkrrHVlMEZHHGhyoWa9pI
         EBYWw/enxDCfSZO1NUl1fgqZ8wUTRqyrjf5QXxG84B0boEXJiQUXYr69aHgZJwdEuMSo
         tv2/bl/lcgHFF9xiLizbGOu0zdLHlKwWC66AyOVU6JSu94I/h8s5S1T0LqBMl+Z/67eh
         B57bIfDiF4TRKdp5rvpp9el/6Me/xy+c5HpztvT6hxO245LBPX+ay0RsF8nul1DNdGOG
         bVWq9dDBDdqc4a+9PqbtBEfVFvjrmvkBjyXGhfKuoqni5bgm8/P4povjWPU3g3+MV8x4
         rORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738429011; x=1739033811;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8abdbHHBhBa7uz1uBTPoLALgNm2yomgXs6FKhMnQIrw=;
        b=NJ0OuSeZaMClIsWhfgRCie15BXArRHKVfNCv/7gACfaF96qZtm42mq82wtdWrc67K1
         C0sOnDSM8NNTt3Ixya6J1zwQgYQQoWbo1b/VGaKjaAmGuagZ69hFHXhe/vwooF23Pgzi
         Fexgd5k2C/N/UYu0/2MSUZUTQDA5ZUCZ4XYQoQmgXNrN31iM23kJWG5vJI5G5tObUW0T
         8Z1MLCaDHmfJ40xo59XtSApnFseHNUjSfnatwwPMcJx1N8dDdNYquOuEjKv56JnRgPSA
         cP/wTcimBJxR4Q5KH6f+0lBtVWcsTYxOYU1iaWVYq7TPjJEJa+aWOv1mLRUeZlSdkSfO
         CM9g==
X-Gm-Message-State: AOJu0YxyLGIRCV5yb6wmDMXqnbvL2l/Jeg4wIBvAmF+6RvFr3p6GxVyE
	+tt3hUuYFgqIDir1TT4I15biQ8jHNrGQCMzBtIUbO5JhSZHOM05iQxht9zTD
X-Gm-Gg: ASbGncsF/AKJ+1PXG8E+6XX8Am989W8cJrRZJSb8bgJlsrPumOv03rswfUqRpPhBXTk
	PknKNdApptgWw/j9tYGQbUbvV6QyTgCb+Ne0ksTKkXHhu810gld8ojoBpCt/GuvjAoMZ4MUh+Q8
	q8QLx0GjxxANAYV9pOM7RrHFTllnP8ai0TImIHmXtsPdSmHwKKpTRBL2htfK+0qXEgqaKYtgcAZ
	Arg/r7bhBZSep8ERodiz/WFITNCfnffNocpC1W+vbgqDuYAmtQ3er7LCmoCcfPh8qyS9B/MTsKX
	wjpdNgWgguN129wcDe3TnQ==
X-Google-Smtp-Source: AGHT+IGsMloR1j8CZPCGP1SLctRxNZVkzCcE3xQv7vQj4zTG+ZpXKNcNG/aq7/+ZGQXcv+NZ9YLr8g==
X-Received: by 2002:a05:620a:4415:b0:7b7:12e:48eb with SMTP id af79cd13be357-7c0097acdd1mr1901888585a.17.1738429011384;
        Sat, 01 Feb 2025 08:56:51 -0800 (PST)
Received: from [172.17.0.2] ([20.25.205.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8bba69sm315870085a.8.2025.02.01.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 08:56:50 -0800 (PST)
Message-ID: <679e5252.050a0220.1d8be6.c3a4@mx.google.com>
Date: Sat, 01 Feb 2025 08:56:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2823840545628906192=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oxffffaa@gmail.com
Subject: RE: [RESEND,v2] Bluetooth: hci_uart: fix race during initialization
In-Reply-To: <f5ea6c5c-1904-22a4-72f2-d4050878dd26@gmail.com>
References: <f5ea6c5c-1904-22a4-72f2-d4050878dd26@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2823840545628906192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929721

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.53 seconds
CheckAllWarning               PASS      27.01 seconds
CheckSparse                   PASS      30.67 seconds
BuildKernel32                 PASS      24.47 seconds
TestRunnerSetup               PASS      428.20 seconds
TestRunner_l2cap-tester       PASS      23.35 seconds
TestRunner_iso-tester         PASS      33.47 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        FAIL      118.88 seconds
TestRunner_rfcomm-tester      PASS      7.58 seconds
TestRunner_sco-tester         PASS      9.33 seconds
TestRunner_ioctl-tester       PASS      7.97 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      4.97 seconds
IncrementalBuild              PENDING   0.76 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.162 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.193 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2823840545628906192==--
