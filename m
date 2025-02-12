Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474231B21AD
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376152; cv=none; b=a1y+zoPgQgAr36phrGJSZ1wlNVSqLH3iRp4tHR8dApXtko4dJhEr9YKHHhcH1N+ffUhNYVKDoRlP74FpkwXuLdd9UAsTi2166V7fy8TgDD28A4GH+v+CvZzE5BuAOlOKhGukTrOkswxwPxrREyq1/F7IXuvSoInzzlVZl4QzmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376152; c=relaxed/simple;
	bh=Ex8R/ICjXmBicEF+5eOthw/sBpTuKLeOAO0hWqA334U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XsB+6wbFoLmltF/SywDatLdubmkUnNiYiZmImrGnrr+M1da3KOTVmrVv8I+hVzwlg3l3CgFl1E1cxjiFga6TbR87TGGEiA6Kev3He7FDhPYK/i7PDbYq7PZUk7JGgasR5TplkOoWdP+Q/nYodOfqFlfa2KKtEFNeKyQeZapjp1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG2+vPzZ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG2+vPzZ"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e65be7d86fso296086d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 08:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739376150; x=1739980950; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FgsA5qMF+XCjXCWDrFc7p6wg91VJVCdMjlak8lxc0+o=;
        b=EG2+vPzZJEBd/71RuIrbjVk4E52bBmUPctbDBEXN9S7X19uDW3QrJiBsNpHG30DALE
         IDe1z9Z1FWaMDRj3RsY1ZOXtWLMYx/mIF75h2SvZk1D6P/JkHz7G7z9Tlt/f3syR03G9
         HPtkic2/rS9Tx5kwMm4WeFCeD2ZG590Jnjjc4ePjnHX5118DDulpsfATDq9t/5g0k9mN
         lHwxdkn3dsdNEDgcQfeXKHJiEYACIGAPrsxDj3rUGS+YzhlnIBaCtrnZnLQ6YfNVXQKz
         xXbFie/epytM0mqtglXBaT92N18SpvUq+moVDc8RIVY8lFXSnRLNdBrHJsnD0vsE/a8H
         wFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739376150; x=1739980950;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgsA5qMF+XCjXCWDrFc7p6wg91VJVCdMjlak8lxc0+o=;
        b=M55WRiYTLVwIX0vBoxJ1fhwJi2gG4zX+ByAy56jHqYFvVIS8/wtXwy6RK2SJKbDSaB
         m7KEYB7mmSuzyuQPzNOO3OvXkIx0rfFDYb4svzzKloJ2D5sIDFiW0KeL8CoQ6SRx67E0
         AuTKgwchMKv/GPjgyWDvzsuBSebfnS4HcPbEevpYRn5bW5q447v6S5/pbImr+vXClcbd
         ueGFawT8tJTF2SLjijeVZpTsAK9ydqOGbGKUrdgHs5MtbpFXUsfmEnPpSAiGDsuriFls
         A2tMljZfgA24N8ABiJm8HuSh87ap/eGKi9HCk658k2zTRd1+O8QBoAEhz7EaBJLcOluz
         mJyw==
X-Gm-Message-State: AOJu0YyMeEfRvozXH1URRSW3m3YV6Bvfl370gem+bNyIVgc5Fye9rFp9
	di/uVYGRw6XqcWTDwBDukOG/3ZunVVlinWHg3rJ2cmAW4UlG8y1APyp3WQ==
X-Gm-Gg: ASbGncsrW+qJbYr7dhIKvyxUOZyjdgXiBqDwX/TpJUDiHh7dnphBj+DNMx39K34es6j
	iHRca4+1jKMWwy85DitMNbrLsnn2u/hYwD5Y1iOzd+6fr5oZgnwDAUGYFj5AIViakPeZb+d42rh
	zf0BQCFXesYE9yIiztk7SSb6AfDS2ncaietU1IBlIHG/ieSbO8lZK02L7g6w4iM4V4yTumlZ0dl
	AmnnTb/mRtKhvfWcWMMZ5kVDiSxkbCXvOBK/42JSJcFH1om7Ej7yQayC02rc9XGa1xQ3+MQGnDf
	IxkqYOdeVnCsXvy4fO8IYR0=
X-Google-Smtp-Source: AGHT+IH03pYeVFvWotyOXiuryK6BvVR3nptoi0dX9WfgtUP4nZIbvf4qV+wIOyOLHVrGr/Ixjtbp8A==
X-Received: by 2002:a05:6214:19eb:b0:6d4:287d:b8d9 with SMTP id 6a1803df08f44-6e46f17cf17mr58447596d6.2.1739376149797;
        Wed, 12 Feb 2025 08:02:29 -0800 (PST)
Received: from [172.17.0.2] ([74.235.134.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baaca5dsm79861586d6.72.2025.02.12.08.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:02:29 -0800 (PST)
Message-ID: <67acc615.050a0220.adad7.b367@mx.google.com>
Date: Wed, 12 Feb 2025 08:02:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7443988871726786317=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, avkrasnov@salutedevices.com
Subject: RE: [v1] Bluetooth: hci_uart: fix race during initialization
In-Reply-To: <490d0026-2561-76b0-c11b-495b3e967e35@salutedevices.com>
References: <490d0026-2561-76b0-c11b-495b3e967e35@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7443988871726786317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933152

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.44 seconds
CheckAllWarning               PASS      27.60 seconds
CheckSparse                   PASS      31.87 seconds
BuildKernel32                 PASS      24.96 seconds
TestRunnerSetup               PASS      442.34 seconds
TestRunner_l2cap-tester       PASS      21.03 seconds
TestRunner_iso-tester         PASS      32.77 seconds
TestRunner_bnep-tester        PASS      4.97 seconds
TestRunner_mgmt-tester        FAIL      122.86 seconds
TestRunner_rfcomm-tester      PASS      7.75 seconds
TestRunner_sco-tester         PASS      9.59 seconds
TestRunner_ioctl-tester       PASS      8.25 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      5.24 seconds
IncrementalBuild              PENDING   0.68 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.178 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7443988871726786317==--
