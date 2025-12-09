Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B659224B0D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765284853; cv=none; b=uZbcOLRzzwcAfaofyfDeeHQyfYipCoGk8fPK9VQ75mRbg/17S+/iNT53qteKTNUCWcxTz95kctjmzq/Ahv5BEvfeDCSvzsjtWKMRokdzBV1dE25yd/9xrFjCtb3udTnoM7KNBzCMlEKSVXRJTtrMLzlswm5gI/Pda+odkxENNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765284853; c=relaxed/simple;
	bh=vaW6plN577Lm63jpzNXH0KNvZi+xv0RtVJWC7b3jlBo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QLkNgqQKBnM99qlXvsI6ZYtzQ3Dcmbuw0p85XYhCSPMqdLy4d5I5TEhd6eEGp0FRyKw93fkq/qQOke4+XDXkoLB6c8nxButJDoskPaVU4cby9GcVBtrXtL2o5BfG5XhUxjn8pOIAexnR4vFtD1bXnjdBcqpzSqZ5MGoreeXK6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1CKDfLn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1CKDfLn"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2da83f721so600921085a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Dec 2025 04:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765284850; x=1765889650; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RqW89GUi3Rmtao+POGJsz+UolCVH8f5Yu+R24YZjFl8=;
        b=h1CKDfLnDAEMQtsZiq9ZyvMYBRQ2ckAcRdsud0TwyGvLs6kYxz9pPzWDJlWusYmNf1
         LHJeOJbZt9ryKaK6p9AM5xGVk9gHvJu8vJW6/DcQ1MJEo/XC6OgMHLO6ZcP5mM7n1GZN
         dAvLR3XvsJJa/8jD/je/2qb39OLFjKcgppiMOV4OaYOLQWPK11eCISz6cUq7FPPpqIhg
         X3KFg+S3nY3nj2GBuKZoPVDN0haGmM60glYc7jufChO+sqAEsz8gcJHExww6OB8NRVCg
         KSQzdWHmNW/848qsL54KA2nj/2qbaFKRBYU57GdJupOso/B97w5VMs5034jgrzyv24lx
         LrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765284850; x=1765889650;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqW89GUi3Rmtao+POGJsz+UolCVH8f5Yu+R24YZjFl8=;
        b=MaiZyjY5++2Rd0YedaSVBFCbI28CUA4FHgiTpzDtMt0QOjHIR+1qB5rrLLmLnJYw5D
         KF2GCLpAZb3XID9buyLgKFHNViMjozy7qybRKS6JIxDjpyfo6F7zX6wyxjY2Tw4IsBKx
         Pv+uklzDucuT7+p+lxpfXz/rUm/2EYi5MXPKy+ScR4AVOV6C1RoodYNQbth7PbtkQ1BQ
         E6ajYK12VoRpZ1E05qYsP3kV0X/z3ghzvj4u5YAjg9yC5ECIBhVC0fRDjYQkLKt7kHf7
         4rnYCAdBVOzVDn2EuFx6bIohnShMdEGHLwINUCoQGEZZbnZgo7N9D6KcRkd+w8jv6TzL
         QGNQ==
X-Gm-Message-State: AOJu0YwlhOTai8uMiNkw0OewTPMRtEe1cV4qDdZSm5vNIjYQkrPrW3Mn
	u6dyWoDVHq04iEvxfaRKffiLmtkxwh+xy1EqgANnvtD1N4GjYOduFJ7Z7yWfWw==
X-Gm-Gg: ASbGncvJujSDoqJZqQAFH9pVTy+sO/ul3sgmXGkeprq3pRWDO5UrmKyabnr5ErWNBhA
	GkZWCG51V4wTC9VAG0kYdnxey9/QFRIbVg/Gg+wrlaoTJ1rvD5e9lJUf9vbGFDYB6kxwSMsbIQO
	OeBR9OudS5Z+AEf3sRqgbEFNwbom1p3bb/LNqPBJMmOM6MxGCSDbMuzJeYnKeYcHvQSBnkURBSC
	43iBtKhIh/shnE30W11uvNnIV7GcqVdlkhdVWXv3XFvHLqbGmrPDv5+NvrELE975ZwYYCSHUfYz
	oZJUO5m1bE/7JBryzoiiBrn42aqyXWbIx9ny07+f3qdvbO3Exdw7gpahnBbxEDiSqwmeC4yZtzk
	weXfG4dxd42vVMMKhqx78QAt5z8+irarCY/PKI1r4iBjO2AN064+ku35CUEOCf4q5OQv1CC1wP5
	gjSNEeZ8UJTQUOrt/W2Q==
X-Google-Smtp-Source: AGHT+IGXWo0bQr2QMjRA8H21Lp7dq11hcu9mg0NBAc/uzBcH2kP7hGyeu1jy8ow30w4HCUfGYd5b6Q==
X-Received: by 2002:a05:620a:1a07:b0:891:7008:f2e0 with SMTP id af79cd13be357-8b9ccd0906bmr133411585a.8.1765284849937;
        Tue, 09 Dec 2025 04:54:09 -0800 (PST)
Received: from [172.17.0.2] ([64.236.140.198])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b6250ef1bbsm1319383185a.0.2025.12.09.04.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 04:54:09 -0800 (PST)
Message-ID: <69381bf1.050a0220.120789.4eb2@mx.google.com>
Date: Tue, 09 Dec 2025 04:54:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8724745987128786381=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v1] Bluetooth: btmtk: Trigger reset on firmware download failure
In-Reply-To: <20251209120559.2991698-1-chris.lu@mediatek.com>
References: <20251209120559.2991698-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8724745987128786381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031700

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.42 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.46 seconds
CheckAllWarning               PASS      27.76 seconds
CheckSparse                   PASS      31.06 seconds
BuildKernel32                 PASS      24.82 seconds
TestRunnerSetup               PASS      551.53 seconds
TestRunner_l2cap-tester       PASS      24.20 seconds
TestRunner_iso-tester         PASS      88.35 seconds
TestRunner_bnep-tester        PASS      6.15 seconds
TestRunner_mgmt-tester        FAIL      114.62 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.31 seconds
TestRunner_ioctl-tester       PASS      10.33 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      6.58 seconds
IncrementalBuild              PENDING   0.97 seconds

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
Read Exp Feature - Success                           Failed       0.102 seconds
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
Mesh - Send cancel - 1                               Timed out    1.816 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8724745987128786381==--
