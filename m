Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604D32E743
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564038; cv=none; b=V85Kz/6zoZMua93f1vqBp25FZjTi3lgmEaQ2BNV/wLCUlItpXRB52aXKnRbOcl443o5ZdE7mJT0sJ0ugLhIjUG5S522hCoxH7785WQw3liVzQihBrvdIUoCIJ5PSlJ7VPxmT45tD/bWHr2Ukp3CMvktYAuU+udh+0YqeymmI8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564038; c=relaxed/simple;
	bh=32i9CF+gww6ryh+2ZqNuvpkUTWIPJSD9cUzAHhnT0xk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p7dtWEJYRN88/zQ7blfBmIEuzZ1O3VN+/LY3bQN9cPnjgMeWEzCw38YqkQ2aNzZjnwA1HHnMKnLMO5VIpP3ZJv0FAj7ltvDMyJun1775HRXgD6ZghYUEvgr4KUt+04/UgOil03voh89RehxJKoGIaJdAoH3MVKNnPQPvbRC4xmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNqqo4RP; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNqqo4RP"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cbb6d5f780so176718785a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 15:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774564036; x=1775168836; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw0eldtEi4ARR2M6ylYfWeFki6BBqLTPz9UAelA8eNk=;
        b=sNqqo4RPMhVOs6x1u9epyGRPlQP5IwxwrHXsHcGaGgK5rGvd3W/y0jA5hmABLBA76X
         cOTLOM1vcPtOlPH327CONHzAIqKnOaK7bGzh0QeWdxO2QQwjOHVBpLHBc6mDeWfx8afJ
         fs+8kJW9cRn8vxP/nAWAlxFvE0m4FeftTEx1Cjjtf/U4jMIOG1xNTIy4m6goNrJV0nfT
         h1LkUjSIRtpWp0idS3a5nZe02fmzFzNf0tOJDNH7VSJAX0XnY8NOHB0fnfSZOzoDR7WB
         GjJgkzy6QaI5aXzOmPE3qjs1pUKmWiIpwNgTMd409gTaBCuXBhLNphSKIiMUAQaCCCVn
         9eSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774564036; x=1775168836;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw0eldtEi4ARR2M6ylYfWeFki6BBqLTPz9UAelA8eNk=;
        b=ENHDHmoOIcsgpyx0TJj6/TP/70UbICAEXFdWujKSrKHOY4d9tAa99nQVcYBh14RmwD
         2nwC1LgRWVsUoqUa0rsF4IMObL+Z06H85eKpuBxa//78o02T+vxWjDB0zlZ8dzKRnskY
         yul3xVBD1/HKMNX9zfa/IxzFus15WNsLUIj7o2gptsUTXiayVBM5vLMFtpJnPx3xxaSo
         QzVxY4JycisDKmUSzcsh1Kpy/Hyer5XJ8cq0hJ8wdCl0QFZ2xDw5Jd4EU5UfqvzJpKZv
         fyAg6FyeagfGKsJdl58/hJ4e6RFoNR2HI1lX3v2zrXIo7fnL0Gu7u0/UpZDhvhPaB/Yb
         DqWg==
X-Gm-Message-State: AOJu0Yy9BQPY4Vz8oT/kIOCNWKpwEW523z5wpzZlgv6wbKWNWMpa4oUJ
	wULJiQgFw+K+IdkL1PJ9fb3xdxf2b59k8PgMlObSdw8bHB3B6LYYAtp7pec7Lw==
X-Gm-Gg: ATEYQzy20iTvezvFBITJJAv8qxN7mA/ZSLfGbwdMWNdCORHPovkVZez0VqyOa3mRwSA
	k73uJUWxEKLYVecOziNTN+IaPh8f9Leo+1+au8ed8gUyDLpWvcgpi+bFKTr5SRAMYJ4X+HRTWvL
	WNecycp7dsVmgFBfo23caWSX5yubKIQpxOvb/JQ8/BaAIoE1GZHRm2WQuBAKGZQjemBS3UYiU1f
	KU7UW2DQfp7CttwD7SBv4b5VeYamEL3KIWMibkZ+F/oWW3Ny62gKDLb+6XSLq6U8ulizxENQJpM
	4PS5MG9hBCKpMzeCcyrKzY+MUHP2VRYhwfobS76s2f3pINGbqFPIwZu9VSbWL3aucqoV3fa03uT
	UKH68IQsrUKDILbw1I0g/hpwqOeYspTh8RS3gkqMzReoL65C704iSwyI4pZ6ES4YAQySAHOaluP
	Vy8ynXfN9wSIC/DOQkXTb7ry44voY=
X-Received: by 2002:a05:620a:4014:b0:8cd:7f7d:b091 with SMTP id af79cd13be357-8d01c870d8emr20703985a.71.1774564036179;
        Thu, 26 Mar 2026 15:27:16 -0700 (PDT)
Received: from [172.17.0.2] ([51.8.121.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e4cf163sm347179985a.27.2026.03.26.15.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:27:15 -0700 (PDT)
Message-ID: <69c5b2c3.050a0220.322c8c.7500@mx.google.com>
Date: Thu, 26 Mar 2026 15:27:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4916977586775427663=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix UAF in le_read_features_complete
In-Reply-To: <20260326205046.890020-1-luiz.dentz@gmail.com>
References: <20260326205046.890020-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4916977586775427663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1073172

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.62 seconds
CheckAllWarning               PASS      28.87 seconds
CheckSparse                   PASS      27.82 seconds
BuildKernel32                 PASS      25.76 seconds
TestRunnerSetup               PASS      567.70 seconds
TestRunner_l2cap-tester       PASS      27.52 seconds
TestRunner_iso-tester         PASS      37.92 seconds
TestRunner_bnep-tester        PASS      6.50 seconds
TestRunner_mgmt-tester        FAIL      111.19 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         FAIL      14.41 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      11.57 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.73 seconds
IncrementalBuild              PENDING   0.60 seconds

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
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.129 seconds
Adv. non-connectable & connected (central) - Success Failed       0.120 seconds
Ext Adv. connectable & connected (central)           Failed       0.175 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.169 seconds
Read Exp Feature - Success                           Failed       0.108 seconds
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
Mesh - Send cancel - 1                               Timed out    1.887 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4916977586775427663==--
