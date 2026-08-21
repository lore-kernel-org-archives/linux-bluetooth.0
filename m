Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E9637C929
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 04:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286399; cv=none; b=rqWeZBcRaTDVPo+WEXb+Y151Yg+61R/OTYlWVC9u5ibX7sNP14EbxRI/KnMyBj30x0qIG4MacQnDA1IpxUdylAxT9PhparB0pCk2VRGaBGlA7CHNOR1e5nenWLWVJ6Q91Kah8fp0aUQFE423XLds6zcNwwuLSJsqMRW4ITeT1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286399; c=relaxed/simple;
	bh=VDGvw0vkKZdXy487HfKyk7ElUdcCOUTEfQZRr1kO43g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hd9C3H5eVmKXgYswUU1ztZxRMMHSPqXFusNn1jYgWiXfKgIRTQ8efEO8WVMiioFphYDRVf/uXtvC0jNNaJVyr5ZsuJzeqXBBnf+65aPkcNw4x9/zV2hyGbFLoyN4K+ZpMLVTdEtjgKYyS5ujl0Zr7Bl2mLzvD2XfGxk/zUj0IvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4X77FNE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4X77FNE"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bfad59921so3402721cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 21:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787286397; x=1787891197; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F89FBkADEngocpgSvDQOQqPleU+w4rlvSfSUfXTr5Iw=;
        b=L4X77FNE3PsuSEOeiRT36Uo3uVUNN7tfc3mOaaH+lT/gZT1yZvbGX2VqrTY7z5DOUJ
         QFop9qb6NTeBFNhQb3kuW93fbl0wOjxXNOrDgMvubiL89lVm4NA2U3b2kfJEQsnndtGF
         0iNbS7o7wnSKRJRetn3cfUiMznSEFhI4ubeyKK7cM3mWVDDrdvrLng8FlX/7qQp7tyS+
         fgYNiZXfGRGWdyfu8e7HnmDzkjjU8hK+OnB2HpzQfKVV/zUKA7M9YSiAGgfOKy+tUGoe
         EJl/3QoFERUv3Ig6dFNq9zs+J4+f+7+/qzlLuznDYKOBerkrIi2Wx6VPCsAMmBlKOMlJ
         zgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787286397; x=1787891197;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F89FBkADEngocpgSvDQOQqPleU+w4rlvSfSUfXTr5Iw=;
        b=SbKCms6Si+yVbLPIOpiZhBt0u7c6r8MI6GEGSSRFIvhoO1hnln+XPuFvCK8YYovJPJ
         lJJ5m851ht8ziO5/u6sEo1ssm//QVcBGWcpG7xj/eIOH1JtSq2wEM4WoLRM0lw4VBi4c
         /JOaIpb2LaRsF84sP/ojSqy8oveo0i32YkVnqI8qz977e1WnfOFRiPr28ZLiA9IkYrxN
         QNJahrGmRPFfnGCCE/4QFMbPksMzHKi63NSgKxG8d4oo/GubqFt4gk8qQMBdFTngjiUB
         uXU0EqFGVJgBvwJ65B74GJ58BG365TVF9eJVRbOvzJ+H6xTIkG93p3Ux+2U3Gjba5UMy
         Z2Sg==
X-Gm-Message-State: AOJu0YxUfdwkMF2y9zXz0E8Z78JDFSL9ls0yLONi3pyI1ThX82mTXzf9
	rUlMelDI8IjwkfKjLLpPHGc6j2kmWHq+tipX2/gJcnQQYMPTHOOqG9wPiVukRA==
X-Gm-Gg: AR+sD10iMsvitfJao9quh2ItbyjbkSxgI7PcTFwa7lAH9aTT0jcXlO0o3PCP9Dlmfje
	atRSgoM5pLg2hE1rCwjMi2mPWRAWCvnOs8lYwQDUQ63IXSVWV+4RWyWEwSD22QnH/nX50V+LVkB
	d49ui+8Wn6E9ixT4yQ+qjvWpHcJJ833+DLHgCh2RfpCfziGk7DpqlykanKUUFUweBfqW50xMhrw
	/lh2dYfjM+vxMY+riUg1riTnCpN/aSx1bylFsoUUYVlvk11yu+YiCQtRE4YV06pbZVrukWQUXUe
	IGQYXqTKhf1y5NCckLabikUWnwYkO+s2rcFy7sVd+STdmhlJTcQ26WZPul0LvEYymYPDmp38563
	jFspfqsMeuu2KVCdHr9u1GquVX0dlfp5RJB/qVIYkV/K1lrdiR9nhCOzA83SzDvRomHvoMnd+yh
	+2/sXvefJBcfQ0PWhos3tDe4BhzBGc6soUHe3GptXqA2niCOdET4qHN1tCL1nVlCENewE=
X-Received: by 2002:ac8:6f14:0:b0:51c:b98a:2448 with SMTP id d75a77b69052e-52df56f9741mr33277701cf.9.1787286396764;
        Thu, 20 Aug 2026 21:26:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.115.103.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52df42408ebsm10770441cf.21.2026.08.20.21.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 21:26:36 -0700 (PDT)
Message-ID: <6a87d37c.c927a5f4.1215d7.1eb0@mx.google.com>
Date: Thu, 20 Aug 2026 21:26:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8551510564631297657=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, daniel@makrotopia.org
Subject: RE: device_schedule_reprobe(): core helper and conversions
In-Reply-To: <1b051bb8145febf69cb33d9e8a83444db079e8f2.1787281239.git.daniel@makrotopia.org>
References: <1b051bb8145febf69cb33d9e8a83444db079e8f2.1787281239.git.daniel@makrotopia.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8551510564631297657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149424

---Test result---

Test Summary:
CheckPatch                    PASS      3.98 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      1.36 seconds
SubjectPrefix                 FAIL      0.56 seconds
BuildKernel                   PASS      27.88 seconds
CheckAllWarning               PASS      30.35 seconds
CheckSparse                   PASS      29.30 seconds
BuildKernel32                 PASS      26.40 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.81 seconds
TestRunner_l2cap-tester       PASS      65.90 seconds
TestRunner_iso-tester         PASS      83.60 seconds
TestRunner_bnep-tester        PASS      19.21 seconds
TestRunner_mgmt-tester        FAIL      221.72 seconds
TestRunner_rfcomm-tester      PASS      25.46 seconds
TestRunner_sco-tester         PASS      36.60 seconds
TestRunner_ioctl-tester       PASS      26.30 seconds
TestRunner_mesh-tester        FAIL      26.05 seconds
TestRunner_smp-tester         PASS      23.47 seconds
TestRunner_userchan-tester    PASS      20.58 seconds
TestRunner_6lowpan-tester     PASS      23.63 seconds
IncrementalBuild              PASS      30.46 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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
Read Exp Feature - Success                           Failed       0.255 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.908 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/627

---
Regards,
Linux Bluetooth


--===============8551510564631297657==--
