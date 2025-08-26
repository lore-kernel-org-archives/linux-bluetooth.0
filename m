Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F989CA5A
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 04:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756183085; cv=none; b=r+cUFnZIrZQqAUbbnKiJ9TztA4n3hmfFN+qNaBhw+wtHk71CMgWRS1nKj43+Cb8v6nmzt6cwwKn4EmRbO/36jMO9x/0GRvRbAtPOneTIAL7+AqwsC5D0o3NFBAe+Ce6Gd6n4nwP6prYlXg54lJ0It+rLMcrACuvqidU9gdAQ4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756183085; c=relaxed/simple;
	bh=yII33NygyyapyQiz3+siKZ2oZ/XlTY0by1tWeLtbF74=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iBzzvkUUSkZqTfV9ue3EUTmweb1CR8FnEZKVgbmD0lga30RFjBIhEq7geEDEZ5dGpByIEkyLZM9xbz374fw8tVYM0CYeMjLGSaWPEopiIRCLbi4dqu9l7B9BMvwNg94O0HApN2Yllbbpby5AKD0UnzaVnHimZE04vkmCTlE1roU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsRdBO/2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsRdBO/2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24680b19109so21795655ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 21:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756183083; x=1756787883; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HxnVYxYDo9+Oku5UJszsIqyxHY5dEKj7MtNgKC59kj4=;
        b=CsRdBO/23+KT8JrNAOX3E+CQLWNY8M5QQbFd7/VlMOXbT6Wyt2Arjs+UpOThgz9zRQ
         LTFsqKSejH+veFRVDfK3i1psdqgS7zSCIlmq43nrZMpC+VjCnbxr7rckSl/J5Al/eVSo
         Jr4wg2s0FxgoNBjtV6i6V/xYKk85l5O+dyqYqvza7O9ow8EzyzVfUomH5+HmnZlj5eXZ
         v0Rzbn7IODDdEBK7wUBNt/NNJrEnD5PBnEs00rf8QyNO45W+sQwAe2lzvvleOviBS2U9
         3gdrFc9T6VMR2KbsQ+duyxmFHinvdZBMrdA8+qg50fvk/AYbAiR2+jnqwVe4rSqK+nvi
         PLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756183083; x=1756787883;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxnVYxYDo9+Oku5UJszsIqyxHY5dEKj7MtNgKC59kj4=;
        b=XPEiC06FwAPzM7Atdf8ERv0v1PFByTYKqwSn67fkX1BFhhQDf2RwWn0IyMB/ccdXz4
         g0cUfqfuxZBSrjjCU1Oc9/w18a0s1sGHaEUlRGoHyZydK84mKTaBhyb0bSqxs2tNdOBD
         eY5jKnclPb025tLDCxYYtbv0vjquQVIF+aVPW/+zzI20s3s8wHcSSuvNhGj+dhCXnM8C
         9jXn3/8Vf9ePdP/2J0mnf+1M1FQhDGgIwHZiX/fljcQ15F+/ctBq85iA1nWfObY88lmb
         SxkLG6QnKjFSgh25n8XZ+OcE9x/ZFIZuuGfaDAiNoK4/gcZUYIAsQ4EDOU7FfJn/bsJO
         Fzcg==
X-Gm-Message-State: AOJu0YxRpNOJiAyqFdWdUqWYBKib0ipaBr+tV9kDujMu4z7BPOFxudCX
	Zn09ZGsUabux74UwpBG2cI/opCqVRhGKAg9g2HUGN1O/kZTx4l22T0oLEv9l8w==
X-Gm-Gg: ASbGncvDFDHKoenFn+u+eRgOcHBZO55UBmHrl2hrPOvZAeHC/BaFrCeBtUMdJR9qZC6
	BUCwOaYGwN3FVTZzPfBxaDxYLDfHpeYOpzs/TjwvlhsthLs25AkXi8bycwt38YmoQjE13/TRB4s
	aRF2YYjAnn3RitdsmBRZ5iQtWvzgQ59XKmLeh8jps2WVcG7XWhYBNhFmo4NTJUGFIvzHDDmCdCS
	TZ4nmp76f3upc1oId/PanDmBdWzxeeBkyADtfIVQ2xrxKt4u5NoqinHnWLU+ZBrGcV8iPu1t5KO
	KEYkKaa1nXkBZtuE+jMdnSGdPu4QX7RkiKFhSEQ0NrDqV2HmkHxVpQHHc8tpmncHVSRz4q+TbYP
	cq5ITldYeDO5BuQVp5h0wYQOEfabEuF+2uLUbrmfcpQ==
X-Google-Smtp-Source: AGHT+IEiiQDoDLym4CRpl01Gd4gzUyhvdqwAYdMZG9U3lXgvkkk/m+c+QlVYCxcDl+Rp5Wmq66eqWA==
X-Received: by 2002:a17:903:1988:b0:234:f4da:7eeb with SMTP id d9443c01a7336-2462edd7d61mr196824855ad.7.1756183083026;
        Mon, 25 Aug 2025 21:38:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa4fa20sm8700548a91.17.2025.08.25.21.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 21:38:02 -0700 (PDT)
Message-ID: <68ad3a2a.170a0220.3ac523.0aa5@mx.google.com>
Date: Mon, 25 Aug 2025 21:38:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7706834974940707109=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, calvin@wbinvd.org
Subject: RE: Bluetooth: remove duplicate h4_recv_buf() in header
In-Reply-To: <be8edf7f8ba8dea6c61272b02fb20a4ac7e1c5a5.1756179634.git.calvin@wbinvd.org>
References: <be8edf7f8ba8dea6c61272b02fb20a4ac7e1c5a5.1756179634.git.calvin@wbinvd.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7706834974940707109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=995480

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.14 seconds
CheckAllWarning               PASS      26.51 seconds
CheckSparse                   PASS      29.75 seconds
BuildKernel32                 PASS      23.75 seconds
TestRunnerSetup               PASS      475.33 seconds
TestRunner_l2cap-tester       PASS      24.79 seconds
TestRunner_iso-tester         PASS      39.19 seconds
TestRunner_bnep-tester        PASS      5.95 seconds
TestRunner_mgmt-tester        FAIL      123.83 seconds
TestRunner_rfcomm-tester      PASS      9.36 seconds
TestRunner_sco-tester         PASS      14.64 seconds
TestRunner_ioctl-tester       PASS      9.93 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.22 seconds
IncrementalBuild              PENDING   0.75 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.082 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7706834974940707109==--
