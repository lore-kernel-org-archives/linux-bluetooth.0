Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F5189906
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Oct 2025 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707862; cv=none; b=iGYDaYeq/LqjtIpkYFF/dPwinj+YRPUrsgJcYDypSRHtYFNWtBFAaeqQCPBfCnhi+fGGM0Xhhm6cIQ0JW5cVMrXt46/VL13Pjdxe+8nsZrTJWLmQ9fDnrP0FMTV0ypNScwGtaLtXSMts0J/YNZ/93N1qEV6ZXM8xzvePD9WVz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707862; c=relaxed/simple;
	bh=08B+9jj85qtUenM85KLBopOTQeR9eP6MVFBOnJepqeY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JSwHEO8ectX2QpJRIPhMP4FR7KX039IdzyPZgpgOnVQQBz235FMpMkPuxtcVog6WyfAbVqlcq1ivSLXLLmxzmnrabBjYT5MHr0r8LiHlFqb9aK1g65puJ8JBaCmm4x4hxOOjltiFwohvNXzVti8TV+JWrjRTJvDknWVTOlkM7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KstbA9Ah; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KstbA9Ah"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-292fd52d527so68577255ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 20:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761707860; x=1762312660; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2mCS4TVVIVqdwvmDa/ryStkCnKaR+gVmAIbzCMeQ9/c=;
        b=KstbA9AhzJae8ccTv+mYln/kWM3OwXI00KgaLiRyk/Udycde0cpf0bZdktuwJ9lroS
         ED+RCKDPQZCYyTFxfGuS1An08fBUd/ELid/iTHDDKcnHAUTmT5kHuPYL6EE8FHZ0KeLd
         qqkTnWRmFdH/l+Qil0JqiUC4vwV7ojNy0PUVXVuY0GDRJ2VDW6IJ57UMldLw2RJ+v+NI
         LC1sLN1g3NExp47DhpbXCDv8m4KVs1lVyLkY1ySZaJhWzArfYZa87ptucvvQkQL4s7Va
         2R52bwm8RgxbinuU6dOkS8pbfP0EXQNEQQdHr1tJGo3IdDPFHLHtnySN6qLETtH8RiQA
         NYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761707860; x=1762312660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mCS4TVVIVqdwvmDa/ryStkCnKaR+gVmAIbzCMeQ9/c=;
        b=pGSoWlRBcpFSg+3jumyZXYxt0lfDxwMCe9Fb7Qyj6qbapnU5MZSP2ZYkiF/+x+CD7O
         tYl0xsxCFKIYVHM82Ec8bvyypUPBXLw6cC+fVgFZ5merMoE9c362QeHg6PNo9Oy72BeZ
         MC0rTP5IplfdgjqGrUg4/GlE6Im1dWOJvNHsti8os3teiK1mqsJyf0KSfII4TQ4c2sAG
         XaFCySNK/AFJL10OGLx1P8+bSD1G5tTT9EYW535gqypD6hm0eJlbgIeofvd3V86wXTa3
         Ke+AtdsfEflhHNPcf5uKfskdwk3p1MqrWrzuJYEf+7WJcfLl6vR7ml6CteXsp7RuVt4e
         2Msw==
X-Gm-Message-State: AOJu0Yx0POR/BEfkggfPyIPhWW2IkY/vanHAWxBQW9zfBEnYmYd5KvkF
	sNv1jdjPXfRlxB80ELpx0+piLE/+2NX04Ni4NcOgkn8X7i4KZUuItbP/ptWhBw==
X-Gm-Gg: ASbGncusdmMJjGAHft1t/MN3RoJ+SXHg+VeS7pK7R/jpIAvHAknnwqvZBbvRwPJ0hrj
	onvEy8pxHasrUfRrnsY5rbiQlTle8kiemtCDOWb48S8KsMg2X5skeJ60rcv1qHMTmrd01voDg3O
	0cjKfgVUFF7u1cbNQNEkBAZpJxaONvQ39CCppi65Q3rXC0QDtOJDMvDxKjBZ5zIpdvutuuv8ziy
	i7WYQgd5XhEkLZ1fzubF/RggP37Rkr8swIQkbqqQaahUzgpTBRU8Q2qcj5WTFxmTE8VI1H4NnD/
	sgRjaJ7jUQQvlKqJRDomteAqOKxTlLJaYHK9lYufLBOHmJbYxRhlYxEZKZwSt86u/a9TxbU1s8U
	O14c4DtbpaSmiYyb2dntbfbO486titV94u2EbooxtDdCXD0HxqkQ15C4ki1D9T4W/af3J+UsT+Z
	9F7ISgZ01F
X-Google-Smtp-Source: AGHT+IEiupx7gTo0XNCP/+wUKYXd5dmMr7yl5Q/kNSqdFZOedihIHpKc9UUpwRe/tZ5CORd7+IWjwQ==
X-Received: by 2002:a17:902:c40b:b0:293:e12:1bec with SMTP id d9443c01a7336-294dee2c381mr20709635ad.20.1761707859727;
        Tue, 28 Oct 2025 20:17:39 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.220.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d412ebsm135360575ad.78.2025.10.28.20.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 20:17:39 -0700 (PDT)
Message-ID: <69018753.170a0220.328a95.10d9@mx.google.com>
Date: Tue, 28 Oct 2025 20:17:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2188259314879588039=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: Bluetooth: btusb: add default nvm file
In-Reply-To: <20251029022955.827475-2-quic_shuaz@quicinc.com>
References: <20251029022955.827475-2-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2188259314879588039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1017003

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.75 seconds
CheckAllWarning               PASS      27.34 seconds
CheckSparse                   PASS      30.51 seconds
BuildKernel32                 PASS      24.44 seconds
TestRunnerSetup               PASS      496.49 seconds
TestRunner_l2cap-tester       PASS      23.79 seconds
TestRunner_iso-tester         FAIL      33.35 seconds
TestRunner_bnep-tester        PASS      6.21 seconds
TestRunner_mgmt-tester        FAIL      111.65 seconds
TestRunner_rfcomm-tester      PASS      9.13 seconds
TestRunner_sco-tester         PASS      14.17 seconds
TestRunner_ioctl-tester       PASS      9.79 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.38 seconds
TestRunner_userchan-tester    PASS      6.38 seconds
IncrementalBuild              PENDING   0.81 seconds

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
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.097 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.141 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.058 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2188259314879588039==--
