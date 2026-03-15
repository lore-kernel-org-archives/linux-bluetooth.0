Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D71D9A54
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583589; cv=none; b=RlLaO6tZF4YPgwMk4iCrRUfK0txfaNjwB23kslz791s5Q5aECKiTFqOPdWmZSnRD382j9HocU7ByFA2oqboxL116HFiXs9kUxM1oBNpYYGCj2wQbxyx9+8zj5p0OlbDPdb45pTJqEi15OpGhcfeSmi1y/vDo/5kX2WNqS3BGZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583589; c=relaxed/simple;
	bh=c7hjrYO85FdA0OZ3/9bWPWXXNcl0XgEzoP4UKwtaPzM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p7hUWvpBQtziCBBK8hs4UV1S+KeRd6n9WYpEsZJFDcyDJ3+HwXHi61A6XqmuiGMEPqcn47tFIZWQ7Kjh6BjrVQ4kuN8pDlaTmQ4Jp6IAwi9L8zSD7s2pMe7Lp4MoakhkAGLRXtbw7CQ4nm4EpPRSxKhwl+XTPCq6NtWbKAF5uuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFvtwASz; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFvtwASz"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-46701f2077cso3736334b6e.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773583587; x=1774188387; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HymH4Qn5L36eJRbPnFwaTzanwTRLFNKHgQ5qT3xZHyM=;
        b=CFvtwASzqTEdIxo9RhTngVc//uSATRABazeNe32Vi4BYD9k6nh7x+mY9cpmwpNqhsz
         WZCaBUr9AlpPpgRfRtheF2LI/iHbPWb+XyR54Z3M9yvgyvKmC7fxx+KxM9RWq92ce974
         ZLzWjbOvBRreUs3N3/9DftVXS3BkjKldmIiJMGQgpPXVvhjm/43iyjvZG3TCO+c3guJO
         3zxm2KQRjg8VpXGTA+ptFqsfZAUEsx+oM+tkjatcxO6B9sm6MOYDdIRH04rBsehj7JQm
         DeVuHlilmd9Z26hLM8oA5vTk0+Yg1JgEBjcC7t/3xoiXOqyKKo3I8xVIWu6kQUouiajv
         OPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773583587; x=1774188387;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HymH4Qn5L36eJRbPnFwaTzanwTRLFNKHgQ5qT3xZHyM=;
        b=hatZCw3xIkOA8K3jeFSUuAbJttZbBBU4MyXtQ6gZ69M4AQm/JlPOITu4E1FRoJSPQo
         Mi+eUyaxQsrTY14YXPBZ7NmTstHyS2Amrx0lvgsR6B51ms44NIqsTD+LXvCVbOIRUcFD
         hEGwJzfO46fs9+4D903e571NjujuaJRzDETngS9UMnSjFVUgUktaKNioYEt4PsLg1sQE
         L+zl06kLVnwjjbBDJD7IT+NMvCOEM+hdtTovxGmVB2u7pfNb6c+IPcy3BercHwD+T2ot
         8231ZE3J7ItXZKBN4C1SR4qzbCeVD/EzNw8y7eoP57YrI1yVuZwhouW9YEc8fU2dtysg
         3trA==
X-Gm-Message-State: AOJu0YwY2gJuwsHSjit1EGkpq25QklzEaA4iTv959g3R4X6Jz3Gf/NfK
	3XyVCyRgXfS/I4wwbSu345YqKtb5RRtzJ/RtsWGwOYw8I290zLMrEYPraUJfiQ==
X-Gm-Gg: ATEYQzwMnaujEh3OsKvZxuiAhpqgPwmc2dnUieUt5O9U3hlCAXXlN3ClBlD7bGJj2D1
	SsPhDc4R76WOm8JArt6+GFVLHi9h5V6+/G5fIvW+qD6LfNmUDIK2dEa1BsXhCL5OPakuDGyIRRd
	lscClE7nhA6dVyuXASlrhMhCc15EKmddEpRm5ICg1mK3RPNM7GRsE1TE28jM9dVq6RhzhNtCQXL
	RLgHSNinfQ7pWfRe1YQ3Q7eaglJsq3/DKMwM39KMMSs0ura2NkCjNvsB2Dzb+OYKIuOHLHqo/AF
	Gq67omNiTpO8L5ebroImfvnaYrAbVG2ezpp0yQcD53GPpjYxDdQTXbOTuxOfLgClmNLTWEpBmjG
	5vojSrveDOVD3zW7QWduBTevvUxuELG37lMNWmf6U6FuQnNVOsaVtFWrltp0D9vcYf2TPhhoC6I
	dHE6ubMKmNwNYiTgg8ey+swcM0GEg0
X-Received: by 2002:a05:6820:621:b0:67b:b6d1:317 with SMTP id 006d021491bc7-67bda3abdadmr5386822eaf.3.1773583587114;
        Sun, 15 Mar 2026 07:06:27 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.83.35])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bdd612b6esm4083612eaf.10.2026.03.15.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:06:26 -0700 (PDT)
Message-ID: <69b6bce2.050a0220.3d4b44.fff1@mx.google.com>
Date: Sun, 15 Mar 2026 07:06:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7331847973924770885=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jacob.park.9436@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix stack-out-of-bounds read in l2cap_ecred_conn_req
In-Reply-To: <20260315131437.10890-1-jacob.park.9436@gmail.com>
References: <20260315131437.10890-1-jacob.park.9436@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7331847973924770885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1066903

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.38 seconds
CheckAllWarning               PASS      29.04 seconds
CheckSparse                   WARNING   33.50 seconds
BuildKernel32                 PASS      25.85 seconds
TestRunnerSetup               PASS      571.72 seconds
TestRunner_l2cap-tester       PASS      29.16 seconds
TestRunner_iso-tester         PASS      98.92 seconds
TestRunner_bnep-tester        PASS      6.54 seconds
TestRunner_mgmt-tester        FAIL      128.59 seconds
TestRunner_rfcomm-tester      PASS      9.68 seconds
TestRunner_sco-tester         FAIL      15.05 seconds
TestRunner_ioctl-tester       PASS      10.42 seconds
TestRunner_mesh-tester        FAIL      12.39 seconds
TestRunner_smp-tester         PASS      8.79 seconds
TestRunner_userchan-tester    PASS      6.86 seconds
IncrementalBuild              PENDING   0.52 seconds

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
net/bluetooth/l2cap_core.c:7798:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7799:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7801:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7802:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.120 seconds
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
Mesh - Send cancel - 1                               Timed out    2.528 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7331847973924770885==--
