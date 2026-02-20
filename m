Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC52FE598
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579651; cv=none; b=QVATBPoIcwp+NEJso1ecJI42hFINSEsBsd3pd565ElCDIHrXGEIjZCzo1YDvNCP42/ShNMYyUf11c5NTKWHf6y0q/rEQkodccAVeNOSATwa2n2laGHbWk0WLbcaeTbapplomNZmNjDAj7gjRJEczDHf8BHw36YvVrRX4gYDFHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579651; c=relaxed/simple;
	bh=qQ/ulrXI8RH+4s6JZlKhhdbbpUItAw7jW0NDyKndmP0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=S7IU8FPUju+rH0DvaV9CsapXu+QQU9beit3EGj5SN7NUXHaeU33Ox7G3e2XTzt1jkNfsxWwrMCXh8lTsrsQF+2Rrda+kH98s6RZDF/GD8J64dxlGLkplOt6PE/1adVDz/iI06F8xYrnTKh5TMq8De8LM1SopHT1Aj2argfE0zKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMFB4LkL; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMFB4LkL"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2baa098ffc6so1722310eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 01:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771579650; x=1772184450; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vuSKWX9WvtkgdzlbFaCBrNMHPf8gBYog36Nbw/KRIr8=;
        b=NMFB4LkL7wZHX53JDc3Gvfgi2ldo2KKWj2t80s3LRE7ZwUbhd17nR78XNoYd+BsX86
         CMot7L5kaYR5htxuUY8QBdjgtAIBEguRM4UPWZ5pvAZjnWTNf5ohlXj9kC4C43pDJzWt
         5Fg/Uvy+wk3kQnJCsSqFv5XGDjuHaiiUzilcvei2HS5TE/vW33k0GkwkbgpOHNpnRoVe
         MjQmRpfm49+kUTLBL13laWjqygS9t6r00iO/dyUHEqvwEmPjXlh/1oxGqifx62DcKkph
         e1eFQW39sgsywV42xFKMIc0kxwrGnaOj0ndh76bGjuAhqmzQKyByAyGJJVs2khizkoWb
         g97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579650; x=1772184450;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuSKWX9WvtkgdzlbFaCBrNMHPf8gBYog36Nbw/KRIr8=;
        b=eQzSuXQV24c3u/4LikxN67JEcF/PHcYw1psFex2TUY4Nm3KqRsDh+5aTySpO6aH04O
         jGkqs9VwoxM8Ocrer6DZKbLmmepYKMFcYg5XfilAHIaZACBV1VPbQMVwGDeoMJy55Uw1
         rBn/Tz6YJt8+cA42k6i4HbD+V2iMPHH7EBjQ6dnTvccLS9EmPkJLiQC9TO7a0DXOsrKH
         rwya+Red38Bbj7SHg3YKOtoAPu4N5DUSB2lpvb1dqQEsoJTYiZ5Gd3No+EKpGOHE4Eh/
         fX4JiTTDbHn+HdnGM4tW7Ryq/fdreWMEnywoT8xndO4Pu25LUTphfePpZFv73VrWNczs
         rt9Q==
X-Gm-Message-State: AOJu0Yy2k/+XJB7VWGSnd4AtU/kSG2LXJAjTv8dj73fav9AVIp1yW4Xi
	DhdUQumKrHyw6ePu9A0WseWtNR4FPdTAdVVvrUx/z2FkdpWwYFOg3ALtqCvEw+aO
X-Gm-Gg: AZuq6aJkrxJH0Dk8wMG+417bvRxIk2cXK7ZogxcD0nsMc0l9hHqNLrV1/N2PIWcKHMz
	agZ3rwqtBoVEu2fJ1fijlkXKckAwBV65ZFRpv26P1bzYp6VoopwB9vYNND8CfJ7c4qaM5vu+GZt
	O6PkHhiv3pQYCI272Kw8zq9J1OKlSRsFfkMjmrIDwDTWEOPUXZvjFwvWA+D/DGDzcZjYBOuuGGr
	CCW4I94Gs5R5wfCoyJhGZv5aLFSDDiKp5gAa0fmVGD6J7fKlfR2hOevIu/7cuxjrNs6vXbQqwlF
	GWz71uaLwYhfvZNlkIGYnDt8wWHw83W/SbL7gEGVdrHm4z1W5nPg3bs8TXIxr5lw9JM9WcJ0P2b
	sjXvDUL8BWJJyj7Z/AR1dATXL6oHvJcKCgXYUfqm2z4NavSeKfrNqDLyXRE0jXRnYMwTTK0CGBa
	111/cuMDhKNx5xbggGgLH1296h/YXlzQ==
X-Received: by 2002:a05:7300:d50e:b0:2ba:9c19:bdab with SMTP id 5a478bee46e88-2bd733bdfa1mr338183eec.28.1771579649413;
        Fri, 20 Feb 2026 01:27:29 -0800 (PST)
Received: from [172.17.0.2] ([57.151.137.150])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb543e1dsm23112794eec.4.2026.02.20.01.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:27:28 -0800 (PST)
Message-ID: <69982900.050a0220.19c382.abd8@mx.google.com>
Date: Fri, 20 Feb 2026 01:27:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5034576810327071894=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thorsten.blum@linux.dev
Subject: RE: Bluetooth: btintel_pcie: Replace snprintf("%s") with strscpy
In-Reply-To: <20260220080058.1112042-2-thorsten.blum@linux.dev>
References: <20260220080058.1112042-2-thorsten.blum@linux.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5034576810327071894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1055798

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.45 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.77 seconds
CheckAllWarning               PASS      28.30 seconds
CheckSparse                   PASS      31.68 seconds
BuildKernel32                 PASS      25.44 seconds
TestRunnerSetup               PASS      561.08 seconds
TestRunner_l2cap-tester       PASS      29.85 seconds
TestRunner_iso-tester         PASS      100.38 seconds
TestRunner_bnep-tester        PASS      6.57 seconds
TestRunner_mgmt-tester        FAIL      115.01 seconds
TestRunner_rfcomm-tester      PASS      9.61 seconds
TestRunner_sco-tester         FAIL      14.94 seconds
TestRunner_ioctl-tester       PASS      10.48 seconds
TestRunner_mesh-tester        FAIL      12.66 seconds
TestRunner_smp-tester         PASS      8.84 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Mesh - Send cancel - 1                               Timed out    2.777 seconds
Mesh - Send cancel - 2                               Timed out    2.002 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5034576810327071894==--
