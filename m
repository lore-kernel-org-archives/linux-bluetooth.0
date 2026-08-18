Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA04221546
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056533; cv=none; b=R6++gBQDskvnG818HV0JyNrtOv0HEWoQQZyg2DuGeytkZ1XKBLDg0LJ9Kgd1V+b/i7hUwAKJxVoogwrPTz7kyj2MPj7YFBcM+DTAqgUL5m5hA0VYewoNcz2kSmvhC8MKZKpow3kDSK/Rh+WDItB864RL7QMEsljXDG9+r5+/tIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056533; c=relaxed/simple;
	bh=1tAzy/jbDfbu3w1zHLoO98/NZiE7U5ZyEi1iSAeug54=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QS4jDp2c99nEnpkv0324nWgNmsKPYoa272iLKb/nT1deUS/uJVEVWDNOh4GBtXVwyuVpHtEa18ntcDp11eTOJx5bwGlBGQNG/TfZIy1ZLD+C+leub9U8cGT41FB3t8QdnoJwSIn8a2ntDofy/fLLPvqDxTPMkNNpV156F20NIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STX3wtwq; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STX3wtwq"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b01562adbdso2990582eaf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787056531; x=1787661331; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bzd1dcgVMU56KOOV/aIuVNKWUsQH2FoOqC3kRsbgGp8=;
        b=STX3wtwqWRcFUrN91sl65PMRoaVdgh4bsW6Hvniw7aPfk+eLYCBMHY05bTeNrPVvI+
         55LzjjFlLOz5FWW6v+8mif/FRrfmlLeIeX+y5GyRWZdxpUB69nDGOWyKIjYELIdCw/LC
         Gf5Ys/+A3uSoigeesZez8nfMrGT3gkZ8xozX+fRv0fhBNil6EeSsCA0oFk2ZAZcJYb9b
         7d2Q/fxTnkwsPYwk+nRGe9wrpelkO6aax2N2j87I+UU9rsfy+lb3/Hg9YlUCBJ21Eaaw
         MC12Per5tVGCbqil66ohdX0w1QnO/JMXtNdtQIxLTk4JMJzSDBjpwzEwqnDlSsM6zVyH
         IJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787056531; x=1787661331;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bzd1dcgVMU56KOOV/aIuVNKWUsQH2FoOqC3kRsbgGp8=;
        b=nnSnxjf8QGPMO1MkUwmMEV4Hq/JLwk89ml4/fdwBcaWQObb/igfCfVXhgQr1FCjg9G
         iTV37wHeyIKeop0KTbEz4UwLQ9e+SYht7w1ELxSvZKIuybhfeqsKE23M9gdAaGsgeelX
         xBOY/tnjKUin1DjxqAKbwrhpr2jVdh/8megi2TH/6u6hFt8DnCpfvjxWqIUKTR9/mhXK
         NzFKRERPdAULga6xdNjPkI+Ptd4/53ATBXcIMYvUOLdQ/ddbRymHfytlo6eeGVHLLRQV
         Tt+EH1LuesRkRFo8ITxJjwjvJhgVInTyJEecoEdZduoaDRrgk29A2jV9UYn55b0tieyq
         Kd+w==
X-Gm-Message-State: AOJu0YwZ7oFkG4bqBbvaBa2ndFZ0/VSyksaSwsc171d0PvZo6oDnL2/G
	eGSklPS3U5t23BmcmRSBBkid4s06GsB02U6pCO+FDHehzsSHVD4B5ZmCgg5kFw==
X-Gm-Gg: AR+sD11C70k7GTMMYvpRnqAItdXMxa2Ty0U23HeraXkp6eEuhglQl7x4VVv/c/RfUC8
	VUXagNNalvGd4+0N9j7u83+DiBiPqfONkiwX90K0f2wCKUwNHirOUFwGTzhayTlGoc5ghzygIRa
	4zpAhmUcJ+jX1fuYuPt9d0qpdp7cHOxVrwUV7x1aVKvTuG7SY8UUUPairQCrYqRcyAMzQFTfFFd
	PuD868HU/4+aU9UaELsaHPKTn1OyggJdVq/e1J3ilx0sPCGoi8hWJGf2le/7GazdWPkZC/Nbz6A
	G/0OpfUyogxl1MVuaPQ8Dr6i1JIuQh74YGCuKBMx7ZiFzl01cYWPJNFO3kMbfcV2UrEAJA7quc+
	MNx0w+Sjw/4nBdmO7Nw71SqYRtzrIoORgaVbE/DBp7VbhWeB9XR/5nn05ngAL59GLgbqKk+C9yI
	vI4GYnZKuq4/I1olsURd4iCeLUlXCUgJuKIE8dQbjHwPudadSfewWZcDwgf1vo9q5aH6d3JeMeq
	rDk+o/y
X-Received: by 2002:a05:6820:168f:b0:6aa:cce3:ab61 with SMTP id 006d021491bc7-6b11dd2ece9mr5968573eaf.9.1787056531226;
        Tue, 18 Aug 2026 05:35:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.135.152])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1166dbcf9sm4534272eaf.12.2026.08.18.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:35:30 -0700 (PDT)
Message-ID: <6a845192.26e5e084.9191e.9743@mx.google.com>
Date: Tue, 18 Aug 2026 05:35:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3559888124958554073=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v3] Bluetooth: mgmt: reply to cancelled mgmt commands instead of silently dropping
In-Reply-To: <20260818114116.3228662-1-shuai.zhang@oss.qualcomm.com>
References: <20260818114116.3228662-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3559888124958554073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147775

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.72 seconds
CheckAllWarning               PASS      28.34 seconds
CheckSparse                   PASS      27.00 seconds
BuildKernel32                 PASS      24.52 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      465.28 seconds
TestRunner_mgmt-tester        FAIL      235.64 seconds
TestRunner_mesh-tester        FAIL      26.14 seconds
IncrementalBuild              PASS      23.47 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: mgmt: reply to cancelled mgmt commands instead of silently dropping

1: T1 Title exceeds max length (83>80): "[v3] Bluetooth: mgmt: reply to cancelled mgmt commands instead of silently dropping"
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
Read Exp Feature - Success                           Failed       0.271 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.340 seconds
Mesh - Send cancel - 2                               Timed out    1.984 seconds


https://github.com/bluez/bluetooth-next/pull/609

---
Regards,
Linux Bluetooth


--===============3559888124958554073==--
