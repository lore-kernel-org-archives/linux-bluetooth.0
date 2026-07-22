Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72D43BDCA
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734759; cv=none; b=gxwpFtLe9gH3gRpiN4QAzkmoORQGRjOZtYIZ1uShF7ZrzSMPNuwEWTOYSklFFvB2g8wSCUs71KV6TIfw8pKNpy3526RGPSmdU204SN04j9vBStc6sMhoDX1mHeKOlwEe1IeC/kEduSwvKZ7SwwP8AvnmaN1SzHifJRih1RvmCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734759; c=relaxed/simple;
	bh=l/rghw4cPgkJ8dnWvWXzPXTrb0tb+6sRZNVmD7Fz5Jo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l5VweDM8XHiDBqfj5/j4CMbPUvHSsE5PW91t5CJix+DweGwtG6GbBaZwZxrDk0sHgkNd1zSm+UuVdtMD1DPAES/gt93RCng4GxWKRPrzyrFxJQXZMNkfZ1jnX6cpFYFUTs+xub4GcLHAIfAw4y3zZmyYMDVjNiEDuaNg0YXOSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amya0eBA; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amya0eBA"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9061a795d76so97985716d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784734756; x=1785339556; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f9tCCrUTyftOnNAGqJVQMIezIHty42k5HKmEBsBUZmg=;
        b=amya0eBABnDBrB+khrNfkqrVpxWtN90nsTZ4n9Mfbu+RSocC4tg3uMdJd+rDz/W1yk
         Gedy5bllaD+WmpqHCY7Tl/qk/l97QfJvSlE5cNQZCAmpWLxTGB7czPfoLtUDcG/s5YAR
         PhjjFT1fhgCvKBNsDPjxgXxD9YDevXLqHayLkEKZ1P+xsUz3lBp/+5iuJmc9OK7yMyCV
         MohiBqlp7GdhBK9w2U8yJvtu5sUIMy3whi3Y8i7dzPzwpuqIbbMxBZbtK4jtOOZrQunU
         dj1netYBoTpaJbastRLAJA+VLvNz70pMqoeTPcxgeIUA+em759rd8qURrEgKXpbnF0mn
         23RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784734756; x=1785339556;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f9tCCrUTyftOnNAGqJVQMIezIHty42k5HKmEBsBUZmg=;
        b=Bn4Tn3KlOIDs/di8HgvqAkYbcBKEXXmim/vsffykhkGNjkLbhjq2BMntqp38aYsLnQ
         xi678tw7ElfAgCzEB7sE9c+FlbGR1htyaWYUVVpPbvxEXJc7U7GsZmDNv6h6E/KYOfq4
         Dh4Lt+cTq3IKjleS6Ftdg8sL0hFkctwN/bk3R7lhXTeEeUKPPSgGNCGQghkBr/HLun4Z
         5mufu6/v3d5H5otu62Sd9g2PWUiFTOjfxyyBpI/I3bJSPjAERgpupbVc4cPkexCPJ15V
         m/NMxXIKdEaikWHTl/6EdL0mpw9UDdenrO8w+EUZXd7ofurbcmhUjUtRD1Zwmk/sudRZ
         K34A==
X-Gm-Message-State: AOJu0YwLq4zsc+JEovyCjILf5SvqrrMX+W8U75tX8jD03QcWTR3iMs0T
	bNv2DajWVA9BteQM6PRst7cVodhEYw5IggA/JjhgnRcbnWqeBW7y4j154PpvmejE
X-Gm-Gg: AR+sD13WTOaCKQUT2KYHx1fxNz7XzWTM+JDWEsuFKcxfGDrj1FeB6iScukjg+Mhw2pK
	5jAdwc/Flo2ewWrjlKY0gHdOdhZETmvLmG4Ou55UkNFMDuZxqTHa+qxbuRrdAY1ehUbVKQJ7ZSC
	fl91yjjMpeBXVXuQypn0Kf1YGM/qeKdZBrlZHT9+JDZEsk0anXEKgg2DtoB+2JlDu7YLiPlFVcZ
	QRRRACWv2/23YXPtukh1i/eeRYsYQkKSjyAHhl8DPMT5wPvmeQ6GT7XEdsT886uwmppGTV1fSSw
	0kF893O5yLLUTXJwTTKCym2g0ZmNr771mSgu6G8/O0xLQuPfgPcjq8xrQysx4VMb8GHyFQ3yu26
	cc11/HNQreNWejNkLuusUE/EZ7q31OZrfPy8o5sn30tqEIW1lkuZOe2FikowHbDNXTHJTmGq+mN
	7hramkAgE=
X-Received: by 2002:a05:6214:416:b0:8ef:33aa:94d7 with SMTP id 6a1803df08f44-907783a065fmr264450936d6.40.1784734756042;
        Wed, 22 Jul 2026 08:39:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.59.242.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8d484esm23587356d6.14.2026.07.22.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:39:15 -0700 (PDT)
Message-ID: <6a60e423.4c95d0d1.51cbe.2be0@mx.google.com>
Date: Wed, 22 Jul 2026 08:39:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4098478316739543201=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iva@yenya.net
Subject: RE: [v2] Bluetooth: fix BT dependency for submodules
In-Reply-To: <20260722130849.7813-1-iva@yenya.net>
References: <20260722130849.7813-1-iva@yenya.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4098478316739543201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1132479

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
VerifyFixes                   PASS      0.17 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.21 seconds
CheckAllWarning               PASS      27.70 seconds
CheckSparse                   PASS      26.15 seconds
BuildKernel32                 PASS      24.44 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      468.57 seconds
TestRunner_l2cap-tester       PASS      56.73 seconds
TestRunner_iso-tester         PASS      78.10 seconds
TestRunner_bnep-tester        PASS      17.88 seconds
TestRunner_mgmt-tester        FAIL      208.73 seconds
TestRunner_rfcomm-tester      PASS      24.24 seconds
TestRunner_sco-tester         PASS      30.13 seconds
TestRunner_ioctl-tester       PASS      24.31 seconds
TestRunner_mesh-tester        FAIL      23.79 seconds
TestRunner_smp-tester         PASS      21.59 seconds
TestRunner_userchan-tester    PASS      19.24 seconds
TestRunner_6lowpan-tester     PASS      21.64 seconds
IncrementalBuild              PASS      23.30 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.237 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.948 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/476

---
Regards,
Linux Bluetooth


--===============4098478316739543201==--
