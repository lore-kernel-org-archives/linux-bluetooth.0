Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54745395AD1
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770245; cv=none; b=t8h0nFYZarxPnycZx/7s9/KsZYWKqqqIKvkL4w1PNvUdYFhygCIOfSsh/yPGq4rN0OSXLsstx3peF7hElvZ5fRFiAFJRnW057dO3ui3kN685kWXxQwBnuRvty/1ziD8nZW0I68hJzvZ9Cq8mxqKNhmOAMZ61GRLeqFB4lVtP2h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770245; c=relaxed/simple;
	bh=ssfkVkzqhy1r6miVY7GrnuIJpc2pyUxb/3me6RAAjUM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cMshB6ektEpRL4XymL8gQD9mrY8cOy1LKwFP5IGCAQXQAjxDASK6P0kNb/1sLiEyAsJTe0L8X/SJf6cqaeCul9snDW0qtvtvsaqkKFK4JfpQR/etCGqgrzMkLrQzx/nTYXpIs8z/PoQACkG8UUq57ndWUP3ibqXtKQGAOJK4nOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhYMvjN+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhYMvjN+"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ee88fce536so16995866d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782770243; x=1783375043; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YY8tbtJWUnhTflWdBck2Yym+3KRCkxyvJ7Goqqf/oCo=;
        b=RhYMvjN+26hhiA0AuJ1xYTZVAtaiPVO8hoo4daNif5jWQh5aC39Tw1mX0JJUuU04qQ
         dfFrnIxtccH5BDmFnyqrW/C7Gq6BbnqVI0ZYO8qaDn29HTcTkccb2YyX/7Nm/uPV1cQ9
         gyNmvv0SbbXbB23EOmpYl0HZ+SYkgVV4KZ4rmj4Q7IkYsaYhQGViAcm/0iFwBiIeOm+L
         sZDmk2Q/81eS1Y7kLLIFTikfvqvZnURSjQsLPTePKSHjrj5bGI4zzT6emIHa8v9+PNnU
         hiYBynIz+bX8iom44x0m2d9qMYSDv/wL3nnVMmxyN8v8AdXXWRaRYaUODlI5bPa10hoC
         SUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782770243; x=1783375043;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YY8tbtJWUnhTflWdBck2Yym+3KRCkxyvJ7Goqqf/oCo=;
        b=PwqB9tKS9nfTX2nDkGBBckjGjlcDAJ5GBOLdgyF94tI1m1jRgvaNy0BuX10Vbx1h4F
         WU8PCwacV4jLOwmI+/xrOIgKEu+ORrwTxCWHDR7gIfSqB+xy+ig8FsWjwPnKj9wh+BpX
         ccYclrkxcT1LjhOMJZm8F4+cWFqkjsf4sYBxQynyq2aTB43WLgmvOHEKq9VnzIXZGhNq
         ZK0/l6Z+QC+muHOtl/BgT5n8VHo7srJPSgyT3EcyZMCDKncJfE6S0Cz22eBFIegBjenu
         t2BA2WEmCWIu4lopK/ekylI+/uyS3b1vGx6yeAZE/ekDNaf1D34XFZ7lUz/JamRqV46B
         csJQ==
X-Gm-Message-State: AOJu0YwN63QSHfe7Isa52nNfovFVS8j3EHI3P9fF/tn2bE0AGXBnlVxJ
	5CkpAegniLl6b8ljd6qGGaOUWPCGKESjbKFz28bvpfo7Kko47pRdhycASobkgw==
X-Gm-Gg: AfdE7cnhLiKrpzG/NOGD/wwKleNIk09lSLQMF4hgFqZ/Zc7Um//PiAQpP4FQtjIgVFL
	qnnp6JkCTNGU/McdTE8sT1XcV0H6c53U9Ymr3y9rEOvYVxckAkVwwVb2SxOxk45hWbi3cmUSW4X
	iBlGdctanqhwluS2IChuc80Gy4G4n4M4EGuQC7XFlIo0HVNrFlODuF2dh3WFZs/JxEjgO73oKh2
	M+MdlJRz6kVD7oI4g7qptfUYrmdPOYcszy4s+xQirQKXnYNMBdeJ5V8X/HHtMXo4CN5BIMF1cba
	Wscbh7c/oUOTTMNNa3X8ED7Qovn01mXa4YfGWV1yhXz9QZe6Plw+rw7ctn/Cgx7tjToTgVGwBVD
	QYjwsKZQ6COHLaZB20fFj6Op3I8G67TFEH7mh8CHxkBfEuITXKsZp6CftUG2nHtErfmUNUkAzgN
	kdnH6NQWjBdoobtRK8BOk5
X-Received: by 2002:a05:6214:d41:b0:8f1:8349:59ee with SMTP id 6a1803df08f44-8f1bc67d6e3mr18924766d6.35.1782770243306;
        Mon, 29 Jun 2026 14:57:23 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.127.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a3483679sm8118086d6.18.2026.06.29.14.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 14:57:22 -0700 (PDT)
Message-ID: <6a42ea42.cfe3cbd7.d31aa.5077@mx.google.com>
Date: Mon, 29 Jun 2026 14:57:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6602736168538105492=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silurust@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Add IMC Networks QCA9377 to quirks table
In-Reply-To: <20260629203420.24137-1-silurust@gmail.com>
References: <20260629203420.24137-1-silurust@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6602736168538105492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118481

---Test result---

Test Summary:
CheckPatch                    PENDING   94.38 seconds
VerifyFixes                   PASS      17.55 seconds
VerifySignedoff               PENDING   30.09 seconds
GitLint                       PASS      36.39 seconds
SubjectPrefix                 PASS      15.88 seconds
BuildKernel                   PASS      24.99 seconds
CheckAllWarning               PASS      44.18 seconds
CheckSparse                   PASS      44.49 seconds
BuildKernel32                 PASS      26.69 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      454.66 seconds
TestRunner_l2cap-tester       FAIL      57.85 seconds
TestRunner_iso-tester         PASS      78.17 seconds
TestRunner_bnep-tester        PASS      18.66 seconds
TestRunner_mgmt-tester        FAIL      209.38 seconds
TestRunner_rfcomm-tester      PASS      29.51 seconds
TestRunner_sco-tester         PASS      32.86 seconds
TestRunner_ioctl-tester       PASS      26.18 seconds
TestRunner_mesh-tester        FAIL      27.19 seconds
TestRunner_smp-tester         PASS      24.07 seconds
TestRunner_userchan-tester    PASS      20.24 seconds
TestRunner_6lowpan-tester     PASS      22.66 seconds
IncrementalBuild              PASS      25.24 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: VerifySignedoff - PENDING
Desc: Verify Signed-off-by chain
Output:

##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.250 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.240 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.682 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/374

---
Regards,
Linux Bluetooth


--===============6602736168538105492==--
