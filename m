Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E93513555
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026031; cv=none; b=NN7SihQRFyWV4qjR3Fj893qgGQdcmQ7P9RIQGzAo7OaOkAO8YztaJ2Gi8XpaJy7pXfTUm0houfU7P1XSW45nXwt6pVkGlPiO9b9YZvjGjyqQ/wkjkndZK9PKT4Vv4gKdACs0Aa1cxHLvxvJ7j94S249DWfOvYYRRAP853heN43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026031; c=relaxed/simple;
	bh=11juog9jO2VcYTGBCsddLAmI37xXMRfzaXeyzleOa9A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a0LWUs7R2u3Y4Q++6NCeWOlhdRMvmC+TcdT9AFAgHIChZtfSFDWeKYiOxXvMQhM8kvARUSWCOyX/ZqyeCJ0HMMcyxoYrdhzTDE+3CoFcvGu3encc8IoN7S7EXtPL1yi0Mb4pTDbsGW1+XiwlEVrTDMG8CHNap34KfxbzSeccc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xfl4sWaz; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xfl4sWaz"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so37593086d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790026029; x=1790630829; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iz98yFcAicJolMYxZ8l74aCqK5D43DQFnEe3F1jUwmU=;
        b=Xfl4sWaz1sR3SmLrWE607Aa2Tu6CFf3Fw714rcSYtrSZDydEDxVo/EvWknvkoDuPpU
         P+vT6ohLU4JB0zgdnhJOAfUvxc23aeEAkgzxVenZS+p3RQUwasJe2B/D0ep/7gWzUjov
         HHMvhUq+7Mk+9njfJeCBYGNuI1c+rMBdaG0Ds185+jFJv2C9/U1yFuKFtSmGvo2xeyvn
         rrT/LL0e5JHxlZ3zn7HqHib0mmEpSQUpyv1+neHv2KmUI+2unxNMdfqI1+CUDx/8eHvK
         JS5jmt2IrJ4j2OKzRz3Z0QpOPL7cKiC905g3xiUonSl9EF7XTtkOyf/DiUd9lbg7o8nz
         w9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026029; x=1790630829;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iz98yFcAicJolMYxZ8l74aCqK5D43DQFnEe3F1jUwmU=;
        b=XCsTo2aHsWiAnSN/lVx/TCShMF2fwEeF6saRPzQ5H+sPF2p9qkfXd97gGcHPYmK2K9
         9gRjntVFnTVCbeLzz6ZNgla1wtejRF6xAiGyAv71n+IbLln+2acFyaZn/cBN+3NTdJbN
         70P0nj+sO8JTaoxVNfBal6jrUNBHyjyQaQfRpHZaMRS81eD7IuqGwq7Fyr2Gy8L92lH5
         zBYDupz5KwjA6jWx4E1Gj0dilAm9eopP6LrJBlMIEcdN1MlokhJ0GSnP7Lwj6Wcs3VFq
         B23apuXtHZyZ6w/wgb/FJ4qylzXE54m2tdPq53fGUF+D9bX0QE1aXD7orRclA5m16mib
         2kAg==
X-Gm-Message-State: AFuF++nJENsipO2gpJqoxctptvbSihvehgqbCxxMlCv0eGSnr6HumP1n
	jge0iuqODzpYSTjfx2niD4X/t7nJ9+RnkyCT+zszrUVcFpzkji+pgPebqiCdgw==
X-Gm-Gg: AYBFou0w0V3bvg2jLGMQ6Tm7FsZujHPl5Z4NbRH9guGwYgjFsHy49jyasMXaBdRNZwG
	l6ZPOaziDRJYBlvd/FinrTwdSGxSLbCaZYSeD2cuQcXPppCYqgwybgNLIYtVEP30qIMGR4ltAIA
	TO1K2NSkwgoaNkqpd2IpCkNh9Ak4XZaX6mpBYlIDSJNg9wZMSt5j/e9dU0wZU6BZ1qZJWoljPHJ
	jEuFdwuPYtYOomn+nanNBCgzzYh1vMQ6ztLVk5ygfpSwJRxtfQfZ8WhQob5IivwI2JJ7oSTYrSf
	uxonPqnMh2liaPMcw27vik4DbnCzpAE0hDEu5r58lkvWMK98C++1cwmsE20oQQFC++C05JAH0A1
	1lw3kEIFzNl7g/oKGXp3/DV05yrEDodYKc4wADqsXuXsmwyCxxeZuqUkwXDarx0FnvK//DR88gy
	q0mUubjP4bBA7zDXPfK4DM4wn+jw8IaHE04WtvXLD/oF7Dv5tfh03HzrFmQjGo0vtqKeHFqg9iY
	QlkWhc=
X-Received: by 2002:a05:620a:408d:b0:93a:3aba:a0d4 with SMTP id af79cd13be357-93c15db614emr268965685a.27.1790026029194;
        Mon, 21 Sep 2026 14:27:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.86.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c19aa9e79sm20534985a.33.2026.09.21.14.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:27:08 -0700 (PDT)
Message-ID: <6ab1a12c.85560941.26cfa.cf71@mx.google.com>
Date: Mon, 21 Sep 2026 14:27:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3124491454808697010=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, csh0052@gmail.com
Subject: RE: Bluetooth: hci_core: free the HCI ID if naming fails
In-Reply-To: <179001656830.91284.12508704070539939097.idr-bug-55@gmail.com>
References: <179001656830.91284.12508704070539939097.idr-bug-55@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3124491454808697010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1170616/

---Test result---

Test Summary:
CheckPatch                    FAIL      9.69 seconds
VerifyFixes                   PASS      0.18 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.86 seconds
CheckAllWarning               PASS      34.47 seconds
CheckSparse                   PASS      38.86 seconds
BuildKernel32                 PASS      29.69 seconds
CheckKernelLLVM               PASS      35.33 seconds
TestRunnerSetup               PASS      790.99 seconds
TestRunner_l2cap-tester       PASS      16.44 seconds
TestRunner_iso-tester         PASS      29.05 seconds
TestRunner_bnep-tester        PASS      3.17 seconds
TestRunner_mgmt-tester        PASS      61.53 seconds
TestRunner_rfcomm-tester      PASS      4.49 seconds
TestRunner_sco-tester         PASS      8.78 seconds
TestRunner_ioctl-tester       PASS      4.72 seconds
TestRunner_mesh-tester        FAIL      7.84 seconds
TestRunner_smp-tester         PASS      4.34 seconds
TestRunner_userchan-tester    PASS      3.20 seconds
TestRunner_6lowpan-tester     PASS      4.43 seconds
IncrementalBuild              PASS      28.30 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_core: free the HCI ID if naming fails
WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#105: 
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM

total: 0 errors, 1 warnings, 0 checks, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14836139.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.371 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/809

---
Regards,
Linux Bluetooth


--===============3124491454808697010==--
