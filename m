Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F242848B
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769034395; cv=none; b=Fgzfz36nC0uHAanDP4IcV6zHH0eR4LeRe+4CocOuGbJeY+OAVbYSIiXHvOKJl2TtU4s+Bov6317pJ5H6YojKODYP5mtAfnEs75IOwWBzsFWe0xeEPZVgHsbNYK8/x0wcZpYozQWG/8dJN0zP/Xb2394sG+jFE0l48XEeReE/ISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769034395; c=relaxed/simple;
	bh=ITarJCnC7ijlsQgnA/20N9L9m9fTPrP+kC8qXP4ppJM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qZpzyy2FAUPXGxGNo0s//EytgL+yk1pMSJ8VGMkWW0gpkucz4CoVXKYorkBPs1RvMgp1B5bodClyP8C37UdGu2ba5i4PrYUvNMm38npQ37W0hcNUyEa6smehjjz3miUyq5UWOqX18Blt4IXf1LavpmzZg9erVXsIl1oMnkrcsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4Fle8uN; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4Fle8uN"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-12448c4d404so390250c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 14:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769034390; x=1769639190; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TPZZYNC7RVdqtyef6M8wLVsBccpE2O/wTolELojAbQc=;
        b=F4Fle8uNgLzs2EdmINzvA0fTp3Ds4FEq+j6nsmqAQYTqv3J2APlzxedK909SqHJM1/
         UDo4cO25mk4nn/X6c16oAPW4Tz6kO9PHm0SCpLlhmnpvnuJl9wE899co8lZuOCJ5goi6
         4PeK5zcK+10565SHGO9HcJJehpiOy163q4iiLk+n3ifS9EECGoVTlrK1qX0XzMBjrk/E
         WI8ctv7e0HQmbqEnmy9DYWnRoLHXPwFj4jPCZhYzacs0AnOT4hEGZQwJ0R7LSjwCVcuQ
         5ySnuQLkZZtbteqrw0LE4Xoaj5OB/gIgPktotNGimyzZs4ozjcnjqOKEnJNYIgeRi+MP
         xheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769034390; x=1769639190;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPZZYNC7RVdqtyef6M8wLVsBccpE2O/wTolELojAbQc=;
        b=C9EXhg8ooqUfoF/QoIC/pCh7Hadx1zjqezqgSEUMhSs7UAaujICeY73d8tpSH3IWT2
         SOqP4IPNWmolVk4Y+VQyTlT3dOeRoZ6zT/SDMoRsSVqdcFkFcRJ9rqWxJOi4FSSN6HfN
         txzeky8lbzjOXaICX7Em9dPGoLy9pZOGJ99/ffB8l/Qu9idzYhXG6PB/x6Ds5YPKsC9J
         89aKXZ1dIK1LEBZljU9mAzPHQGGQYiIDqUGPF57iSoNfBl2ltmkfRrF6yYjWKxVT1P9Q
         giWBsh8j+bp/Zu5nGPEeXzyCJEeSFN9eSe2u0ad8RoEPACZchpMRBdC+8td/KjU3m6rQ
         3Aug==
X-Gm-Message-State: AOJu0Yx2WfwR90zVjTnkEWY3TRTd6yGuHD+1ZzlJ1kR/K/oLZFYZGKi8
	5FRlGTwfQakqWL5bUwHEIpYLaEt90SzYPbM10utER0Ky42JzFXlN7IdRgU8jPHGT
X-Gm-Gg: AZuq6aJbhbVgtVyJn27Jac6AJt0/8Waknmr7nL7nwtvg2ZsDFEsRBWptLRWlRImPm/y
	H0LUrDZrc8OCsKVQ/vHc4ttKGIJayFxV0UD5D0mnH3hYLYVYtVWwE3wsc3Sp2fjXuyA95UNwQPG
	mvtinbPHI98LoxUosBPl7eEqEzONfQTX9yvoF6efIBfx+j3ic6jt4WVlig1FDCMwyYMNXmVCKXk
	s/TGplTIX/EKLYR01tN7VYSatbD/qnbEcQsC5RqJg9yTUrFGOFvOAo2dWFgezmuzYgskvi4rLnR
	KqnVhAdTRhjkjSIz9g+FzLfVEeHKUMICJ1wKEgYj4lzl7sYkauPA3Wpr2QEknumyBnMQV6Yz1As
	LKCaiA9nNHBPTurHEZ3Mcnv0GPdmV6SZNPrmrRkcKC2eNxyCfLXNa8YflkTgw0Mhg/yV5vWf3TN
	30I7H58YifF5neCn0mCIl41U4US2KYow==
X-Received: by 2002:a05:7022:51b:b0:121:a01a:85d8 with SMTP id a92af1059eb24-1246aacb80dmr4498486c88.45.1769034389731;
        Wed, 21 Jan 2026 14:26:29 -0800 (PST)
Received: from [172.17.0.2] ([172.182.213.152])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac57fd0sm26544394c88.3.2026.01.21.14.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:26:29 -0800 (PST)
Message-ID: <69715295.050a0220.1a4a8f.21c4@mx.google.com>
Date: Wed, 21 Jan 2026 14:26:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7683710043026832622=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
In-Reply-To: <20260121213944.2686506-1-luiz.dentz@gmail.com>
References: <20260121213944.2686506-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7683710043026832622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1045342

---Test result---

Test Summary:
CheckPatch                    PENDING   0.54 seconds
GitLint                       PENDING   0.32 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.25 seconds
CheckAllWarning               PASS      27.92 seconds
CheckSparse                   PASS      31.15 seconds
BuildKernel32                 PASS      25.09 seconds
TestRunnerSetup               PASS      550.94 seconds
TestRunner_l2cap-tester       PASS      28.16 seconds
TestRunner_iso-tester         PASS      81.93 seconds
TestRunner_bnep-tester        PASS      6.17 seconds
TestRunner_mgmt-tester        FAIL      117.32 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         FAIL      14.54 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.58 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.52 seconds
IncrementalBuild              PENDING   1.09 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.187 seconds
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
Mesh - Send cancel - 1                               Timed out    1.837 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7683710043026832622==--
