Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9F25C804
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781242622; cv=none; b=OaMI25QnX6dreoYfZUwX7bJMIU3d5kz7kyo9zfuMZd1NqgJarTnWVFKo7JulCQPw0bFC6uRGEliABt/AeSqEC/xnHHErfBpBLQGQIZeUISeS2h6zQfzX3mKI/ebwvSN7gHrrpwCAXc86WGGOc0yZstthV7Nd+sdq6/THCt+mmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781242622; c=relaxed/simple;
	bh=Lw2Ytip2QTz9knUC5wqIIGzpjBKzCGZa6CdZ2jQCwzg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q+WnrwwgJ7u9ug26SwsZo5dCnt+rcTBV2svOYcmRdWWj/XtMsa8MXj51+9sDkb/nf61DEq5kFW6ktK1fGSedZVXiIBYv6J1DJ6XUGQd4sXz863au7V9katOeVLf/LD80C5ESO4Wlpdo2CkW1+h3OCqr4mKJlvwB/kt0o0k5+Po4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX5mR5fc; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX5mR5fc"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304d7f31215so617295eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 22:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781242620; x=1781847420; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gALloOXnSaFYTTk/SXvZ0OWKfnpju343ne1en2uz7YM=;
        b=mX5mR5fczJlhBvqIC/e56XAngjYoYy58TYfIPa96jjwkAo+JRxob8iuc9b7nbHPwbe
         AHYXChVywgbs30pjwFXOrDc5mK29kesFG1O0XLzj6KEhiNtH/9KQ1Q+1us/sddZPmTxc
         UGbAHMUFYIg3LOefHdaE02gIFI4rb91KaKhcriCIx9qPnPopPgXCktMtZXgrGHBRP5OU
         pDKUXuMc9FX9OTD5U0oxS+myYdU/g1KQ+RpuAn2b921B7fZz4ezo0UlWcKzzBVHc1pd7
         DLaieaDBPCAtG2oFcyBqhC84cY5Vft9jrhhJkw6S5Lz0qmIfPQnYHMC8rEvTF0G4cCJk
         b8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781242620; x=1781847420;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gALloOXnSaFYTTk/SXvZ0OWKfnpju343ne1en2uz7YM=;
        b=BAyv58gFpDt3jfObTSO4ZM9jjaZK2wSYW6xaUQBHwVPSQs7jPgXWfz27PpfAxUPMxq
         RNBZ2AorB1dUvCknHnqD43r+sUq2X9BIpksMQLrAfqGvgP8Jds56euT4VBcDdULGDbl8
         R2wqVRHz7N5NU4hufNInjJCmLQfBtuS1YTKbw5Vcynk96KnUSRa5vLXHJybOzUP+xDl8
         /CIfEhBpHDbUrBSM2StAR3iFk5WA4NkLTfRg1eW013dPOuavSFjeufshJxefaTfr9nTV
         blXM3xnML8kojVkxC5SB2SC0smVmc/92kDTyHXquEmLo68+g6dH/dV4poXXwregql/8i
         WUow==
X-Gm-Message-State: AOJu0YxRuxYknGCAw4PB1puQth3PNLZg3vT/4aRHyX9ffJOiCUtE6eYw
	/wPGkXX5CFl4VmJUFgemK8/l+pJvfEoy+tMBq/giz0S0RQqBIikQX0fG9rzCtg==
X-Gm-Gg: Acq92OEF8uMaMr9Ju1sy9pqTdWtt0dX8c3s+UdkDGxX+9ZLzkNa16nuvdRx5htb2g6Y
	Zx+Y583OcAPY4py7x6JmexwfLy8LXE9SdwywqJsZ1M559jbvO4SuaBTpI9pG+sxxbodlzqchrTA
	C/+QSjsnj6WIC6torioXX+SoquktwaWMZDD+r8mntuxpCo3ovkErRh4l38lrG9RN8Zsk4H7rhHA
	p0P7D4ltn1aIkHQMO0VN6GCkQbv3z8SpfHYFwQhKm77GndVzjJFgOI7goWrVNa8neMp71eNCIw2
	Mtqol03DUl1eh3GWTfFk3rg/RM5erXo/Zy1+BkMnU3zl6NloieSQOUKZn2iRdkEf4T1EijiGCcH
	trq2jrmWHOP1CepIBALqpoV6ZvQvOhMjZaaNCjg4O9WLjGAJMcAENc38bSfsI5X3ukVNmOf7nZm
	8QPN8BLxYMsDGsf3baPCQmxODz4/XGvGn0smWOhdk=
X-Received: by 2002:a05:7300:6c26:b0:304:d82f:c2da with SMTP id 5a478bee46e88-3081ff71b5fmr852297eec.8.1781242619923;
        Thu, 11 Jun 2026 22:36:59 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.58.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb9a138sm2624594eec.31.2026.06.11.22.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 22:36:59 -0700 (PDT)
Message-ID: <6a2b9afb.e1c1f991.2297f8.3751@mx.google.com>
Date: Thu, 11 Jun 2026 22:36:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7044222967951045971=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1,1/2] Bluetooth: hci_core: Add reset_type parameter to hdev->reset() callback
In-Reply-To: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
References: <20260612012832.2395034-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7044222967951045971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1110374

---Test result---

Test Summary:
CheckPatch                    PASS      3.16 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.77 seconds
CheckAllWarning               PASS      29.45 seconds
CheckSparse                   PASS      28.09 seconds
BuildKernel32                 PASS      28.65 seconds
TestRunnerSetup               PASS      578.26 seconds
TestRunner_l2cap-tester       PASS      64.11 seconds
TestRunner_iso-tester         PASS      76.12 seconds
TestRunner_bnep-tester        PASS      18.76 seconds
TestRunner_mgmt-tester        FAIL      212.36 seconds
TestRunner_rfcomm-tester      PASS      25.63 seconds
TestRunner_sco-tester         PASS      31.99 seconds
TestRunner_ioctl-tester       PASS      25.87 seconds
TestRunner_mesh-tester        FAIL      25.83 seconds
TestRunner_smp-tester         PASS      22.87 seconds
TestRunner_userchan-tester    PASS      19.36 seconds
TestRunner_6lowpan-tester     FAIL      45.83 seconds
IncrementalBuild              PASS      26.05 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.244 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.657 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
Total: 8, Passed: 3 (37.5%), Failed: 5, Not Run: 0

Failed Test Cases
Client Connect - Disconnect                          Timed out    5.240 seconds
Client Recv Dgram - Success                          Timed out    4.987 seconds
Client Recv Raw - Success                            Timed out    5.009 seconds
Client Recv IPHC Dgram - Success                     Timed out    4.986 seconds
Client Recv IPHC Raw - Success                       Timed out    4.997 seconds


https://github.com/bluez/bluetooth-next/pull/306

---
Regards,
Linux Bluetooth


--===============7044222967951045971==--
