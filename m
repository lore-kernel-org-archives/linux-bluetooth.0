Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3324474262
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270618; cv=none; b=PlmfKI2phhhwMob3v+piFoWJGBm27/yCQ8ONRO+qqftRryd2LACpifnhxaqFc6EI02dX1AxtmUPUTgjZ1UvpuTnVyGsl7/EWgmkI2HxH6cto2+GOW3FGIHYt5SjfuoceUvD6MTijrqtK4glTmAXXThqoVjrR/0vc9WxiU/T3380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270618; c=relaxed/simple;
	bh=grqotrpH1Kg3aSCg/ZKuhKIQ2lZFybYXZoq3/fS5aqU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E/jMhlw5WkmAcQvYXCBJKy4aJCvI3yubDJE0YkfFHzDizrraDH0RmJT1QpRmRavhORcw2DVnnxbsch+kZN89lgZ/tp4A6Iz3IwBBauO1rQu6Q6dVXk+qCY7L9EnPfYhqhKtGE8zMrKJi0lpMEQe20feTTKo1fJB0/tnoWLQXO6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXNJUzep; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXNJUzep"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc891373e0so3697695ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 13:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785270615; x=1785875415; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PhRHMGl8PlFNbjJFNwgPgvUy+NQ/qtbb0z1mCDGUfVg=;
        b=oXNJUzepB3mctq3wXHjnwkGHndPbf0FtQg1onV0dmUJ4rHinRvRdpL2qxHbR2Y6RjC
         FzOy9Xef6jfJ7V120vnHKC+qKeVf6D5o4zyV5QH1mJjw2IGFUWzKehfkxYe752prJ6k5
         zr66O2JUy+4IlMSlQDu/9R1JLQAtF/rYU7PJG8ek+PwB1ZKEn3NNyNw38Q/g0INtBTpx
         aXsg+b3YTd6ayA8PXRgh70XSBfcBZiWYDapOnYXMyuz0zeXu6BX8wonUliuefEhHfn7X
         fS9D2X6fcrFWJud/EtuVQcPCtnNzkfqJBI42+pLvIQC4uQO5DjfxlZ/i5f3SHO1jRyL/
         DxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785270615; x=1785875415;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PhRHMGl8PlFNbjJFNwgPgvUy+NQ/qtbb0z1mCDGUfVg=;
        b=d+rtPNthgadNtH8LfXRH6CImSyfiJ9I5L7bRRNNkyHWf3ElX+hkf1b5ebsYOlXPID1
         8zGrKvRLkKvo/YCxmOyZ8Zw7GmNNdMVzD+o0bTmUF7kPnwy86lPG6bTz0FpuIfBw9yc1
         UY6nKUWZDS9kbLUf66vqRnFKKyyvteO+P/D2OGwz1cln9tWs3zYRt7e+nMVkgjbE2eCy
         jyVBPfj2AcEEI02BGWE9XdhOyU4aynxsMMP6eiUcWUr1VoxQVjvvcahrfqAcUjP/CAJm
         si9ZPajluZJDKxbcviLyy6GEu9HdMc0a2l9pRcAuJak3zo5qGHXjgJVsejy3lH52IlWE
         SPTw==
X-Gm-Message-State: AOJu0YzQPdbI3cfno9nZjHHPvfn4SvLJa8oRmeRsgNIEFuAr0jRXY8nB
	eA9qifhukB+otg8iltlYJ1YhoF+iG9Doniq0QtuvI8sx6ZzajRMZvER3AWzYdw==
X-Gm-Gg: AR+sD115Lss2Ho6EXNV7UYvHGxrUy/odZYLSLZplobgGgp8sipqPWpvuZ6p4/tOLNEO
	gkL15443SqEfz6G5JPSZmodRZ4ZKCoVVJU+Vwl86FgKZhIv7YA6FwfdiLzALACRzcpzu9TFXyzS
	z3tHwZ8dbRdz7ow0ieez0mFLYFgdCxETcn0KbFRDL+GeYYOmw/zOc+BVqSTGH+M24eVe1ZFX2Up
	qq6rR4ZCfXIaXkknF1io0rfXWzqkoF8EWbcCkpUBv/AXKyqpeGTHNJVVb5/qgtu4EHV+uRH90IB
	WbzpzwedVEInVtxd/YyikvSY5713t5wfuJSQrwoHwhYHoDLaAybfc4G30SATz+hWWZnmjCVPdbY
	QDSUU5Oy9EXHHMtswjcdZZ+3ADtLn13BQQRLTRD7sdH0yN+p1sJ3vOoWDojfkd+hR0WnUiGWFiC
	JY5JooC0EI3wB18HzjVLeMIkOMqwui5SN5m+AOUL7WRxsIcZT5+ttqDLrEjzojZwgroGVb
X-Received: by 2002:a17:903:2407:b0:2c9:960c:f73b with SMTP id d9443c01a7336-2d015d22dd9mr47045335ad.24.1785270615057;
        Tue, 28 Jul 2026 13:30:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b670cfsm1774961eec.8.2026.07.28.13.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 13:30:14 -0700 (PDT)
Message-ID: <6a691156.21a19891.1e44db.73de@mx.google.com>
Date: Tue, 28 Jul 2026 13:30:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8215124910164255846=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] Bluetooth: Add support for Shorter Connection Interval (SCI) feature
In-Reply-To: <20260728182011.2334554-1-luiz.dentz@gmail.com>
References: <20260728182011.2334554-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8215124910164255846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1136133

---Test result---

Test Summary:
CheckPatch                    FAIL      3.94 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.63 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      27.22 seconds
CheckAllWarning               PASS      29.83 seconds
CheckSparse                   PASS      28.29 seconds
BuildKernel32                 PASS      26.08 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.86 seconds
TestRunner_l2cap-tester       PASS      64.25 seconds
TestRunner_iso-tester         PASS      87.98 seconds
TestRunner_bnep-tester        PASS      19.65 seconds
TestRunner_mgmt-tester        FAIL      227.70 seconds
TestRunner_rfcomm-tester      PASS      26.75 seconds
TestRunner_sco-tester         PASS      33.64 seconds
TestRunner_ioctl-tester       PASS      27.17 seconds
TestRunner_mesh-tester        FAIL      26.87 seconds
TestRunner_smp-tester         PASS      23.54 seconds
TestRunner_userchan-tester    PASS      20.04 seconds
TestRunner_6lowpan-tester     PASS      23.07 seconds
IncrementalBuild              PASS      61.52 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,3/3] Bluetooth: Add MGMT Load Connection Subrate command
WARNING: Prefer using '"%s...", __func__' to using 'load_conn_subrate', this function's name, in a string
#369: FILE: net/bluetooth/mgmt.c:8178:
+		bt_dev_err(hdev, "load_conn_subrate: too big param_count value %u",

WARNING: Prefer using '"%s...", __func__' to using 'load_conn_subrate', this function's name, in a string
#377: FILE: net/bluetooth/mgmt.c:8186:
+		bt_dev_err(hdev, "load_conn_subrate: expected %u bytes, got %u bytes",

total: 0 errors, 2 warnings, 0 checks, 337 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14716338.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


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
Read Exp Feature - Success                           Failed       0.267 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.678 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/505

---
Regards,
Linux Bluetooth


--===============8215124910164255846==--
