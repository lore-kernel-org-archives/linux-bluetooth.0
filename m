Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6521C19CD0A
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773573514; cv=none; b=Fi1HZmFr8VxuxBuspfyNEgYy3qxUOWe/haIWqplWSCbi6oxqlaHwPzgLF/lyHH4ZlboVh2pJc5MHv9SI++7AJeB5VSaiAV6isFo9UHm6x2wvAeVPlm1afODobv5ttx8/yRVtdSmPHuX/oRkgT8tF8DXbBzmTyOAzo0ZiudFQqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773573514; c=relaxed/simple;
	bh=En/8g7nnRNllqvYbWgWkb9v+SdxDj4tBl39OZEilIeE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=c20hfoy9fN7v11tYsyF6tCkf+IHIGfiT4u4bZDbtrmYvVmquaen+gMoJJT76So39mrxF7F21bpSSx+xAHuhxl+NnnxkzkPGg8IAA0GQKRpW9i7kUVkZXx1MrOKTMSiSGZu38wJkB2nMk/eMik/oynG3Zyl+93dIhif2CitPLbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1wrqjFD; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1wrqjFD"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-509149ab7d7so30691831cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773573512; x=1774178312; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ta9Aq2gGaKDRP7d1X09CPZ8EqgKBHV4z4EtWoeYXneo=;
        b=l1wrqjFDFY8qrnntHHeDLRxhzJ49OksA3z1mcNVKy7YuzE1zw3cu1GPOLoqrO1ldZA
         PE7ImCmB/Sp1IHYd29WUUBaYyndfhpLS7ivnDgQyVSZjXwkGH9SpLWQbsMIizr5nh/6e
         Rzz9WuSe7gAv00zFi5aJ6uWQIuCYIysPNemDL3+r8z/bRWoD5xOfANPm76sJmkdy6Kh1
         zsmAuud6SCWxBaHC21+XkQK8OquJLU7/InJtX4S2O6NarZ2udKi8LEBilr8lsVjHDKZK
         IJ9xlA0Cv7JrkC4rCBMYBC+eQ7EfERgheKl+VNF2x49fAQ2P+JjJMV4mhLAK9LHCSq/v
         sU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773573512; x=1774178312;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta9Aq2gGaKDRP7d1X09CPZ8EqgKBHV4z4EtWoeYXneo=;
        b=ssas/bnAkUkCsAcYAXB03+LNHv4uBiCChag6dc7q51g4MJ0A9bxhqExLrqnIcYAVC/
         D4VZJ4nBBQrq3OlUg74xkkMqIK0jmncmjYNe+lK9HrJd4fC9bRYVDXcDbcQeVgPWGL5z
         WsMxiSVPJJ8iwAnU/2OH2ctEMHMnLBx3i1U4whJWCFvsvU1DYuDFC4okv2/11egfjJpy
         ak668qkh/50ZasE0msEsRfWpUYUK8bEOTbkdUbtY394U7g3JtrC6uzLea+3E8MXcr8Fl
         yGpcdlvo7Rtd18maV9dXgqF8Q8FFT5F9fzs7xqf0WggEeqKgi7Cgkd4LCmCb0Bu4hwsu
         ieVQ==
X-Gm-Message-State: AOJu0Yx9txG6DdcYBymOOglMGC6GNLiD4BYtPbJn+Ph7LLt0jx34j8IR
	LbGLf5lIRaZ0HRcYPqdaO0KLmD5vYKO1OL4HtFrrKrQoenlSpmE6MzweaCuOcw==
X-Gm-Gg: ATEYQzyuobVEBsVwfZ9FP0KcQIHchaPofIsS0wt+SltFAC05p/ThWOX2ewv796gcOaC
	l7ectWTVIBUS1vmdwC+/27A1DSA/7znx63Ul68691zM7BBFrANhnRlPJhN9Z4jHBfkm4moGFPWQ
	9dVJMQEgAD+Qh4xntG0NS1P113fbRae1LZDiE64ihtTH3MfLEQJuRgsPm9bOmocRFXQKb22Thr+
	v8FCD6Q5z267V7eh0xK82Nq8frwgfZIRovkeGIj1zALOdvdRgXFhyyyzT3C3jITvLst6qqn2+Gv
	YZ4ITCItWOkYwo76jSIGHQb/4PF5NBlApMrDU7dhtuqEKS9YOH2fItouNUdcxrcEPLPFpYSUeMh
	+84CZlf9hYiP3awZrqTRG65pLlrrBfhnBCXwVuH7vQqlVQCmB+7RdnA2PnYkQqGQGcWig0qsDDD
	GEyHwnXx3hqDfS3zwk8pKbJBZwCtcY0w==
X-Received: by 2002:a05:622a:60d:b0:4f1:b742:35c2 with SMTP id d75a77b69052e-50957d12848mr116476861cf.22.1773573512169;
        Sun, 15 Mar 2026 04:18:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.38.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c45c272d9sm19608826d6.3.2026.03.15.04.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 04:18:31 -0700 (PDT)
Message-ID: <69b69587.050a0220.1dbb83.ba5f@mx.google.com>
Date: Sun, 15 Mar 2026 04:18:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8542455598330708502=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mohd.abd.6602@gmail.com
Subject: RE: [v2] Bluetooth: hci_ll: Fix firmware leak on error path
In-Reply-To: <20260315105138.1693-1-mohd.abd.6602@gmail.com>
References: <20260315105138.1693-1-mohd.abd.6602@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8542455598330708502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1066882

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.00 seconds
CheckAllWarning               PASS      28.36 seconds
CheckSparse                   PASS      31.97 seconds
BuildKernel32                 PASS      25.34 seconds
TestRunnerSetup               PASS      558.92 seconds
TestRunner_l2cap-tester       PASS      29.29 seconds
TestRunner_iso-tester         PASS      82.40 seconds
TestRunner_bnep-tester        PASS      6.39 seconds
TestRunner_mgmt-tester        FAIL      115.38 seconds
TestRunner_rfcomm-tester      PASS      9.65 seconds
TestRunner_sco-tester         FAIL      14.87 seconds
TestRunner_ioctl-tester       PASS      10.42 seconds
TestRunner_mesh-tester        FAIL      12.47 seconds
TestRunner_smp-tester         PASS      8.82 seconds
TestRunner_userchan-tester    PASS      9.44 seconds
IncrementalBuild              PENDING   0.50 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.767 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8542455598330708502==--
