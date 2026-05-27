Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB83F54B1
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879584; cv=none; b=d0k3/s5nZakjJviqjpjrIvHXvkGtBIwjVeJkGpHRvXsvqzBkv+yfdgW4Nns2qwmxocxBDZ/LyOG0RieeOHcOXbxcvkaixPxhVm/fLhtt7zyeAvOa0OOidOwbCRA0YRZvJALvPD2VkCGM0PTiI8Ly2aFChqjiwkqAHD2fgOvXeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879584; c=relaxed/simple;
	bh=0XzNn6FFIR2ezKvMeVAnLmEt11z0ivqfHiMHlyUIBus=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AfoBfOqvZVMIA5cBe4T3N5eYhhSxLHsctBo/bXx8W/c8SmcdLeYcBXuvJqFZC2AQrFNi1pXTqZPNzZQpVbRvMdiZWJVub9B6ERp2a0u6AO2vT8ZfWbTle4pno15tLVvVk4TGuwn7YeVBlMrHc7G6eOnnrsipv6Z5A+/RXoeIbjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bObiq0rx; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bObiq0rx"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso4725345eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779879574; x=1780484374; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/+C6ofZ8sa2H55EvXUaDx3cottPu2QOIDGqzLaJyCs=;
        b=bObiq0rxJOyikrwPK/j5Fa8i0iT1P1c06s0z10IzsMl1uNOFQq0mHrdLsINzH/YPhQ
         EnBEVbZh0fzaXyhHSRHo3N4/+voyCpbKSS7qZcXkM+ToDlkdUrXvfjcxzj14VThZdIiJ
         +EuJsuLaIJJUroBq2PuqRnpSvLcwmwcu8ebX6PD303KvwZxWrxo0UnG/bVhFQshpgOiv
         QQzxgDW/u/A7Lqbxu/3b6cpP2tb1NaS7rCnH/5IApC2/1x3EvxTMZ0RQC1c8KQs8yTpW
         knSro9jVZsExQv2QCXF7dj+4rciMrfffmNVjRalUSDlA0f5zE222H087vNm7H1B45jME
         t7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779879574; x=1780484374;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/+C6ofZ8sa2H55EvXUaDx3cottPu2QOIDGqzLaJyCs=;
        b=qqnPjAT4f7eqSx1VfWgMFwJcRfeA4gg2RI7+aSBy8YL/HeR0kzSwm8yFCRXQiESgq7
         OgW9aAHFwxsC991y/poJNBvd2hFUt4XUQBjm+FnlNri2nh+DXnvY5dxZNqu+CKPBZqGo
         ulu9DRsQv921lyxdgAAlF0Ek28wiuUGJmC8HFDx0nt8c9wgA6q9DLNhJNE4Xq4BVSmwP
         +oh2Y73P/cGD+cQI9uM5c2l8hnVWDpIOC+eUqouE4L40eCouc3WrAAa5h7/ZDRc+6QJS
         ch2lVi8KQJ56TZRDDHcKb6v7X7EUIhOFEnPruFnqDu+1aDbi1lg/Ng4WfC+U6/60r53Q
         bpDg==
X-Gm-Message-State: AOJu0YwLHeD5r8JBWLaoKTQJub5vyBukzfGvuO6hKEYy2dcNyyXqB+J5
	fhnxfxn9/txKzECZiOc9PdiLuP39hGsIA5uAnTJjDMOKsL9suo53en4V/mZJJQ==
X-Gm-Gg: Acq92OFNHO3/9sJBFAf8+cyIraz9cEObJRtKFFqJasDJanzvMhX01G01yex4JRRSRCA
	LwT9P/A8E4MVZH3TTFGB2GBl2aeVAvChNBHKjuhIvQ0w8oEA0FX/wS1vXpimTGxEBe4/bK4HMuP
	KLsgdGku3Li3kDJmXGTsW+F7v6BJRCm4PjTyEH8COYMFvwTRM2sCUyI/GzCQq7ACNBr6xfalhwO
	OJ9+sSeMbGOu3kHdoRVMJOWW1YRee7IJkorURMzYssquRuO8InCAegyo5JRU56IA74VDBg+XdDj
	/cFjvI6AD14rN0bbhV/sJZVBtqy2Vq88MAi6x8Q04AQP/wQsbttz5zeNVCp13cpbLkPsVQjjn8d
	mBBHNYosykcEhoFAcy+MvUo8zgxug1UZSxtvEu2AU/ETN/4ztvd17YO9BVhfAaC/aFJGgfvmnSV
	A9MsN9Thig6bTJRuYvITgBw6mbuXcMh13LdlzmdKm4
X-Received: by 2002:a05:7022:525:b0:128:d4be:7428 with SMTP id a92af1059eb24-1365fb4fa18mr10110723c88.19.1779879574133;
        Wed, 27 May 2026 03:59:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.51.219])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13669c6a2adsm10321437c88.0.2026.05.27.03.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 03:59:33 -0700 (PDT)
Message-ID: <6a16ce95.c5bd3d48.2d947.68cd@mx.google.com>
Date: Wed, 27 May 2026 03:59:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4575210176507655026=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaoyz24@mails.tsinghua.edu.cn
Subject: RE: [net] 6lowpan: fix off-by-one in multicast context address compression
In-Reply-To: <20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260527081806.42747-1-zhaoyz24@mails.tsinghua.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4575210176507655026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1101476

---Test result---

Test Summary:
CheckPatch                    FAIL      0.58 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 FAIL      0.08 seconds
BuildKernel                   PASS      26.92 seconds
CheckAllWarning               PASS      29.05 seconds
CheckSparse                   PASS      27.15 seconds
BuildKernel32                 PASS      25.60 seconds
TestRunnerSetup               PASS      572.33 seconds
TestRunner_l2cap-tester       FAIL      58.33 seconds
TestRunner_iso-tester         PASS      79.66 seconds
TestRunner_bnep-tester        PASS      19.58 seconds
TestRunner_mgmt-tester        FAIL      224.69 seconds
TestRunner_rfcomm-tester      PASS      26.56 seconds
TestRunner_sco-tester         PASS      33.37 seconds
TestRunner_ioctl-tester       PASS      26.48 seconds
TestRunner_mesh-tester        FAIL      25.91 seconds
TestRunner_smp-tester         PASS      23.48 seconds
TestRunner_userchan-tester    PASS      20.47 seconds
TestRunner_6lowpan-tester     PASS      23.45 seconds
IncrementalBuild              PASS      25.25 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[net] 6lowpan: fix off-by-one in multicast context address compression
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#113: 
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#114: 
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#115: 
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#116: 
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#117: 
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#118: 
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1

total: 0 errors, 6 warnings, 0 checks, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14596745.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.251 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.260 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.497 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds


https://github.com/bluez/bluetooth-next/pull/249

---
Regards,
Linux Bluetooth


--===============4575210176507655026==--
