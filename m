Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B8401A36
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541528; cv=none; b=oJJN8xJ8GISI9hkuJLUGvulvrGjNzwWPAgLyZxtmUeHeWOaa94m098wLnu/TiLlCuZaZR0uRQl/p5/XHvpL3T8WeF886nRMOVcmRcBhpQw93gtEuWoxgIOJBTr8zaaSEezB50CT7/rkulTAh0bdVUBYF/vkYRDz1XcXETxa0ztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541528; c=relaxed/simple;
	bh=MhJ1Wc35sJj5keYc0f7ILqOx3BRWGUyIIH+3XiwfB7Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fZUuBtfnxKAhF0MnCVWdieKfz2V2ETHtPw/x9r46li9/xevGkfVzCx3I6DB4abiG3DWurQ1103WnWI/0Dran1GQYBn4ITfHylw0ny6QnMNUFyR0m+/cOoO7ZGpGVszef7rOq58FP7+HfklTzgF7NwLZI/5qg3kIqes9+eMyKwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae3e5oCl; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae3e5oCl"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b2d6f9d00so11110871cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774541526; x=1775146326; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5eFRXytiSLlYIQFpBgbVLNHvXWcNpv9XYy2oDMeiSIc=;
        b=Ae3e5oCllvGl63d7eNUs2z5EgUygz7YsHKG57ZAK9qWfmAWpWr1/ScCrnGvqNi29yf
         778VWsQ2FTvJ092T8wzH64L9lbFVq663a3yStr1mdciGGGOfrimjiPR6vwObOXmo7g9R
         dvqclro03KetKU4yyI8FKN5l2QzwhcTgrKzDeNvXUxNzDC1gQdTVZDQZdVGacCfYCfET
         HwhsU6BwWDtK7KqnHCfWXh3hSDT4qgp6Exs1TzKIbDi5mHQOBIAKgFI3uzMmA5WlY9og
         zykGeflcI17tg5Lww88WJ9m5gYJ8Pwfj/Ep1zwVkFAXCiFDnaD8MB21mWaaFP2HoOvlz
         ku7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774541526; x=1775146326;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eFRXytiSLlYIQFpBgbVLNHvXWcNpv9XYy2oDMeiSIc=;
        b=dAAjZWir67p2ftTL0aVOB9SbqQb9MQ1lJXTJUbcvGOvHAHoRxvkzR3wSixJFcvNiFx
         K3f3o7yyIippgKJKxEQIOmMpwvFyLgW1ZchpMl94y5uXJ1Rs5/MrmPqSqaPO2IWvEn+3
         H+HbTeGoOeuEGzKlkik3Fm33Vfn0EPfABK3E52YM4nwF0T4xSLJsdZrssLtJX2stAOmG
         UYHDixXOy3DPMP9gV55niV2nERrMeG+5jm4plAGva8kUtNOg+cpgY2srzB8JYkK5HJfE
         6IrSjyUFnUUrBlkJ1zjJobHxkyS2D8b2Sl5wRbmSclF2JWWaF3T+iNlbrbMI/6zF9VVe
         4S9w==
X-Gm-Message-State: AOJu0Yzvb2rtFEcAd69Z31k/JNggmwpFqR+CxDttc06EabncdVTitV5l
	cjT0KxBatShErVDo2TW4vUdXz+bxvL9aDGofyBQtQg88ym2BD3Da6A1fwnOrcw==
X-Gm-Gg: ATEYQzzrVIOhcAxGVkGQMrplkZLDY83nnZ+PlQDEevWJcAEvbpEaMeEEFsbHWfkW90Z
	LjC1tRU6fTwRnpsk+ptp+DXZeUmODW4BVpiNNL3PyQpOdgx1ZlXBx1hOUeXXJXYOtyeZ5dUe1Cn
	Z+5IAeuk2iBiToMilxVtHbodODcMhXVCgD3AT7GmCwLVa1f634Al+OQ8SY0YOcdAdBlQoFy44rm
	h50ba3vcut61Lq04fJjUCSpNfrWhvo+sgj/9AaY61dKdD/dp87e+4IxrDjUvasdTAwr5h7mQI17
	yZ2dYFI4t0qSy0b0uyZd6YTQBlex3BV8zigSTWI5N7QYY4ZSa81ID6T9azm8BasflT+iS8EjWS/
	JGatVybCr53DrA2DRQsqEdXQjLLu1E8fnlamMdzaQ0O74weJwKAJxHeL2HLJ/ILkI2+i7U7h5lY
	I6pA/RZy2TGIbxgKaVT9wREABg97Y=
X-Received: by 2002:ac8:5247:0:b0:509:164b:5b41 with SMTP id d75a77b69052e-50b80ecb79bmr88804081cf.70.1774541525560;
        Thu, 26 Mar 2026 09:12:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.236.100.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd589a409sm26033066d6.16.2026.03.26.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:12:05 -0700 (PDT)
Message-ID: <69c55ad5.0c0a0220.3d36a9.fb39@mx.google.com>
Date: Thu, 26 Mar 2026 09:12:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2159561494763041008=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [v2] Bluetooth: SCO: fix race conditions in sco_sock_connect()
In-Reply-To: <20260326151645.27909-1-zzzccc427@gmail.com>
References: <20260326151645.27909-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2159561494763041008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073049

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.90 seconds
CheckAllWarning               PASS      28.54 seconds
CheckSparse                   PASS      28.59 seconds
BuildKernel32                 PASS      25.67 seconds
TestRunnerSetup               PASS      545.42 seconds
TestRunner_l2cap-tester       PASS      28.51 seconds
TestRunner_iso-tester         FAIL      37.06 seconds
TestRunner_bnep-tester        PASS      6.68 seconds
TestRunner_mgmt-tester        FAIL      115.86 seconds
TestRunner_rfcomm-tester      PASS      9.65 seconds
TestRunner_sco-tester         FAIL      14.58 seconds
TestRunner_ioctl-tester       PASS      10.40 seconds
TestRunner_mesh-tester        FAIL      11.80 seconds
TestRunner_smp-tester         PASS      8.77 seconds
TestRunner_userchan-tester    PASS      6.76 seconds
IncrementalBuild              PENDING   0.55 seconds

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
Mesh - Send cancel - 1                               Timed out    1.904 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2159561494763041008==--
