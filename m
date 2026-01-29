Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22E336EE9
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717687; cv=none; b=c2Or+LTX1fxYtyrRt7J0Q0ZHBa3fnG7Rbp5lTJHybshVXGtd7vnSWzu0BtveP37jckrQZtez7wpFACQpNjDZj6bvHu2z2XuJKrLMfeZO3uHHw4sMYObRU4Eqh3gnA3IftbizQBdYzOcwO+G1fWGKxd4f8FSxkuZdLfYmr/qX6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717687; c=relaxed/simple;
	bh=cqTGWws3csqst8xircp8+zX47+EtMqYV238i16b9edU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lLcL9tmUnOhNHKOvG6cfdMLYyYUEj+P0MYFZsKE3uMWKJF87BkP8pqZn1AkFJ8w9uxN+U4pRuvY70szTKas88Uih1mZNChouGb2zPEXS9WVfyT/xQx6dxZPOrr5BFpR5fjJr3DlsFRDgzl6GsOG2j2wHoXhDjhG8v5h0l46So04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuROG8jY; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuROG8jY"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-45efd53148eso532997b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 12:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769717685; x=1770322485; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1zgJlqAQD4CO9QbNMOoR+UFXZLwFHx7q3BvSKv/vtwM=;
        b=MuROG8jYMRdYJsmkctTouWMRFlo/FlQxxY1l0gb+HaAiAnC/6a3iGe9vQk8NdJ21QO
         OwkiNH3JqbfpGpID17fBe+jN6sYd2Q8X73rFB6npau/fjjcV+nLqFALCsFIY7flh9foH
         BYhz18tNQK/48o7gHnmrjCDETGLjJp/635Lkmbk92Mw0JCQiY++ZcYj6R9VINB+6ZfVS
         +al6fK64rK0DBgVoxuG5dVhCMKybuj+u9mnRIvmoz/wtVcCNbh9CjvmJD3B9nCrhOX9L
         ChXF6Y9j7qC+xIDFEaWKh6mEhyXsnasFx1OXCO6X6CRwefS6bJd9C/OWNgTnu9Qm7V2B
         MxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769717685; x=1770322485;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zgJlqAQD4CO9QbNMOoR+UFXZLwFHx7q3BvSKv/vtwM=;
        b=H5F+arSNRjxhMgSc3iFSCEJReZ3oo++6B/nJ73Qs2uLa7eXKAXw5aaRnMRA6Y2tQSc
         gmeqL7OQXrTDlj9XGfnkffm9c9Q2nZk54a5Lxw+MQ10iYKc80FDkRswTzv1A6n204QiF
         C7bIAhG7WUj3fGQnzsatYqtmEryhTNBJrsCwjfV3uqwUEHNEwKAS4g3u0OKvhp2DuRcX
         CfyOyyj89s6yPs4408EHP5pCzHnfo2fAKq0z2vhDRu7PYWBT7PReil8FpnbTUbfMtmsq
         HxLUCzOAiLw112Dr0bh9YEB9za7l0bfSu3sDEUroyxQ50Zp3yo2sqPGJnMSxgZHXO3/S
         DeKA==
X-Gm-Message-State: AOJu0YzyLjJgVC97H9rqe2qpKlG818O0x5CAfK9vQa+57vg7Sw2qMxh/
	YVSZQtzOnqZqXVWXBHxJLBXbFMNuUZVvdiIP8QRHh8NOSHf7FDbLwu1OmavdpgmY
X-Gm-Gg: AZuq6aKH2L2gBTqCq7iJdeL7w8ExbXc7hS5GeV0l88ot9bRRS1YczI/ltonDHEVWYMi
	uiOM9RmXTBUW5ZMXI7BaGu+I2NcJZ7iHXZR+SmAZtmxn4zuMRdtXRZ4ja3XBBohCwHcx0t7+R/L
	Q9CL2H8AzXXJgc2NhC8sGhcrQPzePO586e00Ey1OQwUUfS4lPpkEl6xZMcAq7rmZ8j1f8WPOtTG
	19rm+8YLiihqNm+79A2E/QR82sVyZj9In4kV4Pd3Bhtg61/afsHi4kSD6mYS/vk1z7q81jrN74h
	uqpq9Jvn35ejmlh+whkFqNYY7GXxtIGFgTbttS6YkZki1eR3iQxepukl0xSjn9WL49RQhwMEl4Y
	k++CqYDrU8Xpl09uyYDmfHlkTDYGKcfwhFQJaf6OMMwLa4G9xw+5xP1f3OQZGO2J9s1CJlQYpav
	UaVAshMl2rDHZyPox3Ytw0p1QYyRI=
X-Received: by 2002:a05:6808:398d:b0:45e:e196:5387 with SMTP id 5614622812f47-45f34d73e6amr389443b6e.62.1769717684918;
        Thu, 29 Jan 2026 12:14:44 -0800 (PST)
Received: from [172.17.0.2] ([132.196.83.32])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f20d7asm3491776b6e.12.2026.01.29.12.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 12:14:44 -0800 (PST)
Message-ID: <697bbfb4.540a0220.1843a1.0737@mx.google.com>
Date: Thu, 29 Jan 2026 12:14:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7935360769932810635=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, konradybcio@kernel.org
Subject: RE: Fix up WCN6855 RFA power supply name
In-Reply-To: <20260119-topic-wcn6855_pmu_dtbdings-v2-1-6d1c75608bbb@oss.qualcomm.com>
References: <20260119-topic-wcn6855_pmu_dtbdings-v2-1-6d1c75608bbb@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7935360769932810635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044101

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 FAIL      1.36 seconds
BuildKernel                   PASS      26.15 seconds
CheckAllWarning               PASS      28.36 seconds
CheckSparse                   PASS      32.40 seconds
BuildKernel32                 PASS      25.08 seconds
TestRunnerSetup               PASS      559.47 seconds
TestRunner_l2cap-tester       PASS      28.48 seconds
TestRunner_iso-tester         PASS      100.08 seconds
TestRunner_bnep-tester        PASS      6.28 seconds
TestRunner_mgmt-tester        FAIL      113.87 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         FAIL      15.31 seconds
TestRunner_ioctl-tester       PASS      10.25 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.87 seconds
TestRunner_userchan-tester    PASS      6.75 seconds
IncrementalBuild              PENDING   0.97 seconds

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
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    1.796 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7935360769932810635==--
