Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04813FEE
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787410197; cv=none; b=XhBwKmoeUhAAFkS1IsVAWUOFACnPU9xPj8/JKUPooQmx9pC+92hPz731RJCU5CFSeD0Dp1fLVsp+q+YCK2twMGMeztfJGJWkbO1I/RQXQ7mx1cz5BTanlMpLXKpCmqhtaFG1N2OmunMqUPz2hzPdF83KqB0UD66bOqtD3dq4z20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787410197; c=relaxed/simple;
	bh=gTj++Vk2QFHKmTyfrpumqgzHc432q6lZvjafOymV/FI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AvKeTcr1Z9A/IjKBAVWuw9MvLHdvVVe1zFO0ogLZ10UJE0IMkhZRRIGlprRLmtY7jpwZcVMj4QfMiQILo6Z3iFnLsapHcM20rzxqJh5CcrshiU7jFXJOJpTbWiDWtbqNIgDcHMdbpYaO0uNWqfjhI5QhefSriRCCmUQpT+yig3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf6ApDsn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf6ApDsn"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso2213326a91.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787410196; x=1788014996; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yLHcWxVtVFIz4XgvJpQQDbk+l5ZT9EL/WbK6kCBGBw8=;
        b=jf6ApDsnTFfWPejeogC/kIlD+qrkY/6px6bZo9ASTYuUQL7uaLPCYs4FkR/hxWBhSG
         alrv+sCLaDg+5vLoOUHbeJHbFdVXJnGolkiIQpSFs3rLisH5Y1x73JJJGzm/WgcwNONL
         pbJbPV9Q1TI2luoaJgJPKJe03fKiVAj/lLy0zqrIWjBpD+JB9BLB2ZK+YpD4Spzcl8Wz
         NMx9cbiHBilwIn/XI/HpFm9hg279HwyrArZmSVpsn9CMRqSXvedBNqmivfNNkrXOBu16
         NeWfm4IkC7q2piQwmX20KSYANmhzUEfWksbrv1lIefJBJUCWDcgUOtbCGOFx2vPnwGDy
         z9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787410196; x=1788014996;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yLHcWxVtVFIz4XgvJpQQDbk+l5ZT9EL/WbK6kCBGBw8=;
        b=NyJ9q4mz01sG6N5sFBy8Gjxghy9oC71DgO+m6hnvImlLQNjMcS1eHQH8ZPY2GfaSnv
         b8RtTq95mrtXQCxK7uTAja6we++WVd+/fxVrptWlEdbz6xWK/NH5D+VhAB2bpUa/t7nB
         gtSsbBLjr8l9brWNmDmwRREFkCisgsB1XQ8DnQfXUmbxrUEaBcolW67wxCKTdZugbcHG
         TqNvZc0CIjNREzYvXWqpIwCIiMMxMPgj/zw9IyFwwfJps7ALNHbfCrVrMkREL7Gsosuw
         PQi2LxSlYYG0Xe6M2/oG+AQ2VWtWr77BmDMTyPYOmnkEpFeociCr90OeSmg15ljlOzgs
         /qIA==
X-Gm-Message-State: AFuF++kfG0yvFDKQoQ5E76TtyU7tbbhtY4AKIRKoEHMrx/ZOZ5ChNzRg
	gSJlH2B9EymBLSESH9AnUrbufgbRHOD70CH4kMvC4VUTLIFNPlOMW1vyqYqN4A==
X-Gm-Gg: AR+sD13jgv3DG+aAneZ7H3h7/8ZUDGjTtxsMuiH1bb/OfI9IZJFFXYAIJDzQuwQimGK
	beqXBtc8HcMoI3bMWzDW1jDtPAYWbXeejQP/03dR3mNNCGJApnHJyvYvfAdwPmaDUWknb/ZP0MN
	G9kODk3OQo7j+UsTOkMmXONA0zPN1fFjVmd5fVlggNVPrpnV6AqdDTPQxTfO92I+gzxG1ajEyLo
	3Arwd4/miS1vrfTkz8tkLWuPUf8KpGlfxjO7Ykr7JQADlxFpiPws/70gew7txF5faf/Q5y9247p
	HDNpiPcYsvXgtGIDXuht8tZmLn2s4dNMMzty1uJeixMWU4Thv8bgBMREtFnrlaB8pqn6Lx4GrrG
	feEYmfyik7VTi+ivHOHAr+BPU99gaqH/GFBu5z7MkMSxeefbohv2u1fyAZ8LKHULG7hO9fqUDES
	TJ/1FP/6/yGRmkEJ4/glUtQF4p9OnK8yN6zVptvwiuRSRSRZriQ4dv05fUdEVEqwF3FA==
X-Received: by 2002:a17:90a:fc47:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-395df5e76b5mr11836191a91.16.1787410195745;
        Sat, 22 Aug 2026 07:49:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.59.0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f925190fsm14894966eec.31.2026.08.22.07.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 07:49:55 -0700 (PDT)
Message-ID: <6a89b713.633cb3bb.1b53a6.68fa@mx.google.com>
Date: Sat, 22 Aug 2026 07:49:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6381874518675395676=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kserwus@gmail.com
Subject: RE: Bluetooth: detect broken extended scan instead of guessing by chip id
In-Reply-To: <20260822141115.58815-2-kserwus@gmail.com>
References: <20260822141115.58815-2-kserwus@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6381874518675395676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150202

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.43 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      20.32 seconds
CheckAllWarning               PASS      22.65 seconds
CheckSparse                   PASS      21.49 seconds
BuildKernel32                 PASS      19.81 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      362.13 seconds
TestRunner_l2cap-tester       PASS      51.12 seconds
TestRunner_iso-tester         PASS      65.77 seconds
TestRunner_bnep-tester        PASS      14.77 seconds
TestRunner_mgmt-tester        FAIL      176.89 seconds
TestRunner_rfcomm-tester      PASS      19.67 seconds
TestRunner_sco-tester         PASS      24.96 seconds
TestRunner_ioctl-tester       PASS      20.31 seconds
TestRunner_mesh-tester        FAIL      20.53 seconds
TestRunner_smp-tester         PASS      18.07 seconds
TestRunner_userchan-tester    PASS      15.48 seconds
TestRunner_6lowpan-tester     PASS      17.80 seconds
IncrementalBuild              PASS      21.42 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.188 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.922 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/634

---
Regards,
Linux Bluetooth


--===============6381874518675395676==--
