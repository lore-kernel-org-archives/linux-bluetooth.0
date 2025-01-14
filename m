Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C679514B955
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866570; cv=none; b=LwK6T3Be0Ym39EkY6phxbzXSo/4wIpptHVjRg7x+B4D+CXu1wgDLmRphNkSyw1cyZOjI3DniSX+GZn7yzwH6N8CLn8OV6IvesUFFzUUjocWxFD0u8vlSyh77jJ3iOni7rjqtvq1ksyZJjSkDal4VSAEhhI1NZXC61m7pEFpw9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866570; c=relaxed/simple;
	bh=aHnZEI2s26ty1jJOW45PsU/9v7ev4qL8GqJjPlJYYiQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l8qXsD7RbnJ8AItAWrNbumHFeVW6fhFJbrshq/wDYWQ2IMO9BJEcu1XP12qh6aUzSqZuyXS3ckkYxGNnJAzslXdWPwLOF8Ge0ICoqYhDB6m6ytaonikEkPmBaTtsUHOxDiLHhuQyl847oO63UVIZBVXHT7VsQ/yyy17gsGenYMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQRsPWtO; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQRsPWtO"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-467b74a1754so70748131cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 06:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736866567; x=1737471367; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LUWpWmV9/saXVZPFEv9LyCZUThyZYzkqcPgNVLTJc0Q=;
        b=FQRsPWtOfOkNN2YYhs3QamiBXp5fWhkRVQNOjuOe/WeK0QNOYfDksC24yMZHf5Dx+o
         xON7GOQSrgBISb1ZwV4gZ7QFb8zmaHkEfkXLOalC/6BFRb4cSz2rnAw7YgAUTFcvkWLM
         8NN6rzWRnAujwAQ9xvDkGAGcRqr4esSNF/25blTGki5tUn+4GTAY7cZOcmogSz0LfN+G
         x5HlvMVJswHayB36N3Ls5IAk9VDDBdq1TQJsNOmctaQTRy3J8bLVIoeSRdF1PL8i6W5r
         OdJsc52Kt+USbzoIXza++WaFkLnMGOaR09KKvqfarikXfZeU1tepDH06J7I2ONZygyd/
         it+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736866567; x=1737471367;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUWpWmV9/saXVZPFEv9LyCZUThyZYzkqcPgNVLTJc0Q=;
        b=dlHsJRuVX6xupH5acbNHqVBg9TQ6wU7KlcbFvDFitqpRz0mwdO0emAyahvLxqKuYe/
         4JgJg9nhwKH99Bny6429zAhSHqQqMbg7HXW09QcnCDeCwvm7CLtar7wa6s/BFofVDwsp
         WY3oiiZXb2K+q70LaulIWOjHAWXrMpTrDWy18ejd+QF46J3dxqbXgRiVUKEswNeclY0R
         rv4XjnydhleyqPc8SM9BkZveAFOdkBF6ElfNbYV20D+YNObAau1t1o2QA/VSMVLZsgtQ
         2ZTMEx5tdqvmt5cHDFLONB0IFH6+E//WrQYpJMjvzwYglG2z4qL+0GpM3o2o0bGhFlhZ
         B0Tg==
X-Gm-Message-State: AOJu0YwfeDESMU3qy5EBDSeMduhWMSs+XzACAx8vN0ApL5ozWPGMDOIs
	zSWSvV1Il3a2UwGGcFcIDWMkQhfez32L3j2Pz8ItXi4tnQchR2zb0e0Eqg==
X-Gm-Gg: ASbGnctG1lohuZlFZ2F1y6Faqr1z7TeLzLD0tRT22fFcVxYkSxf1bio8qhFznyIKfsN
	eksI8Zll1Fmc7QCpoaTBkT2lpxcl4U/VEExsj+PWkUdO+WxxfCglkfAIhSkbIXsTPGWTZ4lJE7E
	2txoSuQdoMX1JKwsa0ejQIxAFNnde4KQqJ330C0rdpCtoxyL3w8iNwyHR2TB/UJCOqepEtsn+zg
	quy8x6tAebUsMNDUrHvx7mzSIhVFWJ8kDsY8IgzT08y8jOJfybjPoJZ66m9
X-Google-Smtp-Source: AGHT+IGwNerW/WyGz5u7ft85OCSvdjjVVN8kH/HqxosCLrK3h09RPNk8qlk+yHUxKmh2EmWJM8YArQ==
X-Received: by 2002:a05:622a:1889:b0:467:5e56:8677 with SMTP id d75a77b69052e-46c7102fc61mr462158531cf.30.1736866567388;
        Tue, 14 Jan 2025 06:56:07 -0800 (PST)
Received: from [172.17.0.2] ([20.57.79.74])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c87330a2asm53837731cf.22.2025.01.14.06.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:56:07 -0800 (PST)
Message-ID: <67867b07.c80a0220.18a3dd.3c09@mx.google.com>
Date: Tue, 14 Jan 2025 06:56:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4299737024800432549=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v3,1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
In-Reply-To: <20250114141912.2363131-1-neeraj.sanjaykale@nxp.com>
References: <20250114141912.2363131-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4299737024800432549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=925280

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 FAIL      0.66 seconds
BuildKernel                   PASS      24.20 seconds
CheckAllWarning               PASS      26.43 seconds
CheckSparse                   PASS      30.14 seconds
BuildKernel32                 PASS      23.96 seconds
TestRunnerSetup               PASS      420.77 seconds
TestRunner_l2cap-tester       PASS      20.67 seconds
TestRunner_iso-tester         PASS      33.79 seconds
TestRunner_bnep-tester        PASS      4.87 seconds
TestRunner_mgmt-tester        FAIL      123.54 seconds
TestRunner_rfcomm-tester      PASS      7.70 seconds
TestRunner_sco-tester         PASS      9.43 seconds
TestRunner_ioctl-tester       PASS      8.17 seconds
TestRunner_mesh-tester        PASS      6.06 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      5.04 seconds
IncrementalBuild              PENDING   0.83 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 2                 Timed out    2.039 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4299737024800432549==--
