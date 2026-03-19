Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1A3EBF2C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938182; cv=none; b=UUtzOIfLzEu/DJaCYtBnBYCfLYMTWIXSkmdMghw+ZfoveBlWmTzVo92cXcOQPK0zFRFtKCaBRtRORtvjCBSg93IYGHNnc7cJkC4tgv5tLct0KxUUcQ+As/eqLyyF9f+doTLye4qDtgr1q7NM0j6Rc1nVu4mo+lpc8kKLiQ5JvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938182; c=relaxed/simple;
	bh=Nq/vTzTCih+DFIRz9zarnceknHTz8wBXAVCac4zonng=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EAe/O/IkInvb0+698N8srg++6YT18Xpaq90trUZSr6jJxe9QFw+fkAN4Ame/hol0H0QSS663Zn6g3mMQGzG+0h2crNtygjGq8u+taRvcJ1rZQvt8e+DvV3aeOUvGFhLL4nPXZy7aewOPl3cmFK3rK1Sw4hoh3g3vSSRnlgiO1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZzWFL1+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZzWFL1+"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cd8d97aa2eso156133585a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773938172; x=1774542972; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KG3adlIfjf+IYIsGWjBkQBM9SpCk1bKAwvuX9yqbs0s=;
        b=fZzWFL1+BzRMo0I1Z58dLiNoRIPgIO1jkRUDCZ6+paXEd8e/NCxaUmt0AK2a+H54M4
         tmg7yy2Aw0MG4leEiToHyE2rA7n2OlEG5oBw/4AA2Xe6YfFhCoX9d9sUx981oyTOnP+n
         e4mlSqTd3H8ERalsLWchRxRce6pf9FdFnDwixCrP1es3gKKcjkYynXQNkPshtsyVHDW9
         yAguYBTCMOotR8QV2R5HOgRjoWK8SAgL84kHOqW2TJ+1Y5XTEiT52yZ5IkTniyJhmpgz
         Ycb3KGBZrRsPACRlX1jCEQNW8Y3ZTvBtVXmctBmq+EvXw7iT4KstN9+TrpN7A6/pqtn/
         wrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773938172; x=1774542972;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG3adlIfjf+IYIsGWjBkQBM9SpCk1bKAwvuX9yqbs0s=;
        b=U8d6BLdQODYYS+3iRht0SxbGMnfotGVNL+k1AJe9HU3ZyNw34pu9pHDzHEteLrxn/F
         HHMBuCbnb6FGv/q5f1TSOKIgYXjPVRrN+81W5salkv4xP6C/2Ef/x9VGybDIjYMxBIde
         3UjtnxXQ89VKFRemDLNWkwGw/TIg2UhD6KStTU/zFc6Z70SlYG8Smlm/Yl6efLuH62Xm
         p7mJLl4Whxq74ISwEh3ZiOla6dp3URs1P/SyQq0szdjISNLuWwCECRvAo7Dsj9ejgdWE
         PZog5NRgA1qTjIBWd/mPgVatSHB3it4tQlbxEYAoKJH26uzAhvCWwtEJgl6HYgFHd2CP
         C6nA==
X-Gm-Message-State: AOJu0YypO27IXEwIfqREjHuYIBazoLnfo8jOlduS0NdRU5wbiIuns9v6
	1VRa/B7aJA2Yz6BD6DrdTtJCuEVbqrOV2cCaCizh9zkZ9UBvTM5B3oDhQKxM/Q==
X-Gm-Gg: ATEYQzx9v5vuJpk6jIl+mv6O0ZeeQkKXrKu7DILCiJpiABpEavwLKbAr6fQcI4e3HT5
	vbvmirp4wUPQi/OwCGsjfGuzkVrRGpinax4jYK5LzVicqddsv87a7f9/vSc8uK4ZehzuCi6aWxG
	Pk9BcHt1m3qxB019ib0fjC+CwjRY+kODJ0LZYPWhMIqttwm4hqCg1Ibq2LLP3rycvf0b/WsaVeH
	r407qH5U7cMOnwgIWM8nEgQLBcQG+ofoCYhsqIxxk16wVWsdnuVPc/XGIgrfPlqgzQ9qkWJZBQ+
	ZNOrWM9zeXMNDGz5cZMyZeDo0pfGCkBHs8BZslY9PRZuzubQGthbRE0Sg/szifT0nbhxZeUWZW5
	9aSlYYt/j8Q8YGRmjzsnjcUJyhmLqgHEABp8zt1YJWqko+U7gafSsmsYLS8SnJMZsFgM0DVERyH
	9zgS+4ghIH9yj9juS38RERLNVTCRNVMck=
X-Received: by 2002:a05:620a:888a:b0:8cf:c037:37a5 with SMTP id af79cd13be357-8cfc0377c90mr247122585a.13.1773938171537;
        Thu, 19 Mar 2026 09:36:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.135.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc3f8d2e6sm99218185a.40.2026.03.19.09.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:36:11 -0700 (PDT)
Message-ID: <69bc25fb.050a0220.2c1eed.2ac6@mx.google.com>
Date: Thu, 19 Mar 2026 09:36:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6704496023698462880=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_chan_timeout()
In-Reply-To: <abwSxg_C6n8Avid3@v4bel>
References: <abwSxg_C6n8Avid3@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6704496023698462880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069344

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.02 seconds
CheckAllWarning               PASS      27.79 seconds
CheckSparse                   PASS      26.74 seconds
BuildKernel32                 PASS      24.54 seconds
TestRunnerSetup               PASS      530.44 seconds
TestRunner_l2cap-tester       PASS      27.95 seconds
TestRunner_iso-tester         FAIL      31.28 seconds
TestRunner_bnep-tester        PASS      6.51 seconds
TestRunner_mgmt-tester        FAIL      112.54 seconds
TestRunner_rfcomm-tester      PASS      9.59 seconds
TestRunner_sco-tester         FAIL      14.31 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        FAIL      12.46 seconds
TestRunner_smp-tester         PASS      10.69 seconds
TestRunner_userchan-tester    PASS      6.99 seconds
IncrementalBuild              PENDING   0.80 seconds

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
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 1                               Timed out    2.754 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6704496023698462880==--
