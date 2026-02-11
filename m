Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6607259C80
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807872; cv=none; b=uQtWGW8nFF+wNDPlC2g2qAsUrilqCg1Cv3XvbEXr0Dq1b/E+r/uuQe/7SaZYmTu3DAlWVRKPybIOF76ThKMJQX9cVVAfCt0xhCS6IsnkDAaOiu/4NYOnen0KPTZO2joV0kCja20g57UWqkjK+1wSugHa5xesA6BYylM+W3qRFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807872; c=relaxed/simple;
	bh=EJOsQ/F/5fdrc7CyRZ5Lnvx29oyb1/HbO82MrmuUnUc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SnL9k/B32d2evlDXRizkhfsVk3+KJQ/9PX/EWbi8wuHLMySfUjquhBCnDDUlp5+mpGvbLQg4BoHwOFDJKCiYqT4KtxhAQqelwgcphKHKWCSuS7vvkoOCAKCJcdKoBUqJ9lhqR3L/xupQpXWgEWH71NzZu3yDKa3TO2aMLWXkrc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlJDKBv9; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlJDKBv9"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b82c605dbdso3896877eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 03:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770807870; x=1771412670; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OSiUuhvMaqmSIJPCq7SFQ8S/VH6JMsfvA8jaw1JwF/g=;
        b=QlJDKBv9xTTFS5fFWPR2+pegjf2QaSMEyN8/MYRbSD+3ez2HMNu/DhxEImoRNkUN25
         AQ1DnOBiJwHX4gCR7CB1Bqta23zpi0bQR97W52MdBOCPoYdPvpnjI1m40MYbE5DoTKem
         xBlwffdmjm117rLN69p1TXT+uAfskeJMh9gyVk9XYBUwpiOMTVHxTEjCDp8VfZLqMo0h
         QfKxXdmEkyUVQvSWGiBTov9f+pXCwPW2K1GYPmuBchdaVYDeSSlR4A1U5YSy3nOU/klM
         dLpR8QJNmGakpUtwyk+cLiu+kF44tAzEn/wumP2I/ONYnC7lP063FbdzbETIle0+3eB1
         GRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770807870; x=1771412670;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSiUuhvMaqmSIJPCq7SFQ8S/VH6JMsfvA8jaw1JwF/g=;
        b=kcyi0BV/MwArZCQ0zCcqyur1HIWaODb1omc0RdUfZMm6YaC+AGrCXdvXJRbvb0kiYy
         q6rXX6lkkNknk0Y27kbyZAyRlTDu+YDmMk/caZAaZ1TVsGHXpdYz9Q5vG7PXrH+CCZYQ
         ojZXFnZN2AH3E5nWL9BUIzGG8RrQfJluvs/YqaqExa+KdYlH36+BDYSqKKR+fRMIXu8s
         7m5+Wkhrq/v1LhF0X1i7GKcEOOWiQXAqrXkCG+yW3cYMsuqfL04UTNDnYXFVRWAGAkK0
         KU6bpALGvjzDECSDrG/LYiz/zZdgOQ4MuRUz7mcflt2Pe8928Azv5ANDHRNes7bIhx5+
         rMvQ==
X-Gm-Message-State: AOJu0YwUduhbAcCV2aYU8SjMFUSV3ViZJFKSNrxQtAb9Fvgs/vYitZQY
	w160ekHIP+z1aJ2dNU6D6cB3P9ZdpDhX0kkANcjHpAvp0+ilPuBIss0mArrRrk+T
X-Gm-Gg: AZuq6aIUeDMLT8DjcYTcgFwMUPmQ1uWLOgy7a8H/CqOS9SMdiAyOKmSDqSBckZSwkSS
	AuxipobK5MbGZUPDkxtB0mADKr4MsJH/3ynTNv9keTSwp023jbp/FkA6YSJjWwb27eeqBLly3A3
	aMoT/RGIEX0+2Zugh1KTG7RUvwAcugs4ZS7ura9w/sUd64r1dRXOxFR3whsMj6eqW6sOpbWmMdf
	kIW5eTYruSRoQKCagxRt6Tdu4znER8ewfD2ChENeCJIts9CGDvPicO36l0MEtDL5JWkW0/B+A50
	l60q2KrJ7OiwQdTt/jwza9UoFffpiP2AjnvYTYj7yvL7OoN+94Bx/xc/U87Zzj3kLwsgPMecPhL
	u2ncpf734JnYIf4n7PIocr1wxfoFS9hQFwM8y8UdKxHYDXaeKB0ilh7OGh311PECh2+3+ZB9cwh
	QN0QC1xjV3WOLvufZAdpAnYN97Dtpw
X-Received: by 2002:a05:7301:9f04:b0:2ba:7a5f:9e53 with SMTP id 5a478bee46e88-2ba7a5fa4aemr2862661eec.40.1770807870215;
        Wed, 11 Feb 2026 03:04:30 -0800 (PST)
Received: from [172.17.0.2] ([20.169.72.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dbd5d27sm1004908eec.9.2026.02.11.03.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 03:04:28 -0800 (PST)
Message-ID: <698c623c.050a0220.22d278.9b83@mx.google.com>
Date: Wed, 11 Feb 2026 03:04:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2800629263960894825=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, enelsonmoore@gmail.com
Subject: RE: [RFC] bluetooth: remove all PCMCIA drivers
In-Reply-To: <20260211082246.41148-1-enelsonmoore@gmail.com>
References: <20260211082246.41148-1-enelsonmoore@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2800629263960894825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1053062

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.44 seconds
SubjectPrefix                 FAIL      0.46 seconds
BuildKernel                   PASS      23.31 seconds
CheckAllWarning               PASS      25.38 seconds
CheckSparse                   PASS      28.19 seconds
BuildKernel32                 PASS      22.61 seconds
TestRunnerSetup               PASS      506.14 seconds
TestRunner_l2cap-tester       PASS      27.77 seconds
TestRunner_iso-tester         PASS      103.84 seconds
TestRunner_bnep-tester        PASS      6.18 seconds
TestRunner_mgmt-tester        FAIL      111.68 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         FAIL      14.35 seconds
TestRunner_ioctl-tester       PASS      9.97 seconds
TestRunner_mesh-tester        FAIL      12.49 seconds
TestRunner_smp-tester         PASS      8.52 seconds
TestRunner_userchan-tester    PASS      6.53 seconds
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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
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
Mesh - Send cancel - 1                               Timed out    2.779 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2800629263960894825==--
