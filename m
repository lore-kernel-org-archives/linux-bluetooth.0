Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172662FFF8B
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775405783; cv=none; b=dm49jFrHrJrNWvg67MWVeoSzDtyKl+3DB/zZ8r3F62R7UuJqvBhwnx1y8UYdhZ2vxNsj2T6dTqZaHeKRtFsY6NeyK5PX4526PFM0Vub2W+FKM/Lx/wYfsodCZl3bDR8FSRlmAgIY54Ej4HqrEuzz8c5sq4WLX8ShxxBlfi64OZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775405783; c=relaxed/simple;
	bh=iXfCVwXeU9Puzl5TYln2/a3MotiBsAnpXVTTd0eNa34=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OFqVvsOg2cqcxQ9qzcaH8w08f1VALuvYhw8hgWHM3cnAa6klxO3OiJHBv+6iEtkXf2qlxTc1kXqWgSb/GJLS1zskjcv7KfC+C2HhNp+5pdZ8I761KxJ32gXLsD5VfHIvuUyY7PcfCDqLeNopuW9hKoll0dZYHYmmA/MVMe4rGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBxwkGLp; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBxwkGLp"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d736211595so29226885a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Apr 2026 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775405781; x=1776010581; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=69omZZnGgASdkLh/iW844U8wxpHXOGkMsXYZPnL3sSU=;
        b=cBxwkGLphYmhkI46WTnLDRPz2oy6iG8a/uN0ptV2bEXb9jGV+IRnpainSPKsVBt2eY
         BvkAHkTHNYXNprxrgh+Xq6IgXvUfzmlXPuMSNrMnWOSOYSNn2ySGbgiZZixy7Rm7e3r4
         6V9C01w/wZ0bGKJF4lP9aj47JMUuTM7TdgUKiS8OtmGF5FfkrqweQkR54MNcwVuIaDOD
         CHOdQZCUGK+5PiyfPfdt9tVi3ulWCBDwxI9UO7cbV1/Tc+SENnISCVdCwGxyIrPx5bvs
         FCGKn50uEMJ1x8yg9DGfS8ZZ1X+sfIj4lPsRiLeKjU6/6E8/wQKhm1F/tz91sXWAwuAJ
         +GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775405781; x=1776010581;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69omZZnGgASdkLh/iW844U8wxpHXOGkMsXYZPnL3sSU=;
        b=Q1WdcUzMw0I3JtESS9FJ158gU9AwgTWqAzqsNktgaJnKZpCZK9jK07BqOLkGZXWm5v
         YDGkW6rr/eyPG43ylGLGhYiFl390Zp6NLiD3nYmbAYZhPUC5GTFyUmUrCLfaO7RSzLCW
         4M/8rAIsbMVwmnnKBsnhp9o/WQ4y0uLVbsg6lLVZx0a+u7IpL2n5rmwtafSx62EIg8SJ
         udWwXHytMCpfP6Z3zCrYz2SGvO7JCDYbo9EZZJ5YdEu7Wx8fKzDhyUSo3TIqAJqkGxY3
         TzhWNkTMFWp5AHC7DsBdcaJcJKmA2ysbVTX53ViE5ygdklUbsOyJV27Oi9qyzZxPKvHu
         qX8g==
X-Gm-Message-State: AOJu0YzvEc3a4x5MZJsL51saD42ffbeN2CwpSkGZ8DFD4EyecQEn3saV
	+JpmIg1Z/m8PBQsL2rPdvD5Cdp4HOROZ4uz51Z5Thk3V9uRRtzuuAruphc1+oA==
X-Gm-Gg: AeBDieuvqVmpLhRe+jx5NeTQC5trjLFuIoIVFhIS6esr/s2X1mBkFHBRRYyfezHDe1u
	YafbRvdWk0Qcn0ZB4tziZbLZwU00xJfK+VkbZf7rCWhHIoLcqmBnZij5RCiYey6mnU8mcAiZUov
	h0m+rY2KYemjkifS8qT3PS8s7zHRU7L0CJ7fHKM95ZcmwUvSN6bwgqiNh+EgNwdKB9FUV7tobjl
	kNtAXWRDcQJiY7ozii54k+9IuzOHRpLjH/aEsU/x6qd1mSnkwr1M+cV5OBqF4i+pSfWdx1aSKIz
	A6P832mNViGSWu3BNeFooFpyu6MCOuHwv0sfwRZblQA7zH9f6CfvxFqpUm7fuptEKuWiM92wqp3
	DzTrgjMHyi08bbqjWdr1Sxz1vO/KRXQtm+3ifNSbwJMJTPQzj/5j4pgfE/xdnJ1Cl0+KYnxyiih
	vUx/P3fu+LDkeW/ONA+x11KNqn2rmUKg==
X-Received: by 2002:a05:620a:1a11:b0:8cd:8635:c03e with SMTP id af79cd13be357-8d419096dc4mr1387298085a.18.1775405780671;
        Sun, 05 Apr 2026 09:16:20 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.161.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf51b6sm116549446d6.17.2026.04.05.09.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 09:16:20 -0700 (PDT)
Message-ID: <69d28ad4.050a0220.39da36.13a3@mx.google.com>
Date: Sun, 05 Apr 2026 09:16:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4606205396492310508=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, phx0fer@gmail.com
Subject: RE: Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp
In-Reply-To: <20260405154741.7051-1-phx0fer@gmail.com>
References: <20260405154741.7051-1-phx0fer@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4606205396492310508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077454

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      26.57 seconds
CheckAllWarning               PASS      29.30 seconds
CheckSparse                   PASS      27.78 seconds
BuildKernel32                 PASS      25.55 seconds
TestRunnerSetup               PASS      564.88 seconds
TestRunner_l2cap-tester       PASS      27.50 seconds
TestRunner_iso-tester         PASS      37.34 seconds
TestRunner_bnep-tester        PASS      6.40 seconds
TestRunner_mgmt-tester        FAIL      112.72 seconds
TestRunner_rfcomm-tester      PASS      9.51 seconds
TestRunner_sco-tester         FAIL      14.32 seconds
TestRunner_ioctl-tester       PASS      10.22 seconds
TestRunner_mesh-tester        FAIL      13.09 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
IncrementalBuild              PENDING   0.48 seconds

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
Read Exp Feature - Success                           Failed       0.103 seconds
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
Mesh - Send cancel - 1                               Timed out    1.996 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4606205396492310508==--
