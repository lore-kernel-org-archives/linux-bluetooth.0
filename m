Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24412AE99
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762398950; cv=none; b=J06KunzdEhl7dpPjdSxGkW1oddiHxCkKd5fq8X+fpSQ+19TiwBpOm0tsofeiQoMIsRkOiSlKAOtP2oy3suDSz0oEXvYkTnnhNgiPwz2qOWiTcL6ROVUe5JEr60GAFYI/U4L0639+fveO7+kgm+Vctvz/hbPu4HQj1qE6n6Fmqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762398950; c=relaxed/simple;
	bh=HLlUY0dxbFGzywokmJ0hjaBsmFeD4USLk88qz56/m1c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PaMT9Pvh7vs1fRqMJ4u8kZht5YXdqm9FCdqeKXj+1jq6nH4UubM8mq0ECghN+67NCyTCEE0RfCcUilzP1uip+U1VXsv87GdYOQMapd+qNCYZQFIzAqZ0MWyhVD08pXvuLBPhtN9RlXFhxlyvPZPTYJW5X4G01cyEKf8K7RNhxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktYruc5C; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktYruc5C"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3418ad69672so394602a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 19:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762398948; x=1763003748; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SZW5fUMeus20RZbNaiLkipYszHZBskSCr1l1Ghj/JAk=;
        b=ktYruc5Cn3RKYfU9hRUXDIFXgOgCx93eo7ZKeCnpd94fGfSjvTeQd0mENPQdCHkA8U
         rN9ojtb53kRFtm/keN04fMCtTSKwLO8xatO4ASV9aliiTutd08qd7KqE1nRBTyQm7mh2
         iV9WQpTAiddrmhvnFUPi0ym99qaU6QI5ikF3hxji+zY9g6FPYHqiAGmUHLx+/NnzW/uk
         KMdLQbNHSxw0T6Y4IsN2hPMXYOxqGVw2Gk9gZ56SJ5A9fPJASMGn1QceetfAyBRsSVY4
         PQqgqIARUIIgy3HOyKkL90uk/uIXvGFkRQsMyolDQN7udWs1Iys9R1eMSFkYW/YDfjGE
         z24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762398948; x=1763003748;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZW5fUMeus20RZbNaiLkipYszHZBskSCr1l1Ghj/JAk=;
        b=NgxEW0gOFIuQwOpD7+kiUmGvogeQNVHmu9AcdpRjqq3lmBwpyO4QvdcRwAcFO0Jefc
         YbxNPnXQ0qVg28OhXOuuygE3GtzSVdtPZ3kf5wQcMhtKseBzDurksYblkcQpPRPZfaG5
         zQzVM1zEtiz0Qe46lEuLfzY558AnQtO7mdyUPBg/bHIYbfSLVzgpXdfBIOLfYdLTGeoc
         jjp98R1DwyJcnJTffVSpz3seP8VmSduEdDX/8Xz2tYcT70JQCPVqdARbPPWsMen57Oz8
         0Ca27e//K+wfXmO+J/mQtV2NR4jvrU5mJ2tqGaxElxHC6M/iz8quFkJGUvkpx/6+Gxhq
         0vqA==
X-Gm-Message-State: AOJu0YyrbNtJV7D51/IGMqAW19otTte5brF64yZveUsZRt8z5GoUJuEG
	+mKkvMB9pr5tk9Iaw8V+t+rvvZdqDog9LjXcOzwTp0hCkeRMwtJYWxMh9aPZT77B
X-Gm-Gg: ASbGncuE+nMCNSXVt3gjPZC7UNx7jAZtaYPxPVGumiEn7YdzxCl7eoFYRMo4qfeVo7H
	ubTDwdMzV93JRnr4MWjEyilHJs9pQADlBrKe5AIepG1r7s+k27le9Ne8UaCj5loyYk7gCCHSpCy
	LgFux/vB8pX6E0jsGUbobyCL5YqJXca0J5WQtkm51NAvW7dEke/oX6KveUsNlPg6xptANVrMMd5
	as+IwCQokbPpWPJV9WdAIYEy5KZBaSIJTyJ709BXBb4frQrGma4eT1Ucg/JrfrwROREIXyj4+R1
	i39bUleo+wT/FWQnjfOZVSFml9uS21Uu46YhST20uyMevSXRNEloJtK2SuTDAvWbAYUzd5yHS+V
	HB2Dn121Vc9nwLRSWFK20bWqSq0Y1D7iM2KG4WSWRcWWKPMuiFWgy3U2ez61odxKQt5HiSnLyPo
	H74D0mTu0qUONM6EJM
X-Google-Smtp-Source: AGHT+IH0edbVo4Zapp2cnCGVPmSc8b3rLjzV1DKkBdmsUUwcM/hI/XAZfwSRTKZC3fw7IK1QCCYCbg==
X-Received: by 2002:a17:90a:e7cd:b0:340:25f0:a9b with SMTP id 98e67ed59e1d1-341a6f0b7d4mr6832046a91.33.1762398947840;
        Wed, 05 Nov 2025 19:15:47 -0800 (PST)
Received: from [172.17.0.2] ([20.163.32.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d1242469sm262805a91.12.2025.11.05.19.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 19:15:47 -0800 (PST)
Message-ID: <690c12e3.170a0220.295776.0e41@mx.google.com>
Date: Wed, 05 Nov 2025 19:15:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3119992699003415930=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v2] Bluetooth: iso: Fix UAF on iso_sock_disconn
In-Reply-To: <20251106-kernel_panic-v2-1-f4ee57845eec@amlogic.com>
References: <20251106-kernel_panic-v2-1-f4ee57845eec@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3119992699003415930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020214

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      2.72 seconds
BuildKernel                   PASS      22.82 seconds
CheckAllWarning               PASS      25.13 seconds
CheckSparse                   PASS      27.98 seconds
BuildKernel32                 PASS      22.69 seconds
TestRunnerSetup               PASS      452.35 seconds
TestRunner_l2cap-tester       PASS      23.18 seconds
TestRunner_iso-tester         PASS      61.75 seconds
TestRunner_bnep-tester        PASS      5.97 seconds
TestRunner_mgmt-tester        FAIL      117.46 seconds
TestRunner_rfcomm-tester      PASS      9.18 seconds
TestRunner_sco-tester         PASS      14.02 seconds
TestRunner_ioctl-tester       PASS      9.63 seconds
TestRunner_mesh-tester        FAIL      11.45 seconds
TestRunner_smp-tester         PASS      8.30 seconds
TestRunner_userchan-tester    PASS      6.34 seconds
IncrementalBuild              PENDING   1.11 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.098 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.164 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.164 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.177 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3119992699003415930==--
