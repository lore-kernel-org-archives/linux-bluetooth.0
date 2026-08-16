Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC2282F13
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786874432; cv=none; b=lJZYT8wUENQKgIE0fQjJHoqX1X2h3Fw4NEYqmx8cRzORZLoc1JGI7rLgfaVTSblb37T8gIOPkdUo4C1HclZ9iRqyNEcmOE1dZxr8al491FMnYr/tQ4j9OEOLXVC+Ohv7mx58nOGkZKCg0Cbmu1HoP9KOxrVYLucVw643pDaiKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786874432; c=relaxed/simple;
	bh=Z7FK/JChf4rNSvur8h5L2Dsa1fAX0jc5salz4HRHHj4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=enugnDtWIAwxGiZgcMGkCuPIC31fG7momBL+Ivv+om0NAmxIl4c/1gtEN/WbChRRG6Ce7QispsqsW0viwdwRKmQenzg9dEk7qmAESJp61QvIQxqNzoMCDBKojAiQSxkNgBBHftBJ9aWFDCE+97cbgxAL4H2k5Ab6Rlx6Kd/+TDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMt4kHF8; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMt4kHF8"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f18c0e03e3so1231579a34.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Aug 2026 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786874430; x=1787479230; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kvRgnhdwVyFS7P+aa4zJRHCObXTW3N4BvlT1jGfFSNA=;
        b=OMt4kHF8BYkJfqUTBcGJH5gzdfx4yyC+OMxKZgmn3nHWURweyharEoTlyiA53EsZ0T
         2loH5hl4Q3BfMZKNiRndLtJtuJgCyOm3hDgzIJOKtf2ykrWl7po9hPoajFu/XS2xkgl0
         r7XWxWI+x/rAfcr0er7HgjBWvH07R5nyOoTp0yfNQ38Q6ykTJuM6MV8NOP3TxYDzgLgh
         HpeEjeG7yfy5bQiDO3aKHuZezkV8XvVGQBQ03/4IZT/ovnAEdlaiKfK0ix6YGOATNZ2q
         ndQ/ypIVcl5kQH/zhULRcE3bHDyLmZUlxfrUgJjLAFgeElsvF60x24SKcGWFUroyD0/u
         CFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786874430; x=1787479230;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kvRgnhdwVyFS7P+aa4zJRHCObXTW3N4BvlT1jGfFSNA=;
        b=JVKs5VLvPYZrXUAYGdRypGomDvKOP2B/3gaXRKWepzeVI+ShKEKZ3ak48Y7T9Sucm3
         +z6GoHZc3RgZmq1cLmbfvdTUyAPsrLseXxtHERbdeOcM5CRTzRMLN3djMmEOFa71fuUQ
         OcNIanC2z2AdOymBVOi9WhJYBZjr14nrihje0SPTF+1EnfJT49kPtR34x3DhZA2h6Esg
         QQG69+Wf6z7Gza4YufXZjCFVwrRZXdZaBD93vgGHX4KPqMVyF0rjXd2Zria4i3UREJ1g
         2UdCh+vjV4rwrbTqA4h6VD/P9X2auSE8mlKQadjH0nedbUmGAdfr86TlvhkBqugzQ9lO
         OUpw==
X-Gm-Message-State: AOJu0YxH7jkH72s/dD4XEswR1o45JKarnGv7VykRk2fvntayzxF2exRF
	prg9Y35tik1x777R88EfIDYEOLmYe9PA8d+aXBc4rpyG4Sgo+RZqMGk+ZV96Dg==
X-Gm-Gg: AR+sD11lFa+ykFkVUXgQAFjMldx0Gw0jSmUrir65+y4//gaqkVSlu3H8IW6huqm8CDn
	4TZg+Vw81ZuFb6wzmpcISbO7eAk2ki1p5UoTr4ulFEqyks+jhhzIhuWHce9nLiXbZaVf9d4Xws7
	l34xF+ZRDH/XsC5oMrTU28cTL/LgS1sdOXpUPuplFZ5op2/x5B1PaBnc3eG48gHlKLvtyBqDcHD
	5Eub0E1ZgjuQnBKuNhYDTuxUPeAlufs3wuUbvT07xAyy4PPVaRyw4rTK5F9Yd2DsywS53rafSPL
	gEmI/r62V4jE72ENhYFWAqrm4W0Za7PiGR2z/6SyBDGMMzEAUW6N7pJaRSqmsZNRJjSwLZOml3b
	MIXUMAqfAz53KwdogLPUyDogcN5JkeLG9BICx8kbiTDuQBriRad1lKvcT6yLwt1N8Gqzbsw8WgB
	uRWBRThV0CUKzaZoeqtIwLXlFb3aAXbJlYAksSoXmFuaLs1dBVlhd61uUCciN/IRCPZy8n
X-Received: by 2002:a05:6830:6d4d:b0:7e6:ee1f:96f1 with SMTP id 46e09a7af769-7f3de5ce42dmr18669711a34.5.1786874429998;
        Sun, 16 Aug 2026 03:00:29 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.141.201])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e84d81e1sm5819504a34.10.2026.08.16.03.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 03:00:29 -0700 (PDT)
Message-ID: <6a818a3d.9ff26ae1.13c5d4.ceaf@mx.google.com>
Date: Sun, 16 Aug 2026 03:00:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0995873935107257631=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [RESEND] Bluetooth: hci_sync: add conditional locking annotations
In-Reply-To: <1ceaa25d70f068adfe2c40290a629b73c382ec59.1786870726.git.pav@iki.fi>
References: <1ceaa25d70f068adfe2c40290a629b73c382ec59.1786870726.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0995873935107257631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146702

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.44 seconds
CheckAllWarning               PASS      30.04 seconds
CheckSparse                   PASS      28.83 seconds
BuildKernel32                 PASS      26.41 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      504.49 seconds
TestRunner_l2cap-tester       PASS      64.87 seconds
TestRunner_iso-tester         PASS      81.35 seconds
TestRunner_bnep-tester        PASS      19.43 seconds
TestRunner_mgmt-tester        FAIL      225.67 seconds
TestRunner_rfcomm-tester      PASS      25.92 seconds
TestRunner_sco-tester         PASS      31.38 seconds
TestRunner_ioctl-tester       PASS      27.10 seconds
TestRunner_mesh-tester        FAIL      25.92 seconds
TestRunner_smp-tester         PASS      27.57 seconds
TestRunner_userchan-tester    PASS      19.98 seconds
TestRunner_6lowpan-tester     PASS      23.16 seconds
IncrementalBuild              PASS      25.83 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RESEND] Bluetooth: hci_sync: add conditional locking annotations

12: B2 Line has trailing whitespace: "    "
14: B2 Line has trailing whitespace: "    "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 494 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.252 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.408 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.400 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.314 seconds
Mesh - Send cancel - 2                               Timed out    1.983 seconds


https://github.com/bluez/bluetooth-next/pull/591

---
Regards,
Linux Bluetooth


--===============0995873935107257631==--
