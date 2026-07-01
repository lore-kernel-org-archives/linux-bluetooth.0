Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE537AA6A
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925223; cv=none; b=s6Op9vHs7fWszv8ZYNXa6wD+MZRG9nBugWND1+Zspee5I32ivxsgSv1vQbKLuyn5y30w6Pj4bBL1k5iX3Fn23nDD/U1VgijO+lfP8/95tjAL294i0ebC1KTAr9g2Ya9pJpetkGnTwzh1cKLAH3HZ0jPPmcsXjiZ9/i2hu49O0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925223; c=relaxed/simple;
	bh=QsTsVWwgtLnV4MpPs1Cv6w+9GPw2FbkXDzjOvRTWbW8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RonNcCce++hv7xkTAFQSC1Q8yWnPCCuXEPjiu8kjBS7zkdiOQGIqW4qUPFGK2SsJNYHjCWpCjM172XhB7pTvC8k52FxZg66Koa5W8o/EBSKdb7i3Gv5BsHgMYVOoExy+fi1gFT1KaQ0awjUhSRmAyrzpJbR3/kXM5VG3WnspuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlPk7gZN; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlPk7gZN"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37f72212544so876971a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782925222; x=1783530022; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O0s+DpnLbT56t3i1i6zwariEnIWxdQO55SEJXX6jELs=;
        b=WlPk7gZNFwfPyVpU3rGkou7htHVeR/qdXcc0yBappjPToeFoB5qBHzD2YZEy9v4i/Y
         FYUvMDi85rei5TLyOVBnB7G5UMcpvj+hWYefRAJV+PsCpk0uXtjqHwmypzEBDSE5Akik
         Ii7jpH/MoJsoKB1quhn9XnOnxk5z1krCTrRfp93fp8fZwR4XnwKJCtfUkYlNg68pJbKV
         oKRBy6KyOqK//VTkj8hFal9NF0QFJCXM/tK/Btho2mjUOdevK/SFI6cwaSQxWS5Ap/I7
         A8EZCmbGBPqH4SBr2AJ7sB3JPon9uPJeK9fhm/jsNRwZ6UzH19pTi4CRUaFGE5XWC6ED
         iEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925222; x=1783530022;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0s+DpnLbT56t3i1i6zwariEnIWxdQO55SEJXX6jELs=;
        b=ZwPVLMMdXhiEqvQuBh+vlA9aFgVK9pwGUd6dagLoctk3n8hb81KDoyRmXAMJxx2w//
         l1WCcZfsiv3xqvfrXmMY15GRRvU+6JXRV3vytme+EQqfh4Po/fOVGZYOvrcO7deYnWWk
         o5c7wnUOv/TZShC3DixUGhVFBIsWO04GTnlW3lJOTZeJtpzvqUVq1/dV2g1Jyk34RDEV
         98J9XaW8Gjx5ZCZZfs4TMHagKlB7QDILbR2fadUiGzk/1vNLG0AjnOsJimZdFxKpMkEe
         55wLyXNXPZpTmISFx/iP3SBnOrvaapa2RuzSRewX4enDboL5EpRn5rLdmdTvQqmgEWUg
         BH8Q==
X-Gm-Message-State: AOJu0Yx4vzpjEPEvB9IF1fxYq23wEj01HdTq8wuvTSmwXt88FGTUpN7n
	Ennz3arQohPhr/fZkv5VzkzpIad1YV6Q9cICgM2uxtyjN/7QT7U3rAO/1yCBAA==
X-Gm-Gg: AfdE7clpzpdytCuSRP6N7Rcg+/dLc8IUzV2hpzCmCmZQov4wM+gVOiOWNpbnYUaRU7K
	UX/0QsOTixE0krIiS+da2sSCKxAZMREIKuBnXllSaPvyHdKNxJ/2jKEkdJ7idkAoewJJ0MnyZwY
	uaV88ySLgGLynaEzou6pqu4YGsDPl82LPatyr9pWi0IhJ7Eb/CJfVlvKDMoOptZsB0hcrLMxwFb
	6NxR9h8MDcOEKVCoxTjj3OalTcnMWgC+FyrvFigA/WDMl+wnk2qFWxpDxpkm3n3oCXImzLt10W1
	lBVoJET4V6jBOaFxcdUgCGC8rqFW3U7eaufSLOHLKxzwhqc9x6ThJivEWfUF4y70qATL6TFBcxt
	9iQrAFSmd+HZNPfS8bIajHFCmM4O7rIVyigNksW+UnKK78MReHCSGIsMJ/sbI4WtTyYVGRqKp26
	fjsbhYaoIMB9xnZ2K3oT60eTflWRiRliV2
X-Received: by 2002:a05:6300:6d8c:20b0:3bf:ee42:195 with SMTP id adf61e73a8af0-3bfee4223f0mr1880775637.11.1782925221675;
        Wed, 01 Jul 2026 10:00:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.217.103])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee327cea7sm25894546eec.31.2026.07.01.10.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:00:20 -0700 (PDT)
Message-ID: <6a4547a4.d4361ba8.1154fd.636d@mx.google.com>
Date: Wed, 01 Jul 2026 10:00:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8536465683254064277=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [1/2] Bluetooth: ISO: fix malformed ISO_END/CONT handling
In-Reply-To: <da68c9b8242e9fbf482b1512e9d612768f2cc7e8.1782920668.git.pav@iki.fi>
References: <da68c9b8242e9fbf482b1512e9d612768f2cc7e8.1782920668.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8536465683254064277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1119954

---Test result---

Test Summary:
CheckPatch                    PASS      1.16 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.48 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      25.74 seconds
CheckAllWarning               PASS      32.87 seconds
CheckSparse                   PASS      26.59 seconds
BuildKernel32                 PASS      24.57 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      456.24 seconds
TestRunner_l2cap-tester       PASS      57.27 seconds
TestRunner_iso-tester         PASS      81.36 seconds
TestRunner_bnep-tester        PASS      18.68 seconds
TestRunner_mgmt-tester        FAIL      207.92 seconds
TestRunner_rfcomm-tester      PASS      25.09 seconds
TestRunner_sco-tester         PASS      31.73 seconds
TestRunner_ioctl-tester       PASS      25.50 seconds
TestRunner_mesh-tester        FAIL      25.88 seconds
TestRunner_smp-tester         PASS      22.55 seconds
TestRunner_userchan-tester    PASS      19.51 seconds
TestRunner_6lowpan-tester     PASS      22.29 seconds
IncrementalBuild              PASS      40.58 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.243 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.605 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/381

---
Regards,
Linux Bluetooth


--===============8536465683254064277==--
