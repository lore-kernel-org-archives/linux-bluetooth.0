Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5DB3B4417
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073450; cv=none; b=kBjYSmDH2VV3E5ca24QOJ05KrAG/8vUf7hbCWNnoGWAxVoYuCvq5BTAjwct29l2csN+0m9p8hx+6AVUSbmLMFz2Uz8VcnlUuHwKG/crCb5nk1P0YH+7YAt2C6IAzCCjgRAJNAOnc4XhtfnaRlZV/hYQhoO1/Zc6fATxYFQUWKII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073450; c=relaxed/simple;
	bh=EOU8ONiRErkCx7kGzrgDda6W0y2Ej2kT0Dtv4pExN14=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aYMeSmgLr6QyR4Gr6/H+eB4XnJ+3blzSA+w2JmNGtc7MlaaEl6VdEh1V7+9fGOQ3yelfqkH54Tx3nnKUVKduUFl/73RQ2OpEi4SMbDSp40BFBeInncF79fmxzi3xp4prLuSL8qOh9sAZQQE0g50tUiB9Z6wQPvlvSY1pw1xsh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meuPh8SA; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meuPh8SA"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0c68aa31so2358841cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 03:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073448; x=1783678248; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NKVq+9S3V8zHfm3Gsptf+Ai6LEeNfB2tAhT6x21osBI=;
        b=meuPh8SAluLKfSG5N87SRzDj35wSPB7QiZBPNHGAQfmJ7j2Juxnd2NvW6v6UbJhj/Y
         hxdgMW9ccbv4Qf1i71stxg2TiS13Whf1HxnBcVgL3v8G1k+iccHvLuEc/DQ7fUB1IiAA
         DJAuUn7H2AlUM481Ay+4qPzP7+g+zjV54H9UEAsODHj8V/OyI6S2MGGmCA/Udl/1E3S5
         YvTCfSTV9wCPX/ihxzq2tkFeVCUnGhKPgJIEFyQlxO/9bxpdEY6kiXC7dXRq9vwBVjA3
         6xP/96iZNjS8YWz8A2uttehQ1cUZLtSVkvnOZ5oxLIK+zqvo4niRBtfmqGAOKrhg+RSM
         R3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073448; x=1783678248;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NKVq+9S3V8zHfm3Gsptf+Ai6LEeNfB2tAhT6x21osBI=;
        b=pl8YQj4Ki6f7eSVzRvNy73OPVqgNffVzXVgJHnLvKPYJJnm0eS0Pgp8plCUyngHggO
         2t3xzaZufEvROtFVzmKQkelUp3iUxROeGl27PypfPwOUG/s7zAmhmNq/552G7zaIBqzX
         tkSwE69E04EG4ywRUDaTna7XnyRAuiHHXq2xmc/Z4EFsWtKm+MZNGuZFIWbSJXDyc4rk
         S2zTRblFKVDpUxHGmt1o5C0D21PF1QoloBitDQdnKNI5J0CMC7IsFjWRWeY9lkmUC/zw
         rwqbxjzTLovQz1P0mTuyD66myCWqQGcz7eioL1NdybA5i+yUGGVtF3Yh3a1SMTD6dKiK
         pLdw==
X-Gm-Message-State: AOJu0YzNu2MlSF0fwlXZXmwzcQv+NL4GJApSqyUrGlkyjmlxphrDDrJP
	D5rOCBZ67F67ITrNmLFS/9yHjG/yr8F9Y99tyT2YmV1dA8etvbM8mygL0ZD1TsUH
X-Gm-Gg: AfdE7cnbURGrjwiL8dpyO+eyHG8m6Q64YicEjhgLsqdJXggko7xXmLyuQC06niX1d5A
	dcmQxs177fqapdHQ8X+yTniD7AOPdiqnffXLXcPW/AHTsWz7pilq5BUJ9zokbKZ3k5NOdWW5Rnd
	4VCD51sqElKyY5GtLZLgWT1FvNbmt13S6M/s97P+aOI33qwR4D+J14Gty2MnkDEObsXKjO+WiAm
	q82tK7MqeyiitNmzDWZdzelN5zrvkglksijAEaSRiH/W7JRAvSjEzW8IvB6V018FvHri1FL7VO/
	GDYwByW0mY4/l09ymtOgfcjbWJ45NXPOe7aXTxWxE3Hre0Z8QRBmq17Lp5/Os+CoxU0U2r7HoDc
	ExZPhriGw9hs/BJmOLIFlo4UIevni0uALAm/XPhWj4M9HBELmY2vw0oc1cinM8/oj06NfAXTRUo
	dJ4ivkYTdSliNbB0Lv2xuZQbiMAAP0UFY=
X-Received: by 2002:a05:622a:5808:b0:51c:f3e:781d with SMTP id d75a77b69052e-51c2af3cb77mr112499861cf.66.1783073447718;
        Fri, 03 Jul 2026 03:10:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.245.168])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41abe73csm13725401cf.5.2026.07.03.03.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:10:47 -0700 (PDT)
Message-ID: <6a478aa7.99af2db9.114264.42e7@mx.google.com>
Date: Fri, 03 Jul 2026 03:10:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8150643858470351922=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [v2] Bluetooth: hci_debugfs: serialize force_bredr_smp writes
In-Reply-To: <20260703081431.922054-1-zzzccc427@gmail.com>
References: <20260703081431.922054-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8150643858470351922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120995

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.35 seconds
CheckAllWarning               PASS      29.85 seconds
CheckSparse                   PASS      28.57 seconds
BuildKernel32                 PASS      25.65 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      494.82 seconds
TestRunner_l2cap-tester       FAIL      58.69 seconds
TestRunner_iso-tester         PASS      82.99 seconds
TestRunner_bnep-tester        PASS      18.60 seconds
TestRunner_mgmt-tester        FAIL      210.72 seconds
TestRunner_rfcomm-tester      PASS      24.85 seconds
TestRunner_sco-tester         PASS      31.78 seconds
TestRunner_ioctl-tester       PASS      26.08 seconds
TestRunner_mesh-tester        FAIL      30.43 seconds
TestRunner_smp-tester         PASS      23.14 seconds
TestRunner_userchan-tester    PASS      19.72 seconds
TestRunner_6lowpan-tester     PASS      22.52 seconds
IncrementalBuild              PASS      24.93 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 1M                     Failed       0.258 seconds
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.253 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.242 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.748 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/391

---
Regards,
Linux Bluetooth


--===============8150643858470351922==--
