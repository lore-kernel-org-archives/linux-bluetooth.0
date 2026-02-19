Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5430B50C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530289; cv=none; b=AnZhjNQBkkIMm9QyN92szE7TdtcDuIuAbugqrpijZJLXoMxmIvnZxHW6msIzqtfCfi0WZ3zhvIr3fHNwnOSlrthRiR929ZVtxHeAs7LQL87r7zPVl258jVitYw9/vee01ZfW9Lsmh6zER4GSS+SjwEMYbQlkNzzbQJsokeZnoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530289; c=relaxed/simple;
	bh=VwwcEpOnWHiXJWSo0VYPpUbeLAQPWd2bsOL/eb81O/Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gtaF0cjpPJM3E3VCTH5UzZ4Vaqi+PJxuzitZZaaEc5elH+Si9/49tVopAt1OWwJNyKRKHlMI5TX323ntR+YpScM2/FG+gny6revQIfbMaXNEzUlsP4s0B1Y6eOL60s3fTvjinI4kYXsqFqKpnAevoXCsfgzY66dKPP8qI24NQAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDlpdMNo; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDlpdMNo"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1270be4d125so2905087c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 11:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771530287; x=1772135087; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h33iB4nQB7xBWd2ODMHj6nYLpdGUEV8oT9Lfc4QdqIc=;
        b=cDlpdMNonwnXBop8jc4tSb0Sti7hsJWi1KHEOtWvRVRJKiNB/S7cMkjgE7f67cUwwq
         FoN3cKO7HDbzqvUz/pQWfZpQqlVKZJvltVgvB2khU5Jxp1zYOrYxDtTaNBJvO1QOja2y
         tpzpKidWcjJ/d48s64lhHHQMqGe8PZxb8vR6hwl1ZwvU1Vr76MGjw+2svUprQjkUChaC
         mq+B2OL3qdDWqH3yGU+NJIPiNdvGRFD9AZM4LHH8JWyeSbTViu/1oOjgUJ/7nuMOutuj
         ojIBvgdXrCCpaeSjOj94wYv/fwpTbfc5moUV1bh2wvhfef7udvYr+hnb7AxnmCGdMaBP
         AL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771530287; x=1772135087;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h33iB4nQB7xBWd2ODMHj6nYLpdGUEV8oT9Lfc4QdqIc=;
        b=lBIV6tmGyI8/Zk/mEKK5VBnUx1x10A1m2+dNgo6Jj4uv9f6sT0v197jNhSA0RhAAKp
         CIMZ5QChwZmHKwuF/4NLmxQLmnf6DEZRnYBWCwelCSWEHceJT/0/GEI3aeHzVaEDrM+O
         w0lLP5/SJf4Uf8900iXXPYLw9b4b9Y71gDZ9iQrnZoug0PUbxrjFDYooiO4aUXoKd/xW
         gOJTMMzb3zHBF4ehtpXPiXrjMF1a3gkSG8f3KRcovy3AxLxL9RsyfcsZtv8JsUd8waSC
         lhSO/BW+XQrt0U7ym9VffEil6GMECz7EddYS1gdOSWnuPwEvhjZzER8AIlovNE0lR0rI
         r2fg==
X-Gm-Message-State: AOJu0YzxRy/HVVSbAc4TaMvo7nTvr+kOuR/MHsdR4ggq8hMdmd1uwFAb
	LnMftRPrFiDc3zyjSt1+jQmlC4xqBPIim83raux01YF0z3IS9EnaQEcmMivjXNgm
X-Gm-Gg: AZuq6aIfLm8B0NhTL23Z2661ybSOdhcvo6AMyDoGRrXy8zLBGeaX9M3Le1RRMeBs0BG
	d6UqX519EX5wqiuvT+kAkF4WrpMlKq8xGAFluInPDA4Sm05GRaQFSc3b/SfYudora6fv/55lqPA
	VhSqrzSgweMx9MFpFaBs0Ncn4cjjAzG+aE9HiLLURt+ITOUM2LKg9z7jK/rmbhUiPPJEmnt+Q0E
	MZHZO0ErAX+TA1R4+YrzMkwoQaR5XpWJwTfQ1M00uNdazM9KR96Kokokw/MBqK04n3nAfrNogp5
	KFNbndhIFbVoH0EBzrCrght2WGa1SbZ+dNWgWDmDNXKG/vSoYLuBxDy27yB3nC5X/8j8y/yifjT
	sOINiv1nk6mRh/f8+nshtiMMiYS0LWx45+SBqIaA0UHwPXAtfZM7UdvthDyVm5FWGENM2sSD4aX
	VQqxO/Gso4syUmZWa2zN1TSlMxetoCOAFOEhNPkA==
X-Received: by 2002:a05:7022:249c:b0:123:3584:de40 with SMTP id a92af1059eb24-12741bf7123mr8596408c88.50.1771530286625;
        Thu, 19 Feb 2026 11:44:46 -0800 (PST)
Received: from [172.17.0.2] ([40.65.56.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cc9376sm26131871c88.16.2026.02.19.11.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:44:46 -0800 (PST)
Message-ID: <6997682e.050a0220.11385b.0e0c@mx.google.com>
Date: Thu, 19 Feb 2026 11:44:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1628106084764418151=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dylan.eray6@gmail.com
Subject: RE: Bluetooth: btusb: Add Lite-On 04ca:3807 for MediaTek MT7921
In-Reply-To: <20260219191102.64722-1-dylan.eray6@gmail.com>
References: <20260219191102.64722-1-dylan.eray6@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1628106084764418151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1055639

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.52 seconds
CheckAllWarning               PASS      28.37 seconds
CheckSparse                   WARNING   36.21 seconds
BuildKernel32                 PASS      25.20 seconds
TestRunnerSetup               PASS      561.05 seconds
TestRunner_l2cap-tester       PASS      28.11 seconds
TestRunner_iso-tester         PASS      86.15 seconds
TestRunner_bnep-tester        PASS      6.39 seconds
TestRunner_mgmt-tester        FAIL      125.07 seconds
TestRunner_rfcomm-tester      PASS      9.67 seconds
TestRunner_sco-tester         FAIL      14.55 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      11.53 seconds
TestRunner_smp-tester         PASS      8.69 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.96 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btusb.c:4661:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4662:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4664:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4665:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4667:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4668:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4670:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4671:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4673:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4674:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4675:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4676:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4676:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
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
Mesh - Send cancel - 1                               Timed out    1.802 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1628106084764418151==--
