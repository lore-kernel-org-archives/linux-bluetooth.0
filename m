Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0CA306B25
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765972971; cv=none; b=HK2T1Pj/3qkLyckCYun7BrDVezMWcGODd5V+jJFr9JOTIhE7AQ2zRgpV0SGPkxaMaq+xZO1OG1NFtlCwF2MOtcpJvCe3OXutl64Z+HL0B+vJwwb5quIXwcXIcEG83drtA8o8XgGwYMxYTkc2wRpXRG4oA4Pj1lI0vGf3ZlYo2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765972971; c=relaxed/simple;
	bh=Mq35M9PGakDRK8spbcFjlSVBvimJjIM7iSFQhafGclI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hj9GbW6Jce9+umZ/uR5EcaZi5NkCThcgCXKM0Stw1QmOuSbWxULhE20wtK9gVhi/m9cw0T6vCpaoJQP+AWaEZ1JRU6MRbB46Sf/tfOQ1Ui62fOAdgjohFoids7j8a5TMmF2Lli3IlHbHyD8JuBVc8FHMhj9fmCHPpbuJUpVkwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dI99LqaZ; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI99LqaZ"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so27239546d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 04:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765972967; x=1766577767; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J+tHdmKqqKCCzRQN71OC0O3joaugxg5vtUeUpldJcpM=;
        b=dI99LqaZjn2e2PCmJxnxtiOKphsWlfSaUxggUsKR8UvojyEQvl2SnOtsxhAQdxUjkb
         0C7JibkJRdWJMonFs1NfMVaHbKQ+bC9pCd5U3ciS0o1wPtxi6Kwm0cFMR8M/vwVaqmqC
         qc8u1C7HvRX1HGl4S7B8IBBk+FWl/ejVM7ah/CDHRxr93bl1Ntf3+gM69TaSE+3g5y+z
         sS08slG3fa5y127ngY8LHplqQz5hqrEjahoY1y/YGihiineYYtcZfMeaAcRCnoBBHWdL
         okgbmFnbTxp2YK1XkWWf/i1ztjDRbL6Pvm93Im8G1nJa5sgE6YmmqB2hFjrK7/Odkw5w
         9H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765972967; x=1766577767;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+tHdmKqqKCCzRQN71OC0O3joaugxg5vtUeUpldJcpM=;
        b=MfkRnWH4niRdyNaAS/35V9ojouRnL1og05X2ucz209b0vxm/K6eOM2slKZuk6CF1bM
         Hns2wGtuLvCU8Bm+NpFQUAor2sHUnr0pNvgqsvQeThmzQ0s01krujumBO+Z1gfoNLfVF
         AozRHxbwQG29qWtg8/qWkH6UFTxLv5hFWGhDyL56SUuxoQ4RO2CwNmI0Pfa9VtSLVLGu
         mXM0uOgwdhZvFPXQwcjyUKbbsC+ieXnMXkT9qF+NAdwTMAVZSaWWSTmYCRtExSH+PAma
         MMlHTsvVMtukxrj1Or74fVhTlECfV+H4mCmrxYHSOWQtXu0eWT85+H5R8ZnlDfc/bsJX
         toTw==
X-Gm-Message-State: AOJu0Yw+MfPnRXSjoHANpTDgP28KBk5jBTmjLU+otVpCCBfUkxH8dY96
	xw2L8Mn9a+aaIO3Zip6q4S+19yv4XYfWYiA+SW9vqeD1B1KJaHLqh7lbP9HRypGF
X-Gm-Gg: AY/fxX4OAX+s+kSH3GFt57Sl4+e5Dip11ii3IXCz9Ha9k76AgCrxEWlk0T6oEQ/rhdL
	gDzwWOIIfQcGVgGgtDYEfwmkWkF/Jr76muswV1RHcoNZuBrHz7kev45kLbFmkr0ue2VBEvzMP02
	MGHt1R+g7M+6Fa8J8E2kpW0EtNPQ1+d0h083JASQBMzaClF+vHMdnSHTlvzfZGGYwtRJAavTETb
	Hkdk40kUIwhZJLwo6dOjINBQGzjmcbgaC/fbEpdNZRTcn9Fi8KRfVvgyuHw+CHJBvRe5B+MP3+f
	t6CfWljVYQ6trUlsqvheh8MbtKHOKG+JRJQdE08/SlCcAIadBHV6QLvXodSxDwGu6O594us0Y57
	OKB5j/mqxuZZj0ZNFRRcwozSLnv8cA60GRag3bDz0U2PaYdtCcIv7TKGsFSPyqkYWMDOLnUrgad
	4OcGWmH7Q/GhCg/4uM
X-Google-Smtp-Source: AGHT+IF/FKvKJfaSpjzp4w1vgI89QhjoiEOhLyDG3ugFp29R1zY9fLsPFaYp+uNebfGg9ydB6kXWCA==
X-Received: by 2002:a05:6214:509b:b0:880:501f:5dd with SMTP id 6a1803df08f44-8887dfec80cmr268796936d6.14.1765972966713;
        Wed, 17 Dec 2025 04:02:46 -0800 (PST)
Received: from [172.17.0.2] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8899e7598c7sm93307616d6.28.2025.12.17.04.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:02:46 -0800 (PST)
Message-ID: <69429be6.0c0a0220.22ff7b.5a35@mx.google.com>
Date: Wed, 17 Dec 2025 04:02:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4140137489796300921=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, u.kleine-koenig@baylibre.com
Subject: RE: Bluetooth: btmtksdio: Use pm_ptr instead of #ifdef CONFIG_PM
In-Reply-To: <20251217112033.3309281-3-u.kleine-koenig@baylibre.com>
References: <20251217112033.3309281-3-u.kleine-koenig@baylibre.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4140137489796300921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1034164

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.52 seconds
CheckAllWarning               PASS      27.97 seconds
CheckSparse                   PASS      31.47 seconds
BuildKernel32                 PASS      24.93 seconds
TestRunnerSetup               PASS      552.35 seconds
TestRunner_l2cap-tester       PASS      25.34 seconds
TestRunner_iso-tester         PASS      92.12 seconds
TestRunner_bnep-tester        PASS      6.34 seconds
TestRunner_mgmt-tester        FAIL      117.48 seconds
TestRunner_rfcomm-tester      PASS      9.44 seconds
TestRunner_sco-tester         FAIL      14.68 seconds
TestRunner_ioctl-tester       PASS      10.32 seconds
TestRunner_mesh-tester        FAIL      11.57 seconds
TestRunner_smp-tester         PASS      8.82 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
IncrementalBuild              PENDING   0.79 seconds

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
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    1.789 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4140137489796300921==--
