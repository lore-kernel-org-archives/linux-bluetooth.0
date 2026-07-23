Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881F350D74
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848054; cv=none; b=B2Tm4dtq7T6UbiFgY7VonHgUv22yYz1MxNKMiXOx5wmsNW84KVmokBsUihvA17RMU2T+yBcH8cCZG1/AnNHjvRrkYFs3xUnctPGVfwyUKY+4ULB6DbDSM1NZSrR2yHrusmHM1P2aHjzzaj84hfD9b5qPf1eSfZaMyeRK/NkbwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848054; c=relaxed/simple;
	bh=C4XWaP0HrsDbAiuAXu7VKvVkAwrxJv5aEL6U4HwUaTc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f3OqeDYHp1ySGYoqc30zy+5/U6ZgdDzArqssVTaht7QsWJeQgOjzYd5PAgcvAYLey9nGxB3g59WdioejGZQkghForHCY20P6qdX2sKjbL1SSiBCRnYpXQcJBU7xR2k3l7phEkQbxQLZ9wsuyX/BiF2e8Xt4Fxhc49EY5ZyKBDZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XccBjqXN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XccBjqXN"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so857831a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784848053; x=1785452853; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5bm+YXNAQYMuuffjF1cXXNQfNmMEOqf8Aq/LQrC72Aw=;
        b=XccBjqXN4unGf2UKrp4wbOtfP6lqhhOgERS4yFii198Ccqmo8mvFnHbPsT9XnNSkM2
         nKrfskvF7sqsO70uZ2n4VzcuTXQtwpYmda2suLDICeThOlxKDvhYmpXO7257S3QVzjX6
         LhU4uNO4UrNg/XymHChLKe6YRhnXXOkCHWUcDavur4S6NVyVo4sLPjQ+TaeGzr0EVyPT
         CsvF+r4xrcfMW7fxeODFBErP5UFExvgv5RJ0ut1GZnKwlRc6/F1wgucqRrdKcB4+0Dwn
         14InifEC02Q4RbPr1XFOXXkkYUvb+iS8rZGtSpuXgJ1FSULo5yl0oZljIIP8E/rH4AnZ
         AVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784848053; x=1785452853;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5bm+YXNAQYMuuffjF1cXXNQfNmMEOqf8Aq/LQrC72Aw=;
        b=KH+DCczr+rr+qst03d4nAQXcCrkqYzCmCIm+ufkddqHOTFeytuRehnC9DTRQtWdcbn
         +tDIoYHRLwjHVYtUS6IamKVkST2qMjyMv+34EGrMr37FvWNhlU7hPfqCs7kbX8DeYh/e
         iYzpdStKFvw9KNx7y3O4c4iZf5cTlGDKLajRPvh9OyFsOcnZ5t35jr4W2s+XkFmi5f11
         ZcXnzSysOb3iT242oN8JVxOPE50RP2wyNC4Lb+vYDlpJfmdzPzyr7PuvoRbDxaKf0lDt
         zwroHDDgseT02TfajcNSexVwOdNZ3fUw4tsB5FuyzZDAd5KiK2LGwudcEuU6fs6yjO7c
         MxCg==
X-Gm-Message-State: AOJu0YxPTFH6ToQ+o3w+NZGb1GehezuSZgFj2yGmEApGFd8GHq51k63u
	SgR3mB1GpDAXmZXQ0wHV2GOmJoeHj67lO3NUaRp/NSwvxd1IXxVMOMibgZAiuA==
X-Gm-Gg: AR+sD127sZpfSvZJ011Wcgx+2ZI6loIqTJ+XSfJgmgkvpCHVB0SX5z8Z0Vzn4XU3R/m
	H+lA1QptiwhRrqYzzIp1/yoThWMHyYgl10IcJxdjTbQfviboZnMqvStL4wnV/Wwln5d/e3rL+xJ
	2iQrQA/tXMegQQmaFHUrooAf5rHQApWebqRm1LcJFv5869R7ZVfUdcwSk2RpEth5KJ41ybSJ7sG
	cqsHJ3PERGucKiamDkATm6lcMHceJdlfn/+IpphanM5XUE5qhUkkTfXau2i/wagu572QE+xkIEr
	CN69uY49kQquUiVtmDjpAbb5/WZTutdWtcg1wwlLjTzXgNh+KEZQ4EgY6gA692yC9JEENbnXJRq
	A4RVrtIUpeRJLh83nlJVsW1in6a3WjXWVRh78E+GrLiS5yc5JFwBFMmZp37fOKmGYZ/HGWikCDR
	7bEoOwChub4g==
X-Received: by 2002:a05:6a20:a114:b0:3c3:791e:5e12 with SMTP id adf61e73a8af0-3c44b274079mr5948431637.72.1784848052922;
        Thu, 23 Jul 2026 16:07:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.201])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3149198adabsm13084489eec.8.2026.07.23.16.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 16:07:32 -0700 (PDT)
Message-ID: <6a629eb4.21a19891.105e40.2429@mx.google.com>
Date: Thu, 23 Jul 2026 16:07:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7246259258627453920=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: Bluetooth: SCO: fix refcount over-put in sco_conn_del()
In-Reply-To: <20260723221014.527674-1-you@example.com>
References: <20260723221014.527674-1-you@example.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7246259258627453920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133551

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.50 seconds
GitLint                       FAIL      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.98 seconds
CheckAllWarning               PASS      30.76 seconds
CheckSparse                   PASS      29.85 seconds
BuildKernel32                 PASS      27.22 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      517.17 seconds
TestRunner_sco-tester         PASS      33.44 seconds
IncrementalBuild              PASS      26.28 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: SCO: fix refcount over-put in sco_conn_del()

10: B3 Line contains hard tab characters (\t): "	conn = sco_conn_hold_unless_zero(conn);"
11: B3 Line contains hard tab characters (\t): "	if (!conn)"
12: B3 Line contains hard tab characters (\t): "		return;"
13: B3 Line contains hard tab characters (\t): "	..."
14: B3 Line contains hard tab characters (\t): "	sco_conn_lock(conn);"
15: B3 Line contains hard tab characters (\t): "	sk = sco_sock_hold(conn);"
16: B3 Line contains hard tab characters (\t): "	sco_conn_unlock(conn);"
17: B3 Line contains hard tab characters (\t): "	sco_conn_put(conn);"
19: B3 Line contains hard tab characters (\t): "	if (!sk) {"
20: B3 Line contains hard tab characters (\t): "		sco_conn_put(conn);	/* drops a reference we do not own */"
21: B3 Line contains hard tab characters (\t): "		return;"
22: B3 Line contains hard tab characters (\t): "	}"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/485

---
Regards,
Linux Bluetooth


--===============7246259258627453920==--
