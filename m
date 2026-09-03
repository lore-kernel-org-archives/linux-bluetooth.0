Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A94DC531
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448932; cv=none; b=KGXTfINnwXJqNAnvJElMeBt9yrIvLvY/vWZVdc9nsml78B5BisFRcRlEwcfMSfxx8WUWjvoDtX9UTnHLGO8VtkJgtkAqTP/QB7fM9nGhMlMhyzjPCCmge0vSZMBmLuFymZsSQxi7MU5KQuBex9D8ypQCyBQFXj8Zbb1HWIG39w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448932; c=relaxed/simple;
	bh=bg5TTPGUnElBsCFlb47VSnIC2hU4XW/XmB+GahcfK+U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EC7GOQhX5UFr2Zf7HrpzXd6WpyWGCy/DsgmRY/S+GWZ10yubmLnyzxm8fngN2p4QjYloq+YM2aWqpLIMmqCiwWYg3iw9/3FgcQATmJAs4kMirgo8bc+TfV0myDO/P91Nr+xkECbwFSHpVSZbXRLu+SPtvOwOzUARI5ZIOC3jtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMD48F2l; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMD48F2l"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38511175ad3so2525574a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448928; x=1789053728; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8R5DbYqrT00huqgGBeYpvbCJj22li/BwiZN9Ev94gWc=;
        b=DMD48F2ln1bQViuDxYI9TagCTfF54PNbqW0+0e6aYf4X/GlRROmwkNRG5cOMMRhA09
         qDnGmWd7ApvBa2kDV8Au+UzHI/TUQ0rrsdRbst7w8F5PihCfFqp6fRQqoNyqi7M9fTM0
         NDcabcFxet+shcahoJZFoMoK6mK6E3rQNT+QGHM4Ao1qxQmbLT/Vzhv/jznlx0QMGRSf
         3jUo/EYP3WjZ4zRXe3mBRhaIry7dA1pXMQ2I7x9C430pQ1Ce1E/H2Tddrrfs8TUb9XQP
         yNE0ZlQhDey8rU/ky8oKGclYzr4OMMUErmTUPOjPd+4vLIiooQyixUcXMPNvSaqXwVLL
         5Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448928; x=1789053728;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8R5DbYqrT00huqgGBeYpvbCJj22li/BwiZN9Ev94gWc=;
        b=p2TTNgFV9dJmVCU1kBzynYj5VLd9wVo3QYrOjNsTK6PhJ3gznjHsVl8Fr53jjLrQR+
         YjWqwnXE2D2rZZ8YRtYI78t9MhRBhJvoBgHlsrgagJJtUr7/EfIkAoXjkU+B85x12NVt
         V8re3cAXe120OzsFqSOos7QT87vUcH8NljC9EOLCRHB//YCMktG8L+1/bhYsEt6XHKxV
         75gIoqWY6Eub/5O7kYEXxyqKrVqKrTOJnlCAyPPgDMhgNltd1skmKzkud7h/05gOzcbg
         E8LOlNDaWiaJP9A7u8V6JUE3i6Z9reDK/N4rGH88jSSrtOLa8J6Bb01mGXteE57Uyq/U
         99Kw==
X-Gm-Message-State: AFuF++lccdP1qrVwIhENiH4ppPht0vrVi0DrwOqWYQgwDeazEBI8mb7+
	uWo6CxgI8vRilW5x6sp1zG+iO6MHs+SdRWheiBSQqw34txRwsuPQyz3P32/q3A==
X-Gm-Gg: AYBFou3hY4jxCMiaUOfYASx78nlT5kJCEJ1nVgnmoQkxIqPdLKw46ulxdC0saWbt4WS
	IBQf2WNI2UcHMhT3zl1zgCf4BUDoJovK8qyP0H1FiafhnZGForTO5fxF4KbDUq52tTmcv3piu6y
	lFie+YhINAHmzi3qe2gjMp36NG87jOC2eP5FDIPMeoFXq16DYXhMCanLmbZ1NpOSxxFpIM0WGET
	Sl9iiQf2+jvs903WDzpDKmfABVR0nG6u2Vxj0mAEYjA2sHbU8ZEKU7e5uZRYgtKCGsoOkLsI+PB
	mfS6UsVhz1qg62NRkhSmGgntVLbrSKKgCHMBY1Rwx7F7W0BTI+IUm3ELRlPh6Tqet+2LQfV+nqJ
	eOCHC8OwHZ4+S8BIIprBuM/rCwdLyduWFs5QM7M6eIeD3HQt+e6fU8vzI3UN8wv2/vdPRl/DZpc
	I4cuzSTHbvKYVfGooAEaLvF/37PnUzcjBPeewzW4LToA6DQ5JxE+jn8hxojyiO2kFeWQ==
X-Received: by 2002:a17:90b:3845:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39aee16ff3amr16786762a91.13.1788448928453;
        Thu, 03 Sep 2026 08:22:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.22.164])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243e6ed1sm212888c88.12.2026.09.03.08.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:22:07 -0700 (PDT)
Message-ID: <6a99909f.af6ba3ed.37f763.0d07@mx.google.com>
Date: Thu, 03 Sep 2026 08:22:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8349203288454801992=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Andy.Chang@synaptics.com
Subject: RE: Add support for the Synaptics BCM4384 Bluetooth controller
In-Reply-To: <20260903121824.3080796-2-Andy.Chang@synaptics.com>
References: <20260903121824.3080796-2-Andy.Chang@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8349203288454801992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157073

---Test result---

Test Summary:
CheckPatch                    PASS      1.36 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.53 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      24.28 seconds
CheckAllWarning               PASS      27.13 seconds
CheckSparse                   PASS      25.59 seconds
BuildKernel32                 PASS      23.75 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      435.22 seconds
TestRunner_l2cap-tester       PASS      66.25 seconds
TestRunner_iso-tester         PASS      108.36 seconds
TestRunner_bnep-tester        PASS      18.19 seconds
TestRunner_mgmt-tester        FAIL      225.82 seconds
TestRunner_rfcomm-tester      PASS      25.15 seconds
TestRunner_sco-tester         PASS      34.91 seconds
TestRunner_ioctl-tester       PASS      26.29 seconds
TestRunner_mesh-tester        FAIL      24.85 seconds
TestRunner_smp-tester         PASS      22.83 seconds
TestRunner_userchan-tester    PASS      19.66 seconds
TestRunner_6lowpan-tester     PASS      27.35 seconds
IncrementalBuild              PASS      25.38 seconds

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
Total: 501, Passed: 495 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.256 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.412 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.833 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/695

---
Regards,
Linux Bluetooth


--===============8349203288454801992==--
