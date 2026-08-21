Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD449362C
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335156; cv=none; b=uM1W7CNZokmJiBwdKWzZgtwMKNC00F62rmBHaWfLT/7rwx3xgx6aFspZfkXX3USjdxzgK714guLrqDK8hi1GHOFJ2s0HAXDKF0OeQ1eUFK6KFb5lqh5tHE5KuZ/B7sR7a1sRCXhkV2FDoS/bQ+fPbm02HGH0ic/BJ6ykJhkC5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335156; c=relaxed/simple;
	bh=cqBfXgAtCOi3nNY9Z9AG+vnKR9VM3+4tN1dZ76t1pkA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V1GCecBueIImlgF9OrLEAVthUOMLypXkYe1oIffpTRznPYadvVNV9qLY+kG6aE/cSh2InrnyH6R3KfwKSQ555PAF6oBm0piKbhqrs4VOWldRo6FatBgEL34IMomSsVdrUYnM4SjYKkcnG5BcbL30XirBqxXBwWR7NDMd0U2yGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2IwaM/u; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2IwaM/u"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf50c6f235so16141305ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787335154; x=1787939954; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jfyNqVLC14zGgT5pKC9vi72VzHv5wWkDtBaK73H7jZ0=;
        b=e2IwaM/uXbxsqIDwL/jorMPR+627xDRgvQnCDtszraRFoc3F5dZEVdvDa8/cJurqiC
         tL0xPk1kNAzmQwN0TUM5EE4fkFjFjMU7KET0DhFgTk7mojlixKGLiUU4Oc5z7T/x5RSu
         K8NgZCx5ZNDBp7pjuENrM64qrxwbbgyCgFJU6rRgiuobgWCAOzdbge0L8BROuVbmQUiU
         sZyFTDyXA3iQuTjb9RqV9dJQGMX9F0m97rx6aDYeNAPKqUi9Cen+OQJGVZSbig4MXRot
         HvpfG0UiVjGk1b0fzXxjJVlattibD9A/fHhwHAGL37fJgp1jtKztwVurmosnBIRiTH+e
         N3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787335154; x=1787939954;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jfyNqVLC14zGgT5pKC9vi72VzHv5wWkDtBaK73H7jZ0=;
        b=IA4t9sPsjBj6h1/diMPwtti9NE89kYXi2vXtb/PKnqjFGN5C6+sTEUYvcK+qspwl9w
         S6ENBGUOEOAgNXZw0XXGjuDYjqvWV3k67tAfM0N1ZUUJoG/3QyHUvMo5NbRpE3ArGtoe
         jQDt4CeAzTBFx2BbNFVZ/XN8KVPSQQu9RpPqEWOxF77YKzzm/ENA7Tu6PcFSgg5R5qLU
         jbmHvkIcg/fUdwhqWoopIbKmOVT24b6Itrnd/vIHRzKqA+8wSfoVoMRH9G4dMBQT3HJU
         SiDUWJXMPOsVhcLX9uuI19PMVr7lrgPogQFuEE/3AaYuQsu02mZ3fAqtpIkci+OGA6qA
         UJtQ==
X-Gm-Message-State: AFuF++mbxEspHDyUKFa6pnVY4vlCCmiyi8Z0VP4beJPqkxLmkyy7mlqh
	1MXiNdr/taq1K/MrP26copAs80FM6LbZcsqJWl5pYCgmdMKA+Wfe13pveBw33Y8T
X-Gm-Gg: AR+sD10DCWKkvcpCx9GtpXS/mjRP0gDzdO/64/gw2nRW/MfxLdZQ56R2sjTcb3gvEWu
	A6vC7tkgRBB6GhI99gUfgLWDihSEQgu/8i1g/QGZOzy7mkrHDIGSECzzuWdb3r28HuIjltNs186
	fkza9uOJ30TdKmDWgPIB1S8wjiqtZlMyMNIu1ZXc53u0pkGGUV00WhaIvgJkdHqz6+zrnE2LPA9
	A0ELWcePdWCm02EqspjTgLEaMOSsW9Lrd5t74W/XDkMc1rdPH4j7bjQ+9sbLMlmrWe1s0ybjyIR
	VCdMlHVdZPj0U9LBofZQttByMJhKrLVYWxYYpmLgjR78z+ssepwvt0yiOqvG43bDQFS1jE9mDmW
	8dhsAPYK8jn5gXjvXLDYSXkece712eFyO0MRoyLlKDElxQX0Nx7UPVeNgK/E5f047f6E0n5sBQ6
	0MBDdHWVlhzp+v62ZfJOzFQUYDdPjHa+l7bZVyOAzvoBRk9GWt5DqHi3LbWxe7aCDG32HkKg==
X-Received: by 2002:a17:902:fc4f:b0:2d5:e9d5:8ae with SMTP id d9443c01a7336-2d64adf7719mr60779825ad.5.1787335154271;
        Fri, 21 Aug 2026 10:59:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.223.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d6168e5bsm18546448eec.1.2026.08.21.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:59:13 -0700 (PDT)
Message-ID: <6a8891f1.d07e16d6.329d01.4fbd@mx.google.com>
Date: Fri, 21 Aug 2026 10:59:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7019596961844877028=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: [v4] Bluetooth: hci_sync: wait for directed advertising completion
In-Reply-To: <20260821172441.3020751-1-nicoyip.dev@gmail.com>
References: <20260821172441.3020751-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7019596961844877028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149955

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      20.72 seconds
CheckAllWarning               PASS      22.44 seconds
CheckSparse                   PASS      21.36 seconds
BuildKernel32                 PASS      20.27 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      366.74 seconds
TestRunner_l2cap-tester       PASS      52.34 seconds
TestRunner_iso-tester         FAIL      73.59 seconds
TestRunner_bnep-tester        PASS      14.91 seconds
TestRunner_mgmt-tester        FAIL      180.28 seconds
TestRunner_rfcomm-tester      PASS      19.78 seconds
TestRunner_sco-tester         PASS      25.55 seconds
TestRunner_ioctl-tester       PASS      21.03 seconds
TestRunner_mesh-tester        FAIL      21.54 seconds
TestRunner_smp-tester         PASS      18.33 seconds
TestRunner_userchan-tester    PASS      15.47 seconds
TestRunner_6lowpan-tester     PASS      18.20 seconds
IncrementalBuild              PASS      19.11 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 136 (96.5%), Failed: 5, Not Run: 0

Failed Test Cases
ISO Broadcaster PAST Info - Success                  Timed out    2.777 seconds
ISO Broadcaster PAST Info RPA - Success              Timed out    2.004 seconds
ISO Broadcaster PAST Sender - Success                Timed out    1.990 seconds
ISO Broadcaster PAST Receiver - Success              Timed out    2.107 seconds
ISO Broadcaster PAST Receiver Sync Lost - Success    Timed out    2.111 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.196 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.666 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/629

---
Regards,
Linux Bluetooth


--===============7019596961844877028==--
