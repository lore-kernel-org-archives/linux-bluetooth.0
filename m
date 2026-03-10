Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C53CFF7D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180831; cv=none; b=YTM0XkD1NAwQid+4Z0bJgoHeMqu48mMj+u5pp85auILEbZnLrEoz004InTGS0QaFfB2eK8CyKJfR1vR08gzsCjWRlx4u+49/5cMFgwq/4kK3jBaNc5fXY5SzBP8+orh41uyQeLzGOzPT4n6hm4OzRCWvS5ZYP76CmSYSl7a4Vs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180831; c=relaxed/simple;
	bh=xKs54TVnNZPLDRG2OULsUwFhkIVS5EUsmpKfiGSkCfU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eD5FlpUKvff+EbWKDaBwT4jP1esW1bJy1dkjo/Xa33PSKHDc4vRs/1CH09R/yBgO3VzrX9suqRkwEQKKpi/ynT/WOrKeRv/m4XLjBi/fUMigg1JMSNCltdF5XFAEN4jagkG4dC/J3ueB+vGfJMfkyKOHOLs8bsGceYIvg9/b6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cts+FXoU; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cts+FXoU"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a018cbbf8so4669856d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773180828; x=1773785628; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uVNDhY890KX3DNBJLYER8VTqMjnRh5AoGtoxQQIJttg=;
        b=Cts+FXoUpfpd2rtdHvyPG5CkW0fuj9PZSafVIaEvUt+R3a14FkKePEaoDR3dO/mP/2
         gnNlN+mkc3r1fZkhdsxmOLLQWFsAUsyvaskQIRWAj19wlaBzYlQD5vK+zIPFwM8XTXFP
         vNqmyT2MC9bRubWoeyYu4s6ikAw3Cn0mdy09LlDfVz3vCjFCCHCkn80/xf5ojGkxHtme
         SI7zSmyqot8f1fr/Lp8APNnIKv+iTLtQYd+6II6QG/qlMMYR5wJjehvunEAXgwbWA0pZ
         FYHm57QuLhNf2yWGAfHWQv4YtpKCFWxNt7MWOSOqrX2bfzoM6o9YWifqASm6Z1d6Q0tb
         5CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773180828; x=1773785628;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVNDhY890KX3DNBJLYER8VTqMjnRh5AoGtoxQQIJttg=;
        b=URMalgVYynrCD8jnQfsKc8ac4cFt4GHjdHVPLVFZV61Sht+vmCbMxl05yADc7uNHtM
         RCLRheRZbTD7lx6BB3/AxrEvqpsS47SgB2Z6mjgsJQbAMhfpmS+AQpizrTLZo8TaZNRj
         DIXeUMQ9xeCRkEwAh1VLZUbvBBBLCa3dAz+8ybEvfTMcm5ehOApBLugSA+gy5VrZ93cE
         yi5RAF5KfxA4dzTC1zC5YBifAVH4oGdB9oQHnTQHZXNpt5BmruDyBrCPKQhtQk1hlsw0
         EghwDfaBi8BlErVi3O/TlGwZw2ZFFNyzCSRv05ioXw4Z5Gv0HUXKpplOPkBIwcFz6GMI
         KZfw==
X-Gm-Message-State: AOJu0YzrZAUJuGx6B85VkRxTmoev/uGwTZJGBd+79HPBPicMAvsWl/wz
	sdFaBUgofZPtkZzieS7km5fIT89e/lzJWdWmBt4AjYWACRaedaYCI/rmtLv4jQ==
X-Gm-Gg: ATEYQzypcNCK4GqiIPQWKZJpgWYeXei7CoM9+icmu+ExyY/EItdttw2umgRhrxypfUt
	2Jz3FzB9SsTVgK4UnlDLlnzglk6fwy5KUc4RzBP9Yyh3hsj7NZODqj6rAj7KGQXp+xUjUvqavL+
	ldfaMDgEmDB9a9QhOSjyUouwgyoGI+1HRMtG19fsQn3g6zONbAoTvo50yBKRhIj8ji0mFmpoyDb
	BNPEH+H08IEQvYh4Z52mkAtcjhwZLZu5PxVsmHzwPKYHfElXWCqHlZktBG/xZVInHbE8/10NGFy
	2rYzBH84gm5KfeZClfhNE6YWfYrZUxNu4FoDu3Ru1gooamIRMNdBt/evQ/mxN1sgPpqy/Y2FNuy
	abNBTO2V0MwdeTDbDt+hz/ALsncOvyRX9qHbO6Gd7mf5RS39suyzJT8tl6G+kGywMJj25eIeAyF
	Fu38xiQFnBd3SQcC3XSizKEl+Bpg3Jkt/NyzGNQzby
X-Received: by 2002:ad4:5f05:0:b0:880:88cf:59ff with SMTP id 6a1803df08f44-89a6653f248mr4346256d6.22.1773180827756;
        Tue, 10 Mar 2026 15:13:47 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.142.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beb4besm2663306d6.15.2026.03.10.15.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 15:13:47 -0700 (PDT)
Message-ID: <69b0979b.d40a0220.4d4de.9649@mx.google.com>
Date: Tue, 10 Mar 2026 15:13:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1782044518355815518=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
In-Reply-To: <20260310214037.732139-1-luiz.dentz@gmail.com>
References: <20260310214037.732139-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1782044518355815518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1064660

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      4.04 seconds
BuildKernel                   PASS      26.54 seconds
CheckAllWarning               PASS      29.00 seconds
CheckSparse                   WARNING   33.02 seconds
BuildKernel32                 PASS      25.70 seconds
TestRunnerSetup               PASS      570.95 seconds
TestRunner_l2cap-tester       PASS      29.04 seconds
TestRunner_iso-tester         PASS      83.16 seconds
TestRunner_bnep-tester        PASS      6.46 seconds
TestRunner_mgmt-tester        FAIL      115.86 seconds
TestRunner_rfcomm-tester      PASS      9.78 seconds
TestRunner_sco-tester         FAIL      14.63 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.75 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.65 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/l2cap_core.c:7796:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7797:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7799:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7800:1: error: bad constant expression
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
Mesh - Send cancel - 1                               Timed out    1.846 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1782044518355815518==--
