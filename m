Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB94A33F1
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364594; cv=none; b=K0xU15MbD8i2QPzicSguVfFEbd8vxYYSitMVmY0gDPVsPtR4hcxmHdWcPiKEHiZZOXkEDuDxZBL+2rrXWbHPfvOiesbNsNOxNq+HnN3BI5Ny8X5ud7TxWj2MsnSZDOX49PmU90tT+FpWQ37xjMFqFWMSwqqG8LAqJ9Uk9WidVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364594; c=relaxed/simple;
	bh=CNcWIOwP16aAKhe12r8P1FF2fL4poGJowRghuOPjlh4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Esa4H8QNxnGppZ47qMwwvSXlSmTxrj4Nbv2jGc2MVg9nnILWcfjM1zv+gmWuTMvSBq1yLQy6gROR4JuMDFplBtcKxLQ0ks4M/jV7D0RZAJ4halhukW8gRX5OqkG4ytTEhOUkGEGL3Hun4BDCHCg8Nc6cBSS+Ken5Brx6ekTDl5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTcejnf+; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTcejnf+"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1347294a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788364592; x=1788969392; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M30MMEdO/2UMv+2BLGsH3y17f8OA2ihhO3AQuKc9vfg=;
        b=DTcejnf+/bHE480jHSmGZAk+DTdAfKne21bUE6voogco5/6unYPCKDSAk1RZmjUecs
         rBEDdVik0LaeE9dq4KIaQad0dDPsm2YHtvfJZrLZGJRUQDUFhPJaUwBHhUXYspBFONlV
         L+r6V/gnWRzunA26Z+1PGFET9YAAxOUWS5YrvQzFoSERGpLKFL7AOij/eqrAHMFr0aP9
         r0blbU/ROMmv909ftD/5k9W7LROOKSmTbXB3TdLk+xBCow1XLt/DP8qGn5EpWtCWoX2+
         bdMe7UuHa1TxVhD4IJfd6Nl3myEUh3tfVIC16ikb+SzI6J9F9O4NYbwrBId9IVwCdIAL
         7CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364592; x=1788969392;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M30MMEdO/2UMv+2BLGsH3y17f8OA2ihhO3AQuKc9vfg=;
        b=Xh8GmihJqMg+SgHwAuItYp+mc+ZSHuJWLX2ltP/ZyeugidrWcVTAea0HNNYi+BHTa5
         opkl4qD72ZKSZUKJRK6Sx5DndjAfXOtVe4+2CEzr92roUbnj3YTjC7gsNwUJmpxyPaE1
         Ti+x88Vzp3hVUDoOszOkVKJkjRTSjHKORYKh112Mvje5OuF5+lfqG5oeQznq41pwqrHo
         zGciQqLunGI53Rhp0QkPftZ21oAGdSWTlFTm2EwTNKvAyyfoaW9Ta5VsABp6NSiPssmO
         vneURTIJXRtx+ASxTDZFSbvCaAQct1nEQxIZx98TsYoQkUQBBkIzokV7RaOVvpMT3eGC
         TeuQ==
X-Gm-Message-State: AFuF++mvO1GTpAp+qnWR0Gxb6pTnTBTsbDgKmkB2dHLZtWeI0seJ+szQ
	WOr3fZcu8YSdMT43gjIYaDlPvTMVxgULUoVpdWlYR+eM7K2QJVmxcZUm90S5Pw==
X-Gm-Gg: AYBFou3Rf1j5tfM4TFcLfe8KaY9vvO18DgJMofQB8P7dzaRA59MEdonbkZBMTriandd
	if/ik8ly9WjF+iK0BdrYnYnhqEhFX4k2byjO7orgokOlAsPQaYyDzBS7TWQK77EGldzB7nJQoDd
	xp6J3qJTVVwml1nzgDzM7hwgE5/p5C31zrf21uMrxahiztGilHb97oaYDWHTjUIRzoNq7/J3md9
	W+HHMXNJ33psuiGRj0GCe7POtczJbgfSmrXv7J0DYHdXjFgbgxDArjNpw6qVcReDqWzfS13LHUA
	AgMiAOCamu2S0HF2959cC31GUDbStYG91jb8m6sISQd2BTaUhfsXMvSCZ9Z+KRgEIb89zatIvFS
	U1DWoVJK/iYTGK5MQ6/7UwA9TIeDpYCRdzYqIgftSTPgb3pvfi8aBDdlUq1h2Pk5K5R+UvABJyX
	bvOD9pboIjHlPan4nz9ODGFVIezl8JRilQpytDIDNmqm1oFIlXx80aLPG0ajQUV54ent9rtTI8R
	28=
X-Received: by 2002:a17:90b:2785:b0:398:9be5:b41e with SMTP id 98e67ed59e1d1-39aee285570mr9733818a91.25.1788364592221;
        Wed, 02 Sep 2026 08:56:32 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.3.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079c6aa4sm7867324eec.5.2026.09.02.08.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:56:31 -0700 (PDT)
Message-ID: <6a98472f.7b32ee26.3161e5.60d2@mx.google.com>
Date: Wed, 02 Sep 2026 08:56:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3130895678433376297=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_sync: Fix not setting CE length on LE Set Default Rate
In-Reply-To: <20260902151039.1583493-1-luiz.dentz@gmail.com>
References: <20260902151039.1583493-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3130895678433376297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156273

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      2.17 seconds
VerifySignedoff               PASS      0.33 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      23.30 seconds
CheckAllWarning               PASS      26.00 seconds
CheckSparse                   PASS      31.60 seconds
BuildKernel32                 PASS      22.63 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      417.50 seconds
TestRunner_l2cap-tester       PASS      63.26 seconds
TestRunner_iso-tester         PASS      106.11 seconds
TestRunner_bnep-tester        PASS      17.09 seconds
TestRunner_mgmt-tester        FAIL      215.30 seconds
TestRunner_rfcomm-tester      PASS      23.93 seconds
TestRunner_sco-tester         PASS      29.87 seconds
TestRunner_ioctl-tester       PASS      24.74 seconds
TestRunner_mesh-tester        FAIL      24.78 seconds
TestRunner_smp-tester         PASS      21.53 seconds
TestRunner_userchan-tester    PASS      18.38 seconds
TestRunner_6lowpan-tester     PASS      21.62 seconds
IncrementalBuild              PASS      21.09 seconds

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
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.240 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.737 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/689

---
Regards,
Linux Bluetooth


--===============3130895678433376297==--
