Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C92F363B
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774008853; cv=none; b=boqQVF5RwaBuAqnl0e6wJ6n6/qgMJzyYy/Ry+2oou5Ur4vjafjfTn5UPufnJwXqKT9/vtGujf5b24AsIPVURfataKZTdaYlwUQ1SkyYKYCFeYrvzL+8csx6ENWNAm7heM65ah7ftEGOzxmzzE2rYctUutJf2V5XjWoWeaV6+5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774008853; c=relaxed/simple;
	bh=YzuY7wDSu4TSdAnX5E8RfLRFXv6QKTzcVe8TccHRE2s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TPeX5IcambWiXMUw+N3EwzMarLQcGTYWk2gyEOvbVZev5bf7VI2vio9byKeYEcON57zC8SIMxoqICv+pWGDuACzsT7dz1dnoZrcW5O06LD+zCEGQ9v92FEFnpAxRmMRrHMwSFnpeLv4F9pxIUmqQ81mS2QOH7+McbAsbZwjFoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYYTbVc3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYYTbVc3"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50917e02472so5910791cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 05:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774008851; x=1774613651; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jQtt4zPCStkANQFxQaH1vxKUEs8ftXgLE1FM0GVjV3k=;
        b=XYYTbVc3Vq1z7SIZ2DQlizRvVklvHEXwplE9Wjfoh+pZH4IR7UzI6KJsLs9Tdywao8
         oWQPARK2W0QU6/8+e4niAZRlKgLqj0qSyNA4NFltq7ZAAjIT7o508/qSfylGIylkDdem
         l7o17JP6Kb3r2tyNj5fAXlYFS5H97n+MPL9TbuthA5rFzZ0FSDcmzgQlbwNiMTtwBxFu
         iJLg60IxLFXdDVOWTBMytDGUGyUSUcjwZVXjiPWkZtKXb6qvdP+fwiwWHAIfyFNBCGh2
         Cdm7TH9mLGpFU+k1FFluX9N6CliKOpcbMnfjxckO4dItmpO5lTkuCyd6RxZIgRV31CfP
         BuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774008851; x=1774613651;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQtt4zPCStkANQFxQaH1vxKUEs8ftXgLE1FM0GVjV3k=;
        b=FBhkbC8LKPGehEbKeDaB6/MlnnvwwkuOnO+R2JF4xmtbR9ergIpnvPxJ2CYfJLS7aI
         DrZT8RpQpI+MaPukTl5gfva0M/Q08kaS0c8062qcEtzdUWvaqbHqGo/V0NiVgkFVqbSK
         5wQTRh9HA8KNdsyR6jsX4VHrs4lFbehk3P5FH741dl9LBu94jFHl3ua28huAGYA7Lmih
         ORzcoCQO3njILRxGv+8HYE1ZWMLH0Hojd3wP/hdAmLrUT/JkhYC3rR8pzPIy2RvsNqxU
         2JmkU3/fJD/PzGAg9JObujIj1lkRnzu3VFi49j7lsQYHJ2h35FQQ8Y8P6VSn/eZUJfgb
         m42w==
X-Gm-Message-State: AOJu0YyH/y0hR9RQ6mLhcWShFceOIDkluSmh1H1BbQv9RvfDLp8+ggr/
	Yi28qOBS8MdQmKLfj/TruQwEszlNoH7BaIOeHyIfmD4L3VZlkH69Z6PboHcWRA==
X-Gm-Gg: ATEYQzwa/iXFpyiMkJLAvPQTbCEgMRlyhNZ2X+GlBXEiVW8h76sPkBhv9H+UlyOQXNW
	hKzI8C4PxLZQfSPixUbN1cu3FsKSPJb78N9YPu1aMHu7dJFRv8bgMsznRqIkEKvgxlSkZyoiY2+
	H1wzXI9MuTyHGQl5i8AxTEQ9Do9gFB7qzi6iecJ3Bkgt/N/kd+f2CdP5PAzOALoNyNWkSwjM6Af
	REOnXhz3Ua18QQQLUwlIE8lcZwFypjfm4u2SNneo11GnSSvtm0oAEAJYKuxpa1vJtSBfcq9shT9
	2NVyDKXR7GTEFkmidqNH+Ef7wAI7QNsj2X1WWuR3uYOUc5VJLhozKy0TNkoyownGterrPelYHqv
	g/PmQVRbthW8BBEP65nPM7BYyLJupOLL5/qnobrD2LabrUc2F2QAT02cYp8obF/jg9cExT62rXD
	tj9pYmikpD4772EK0hYHyZQRMthOqQjg==
X-Received: by 2002:ac8:7d86:0:b0:509:1924:3f67 with SMTP id d75a77b69052e-50b37541be2mr42251821cf.61.1774008850568;
        Fri, 20 Mar 2026 05:14:10 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.176.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36cb2e29sm21297631cf.1.2026.03.20.05.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:14:10 -0700 (PDT)
Message-ID: <69bd3a12.c80a0220.301447.758e@mx.google.com>
Date: Fri, 20 Mar 2026 05:14:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1650195579732399352=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, fberg@posteo.de
Subject: RE: Bluetooth: btusb: cancel pending HCI commands before USB suspend
In-Reply-To: <20260320114347.2340528-1-fberg@posteo.de>
References: <20260320114347.2340528-1-fberg@posteo.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1650195579732399352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069868

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.69 seconds
CheckAllWarning               PASS      29.06 seconds
CheckSparse                   PASS      28.04 seconds
BuildKernel32                 PASS      25.68 seconds
TestRunnerSetup               PASS      569.56 seconds
TestRunner_l2cap-tester       PASS      28.01 seconds
TestRunner_iso-tester         FAIL      38.59 seconds
TestRunner_bnep-tester        PASS      6.27 seconds
TestRunner_mgmt-tester        FAIL      116.26 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.44 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        FAIL      11.49 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.66 seconds
IncrementalBuild              PENDING   0.89 seconds

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
Read Exp Feature - Success                           Failed       0.104 seconds
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
Mesh - Send cancel - 1                               Timed out    1.845 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1650195579732399352==--
