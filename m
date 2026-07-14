Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C03749F9
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001585; cv=none; b=c+evB5lul4Tr6i53SP/ckKYtEOkab96kdxxlU5XsJU5RXvvBjtfAeSbbVbV0u6pOB0chFUIXJ0XqhCM43s0fYcUycnN6qKTMBsU9mtn9Lj35T8X9upa3Gc5NoCJBSMrig1THcvYKdlvjdIvR4ZzYJGD6HI1djG4N3M+W7/ucIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001585; c=relaxed/simple;
	bh=R5s3KxTbOnwGTOZKB2G9l50jNKMj54Zq4O+kO691mFo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GbpSRgNqqmEWkR2xr0DmYeTUOxPV5+e3Qfi4WF2pWGiLfdD9k2OmSgHvJN8t4YcgkVXrCLNs8lWw8+a/2he+gEutJx2aTehPLO4aIj38YG6U1tgDq5+HM13cahgiUNaNpOW+U+v+Z8Be4FuHK2UzsaOGN6Zg3gXL4vBHUoLClSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akkPm3Wc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akkPm3Wc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso40735565ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784001583; x=1784606383; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CtuNDbZ7GPa5ALVUMaPh+qAhZFolJMAr10JOLzT87Dg=;
        b=akkPm3WcZEzpD8cDS4403hbT+07qV8zDoHLnIXuaFyImygravW0i+5/mToYNbjhRJh
         vqcx1G204nazBAr0NhoZNXVeeoalbgI+FAiTRmY6fuOYVJc9/Nj+wlzqVsq/dC2/kHfw
         nzCFqSKm86dxn+bdIQ2/oFqgrHdi4Nr0RGiN7386TBC24givdbwjf7uoOn7P9Lh4Hltu
         6nyyzYq1/fJaHzqiHyDDspyhO+JbML+u4onvIorMHbUfudtCdvOIX3ZT63ExhLNa5Ulb
         mq3tvV41SCPfrV9qYTMwcPQr2QSbVNWutrc+fVQTcR0Hao1h6T7LA+ReRSoUMNC0Ks3i
         694w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784001583; x=1784606383;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CtuNDbZ7GPa5ALVUMaPh+qAhZFolJMAr10JOLzT87Dg=;
        b=aoQyFsThNVIxa7X6MQZpRMUFZegVWXq9jBNXd/NBvKet8BYo2KeBFIZRH4oNyHE5RG
         81YnxcgwSB7Pn3WKauwx4XW5C2zHjex3a3GKBH7aPuP6H2OHUuoV5LmGLdpfPJddd9Xi
         TYmaevsXzNyRCx+YBA84uDnlTBP5PcokXASiHTas8gyX9vFRMmLoDACLBmatCkxjEhF5
         lPGKHWVYlwpwBuOX9icuYu1nVhkXA5aF83/qldianGby2jw6UcuNt60DfsHc38//VPG4
         T7Zs3tDHxh4ukIYdsyFHOtmYq6hsJbdVHjj/dXO6/re+jXqIGil7si0ZMvzWhDAlFEou
         a1Ew==
X-Gm-Message-State: AOJu0YxM8r5V7BAgPsDUo0QXbOLDA6wwfFZo7eOfSww07HSiygQ8q22g
	j2dpSECl0WFQOIVI2SgXEvjf3p/quNelLhbmneM0Wz9tjY2D4KVfPc4iz0AAAQ==
X-Gm-Gg: AfdE7cngFRZYns8hYSXwigWNKqkLHW37nRdfu9QSrdtoTzYuvIAivgOd9KU7faTR48k
	QjDPkSwcNlwtxxSkTPHMOZq5jKLHFvcr4ZvEEmaAfKWsuWdQas1OeibeEnjO2Jvjs8qmcJrFu6o
	+nSBRna8iyUfgmpfUyPDqT69hnKc9AcE+gKQQzz+7UBagESflfUHxNCQMPwcQsuiDehc2A2VTrP
	hsC9vlffx9G2c4i1cYGkzlnug46vmiS3KPmnJPXNWRKrOLq4fWjm4TnFoAdwKK4d8De+U4+upfS
	mZdy8a32dI3PVSmtMmbnblYSVSQ5vO+esNs9/vYsF8SKmtaoKqLH9zPoP4RPCbuxCQNq8D1EUmM
	jPWyFyIBVxlwBWwndtfLC2t8x1qzkZEnynLwsfkCg9U1WsGW/zOKh8hwp/o248qWHonmaZZ4pm/
	pQ/srMAYMK/6PLEIqkctY/cQ==
X-Received: by 2002:a05:6a21:e58b:b0:3b1:882a:607b with SMTP id adf61e73a8af0-3c34d583262mr2602826637.22.1784001583170;
        Mon, 13 Jul 2026 20:59:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.210.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm81480492eec.0.2026.07.13.20.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:59:42 -0700 (PDT)
Message-ID: <6a55b42e.510f576d.1b3cb9.443c@mx.google.com>
Date: Mon, 13 Jul 2026 20:59:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4038020521529859069=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 294305068@qq.com
Subject: RE: Bluetooth: MGMT: Add length check in confirm_name
In-Reply-To: <tencent_406D2B6F64B41152DB435F3A88E40205340A@qq.com>
References: <tencent_406D2B6F64B41152DB435F3A88E40205340A@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4038020521529859069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1127042

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      22.68 seconds
CheckAllWarning               PASS      25.41 seconds
CheckSparse                   PASS      24.71 seconds
BuildKernel32                 PASS      22.49 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      416.57 seconds
TestRunner_mgmt-tester        FAIL      204.83 seconds
TestRunner_mesh-tester        FAIL      23.76 seconds
IncrementalBuild              PASS      23.30 seconds

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
Read Exp Feature - Success                           Failed       0.234 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.974 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/434

---
Regards,
Linux Bluetooth


--===============4038020521529859069==--
