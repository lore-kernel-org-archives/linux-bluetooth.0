Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6EE3CBE6B
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775150001; cv=none; b=hQcA//IEBr+hZpavP0ozVBNPu70dhCpHpubQAz1U+6KAc0LN+K5ZhWfJ5fCNprGNJ1vAf6NNnch/QJDNuSQBcVey8VlS3PVN3+nXz3/vD8FBhj9IBPKxD9Qf+EYgTKL8y3Z3yXGmAoFyrI+fDCd4kCTn0XursbEkwANB2OryORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775150001; c=relaxed/simple;
	bh=QSBo3ohYTA5opQbCD9tR80FhfObgITXgKsjon5VhFzg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dkdwgbJ+txWuzoPqrB9w/5uFQHLXAFXXKMRHpl7DVfLMHNOet5EskUDOmF3BD1LShQyipRN4MqILDMROLCn3U76v9etdYG7zNapk/N4Xo79Kz4Ztcaq9iIHUvC8l9YGrndjMJzMZ8JRhP4XlZgwX5YTGyS5+ukcsg/K2zm1lLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNuMbuPj; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNuMbuPj"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a05c18d3e2so10648696d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775149997; x=1775754797; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SXq/HebB27pLos13fEwLlfGEYEwSDNk0pw947pZf9uA=;
        b=tNuMbuPjvJQkPDoNEguJK4aywwyvJojuMjL7xmw1j3aJt9omH4W01RD8pTx4MV5joT
         PMHRzv8t3wX+NDeklii7zw3xl0c+TXPij0XltIDm/JznwHRUg5pxGhFwF7sOOQKGUap7
         k5DoXShBzFBlcww8q62TsqpmLOG12dffQj1JdFdhbnePbx2KnZ0GjfVeyFkq8STaj2Or
         DOhklLbY4Dx1GdQiVuVl4+w2AWSmlFEf9CHEe40rwtRdvQB6V8s8AYpvW8VlwVvL9bSH
         bKUfV0hS+H1l5exiQmIbO+yqCUGPNhDcEM+C1citZsYU+Ko6DqoORzmAab4VxPO200zp
         KEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149997; x=1775754797;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXq/HebB27pLos13fEwLlfGEYEwSDNk0pw947pZf9uA=;
        b=iMbMuxaC7FM9O8D1gjTO9Aw+4l7PW0QLKnToo4y2BFdIlzB1kcA6MbKjDlGOv9tHQt
         GylScT7Ie5fHdg0PioZY/j0q2AOSefNkooTd93ENqdsEoyIkhBa49z8wFX68IXhQOshp
         6BnDW7Gq7sV3beVL+GOLniIm1qy47qJ5KSSi7Pu+OFuU0V/pExdPGU01uZmmJT8yHxFh
         qESKtt8BWNR60CF0cxCEcLuvcA3F9VRXnfpGZ3hdSanVlB5mzqVpuUa9+n/aH1ryM7l1
         bcugfTGT8t9EHY7NbMmoQLzjj3GFIWu5QnqV01xj9qC2dB4r5mjGKzzzcafyQLtWLMor
         Um5g==
X-Gm-Message-State: AOJu0Yw55Fv8iufoBySw0xFCC9o2WjsCIuR7e1cgSWhZLYp2FCRhfiEl
	jl7TTXwVRr0F0eTYmT3xHJtjiTs4TrNg94YYdfwNrSCA71Jl68wcRWA5H0BULA==
X-Gm-Gg: AeBDieuB6vP5t9yEFm9xnG6iGsuSeHw8/bwHIravBZCbxnGds0DqQ/iFanaDyHtHuuT
	l5jxkbkp/7LCxqsPqg7sLxD6hHOAvBLXetr4qcxtjqixS0vjDhB2ZtWn9TxXAdKg5mcaPP2K/z3
	KHZEtqjes7AkJ7ZpWGjA5TKqXxA3dj92WyUK0SZiAotMObARs/dwAR0iwMAjKA8PQ3GnD22FOS3
	2BOE/Vmtv1Kiuct6RrEEeWlrNB/738MI5T5z1VMmHUKUA1UY+s+zUoUVoq+d18RZT+6yUPD7rnr
	ABp8plYOLvRcpokW3xPYWE5fuYlPGcOFTh3P+uHBXZqAqsCB3uVB4zWcT6MirBrzHhNMeWtm7KN
	ilINw7SS3rcTfef+j3NuEaN3G0MaUFHHrZsP4OAHLBiT7BUPXQ9FZvpbzy45FMGCet130GXj/Mb
	+WcKvhcsdbytCmQk+PV2abtrnni/pB42tf
X-Received: by 2002:a05:6214:258b:b0:89c:c3db:b302 with SMTP id 6a1803df08f44-8a5ecbb0cd1mr44308516d6.22.1775149997008;
        Thu, 02 Apr 2026 10:13:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.135.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596914bb7sm31698516d6.28.2026.04.02.10.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:13:16 -0700 (PDT)
Message-ID: <69cea3ac.050a0220.26df3.d299@mx.google.com>
Date: Thu, 02 Apr 2026 10:13:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1789060616015506982=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan@kernel.org
Subject: RE: Bluetooth: btusb: fix wakeup irq devres lifetime
In-Reply-To: <20260402154810.2467291-2-johan@kernel.org>
References: <20260402154810.2467291-2-johan@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1789060616015506982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076527

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.47 seconds
BuildKernel                   PASS      24.97 seconds
CheckAllWarning               PASS      26.82 seconds
CheckSparse                   PASS      29.65 seconds
BuildKernel32                 PASS      24.14 seconds
TestRunnerSetup               PASS      525.22 seconds
TestRunner_l2cap-tester       FAIL      28.52 seconds
TestRunner_iso-tester         PASS      40.06 seconds
TestRunner_bnep-tester        PASS      6.47 seconds
TestRunner_mgmt-tester        FAIL      112.80 seconds
TestRunner_rfcomm-tester      PASS      9.53 seconds
TestRunner_sco-tester         FAIL      14.52 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        FAIL      12.51 seconds
TestRunner_smp-tester         PASS      8.68 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
IncrementalBuild              PENDING   1.02 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.116 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.116 seconds
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
Mesh - Send cancel - 1                               Timed out    2.573 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1789060616015506982==--
