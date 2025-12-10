Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317582D97A9
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 22:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765404355; cv=none; b=lQj61AOEwKTMwEI3IjPvrxuvIef6XIqEVdGoa03ZaSXjjTRR+YRD7CUtCpg7urq8IEibKQ++O+8LlaW6B8OkVyHWfxEryK6ZraNQSvC8hqDeryxyjs2KeRVO/eC8iWA6VCd0W0o9FP6qIBvHt/Tj0Rys+499vS09K5ld5T51ujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765404355; c=relaxed/simple;
	bh=lYJf8OtId2OAidejmbCqVYMn5dyE/ZNStGky0nlyhuw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=spPkl523LTTpI4i/GwsX1FURbbBNb9RKQ71YcjbHZOU0oETguR4NgzWXuLdwHfYefAyhC3OSuUlx1OPbLYXFh7089US99BzcmRrCkQ7MUQpgwWLCLSe0qQe2iLUxB7XvWxxmwmusIc6Z+PfOZT6L7gCL0L5G2/VQVvHFeMZh7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUB5vUFg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUB5vUFg"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc4b952cc9dso245341a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 14:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765404351; x=1766009151; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SPZn6+mIXeRsGknj0VsZo8hWL0E1GPc8EpEqb2i+Mic=;
        b=MUB5vUFgssEtySJH2SC0PvIuZr37uS8zMxwQWfuD784gkZcBGC06wfyeb1JxGNkTVT
         0hzix/RcPXuE3SRpxWSvb1UlfRhRIjxNfz1y2yze2fB4NIreaKX6LPQxwwRTynVdi0aQ
         HrrVgXsHYEOK2eUuUDjNinmR3Pv2bgRiJqjzhM6PWN8P8v0ubs9rn5SwNLQBdQKDju60
         PLhYNmH9P+ztbq2nW9V3v1L7UcS+Wayur4CJveIXyuJeHFyUpIKwSFXp0EzanRbh5Lez
         vmqbFmAqiRIc2oZEDTCgjJ9FsCuukv1z8aTEqHoaDu92fuQCzN8ue1icpT1X7jylNkXe
         jbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765404351; x=1766009151;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPZn6+mIXeRsGknj0VsZo8hWL0E1GPc8EpEqb2i+Mic=;
        b=MhpMHgjKVwvtv+2uZZ6t3alHyoApxZx7d2Stn+fum7zfjmhParRR9C3PFnlRWAJdeg
         9TwD4rbUUbgfL/twHz9OqnvxsHrmx6BkCmE+ROUPsef3lxxbUWfblUS8aXYYcEXhpSuk
         ivcBFIunaUVPw6AF6na+NYMiudNyBDdmzvbVgl4kOB9fYN10yk+xNOmfP8YWnrMHXQ+M
         Qfq9Fni3agT+wzAGAStpoIO6feF4vYJDeAsM4r06VYa57jfix+l5j0EdybS9xjRpiraP
         5atdNNcrHe2c/zEJRXk0OKh9YdkH9kq3JreJdBPgPRdP7OnaQBpUFUqlBJxLbxuLYWqs
         EY3A==
X-Gm-Message-State: AOJu0YwXMz+SRIspv0t6e0V9ihL9LJhGjyNRCq2f8uOWzYkfhGhIUNP4
	j3dA0s+CTXFq6uD6otjDz3r0ANHV8DyYnamrsPboJmq/uOnkSqBHfS7M9Ci4EA==
X-Gm-Gg: AY/fxX6p9F22zcDtIaTbuQVhfyIK8Psmw97zGO1sWmW24YNBdrzIlcGIAGrv9do9kWH
	p/QoOwVUONbqL+uXIj638cM5LtxiMvApwLUu0D2ioCb7k4doV+rBMn53XU9DAF5wB2FLgKiGho7
	wusB8tyPrs+rGiBCHaDdFy/nab82b2nMXPdRcP3Jr6O3QTFFdrykBCXip8uoUPYpSPpz6LWB4wx
	xc745JV/+EwDJXsilIKBuGDdEVxdYY0G0E8qCq8t4ZPQ/T7CyFORt93Fgb6uqHuU8NBAJuaUdH6
	2DS1aIiRxg6cTomSRPs6VVli1ZblQDm04FbfqyEBoqhB+iwLBsYA17YTmS+/bDowB5JBuWGY/o2
	T1nqnKCuwM0f4+m+r8K5DRzpQp71fXSixY2UOk+EXSvPpX1zARRXmikrESBfOvGJu6npskV8kxd
	JsDruH+n6NJO8OlDaPZjw/biBpvCgPqw==
X-Google-Smtp-Source: AGHT+IGeLocZMiQ87PRXFMyb/lQH8LPpOo3ok0RAMjSChBP5/e9D1YVE3LlMOB26m0JtNiXNDgsUag==
X-Received: by 2002:a05:7300:e12a:b0:2a4:4885:6cc0 with SMTP id 5a478bee46e88-2ac05473aeemr3501965eec.14.1765404351268;
        Wed, 10 Dec 2025 14:05:51 -0800 (PST)
Received: from [172.17.0.2] ([172.182.224.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ff110sm2028504c88.10.2025.12.10.14.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 14:05:50 -0800 (PST)
Message-ID: <6939eebe.050a0220.8a5cb.f2aa@mx.google.com>
Date: Wed, 10 Dec 2025 14:05:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2163891601668988227=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vaibhavgupta40@gmail.com
Subject: RE: [v1,1/2] Bluetooth: hci_bcm4377: Use generic power management
In-Reply-To: <20251210211728.544677-1-vaibhavgupta40@gmail.com>
References: <20251210211728.544677-1-vaibhavgupta40@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2163891601668988227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1032107

---Test result---

Test Summary:
CheckPatch                    PENDING   0.54 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.62 seconds
CheckAllWarning               PASS      27.76 seconds
CheckSparse                   PASS      31.05 seconds
BuildKernel32                 PASS      24.76 seconds
TestRunnerSetup               PASS      553.69 seconds
TestRunner_l2cap-tester       PASS      24.62 seconds
TestRunner_iso-tester         PASS      90.05 seconds
TestRunner_bnep-tester        PASS      6.10 seconds
TestRunner_mgmt-tester        FAIL      116.33 seconds
TestRunner_rfcomm-tester      PASS      9.42 seconds
TestRunner_sco-tester         FAIL      14.33 seconds
TestRunner_ioctl-tester       PASS      10.11 seconds
TestRunner_mesh-tester        FAIL      11.49 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.55 seconds
IncrementalBuild              PENDING   0.85 seconds

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
Read Exp Feature - Success                           Failed       0.101 seconds
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
Mesh - Send cancel - 1                               Timed out    1.991 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2163891601668988227==--
