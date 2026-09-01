Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA545A2B9
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247633; cv=none; b=fsWHb/wiNqIU9fuA4rxsVlmndnyLojVdZWoEtrkNRRJ5GA7cmiZUHt2/GCuBFs21fOpHqdFLdXOgCPX/YSZX5vOuco+fpTRok4BbyPdPOgxdJIjhalpuP5/SP+BdrRAzFlEBSVqlBLurKVKfbCrH1SW5xVhQNlxKYquDL44+iK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247633; c=relaxed/simple;
	bh=dSG9Cpf6KmPvZ4iRqXZkqZ4IbMj81FbB9GSfx3lPJec=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QrSWvBjq6BATq61uvMHwxvOogxCy7ra2pBKQcuV4pWOZ3mauegrtdb1bghULKkeQKwY16wrIKwp9SqggzuJv2rNCdEvHcCmA5rSqt9jzZB67/7NOsF/BEXaVCb4T4NW9SLqhPgrq4bk7uafdrgQH5MuF4Gdom7+J4wyDWbQ6OcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPeAZoxx; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPeAZoxx"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9377f717879so39196385a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788247631; x=1788852431; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bzundgwn/OMMz/L2rsrTQM8EMFwh030EVy2pRk3OsgM=;
        b=IPeAZoxxnlXwAwN+j6w8j1ZHPWRLZjdPEhsbnq0iJGgPUUBT8paPDVNJj5wb+aupyh
         j3UWrpgvkpxD36TArT85GUUq4s0joz5YJPCudZQ/Oaf8zEfItYoJf8K1BZgcpOIiFkHC
         W1vGEWYmYwbEwIGoNanwEXvx0QSGVDP/s3UcCqacZp0ze5wDbsJQKRSiA9OYov45kX1B
         UrIUiPRuS8qYRc5Bp9KAVQ4ItYpOTngx0eGKcxEWvvuS2TA1T7PKiHliIcVfUVUKsng8
         JitgQwvkBEqtjKtqCch6umqLoEDBrHgivK+SQEvSZsyXhmaZRPDyQ3AVoOhZ6p1vhMdx
         CKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788247631; x=1788852431;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bzundgwn/OMMz/L2rsrTQM8EMFwh030EVy2pRk3OsgM=;
        b=SF1/j/e6fBXhGGLs0cFtf6y3G5R2/3iO28IzzpGiP0l8EEiBLec8v35MHLEtxXmKKx
         /EAMS7vyrlh85FXMy62IBuPqZa9PUmbpuhE/1LKWL6UNYLfqp0oQPMz4h8xcRRPb7qpb
         qjelKVEqU3rma8UrXRikDrIhh4LMyvXap9SLTFMm1uhI5LoBHGM+t0W/udLYA+aKlbIu
         YTp46o02Mwf7rWH7LxRZZaCqUCQv//vGoI+oU0ZSWWSQgNNGEXMrEdWYRrkK5QPCiY6T
         hRjYouYgmABd7w0WcgIWZTYrUg9Si+2bgSFBin5ewGI7RgXgv58zocigMTcC7AbqtOZM
         M9sg==
X-Gm-Message-State: AFuF++lkBxC7B1QCCQ5g7L9YcelW7IASkzSaMWdGK4FWl7BtpFpEo6Rm
	TN8oASVQw4EbHU4cma1rtoTwNhdzaJwyu2wWTWBOeXWEjbW3QmwLu9sUmlaKQWNN
X-Gm-Gg: AR+sD10o+rGgyfB2CS0lA+yVuWKoUseGO2WX+f1eQd3HJJ16u/wY2GtVtcizofdSWyy
	utvAUbImtyxOk/gRZUjUzQ3j5QHDhoPsrlpp+eik5u5ah0rH35hZd/XmDndEfIrLX/llt2XSUaC
	pB6DNon1ee3y//S9o3Ft6K/dUin3eh77xKUWjxNXCP4RdOgnwbtSsBrMC/MRDp+HJaqHQlUVHDZ
	J9cMXGUrvTOLsbjHA/s5DATXgD+OeXASyIFLMn9wE67sHcvkjw0zYX9RM7OAD0sl7GJZqcQQFcP
	OZK6u+SfGzuj0I8ma8LH6DFzduglUk93bsrkzvSFawCDFICofMsTN+7r8d5BF4EPfP2fUKTG/qH
	DdeHvoDIZlQmpymnCz1lVhlOKLVBQIZQear9Bq3dogR44ufM/CBaUlUjfHjXF3iHM8ijoaEgt3Y
	42as2hBn0So48jCRvDLKLooUlHepK1xFt5fgr0bO5DCneC5O24HVvOH+OWR3NgerZ0f45F
X-Received: by 2002:a05:620a:6b06:b0:937:3669:14e with SMTP id af79cd13be357-939137afa0bmr2772870385a.9.1788247630778;
        Tue, 01 Sep 2026 00:27:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.214.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391740b75bsm964532185a.41.2026.09.01.00.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:27:09 -0700 (PDT)
Message-ID: <6a967e4d.28258500.12f1d8.9b50@mx.google.com>
Date: Tue, 01 Sep 2026 00:27:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7977741310123963183=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: [v2] Bluetooth: hci_sock: Reject raw operations while powering down
In-Reply-To: <20260901020008.3846265-1-zhangchen200426@163.com>
References: <20260901020008.3846265-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7977741310123963183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154959

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.63 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.28 seconds
CheckAllWarning               PASS      30.17 seconds
CheckSparse                   PASS      28.98 seconds
BuildKernel32                 PASS      26.49 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      505.16 seconds
TestRunner_l2cap-tester       PASS      67.03 seconds
TestRunner_iso-tester         PASS      100.00 seconds
TestRunner_bnep-tester        PASS      19.22 seconds
TestRunner_mgmt-tester        FAIL      218.35 seconds
TestRunner_rfcomm-tester      PASS      26.08 seconds
TestRunner_sco-tester         PASS      31.77 seconds
TestRunner_ioctl-tester       PASS      27.17 seconds
TestRunner_mesh-tester        FAIL      26.19 seconds
TestRunner_smp-tester         PASS      23.48 seconds
TestRunner_userchan-tester    PASS      20.25 seconds
TestRunner_6lowpan-tester     PASS      23.50 seconds
IncrementalBuild              PASS      25.58 seconds

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
Read Exp Feature - Success                           Failed       0.240 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.524 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/677

---
Regards,
Linux Bluetooth


--===============7977741310123963183==--
