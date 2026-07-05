Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7AC171CD
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2026 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783294910; cv=none; b=WgbOc+0dNwCX3jQqzNygvfWCDLQ7wS0lC1eOKuvkiuu/vi9t2soYhTlIkCf9Bl+UDDZcX2QCGFqAz5IdytH32OdcpP2Oc/aNVHGQazEBosO2n/kIcR9StM3Zn0TVo1rorXz0GJGF6ZXPZlAvQxxiyEb33Gr/2VwILjeTiYBr1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783294910; c=relaxed/simple;
	bh=a5AMoGEx5Bb3Ur1PIr5D3lBVH/Zv4KDhbGYvXNrDHW0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XspL8F8RSZHmymAc7ImJnUOKxNeud9POjJ+RB0eBJpWZWfw1CSft05iKRYEqCXib1766XhCTht9wfJop9kRDBoAk2cYZWPdrSifJE8jUJDgT4u2xy+6GogOslZOPSDmqru8jooEwtnrCS3MxPdSFZifPmJdrbjUIlL/5sI4MYrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Otz9on3D; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Otz9on3D"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e6c4a867cso140686385a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jul 2026 16:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783294908; x=1783899708; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oH077+JNTWjCYEg3KDuzKU8NDH5vMgCaLbNI5ILet3A=;
        b=Otz9on3Dc1Zve2hO4bZBJ9F92jeU6pvATccqSFUcxLqdTOSiTBHTyvl05m1mzJP0iY
         gFEQW+W31fpHMWhVCYk/9w9mmR5wkQc2zMrqXtJaAeoNNACLZtF8rPfVTlfOXVswtDox
         MOczHxYFXT65bLJv2C5hGLd0HYgNTyP7r7RyvnuuTE7of6Qw6c/I1Ti+sThlmivGelWB
         4DcQFZaUFI9HfqY6RmlpXkKhvDxj5Xq9N83sqq1+iWdlA/ntCINmoEjWy/Fp3MBS8Oo8
         N1W06fVzznMOSIuscmt3Pif7JObnClj+ilOtqCrPdVlQMXohh/PWGB2rG1zIfGoNz8Mf
         bhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783294908; x=1783899708;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oH077+JNTWjCYEg3KDuzKU8NDH5vMgCaLbNI5ILet3A=;
        b=BkGwZR5WCFZBy9jl2C/v/4ph+aWOKgEKfx1fwwmMdJO4jtBD3fxS24fs7vCpfWte/Y
         4KrJwh0E7jKwmgpMHFMwrMBEOzFysaQ65HUwDw1Kbld71aR/SmUh8TtZjA89N4qtBnRB
         X4keqLifn4s9VAn//7MBgiy+W8XEKicL8VzWJqMWu4k6a1AvC0GB8S+QLC/7K91LkA+e
         xJhFl5//n29HqnrOOEgnRTzOnYblPVDAIXj4OoiOQ7Pq4x+OSL4h+l7V2KMIUyyyythN
         eecTDJK9tNbolYMuxiI0YKKSr+8u8aXHywQ1pV0kOLHVrPl08HeaOoBpjonPQ57wvl9f
         3R9Q==
X-Gm-Message-State: AOJu0YyF+4fUe9bEjv56JOznL3fSWrwL/c9IDd+Z9trJQ5w99ZAtvYPg
	yTMSNWaxzqVDwrC9UBx9ZC4GExyGeAXgdbglCgTLcn18e215wdmUktLv7CArvw==
X-Gm-Gg: AfdE7cntbUv3BXX4GFmk+PAtL4jHeIWXEfm8UtC/pmNsMKMDVhue/OkXai4bfIcFEaT
	A2GaU497stXCG8DL86mfUIFA/lkMh9hbvPM/7VKmTMd7CObPsWp+e6noaYWnuvDV5/S7ZqOVe28
	UvPx943kDXpkZ7yTY9Cn6SyqHwwhAr6RDPwpbuc7DI0IoPO/csc0nmkwugGcOMfBY0hl7Y6cZmP
	OCZ+zpYOqAjyAWJ0r99O7tQPPu1yEZr8q2876crOpIZMoLwbVw8QUtKV8hie30/lqcfA801ZYBv
	W9xTOBrZk1cb1iWcT1nYuPhsy3/Oxs2DwjLTsU+pg46xcxmn8TMU+clL+jnE5ccN3mHYAfZFfoA
	ARTGwX6DeH8ykiYlA04YWXnImzxWiYhWNc5wFifTRGxL3QjP8eBtaYshnNWbkGlShp1YpbgD6/p
	CWSFtgGew3rtoYcsvXtANF
X-Received: by 2002:a05:620a:3728:b0:915:675d:a2d with SMTP id af79cd13be357-92e9a4caaf5mr1141194685a.51.1783294907706;
        Sun, 05 Jul 2026 16:41:47 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.239.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ca004fsm775729785a.28.2026.07.05.16.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 16:41:47 -0700 (PDT)
Message-ID: <6a4aebbb.efad125f.14a0a.6a02@mx.google.com>
Date: Sun, 05 Jul 2026 16:41:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5156927609609963550=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: fix hci_conn lookup RCU usage + holding refcounts
In-Reply-To: <4853db33fb044122e1eac76736c5cd0529d13349.1783275015.git.pav@iki.fi>
References: <4853db33fb044122e1eac76736c5cd0529d13349.1783275015.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5156927609609963550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1121912

---Test result---

Test Summary:
CheckPatch                    PASS      2.79 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      2.28 seconds
SubjectPrefix                 PASS      0.47 seconds
BuildKernel                   PASS      25.45 seconds
CheckAllWarning               PASS      27.97 seconds
CheckSparse                   PASS      27.61 seconds
BuildKernel32                 PASS      25.65 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      463.78 seconds
TestRunner_l2cap-tester       PASS      58.97 seconds
TestRunner_iso-tester         PASS      79.59 seconds
TestRunner_bnep-tester        PASS      18.91 seconds
TestRunner_mgmt-tester        FAIL      214.01 seconds
TestRunner_rfcomm-tester      PASS      25.28 seconds
TestRunner_sco-tester         PASS      32.49 seconds
TestRunner_ioctl-tester       PASS      26.07 seconds
TestRunner_mesh-tester        FAIL      25.98 seconds
TestRunner_smp-tester         PASS      23.27 seconds
TestRunner_userchan-tester    PASS      20.07 seconds
TestRunner_6lowpan-tester     PASS      22.76 seconds
IncrementalBuild              PASS      34.18 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,2/4] Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync

16: B2 Line has trailing whitespace: "    "
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
Read Exp Feature - Success                           Failed       0.248 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.662 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/401

---
Regards,
Linux Bluetooth


--===============5156927609609963550==--
