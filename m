Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112413E714A
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963533; cv=none; b=bg9GR+XxD5YMPxwbACS3NbW4/ihfkhZ2Jz6xT+IAgNEiAOfkZOxzTsWu+q0vdjGkzxbGo1PJU44VvUXARGku1zHsmZ8fRqkHmXMFWI/P8sNRh6Oi5oDQJ//5ULd88bfzCi9DO9Uyk8dMcCqx7+U6j0lv27lU6A0opVgpLnfM6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963533; c=relaxed/simple;
	bh=ELp7pubF9bxBl04koop7PVEKgCns7nTb2y8jl4dEczg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i08e7NOrGziD21mUfL/Fn3lxjB/PUS2KX8iSYQqeL2veAdiHMkWvpuCkpyvwkz/ww3hyhvr5vvUvFfn0NOPfblpqJJybKg81NxzHV0pXtGA06fu28rPwU6DqqvTrVnUa/sBy5A2JahmmRBo+ExRlVGk4o76vQ6S3BOhT+jOvQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyQ6Inuu; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyQ6Inuu"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c5b3d8eab1so1998195eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774963531; x=1775568331; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aEPrcW3GE6w1RlT0Kif35FjEgZbG3q/16O45Ae5Y7AE=;
        b=AyQ6InuuYNCYFcC/AMlBpBEeMZx6rOv7rmHStjMvnpdiN5Y9nI78orfcvHjZ2I8HgH
         ZcbyialVZmLRsQaQNAZrvDGC0hwyugJDY5Xr8omfyjLw1zmYggQNX+9c5z8egM56Ds0W
         Gf9BCgZREFiuImtpthTlyyCSolsIyD0xjLggfdgQUBu+fQ2KbTwn2E+41dQUu+T3bvVy
         V32Xb6qnQf/vObgY/K5iftiXBf9MwyHWyUD1ULggZlo5a1g5+H56rmAdZb1UvzjDPEgP
         ZASWydpnxu4vGn4tfJhQrE361V++B8NDC2j7sKojOiRgxkPlQ/NfldlFEgXcRfWcpbQI
         OyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774963531; x=1775568331;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEPrcW3GE6w1RlT0Kif35FjEgZbG3q/16O45Ae5Y7AE=;
        b=HeYxQjPEQB+pujrKUIo3IL38slmTBFYhT+1d5Hq1USjEOrKT3+8LB2wxr8IyWXL1nE
         BKh1XNVtpMGX2Y2lCe3Ip28+iL+o+1FQfuuvCKwP4wXKe3lfmIB+X0hVk9LxH9jpLDEW
         RxvJxbke6rXl9A2l9GNI9VCILd0brkQnKEarxNuitiaB+vdFBjmZFgar0LWx8TdefJz+
         hSlrmj5baG7a8PkspHoUZae2s+n7g8sXRhgJFiWBlKzMonq1KClADF3tLG68XDZzrlHV
         lYTUQxwF2dCBdotl1HKf7WvWmOL3QEYlBUW7hl4hd8FU5BmktU1SiniZZrdrH8BQ12eD
         rMBg==
X-Gm-Message-State: AOJu0YywjJknW+fIMc2mPI4tmuya6g9v9kzrXZQc24u0KUcJriKBci/D
	M5YOwySpFkf5Fth/5+FxSS03LqAqeM/u3Jgfy8JceqHu9bInydWbFGbSFgz1Pw==
X-Gm-Gg: ATEYQzzTGhEYJDlB+qDIC1s3Clf+lnfA7p8yXEyJ2nW+/YpdpQm785DVuEbuAjWGxDA
	7GzlZJ2maFfQH4SNBAO3Y17Y6IUwYAhc94BWQHfUllITDgav5QVk+phmJBBdNM6EAEHQWgELnb2
	EuPNEZFZW5bjj+d6C6DMWURW6XSz6heFdGFSxXvD1MRaEPW39PET/FumzBcSbR5P7VlvGFxN1bH
	uffS4VqKb1dGFHyFzXg7swo01VpbmaayAgV624+/oP9bhI+padTtJXmral2cioxz/Cui8FLghST
	JJvpJr9uHZC1GR9HV6gUw6LDQWZH0sxa6BaekgB8ARxzJEq3ZKzoaHz6iKYJR1V8Dvdn0HQh/gE
	LD/ePr1AI0pz1zGCHlwkRYSK1IfWmUNRAKRIfEvmzo7Fbgm8vWSEvpe/n4RfOVd1mMibrnRhKT0
	h4zpr4UnsMhk5LrjnVVBK7ZffbE8NXvPU=
X-Received: by 2002:a05:7300:fb02:b0:2c4:59a6:9e5 with SMTP id 5a478bee46e88-2c459a60bb9mr4964954eec.12.1774963530554;
        Tue, 31 Mar 2026 06:25:30 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.136.181])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c10361e7sm10281214eec.0.2026.03.31.06.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:25:29 -0700 (PDT)
Message-ID: <69cbcb49.050a0220.97910.8e38@mx.google.com>
Date: Tue, 31 Mar 2026 06:25:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8516782658160360146=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, security@1seal.org
Subject: RE: Bluetooth: SMP: honor local MITM requirements for legacy pairing
In-Reply-To: <8f03334a700549ac8c712032f8ea8a3c.security@1seal.org>
References: <8f03334a700549ac8c712032f8ea8a3c.security@1seal.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8516782658160360146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075166

---Test result---

Test Summary:
CheckPatch                    PENDING   0.60 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      26.52 seconds
CheckAllWarning               PASS      29.17 seconds
CheckSparse                   PASS      31.85 seconds
BuildKernel32                 PASS      25.71 seconds
TestRunnerSetup               PASS      568.97 seconds
TestRunner_l2cap-tester       PASS      28.52 seconds
TestRunner_iso-tester         PASS      40.23 seconds
TestRunner_bnep-tester        PASS      6.34 seconds
TestRunner_mgmt-tester        FAIL      116.93 seconds
TestRunner_rfcomm-tester      PASS      9.51 seconds
TestRunner_sco-tester         FAIL      14.39 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.96 seconds

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
Read Exp Feature - Success                           Failed       0.121 seconds
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
Mesh - Send cancel - 1                               Timed out    1.784 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8516782658160360146==--
