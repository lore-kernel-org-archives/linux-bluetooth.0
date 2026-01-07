Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42F2E9ED6
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777337; cv=none; b=CIMCKn0Nn5Zwufh3MpZhPp2L2rSddz19Xhsv/nlwO0OzIfw5QDLvZyyhw98szd4rDb/lC4DTjjvbxbKx0lTaiAmUfteYOw8RbNviBtlsmmt0FrdwQl5hClMd8c646JK5vXd7r1p4pjcZu4uleGup7PdFP4QEFc2GGAq4Fq9gFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777337; c=relaxed/simple;
	bh=ytcsRLZ+mCBsMchn8Gk+IiW9Vy1K49zH7l37qmPgySs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BwZUwJiACAihl8RHDmkHmOP//EKkUiWwKf2qhK3QTl5eZ3RbyZMlTCI01R8ngnk6jRpoZzU6hDSlW7Sr29EL8LyFGzg60y3oaEA1NdSXWoSHEYqzIbxE2+PH8ZrpNWTgIIFaly87Lvp7or+J3QJzsQ+h2y4q9hE9T4Ze6bxMHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI4Yzz/g; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI4Yzz/g"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-450b5338459so1152709b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 01:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767777333; x=1768382133; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l00pChWmWxYTe9laIu8x223UBSyjQr+xIx4Gc7SkldM=;
        b=cI4Yzz/gxktycKjK/67tob8lpInG9yvzGxDXS5GF0lENX3bR+g/6ii9tOZ/SzqP+dJ
         ffn2kEc/5OjhHb18kFBI4hx9lIUpqnfbij5v8fMKuwUBOfJYZNlsBH6yTR4rP3L6i3DL
         krLPJGBms5KTemRFhepASsh3Zr8rjS4qMC8yksoOZHwDz1hyVZVNe6+/DDwL9CMSkUE5
         BvCE1kPXR5K15zMq9rzF782pF5p/ZrrrJGsXNdEpbpMmzgpgt3iWJUAruC16lFOR+qeT
         eRWvei7KYbW2M6zydl8s4fzkkGq0WWXeyBtYAqq34lSgUJw+mH/Puo6GXIrxTek0waZq
         2IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767777333; x=1768382133;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l00pChWmWxYTe9laIu8x223UBSyjQr+xIx4Gc7SkldM=;
        b=EEzicEi9XyyPNYOKPtGKSBSiVSxmsch/tMGayb44aUXTGkl+AziSw70Hbp13NlMvfs
         tWC+4NAGQwu5XR8uQ0//4W22f3V6C3+mOO9u31s0vF8La0zSjEdRzytZe6M/Nseano2m
         jpiArnZ18NOGWNlhsuK80o4R8qQf+vY1cdmCxgIXQf65qB9prnQdRo72IyA2A17n+rdI
         UBFP1l0YYGlYqOSiHCoNYX94i1P8i3KAn9HZlrFVf2L3fd2Bx5kQnpZYO2yQKDzv/8t/
         /X1ORhsD4ii4y0SQ4o4LZ8zA3otQwnfWL50ykCaKruKkilGGUcIfbs1mfUtdZBvmmzGD
         5rkA==
X-Gm-Message-State: AOJu0YzznFOHHSMh+rxpLNlCihzr8Y8bMtIaB+G+Pga9uwSFEQwlbCd3
	+2ZJDlZVIMaS5yr+a6Xcrhmwfsd2cC8KxAfLowMp18cEorsSW9MGkmIMlYebDkwI
X-Gm-Gg: AY/fxX7gFq5XXPmRZqB8OfYuJIEu5357mKACogVxrIkaD5M6qVMrpvuRjnk3xikCO0r
	+aECFysBXBDwnTeEirT2LA8wK2iU3PU1t9a8iKvSQofjl/+zj+dTOaFNq44RXbxsCK/1tb2YoTN
	t22R0yPvSo6lOmXuil8+ov/t22NBGR4puWjZymCTxrO4rco/l2KJRbjK2Q1AxJoNaLD31DZOo4V
	HyUAtixbpHha+BN1S3d8zv04wyL67/AUYZ03qa9aeva2TNJIhrXQ/KMH5G+pjs71IHjYoT6pRf5
	rv+BqHYnEY4ourSEwYfLBBLmKwqB86YoaNcm3LNqVufD9iQTvK77t3cZKie/9kFxnLY/PITO0k2
	RSf2/Thg89r80QbMzj82wTZOpXUQZSxixpLUQBZEIDXNFw5vtxfq7NSSm2XA3DI5W/7sUEVMw/v
	WYPyjHcn1G2qqAbe5bCg==
X-Google-Smtp-Source: AGHT+IENjkYtlFOf9Ms+7bMMscoGEv3Iopju2VfkMlqdoXMOnmuoYu2oYDIGjr/CczhPEBY5+zER4g==
X-Received: by 2002:a05:6808:1306:b0:450:ca65:ef59 with SMTP id 5614622812f47-45a6bd4ae89mr978556b6e.30.1767777333344;
        Wed, 07 Jan 2026 01:15:33 -0800 (PST)
Received: from [172.17.0.2] ([132.196.82.129])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e288c42sm2115323b6e.11.2026.01.07.01.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:15:32 -0800 (PST)
Message-ID: <695e2434.050a0220.160b1.0974@mx.google.com>
Date: Wed, 07 Jan 2026 01:15:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6408591657626552011=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: mgmt: report extended advertising SID to userspace
In-Reply-To: <20260107-mgmt_ext_adv_sid-v1-1-1cb570c7adf7@amlogic.com>
References: <20260107-mgmt_ext_adv_sid-v1-1-1cb570c7adf7@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6408591657626552011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1039290

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.36 seconds
CheckAllWarning               PASS      28.03 seconds
CheckSparse                   WARNING   31.58 seconds
BuildKernel32                 PASS      25.32 seconds
TestRunnerSetup               PASS      552.30 seconds
TestRunner_l2cap-tester       FAIL      28.82 seconds
TestRunner_iso-tester         FAIL      56.41 seconds
TestRunner_bnep-tester        PASS      6.31 seconds
TestRunner_mgmt-tester        FAIL      122.98 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      14.41 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.72 seconds
IncrementalBuild              PENDING   0.51 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.131 seconds
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
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
Mesh - Send cancel - 1                               Timed out    1.903 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6408591657626552011==--
