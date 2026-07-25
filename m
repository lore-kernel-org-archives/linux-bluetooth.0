Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196733DA5BB
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976631; cv=none; b=oahfkeaLPSHTRJmoP2boCiNLCx2sTuesnyPE+sRTJqmFXxbzk7lKu/zJrIvIdv/l4IWPk2xpHWwki4e1qBUUy1rerwCinnFiSxi6nDP9HiXOEbJkgROXgTYHkHJXjKXwNcJIvN3p9UMEV+Cc+RNYBiIkYdRg46mJkwAoKkwUyU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976631; c=relaxed/simple;
	bh=eo06g09Z3yMEvh9l6m5ZXCENLTcD2WCCg6H0s3OS5iw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b3M0Zi0oGCWfoJ1S7vlq2cQ4FAAvGtfoHmyp//4KTbonA5CxVlrPdRQyse4bp3ndu1vweLCNvQek6m4WX9o6HvIR2W4km9PtgKoqVP76G4zA1isO4MK8mlAO4RadCcGsisu/Zs2B6IhJx2o9T074To5SCZyE0+ZziJ/8XfguEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvp3DAyS; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvp3DAyS"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ff20870ac7so11371086d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784976627; x=1785581427; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q7jcYQSnKFnUtMzQxjJbwRHaXW6AaQvrX9Lq44Zrs4E=;
        b=Cvp3DAySUmlhJcILVc6u18rVBj4FS1Yoc/lc32hdwls6GM+hCDugKfMBQdJhtQR77u
         ooccbErp7Pdz5cY6y5A0iSKpTC2H/bPaTS9HXkZ3f/uclLV9mtFsrIMeag3W2n2OJtax
         eqMG2f1tPD8pQFlRWPrLJm9YRPw8DxlofNG0ZrTtdScxxFqOKQxluYa9wzcGfXOpAelJ
         quCe3IdY0IC+X1+mX7x3wwdq/3PsaVTFx5Qo/C6UpP3igdbU+pANKKs/d08Q12KtxY0S
         ksH/uCrhJwoV63Ly91ZzSYaImdamV/t75ZXNPDqA4q64jfRQt2sKPtgKguTw9ANYR1ns
         WUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784976627; x=1785581427;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q7jcYQSnKFnUtMzQxjJbwRHaXW6AaQvrX9Lq44Zrs4E=;
        b=T/xyquIl3AcsmByuE0wL4fTy6TY+wbJshUgZ4Ze4iqAS/85h9tZy/Wy+/aqmZ9Sbwt
         +kL6TPP4zlxOwI8B8dcFd/Od6Dok0njvOgz0ogKlEvjT+TD7OK+xIM2PuRmftrEyMarK
         EnisJ3NHMawq5wj9s8d2U3B+SG+k5jypAFUpypzqiowHiyI36+NzTD1FVo3+7Ck3iQb1
         GqGPBGJh3JQAKsgefqphSPj4dgg63WSjiMdHWL3f43FkCdx4QaEVBfa6Th9Z/ScRGnxZ
         aTEqP+wPs/aKOUwUYftZchtaVSRqkG4HOeR+a82LZcVNRtX1yfJYruj0FYS7d3xwTZhm
         B++w==
X-Gm-Message-State: AOJu0YxV1eWZRlXdts+xHdoHhwJwiiXZcnrBGvvy2OEDsyfls1jjLUpp
	C34bYfy8jBVo8p+mlPKT8hjvX9MtUTXCQS25Z/ylKUNF6i/FtToo+JE902+hzg==
X-Gm-Gg: AR+sD119Fjem+QE66DeboRmMb4GC3ay2bJzymOyyjQq69cKBmIz0TqyxiJRuL2DBS0X
	zbxeqY2Nh77g4TfJOJQeMk02g3SrFvXpP3c4fTKM79koUixAPnH2t/Z814QPeN8dFwxbjhxOttU
	r49OtqqTKwp1oep4OGzLG+N2vQGCcL/7OLHck/A2LkdTEiP0zG5odQ06ZuMFHuLffBb2lrUjbLc
	Gmxb4IP/+i3gvqVHHdSWGw/A9fRESN8v3tKCTbBKEUM5briXJGmn5tENN/F2abfYDe/VvErd4bO
	PHx9+83IUaDilQld9I2hLDT/ffBhubkhvOyy297CMEF444NNWI+xFsZE0N6HqERJaEdTf46euOo
	4Rdgdy4EZhpuUS3l39fY4qLlBx+FY6NdpwQMsGUzsCbHs7eInqivy+oGgaWNxJr7vq8PIlrZLms
	d/nJu6p9io
X-Received: by 2002:a05:6214:43c3:b0:8f1:440c:7f81 with SMTP id 6a1803df08f44-907ec7959e4mr18611096d6.4.1784976627507;
        Sat, 25 Jul 2026 03:50:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.23.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e8522e88sm18336116d6.1.2026.07.25.03.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 03:50:27 -0700 (PDT)
Message-ID: <6a6494f3.4eff4424.beb99.6b23@mx.google.com>
Date: Sat, 25 Jul 2026 03:50:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7766341149649690677=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_conn: hold conn references in hci_sync tasks
In-Reply-To: <2cbcaf1f4ecc03601653eff0763c07c41c901376.1784973264.git.pav@iki.fi>
References: <2cbcaf1f4ecc03601653eff0763c07c41c901376.1784973264.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7766341149649690677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134345

---Test result---

Test Summary:
CheckPatch                    PASS      4.97 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      2.26 seconds
SubjectPrefix                 PASS      1.85 seconds
BuildKernel                   PASS      26.83 seconds
CheckAllWarning               PASS      29.51 seconds
CheckSparse                   PASS      28.39 seconds
BuildKernel32                 PASS      25.84 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      491.84 seconds
TestRunner_l2cap-tester       PASS      59.36 seconds
TestRunner_iso-tester         FAIL      90.00 seconds
TestRunner_bnep-tester        PASS      19.20 seconds
TestRunner_mgmt-tester        FAIL      217.48 seconds
TestRunner_rfcomm-tester      PASS      25.19 seconds
TestRunner_sco-tester         PASS      31.40 seconds
TestRunner_ioctl-tester       PASS      26.32 seconds
TestRunner_mesh-tester        FAIL      25.89 seconds
TestRunner_smp-tester         PASS      23.55 seconds
TestRunner_userchan-tester    PASS      20.01 seconds
TestRunner_6lowpan-tester     PASS      23.23 seconds
IncrementalBuild              PASS      43.48 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,2/7] Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks

18: B2 Line has trailing whitespace: "    "
[v5,7/7] Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync

1: T1 Title exceeds max length (81>80): "[v5,7/7] Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 134 (95.0%), Failed: 7, Not Run: 0

Failed Test Cases
ISO Disconnect - Success                             Timed out    2.653 seconds
ISO Reconnect - Success                              Timed out    1.995 seconds
ISO Reconnect Send and Receive #16 - Success         Timed out    1.995 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.632 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    2.004 seconds
ISO Broadcaster Reconnect - Success                  Timed out    1.971 seconds
ISO Broadcaster Receiver Defer Reconnect - Success   Timed out    2.417 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.249 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.648 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/493

---
Regards,
Linux Bluetooth


--===============7766341149649690677==--
