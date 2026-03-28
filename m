Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16584262BD
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774691580; cv=none; b=PVxXhMDssFzeUK3nwM9+CUizyvj9/sHJNhdHmNgTmY2gF9y8f2hdlkTfFjmsIoZ/F7wM79jxRj/hnxeOFIl+GptpyPvJTLzRDpr6KE97BNiEzYX038RgF+9tqJGfiqBQKu6SWGQ3XA5mgwjQW3FkIXcKRb2eFQizHkulBRPLwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774691580; c=relaxed/simple;
	bh=kBsXS8lVEv0ReDc+SvD8ByZkq1gTorNtq25D6U/mijU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QfPmuCkiJp6BqS7ECSAVebplXoywUGuYp3Wx8mH2fPJuJ+avk9KDs1aBwQNj30q4pzDSEAdBHE0K9zhBLPw//43BUO8ySv6yXcn3SvqKYeryC5+DIPcdv+L7eTpG1nZy/GVacmXc8gAr2kEO7B5ijIbF6wHqU8ZPBsc+1ViYKJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kism8Hk0; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kism8Hk0"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d7447778b9so1494079a34.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774691578; x=1775296378; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aCmxwdGEYhtvUHTXJDJs8aYzH6PA5p2/KwwZsRpUeys=;
        b=Kism8Hk0+exWZF1IoYPNB7K/2Jzqfs4ZMf8tQCFIufRotAFGDbqJ1FLwUXkVNwX0qm
         cQfEnpPuB4RMY8lNsHW4TjunVnYjwZP2xyIj2qg1R9RpF1r5HYiROQakWNWfgMp3jC9+
         XquW1G1hGmvO8RWJjSHCyF/VNZlfjyqCzUSGgvgY1pJrbm4DP78YMOZJ51WyEj5jHP3z
         cVfsENYATWgRDMeYaeuLU5V6qvqMvTEsbK+p5qSA6CTpcSKS2havOGVoBxMqS8CI9AtN
         77Nz1P2occKNmyeb11f7VgzVHHQt1TKComhlBqrmWmSSXe5C3PDFvD4wYxb+NBf9p9BX
         zlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774691578; x=1775296378;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCmxwdGEYhtvUHTXJDJs8aYzH6PA5p2/KwwZsRpUeys=;
        b=mPR2QFwNx5+J+gc6OTaRuaDjMAGepndrwsjx4qnEZFhDkUh/NnCtkJQ88lxIm9IQJV
         ZbetRJA6pR2vCN8of/evH5OQSq30xfwnrRDuLd+fPhwynA/03RTkMMwxU18nNbRyeFLv
         a72bbAIRDI8nAiAF0DksaAQ5ckqEfCyGv4aveU1/K02pHs2JoGvFVkwgvgYAX8La847/
         DUsaavtvycyyHsjvjxa5X5Iwvl1Ze09THW44N9fGpaMSr64oeiH3ZywZGieKJ0wi3/Vk
         WrUbGUYSY5dU/vGoc6v/fKFIk4EJtqW9KLbfVaGWPyJiBEbz2CiZ0p0KrY/8x5+wRopI
         qDoA==
X-Gm-Message-State: AOJu0YwL7GEYmkAG7tVa3t6l9vNJJiU0dn7qkIdW92ANmdh1vqNetw8c
	lVsVnuxpobVqz+tpH8BVKd65SpadhdBZj30qgFkIrIHEN/ovU2j9uarikx8SYA==
X-Gm-Gg: ATEYQzw5N1sCtQ//4nkwd7+w0cRIv6K5Ga9zYwkpDQCLft/X3AHSD6tLSoohJ1E7sG2
	qgX6PVrHh5Vm8rgmeFayFVLa0jy3QIBmC4Iy32bhfkNAxWaClMYKIOHxRWRQTJ5CVzf3m2252TP
	Jo1JTgPz0xhwu+D87zBWztLW5SDGd9/3PXLpcNO8eRFvwpc3yZxcToegi2ZdOakuvGKqbSWwPIU
	fbohiolIyx2YSjzWtuA9761XO5idk0alCGIXwhT94LW0ecasyI0xgubCAaPMLApVbVuNtebb+Hy
	DjBYxWr/nVFzUtQqxChYwyUSzWfaZcrWDdE0UPZ8FFYBd8Gta6nCH3AVs11NLRK8a+h2S2uEgyj
	6lg6BMk7Rj0sr0UtwyIlJPG1Cdofe/i87HQtcdtI1U3Zx7WPsv0cHfoOLzAbhpDEnwMbdnuzn+c
	NbkoXlesFIItNoo6M0z8lZrncU8JZ+Xg==
X-Received: by 2002:a05:6830:7311:b0:7d7:5113:f83a with SMTP id 46e09a7af769-7d9faee8134mr2941414a34.25.1774691577741;
        Sat, 28 Mar 2026 02:52:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.108.16])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a3e4cd0sm1372324a34.12.2026.03.28.02.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 02:52:57 -0700 (PDT)
Message-ID: <69c7a4f9.050a0220.23af1a.f281@mx.google.com>
Date: Sat, 28 Mar 2026 02:52:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6062182898008213707=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, keenanat2000@gmail.com
Subject: RE: Bluetooth: MGMT: validate LTK enc_size on load
In-Reply-To: <20260328084648.51158-1-keenanat2000@gmail.com>
References: <20260328084648.51158-1-keenanat2000@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6062182898008213707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073914

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.35 seconds
CheckAllWarning               PASS      28.36 seconds
CheckSparse                   PASS      27.72 seconds
BuildKernel32                 PASS      25.61 seconds
TestRunnerSetup               PASS      567.30 seconds
TestRunner_l2cap-tester       PASS      27.86 seconds
TestRunner_iso-tester         PASS      41.34 seconds
TestRunner_bnep-tester        PASS      6.26 seconds
TestRunner_mgmt-tester        FAIL      110.74 seconds
TestRunner_rfcomm-tester      PASS      9.32 seconds
TestRunner_sco-tester         FAIL      14.26 seconds
TestRunner_ioctl-tester       PASS      10.12 seconds
TestRunner_mesh-tester        FAIL      11.64 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
IncrementalBuild              PENDING   0.46 seconds

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
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.123 seconds
Adv. non-connectable & connected (central) - Success Failed       0.116 seconds
Ext Adv. connectable & connected (central)           Failed       0.172 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.174 seconds
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
Mesh - Send cancel - 1                               Timed out    2.136 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6062182898008213707==--
