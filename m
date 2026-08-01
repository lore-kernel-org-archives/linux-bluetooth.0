Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7D3C872A
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785612208; cv=none; b=MaZrDGbh2CKftpwF2BfIyZgM8fugzHAO5ljqIja0l3S23nMZiQTPq/DO+9yjw7sbtjexkGScVU/z8NkDVUk7wDWhaq3qeJ7m0NvX8ACEz1Y323aqU7JI6s39d5DP1L+boibA5LbFdPVL0f6Kw244E/T2rnYg8gP7OXrjkPYTfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785612208; c=relaxed/simple;
	bh=1NusUixglbRdAJ3iq20bGT7HU0PUDhLts5GZXJGcND8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iQedy1vUsEXBCv6Axv/8Hy3gZpDQYcedk/H9o3uNDK4JSAldC8yfN8Bt1mgf68wz2+GzIpfBtfp3Y2fbO2zWgXSRVQHOfeL306Qc8oIgEtN6s24CL50RosDTsRq3ved6KB0DG/oakDrXvC0Ukg1Vaz9u2WaMa4RnTheIyq4xtCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik3l8Mau; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik3l8Mau"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-667971437d6so2777451d50.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785612202; x=1786217002; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NQbAh2hLzghyirTKJkiDtL8F7YCAoV+K8ueYHo0QAtI=;
        b=Ik3l8MauJGrH9Sj2+1OfVCUpCdwxxnhus/e92/UA5snEIeoJWDZHd42APuxiTLzRoq
         X3DHbqmRQwXWqLJVlflValqunI4O0oEwmkQkw1BZtMShS32hQfxzVrVCTi3eH5VqNVe7
         Mjk7+3VqWl8n2BWzlhV8h90rXh+V+sJ2CyU7sxkr7fc59vlxzkM5aSMP4cUk80sVh/op
         qB8/1ksOwfzSsX59sAW5f/Nk8GM3hRj3vFszbe4D91QZv4G3P6f/cnBVTWHFFvSSj7Og
         Ea480aN2EFX9C1Fq3EJcXpeVCu05JNSv4XBoHYliVrK2vK/Atopcq/mJf/3KWVTH5rAM
         SigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785612202; x=1786217002;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NQbAh2hLzghyirTKJkiDtL8F7YCAoV+K8ueYHo0QAtI=;
        b=FC1VZYoZRNpAuCKfJR/33+zFl53YmjEiJ/xq2xKTJ0ha8o7mDI21FNSYikwep7CLJQ
         p6AugnMSSUczxF46zyZUu32eds477n8XUkZ0poiyQBg2qqpUfpPFb8hnEHYBbm3/3eaK
         Nrfd32wC93nDxMLolW7WKfOPBLHy+BTdvIH2cSyXQRvdZgIIZPTkZ0kCGA2r1hnolhXI
         pkYzTe2MevwNcEjbj1eXNLQdK9uSOIklPBVdxKgOX/ze9ZIip1Xjg9gBW0NgaTK575mt
         8QscBROYjl+z73b8Gop3NYhqMsKyIT7i8vy/zPIicAY3b5XZD3oXYvdc1CDu+fcdLhsR
         u1xA==
X-Gm-Message-State: AOJu0Yy1USslhTCOtqW9PzwY/mLKxQcdeLeJ7FfPJokWUN49Dn9cigJx
	N4X+omloM/OTWyE757pqnN06P0FB/JUtLJX7fMK6fPHbRCS/Ou4W8wlqLGgEmQ==
X-Gm-Gg: AR+sD115vyoAqVVoMNyZ5JhuUdCtudzMJc5ory5CMfOrDDGUKikSUoBXE++AbxbI340
	xy1EwYrSjLQkDKzUNeFZb8MRsFK4LjTxtL+R9Z5Lexf300XwFxRYkF88OF9QcM7NpYusyjpqDx4
	SmKZRaOr6aqMaJW3A4Xw0a1hx2s+zlzUdqLCO0m5EW9rq00mgunPVtIYGqifBIKF0nmNkWdfL/Y
	gxuH2kALcGdiSmi0cG4Dk2uBk2Pfv2UklKhXryDKV4TG9yNu1TuFQ8Cg1TtsAmY8elPleJmOzxI
	f/RmANUB+gOpBXONKqlM59dABz818WzT0xLHCcsW81tXvbLb7M6Bksu6vz4DOXdsxDh7hnZ5qNA
	+g66V3/iedM5FGENIJLixjB2P5BO2jo2F1CMdWLSkkdgSm1zizpuX8+0/VHD1Ru+CHlURgsl49P
	ryiFFb8U0JhRbbnf89CFgVoFDDFLg+5x6Mds3zDef4lrstxYbqwx3Lk6YrZZRuRaaFpdq/
X-Received: by 2002:a05:690e:80a:10b0:664:ae03:5250 with SMTP id 956f58d0204a3-6694f170776mr4997235d50.27.1785612202052;
        Sat, 01 Aug 2026 12:23:22 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6694902a58bsm2692196d50.19.2026.08.01.12.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 12:23:21 -0700 (PDT)
Message-ID: <6a6e47a9.f611133b.2443a1.5e21@mx.google.com>
Date: Sat, 01 Aug 2026 12:23:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7768126066124778065=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: Bluetooth: hci_event: validate LE Set CIG Parameters response
In-Reply-To: <20260801180952.52072-1-acharyalaxman8848@gmail.com>
References: <20260801180952.52072-1-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7768126066124778065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1138692

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.45 seconds
CheckAllWarning               PASS      35.39 seconds
CheckSparse                   PASS      28.35 seconds
BuildKernel32                 PASS      26.41 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      499.93 seconds
TestRunner_l2cap-tester       PASS      62.82 seconds
TestRunner_iso-tester         PASS      91.17 seconds
TestRunner_bnep-tester        PASS      19.73 seconds
TestRunner_mgmt-tester        FAIL      223.27 seconds
TestRunner_rfcomm-tester      PASS      25.86 seconds
TestRunner_sco-tester         PASS      32.25 seconds
TestRunner_ioctl-tester       PASS      26.48 seconds
TestRunner_mesh-tester        FAIL      25.91 seconds
TestRunner_smp-tester         PASS      23.26 seconds
TestRunner_userchan-tester    PASS      20.15 seconds
TestRunner_6lowpan-tester     PASS      23.12 seconds
IncrementalBuild              PASS      25.88 seconds

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
Read Exp Feature - Success                           Failed       0.244 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.945 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/525

---
Regards,
Linux Bluetooth


--===============7768126066124778065==--
