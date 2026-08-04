Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8E426D18
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879180; cv=none; b=I1VViWhkUVIGrywjMSW2uFjBLy1nywiFQWG6LHQYVfJPD/+s9HFEGfxDAcTqAbnH8kOP392DP8vtHZGwpu0xzk0GF0PPT8VHtvUlsATXhg/2Uo92rSOlggGn1+O8QG2NPvRDLhAL8vya1tdfUC1Ua879vLtkoryV1Zd+NX0vOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879180; c=relaxed/simple;
	bh=hOYyGARmXecXOCkXSFled33JrPDw8xCfEkQ1GLP8Op0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hYVq01mOCYNNF1i1UkEFWWq3QsXgKbIBFgg3B3MaWndVYe1tzDNC5A7vqiu6KqCX3VYCSlaUgtbfwzp1U+FESu8WcOpj0kiU1nwrYDOCDOsHwxQ5hL2YbtnxKeaopUGyD+h9t2qMytNpOLSjuZ+wU4MQ+Mk8MkGZPb9nihrulzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrE9LGlB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrE9LGlB"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81e6f2ee60bso21243107b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879178; x=1786483978; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nASjRz5wbbUQr0hLBvz3BRP4+CV/iaM7GHkJLzdqZ/c=;
        b=FrE9LGlBGD8sjHcov7W4n1nRJ3jFg/i5ACHwoXbzTNdwnu+okuiewl6E+CrLtEnlcJ
         Q2Loi//FhcnlMROoFCQSr/AuV7y2oEHsU45fIFY3R4iJDgY2LtVzP48gDxBB8+zUHYuk
         HUBsrFBmUD1En4zkNhcqocInF+uejYjscIVxH6ZEe3ssgFOXLtpAg01C4GR2FZLkCBx1
         KlIBD7gvwiiUAfbESn55/HhWJEEpFz2phd8aCmaMV8rT0a6uG/h3ZsJlttzzVYYSYEdC
         KKUDRJUMWJfzeucqFGs2U777Ueuam7B4Hj7mmYSKq8sNHc/9fojYos8FtPrxtF+zYrcv
         otcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879178; x=1786483978;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nASjRz5wbbUQr0hLBvz3BRP4+CV/iaM7GHkJLzdqZ/c=;
        b=FinkIPA3qMCbxpUboNEYwWyWgUr0GiDVKXVfrHQVGLbIqrrbxXRLNHCLyiRbPksdST
         WegVpO1f/657buWlR1HY9WWdFvJfw7SF42VVzNe/alm/Mz79OC7a6MO3Ap0pIVAYE76p
         pXLLVUJj18aqNCExgXSASygQ3DpSw7lKadCo73zM16S+A14Zpx4du12onQeoHwi0+XkJ
         amF5OB+fXOLpNtirOe1D3034XSV5LQk+phkQ2ruhXyr6uGvPmN6eSmTT1K0zGqEczM7B
         59yQFW8TXdjdeQuxVKO+DlB0YQ4Rs6MkteyZb0gSb6XSl73URvrPJcSZP8EDHsUc2Tse
         kBDw==
X-Gm-Message-State: AOJu0YymsXiocv0NBgnz+pcZwJNKT9VQV2uf2dqrHjO0Wd/D9TBAKogh
	mkPxPoS9XaeVdAlyrAeN/bKMvh78UIj4eqJJ5NXDq0EKR5XHCUEDlmiZ25Kg0Q==
X-Gm-Gg: AR+sD12so9XYfKCafY54kNqMbtg0lM0uTmlj+/29ydfgjMaATpQHGtTJx/rec2ux9yT
	z7uXtuuEN5qxJI7bsuo30DlyRwl2MDe+ufMV5ao2Ta0Aova0kLyn9txjmUYF8u2EhLcYRrlkewy
	1Ry1H0xGEcDXLxnvfb7lXisNCLt6iwCKPRVcYfgJryZDYPxP2TUtPsA74L0QgWscG6l+JkscpRj
	Edb+5NyFq/i7LlqWVKzKB1d2o0gudCB1uxjVP5mJFrlo06ULcAX2teup8Zdt2fgb4LqjH/KssrN
	11077h0tj3sGUpRvmvP+6f9oi4Qxchlh/2t0WyUXxoQQunGtsR4ZhlJQ11jUPZBo3zptaYNkRtk
	zVpPFk7MfhGx3Ce18hKvayhl7LqjnorgAlBGnkw4FhkzCOZAFdEq2N42HD8sFbiw7xaxYj/0IYW
	PJEEWVZwRDq6Pl/C9bAObYm3S2r3kzSWRDajBU7zfEamUg2uMJcryuvP0RBIZA4bKHz+A=
X-Received: by 2002:a05:690c:c510:b0:812:9e6d:d47c with SMTP id 00721157ae682-8201aaaab59mr14580577b3.10.1785879177645;
        Tue, 04 Aug 2026 14:32:57 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.200.81])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820134a8e08sm12350477b3.41.2026.08.04.14.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:32:57 -0700 (PDT)
Message-ID: <6a725a89.44484dd4.258fe2.c975@mx.google.com>
Date: Tue, 04 Aug 2026 14:32:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5269153442293386533=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, muhammad.saheed.iam@gmail.com
Subject: RE: Bluetooth: hci_sync: Disable legacy instance's ext adv before setup snapshot
In-Reply-To: <20260804201051.484885-1-muhammad.saheed.iam@gmail.com>
References: <20260804201051.484885-1-muhammad.saheed.iam@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5269153442293386533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1140346

---Test result---

Test Summary:
CheckPatch                    PASS      2.80 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      28.90 seconds
CheckAllWarning               PASS      31.57 seconds
CheckSparse                   PASS      30.04 seconds
BuildKernel32                 PASS      26.60 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      500.76 seconds
TestRunner_l2cap-tester       PASS      64.82 seconds
TestRunner_iso-tester         PASS      82.42 seconds
TestRunner_bnep-tester        PASS      19.48 seconds
TestRunner_mgmt-tester        FAIL      221.70 seconds
TestRunner_rfcomm-tester      PASS      25.07 seconds
TestRunner_sco-tester         PASS      30.88 seconds
TestRunner_ioctl-tester       PASS      26.60 seconds
TestRunner_mesh-tester        FAIL      25.88 seconds
TestRunner_smp-tester         PASS      23.62 seconds
TestRunner_userchan-tester    PASS      24.52 seconds
TestRunner_6lowpan-tester     PASS      23.11 seconds
IncrementalBuild              PASS      24.89 seconds

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
Total: 501, Passed: 494 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.248 seconds
LL Privacy - Unpair 1                                Timed out    1.864 seconds
LL Privacy - Unpair 2 (Remove from AL)               Timed out    5.004 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.748 seconds
Mesh - Send cancel - 2                               Timed out    1.987 seconds


https://github.com/bluez/bluetooth-next/pull/532

---
Regards,
Linux Bluetooth


--===============5269153442293386533==--
