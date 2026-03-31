Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF774035D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970518; cv=none; b=AOCB3rqGQ3tpAn0ZZj7zJJC57XAVSi2CAiQY0JPMrwVgLgyepYfBDBEr1hZHJCfaNXIWaW4DHViKrFEFXcXe7T7XfTp5Jh5Yv7YtvCGaFvuEa+0ZMn1XpAAj93IOwWHiV94mm3V2fXuiYwkKjq9Zk1745p/XK7KBoct8T5iAR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970518; c=relaxed/simple;
	bh=xd7xeemh8B9Mga2fO8iQbRYTHkCy+qU9k0SdkKgmX2U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=F8pgfkLoiNWPVLvSASFx2k5RnnSTR68iVghG/3RnjHhkAuOHA+ZHKki+SVpauRu0L+VyJK+UgK/9CfpFrAR0UhKybv72kR1rZA2W2UBOlxJBgv8tCqT6YVmtwq3uvwqyAH9FMwSIopvjxtvO0Z6CO0LUvZIvAIOuLVYjppMlcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwarKsVF; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwarKsVF"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c54c68db4dso4439747eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774970514; x=1775575314; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qhVGLmib6comzRHXFKkw4usnORHKDDt/HA4XASoDKpw=;
        b=AwarKsVFXW4ZWsEmY6EOQL3H9N+HrJBNNn1fPX/gS/heBu1truvx4O4J8G6+BdyxLN
         DvGocu0GupQdhM+8ixSC7EPHqPxWXTjSuwAM1BawjHXVvqBUsICYJbcDOftwzc4DGufw
         nxFYxcrgpT0mrfzhh3FnV56phOlw6y3O3eOYohpUdig8uWvbPtQmeoCtqeKfEjWo1NXO
         yGqzoEyWM5ETAm48wCIP30vgyFMjWEG/lvnKP3Dw/zepU7cD0xGGDTl0qF/21h7DQQa5
         1qKGJrJr/do67AqwWU7q/lJvHANpv5oY2Zsj614M6YCDemdm8FVUrd/nSmxdi0OI8s87
         0Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970514; x=1775575314;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhVGLmib6comzRHXFKkw4usnORHKDDt/HA4XASoDKpw=;
        b=OY0NgwCAADghAu7x0LbQIAP9Z1HLM5lBXZqtTNnqzsPWtoJDM1zeUVH04I20fHV6+6
         5dwp4MVsmo3kAnCKLyoGNlbS6PlOGCvI3wkKqnf/3KK/eevRkGnWybPs81mo3LlLuuYJ
         knkcjsMsN7oAAEdKAPBM3+ine+YJ0FLrcTHErA+653sPGY9/tZUTf4h4pCSLiB0OnRV+
         UMJk/Yz/p62SPq1aRCBX3i0UCvwhdc82O4IPJKEzFm/J51hAxgzP0UNcTzp4N1y97HMv
         9PhQP7zywvPhix4NMyrXxZP33pz+RPf5gFSOlJgvw5JEUUQ5Az6pKIvgVzpr2y/rVUMj
         IwqA==
X-Gm-Message-State: AOJu0YwLWSrD+/4elODYPViNgZW25cBsEsF21gSA8hy8r007vA5GW/YK
	Q/+vCuqKXOhqILNcIuLJB79XPYQ1i4JEXiItO59wk2ahOabIf+VBItxqggTCbg==
X-Gm-Gg: ATEYQzy21g8dzJNkL9NlN8i8mfmTiRGsLsrdMG035h/1yTB4vVlnNLKHCCwwVIMMj5i
	OGSIosZarDibMPjXpQInPLHFpLhGPyFpyMBDY5yxSVFzaUMC/rqNnVq2VHRjzTCQVzLHMBOUYT9
	3k9LRJmkOGZiCgsfvJwuVq2fkF6c5mzOdD91o4HRPgpTblFfNZJTSB2l+bRa4zNQX0dmLuXW4le
	ptcdzeTqtfrYmOx9O653AlWv/cnCn5/ayTUWBWydgLk5Ig/P+pPE8DrM1UV11ORwWhdV1xtXfK/
	bdaqZz/pmvWYsM5vk5QtYvDb7o4oTlRVesjOdLjuV0bfuuW90E+LgDjBZoMXVTMHA1uscZ53wSh
	r2AoJjK6UkcqVKznt/kAg+J2JSIO2iUeyEtf0JApbeHAri+7nzQt44MFwHKxCWNZqvWFGbBqWJg
	voHXjiMDSV7+UDEEZ3EaDKBSKgO/chAWE=
X-Received: by 2002:a05:7301:3d06:b0:2c7:e3a8:2562 with SMTP id 5a478bee46e88-2c7e3a89835mr2097314eec.4.1774970514259;
        Tue, 31 Mar 2026 08:21:54 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.10.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2721sm9666015eec.14.2026.03.31.08.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:21:53 -0700 (PDT)
Message-ID: <69cbe691.050a0220.afb36.ab9d@mx.google.com>
Date: Tue, 31 Mar 2026 08:21:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1063066216144127050=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nercone@nercone.dev
Subject: RE: Bluetooth: btusb: Add VID 0489 & PID e11d for MediaTek MT7922
In-Reply-To: <20260331144532.10697-1-nercone@nercone.dev>
References: <20260331144532.10697-1-nercone@nercone.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1063066216144127050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075245

---Test result---

Test Summary:
CheckPatch                    PENDING   0.56 seconds
GitLint                       PENDING   0.45 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      25.69 seconds
CheckAllWarning               PASS      28.51 seconds
CheckSparse                   PASS      27.31 seconds
BuildKernel32                 PASS      25.18 seconds
TestRunnerSetup               PASS      571.92 seconds
TestRunner_l2cap-tester       PASS      27.46 seconds
TestRunner_iso-tester         PASS      48.29 seconds
TestRunner_bnep-tester        PASS      6.33 seconds
TestRunner_mgmt-tester        FAIL      112.75 seconds
TestRunner_rfcomm-tester      PASS      9.68 seconds
TestRunner_sco-tester         FAIL      14.74 seconds
TestRunner_ioctl-tester       PASS      10.24 seconds
TestRunner_mesh-tester        FAIL      13.07 seconds
TestRunner_smp-tester         PASS      8.67 seconds
TestRunner_userchan-tester    PASS      6.85 seconds
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
Mesh - Send cancel - 1                               Timed out    1.828 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1063066216144127050==--
