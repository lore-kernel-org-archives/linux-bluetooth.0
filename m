Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD82D8DDF
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768217896; cv=none; b=GeetH4VpdgPT04b/sy9tgPjvKcbRBIIaH/VSC0OqQsKsqDr5AcjG0rzQlkLv7zGdMK1umWub9XOxay+XdAqAmU7risURIxGsuKeDEbyLJmemo5om/HeNqfkA4AyBpxKASprSLz0mx4rsEtSjBraUoD0aIB/Wcmiw2bmrJn9iWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768217896; c=relaxed/simple;
	bh=jGeB21FiJhkgdi/ZrAqk3W5h/rd/iJZIHDA0BbwZwfk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EphozohyXH/WEfa65M38I7NHGJCIqyb7ifhI+nPelLAPWSWt4rNXutfmGfB4bWKeqnZ7LbTG3/Nbi9mO0xc5zeAMcZ3hOPEy5VUazdUbydAzL26ThoF7yAhCAkzxs7/+BeO09NuH+qi4kL9bT5ib8IVIea2q5FjLgu/249HlWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQJQqULZ; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQJQqULZ"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ae61424095so6128412eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 03:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768217894; x=1768822694; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oNxGPnjIFG5LNoUe8CubtVoPkRiMJPdlWw1yH9qS2vI=;
        b=SQJQqULZAzKUGv6fZJIm5NZ6S83wDiVZjU+RF2ryPiGWG/Q0sspBwKpVF8Zi7xB1v5
         gTfugpLzudm5o1o1Y4XKnsb5c58ib1bLSHn+qs2Hzj3WDhLT7E2foSZIsVfXXMn9Q6bY
         bxHkR426RaRxGkn6g/jo8I2NVTelaMXzRVQmjNmOOF99PY/mVpLJEn9s61zms8H0C9Sk
         BV2u+sF1rUN3lnpRqjwL4mROi8zrkTgYE0dvGqZiBwi6k3EKXQ1YQmX02bZUzbVbRai+
         AYCmtM+C+XrpfmAOZdO9oE50yV2eSHfjr5KpInWAsGdfY387qbh3WypH7TPe5pJgvP46
         ziJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768217894; x=1768822694;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNxGPnjIFG5LNoUe8CubtVoPkRiMJPdlWw1yH9qS2vI=;
        b=pIJtsqMGFw+1HWSu39q3eMqvaeeM8BVs065azj8BLQv/OyuKwVHDdQFJx6znjQ8PN/
         x3BSH36fuFO81qznyK7LimOkDLeFwC/AWWgiGJgvhmhnrhjIffsrjLDBySYAecnVuviG
         Y8sBJQ6tVwLzjAQx3hXxUWahuia+7m9IrJ2z54d1eUDqjiqoHdRQVdpI5Bl5/UG4lT9C
         rH4jri2Z2Kv4gdEG7RHwtxxQsjNMY6zbfYK59dMZTXZHlChX+uBT9tzowluHr/2ADsyP
         fkBlulmLvqGhhD6UHbH0CAPkQoncSWxPnp76+ota30hm3QY+ajQxRfE01NForZ1MUMF9
         sBvg==
X-Gm-Message-State: AOJu0YwYf1nnpgW4h/+oVY0IICUq2/LwaG0AQ3AJWxckClqCjvZa87cF
	raOJhwrGqvnFSNI0tAVXp+YQDYZc8cAmMjeN81hOQqx12m1DBqUgPuKu/vrUbn3Q
X-Gm-Gg: AY/fxX61Gx6qWyTzi9P4Z/LkrWjjmkJSTbaRggGtPRqV5LAsRRu/eLIUIvjUF7sTzcM
	o8XlxguHKSqil6PBamewBPIphB+y74oS0KZq03aoAP61GCtkMoUdIVo5zvbbIvJzFYWiya65SzK
	XhyUsOdOHAX4RzUaThZ16ayfGie3YlUc9l19blwisToIbf+QMlvKQf5miiHVEiqf1gmq2Ki251p
	mQf5a90w/TAaB4jP0lsWHmwkv1vFpr4KbsOUw8FZ40PjmcBFKlc4qXIH4z9MC90HJUwZJfYIN3O
	Q+neM4tbADdcWT39ijC006Zu3HDGdwyXH/bBWGJu2tEGlOXBPIF8wCDv4/u/ZyG58HhgqEvOoLv
	E/mHcbsDOc4KY528dmiKdfyVNwFfgk50KK1qZanKjKLE/sADM/j3DUsZTLWb4XoJbzOEje7OWq4
	kJreDjh2mCmzhWuuWc
X-Google-Smtp-Source: AGHT+IHf5r1LCkU9/3tfewaxmaGELMS1IVySsws+wHCvC1k8FIsJ1NOOkRWI/pjELu66zR/LZ6xHaQ==
X-Received: by 2002:a05:7300:4347:b0:2ae:582b:db80 with SMTP id 5a478bee46e88-2b17d1f023emr15547221eec.9.1768217894162;
        Mon, 12 Jan 2026 03:38:14 -0800 (PST)
Received: from [172.17.0.2] ([68.220.56.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b16e4sm15656092eec.26.2026.01.12.03.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 03:38:13 -0800 (PST)
Message-ID: <6964dd25.050a0220.2083b0.58d0@mx.google.com>
Date: Mon, 12 Jan 2026 03:38:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6312956181762398342=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
In-Reply-To: <20260112105127.3664608-1-hadess@hadess.net>
References: <20260112105127.3664608-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6312956181762398342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1041134

---Test result---

Test Summary:
CheckPatch                    PENDING   0.47 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.16 seconds
CheckAllWarning               PASS      28.29 seconds
CheckSparse                   PASS      31.16 seconds
BuildKernel32                 PASS      25.02 seconds
TestRunnerSetup               PASS      551.36 seconds
TestRunner_l2cap-tester       PASS      28.13 seconds
TestRunner_iso-tester         PASS      79.30 seconds
TestRunner_bnep-tester        PASS      6.22 seconds
TestRunner_mgmt-tester        FAIL      117.50 seconds
TestRunner_rfcomm-tester      PASS      9.51 seconds
TestRunner_sco-tester         FAIL      14.49 seconds
TestRunner_ioctl-tester       PASS      10.15 seconds
TestRunner_mesh-tester        FAIL      11.56 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.84 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Mesh - Send cancel - 1                               Timed out    1.839 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6312956181762398342==--
