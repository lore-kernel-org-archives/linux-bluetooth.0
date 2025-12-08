Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722213112DC
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765190450; cv=none; b=gQa1IiZoEZmKNqqlGGXELHkhig2ZkPmUQk/KNbeBWjZ4ALzpbPb16YGD6KKnFxGwX3Y7BI+iCbKbKSwyZ3Fu5nvViaIGAvPNZ0nazLED2ORl+Lzq6pH57P2WhuLBS8HnrxjscCxUWTguR83g5xZ/MADfgfFl4SQcG8IWqLmR4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765190450; c=relaxed/simple;
	bh=kkWsk2ybvfqil/MCR6ISToU61xbZhNxB2xQGWOgIhs4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NyrrSI6rhF/8siSldpdS+S+IwGJoex38e6KWvyBwzznJs9pMDM5oP2pj+fcrg7TjdMhRtFCrBU/LJyuUbP3vPQpEQ8Jg+66hpiwfM4ZXW4tUUWMxTh/hYCw6ocHRkGxxDM55+G8WAMRYgtnqWVoQ7SYt4qqt28ueHewPuDjqwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc7RUG2w; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc7RUG2w"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-882451b353fso29585636d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 02:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765190446; x=1765795246; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4o7hGzOeRj4Zl/crnLfCxIrOLVsXn0qjGuj6pMu/SBk=;
        b=Lc7RUG2wb28jDyQRFE0rdUN7bfDw5bOmrdmp9SiEylumG30e9lCewvBukZKXjqRzuk
         ImMcF2gzsOtIAdd9/bfNX0gt1V0j0XZ0QtDVBIWG05jqaa3D+HlDj5BnBPBSqXM98Ru4
         4SmkIi7SPOQgeJLCl52G9rWymW393ETt8Tt3a+Ov+bTq+46+aaRnxzw/s3fpRu3nWNCl
         z+sC5gHMqHLftqkHPrArsE52eKttH6c1Zb7youg5DAGxNnyW2OBIHP80GbxUJg2eC1pU
         zEZoLqWX7+9LzTM8rKod2iWoDMq6MBD+BCqyCPnpfs1/24KSWFq7zF02KXicKoM22nAY
         azKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765190446; x=1765795246;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4o7hGzOeRj4Zl/crnLfCxIrOLVsXn0qjGuj6pMu/SBk=;
        b=VFsZ9e2b3NlT+RNTreE/GpFt95NlZ16OaeqJ3SrhV8jqzznR0DK8coJe9qU5tFnHYu
         Cs90U4sKKx3ukaVJWZmXPIob8on4Ve+f3KZMOLthw14qJD0acvmjqJ0Qqx2fFwrat+Gc
         gH8K3jsMQbTMyrq1CVXmEFlZmlgOEWlp26pSMPZjmCVl1B3J5wycXtRowjrmgVdzxzAw
         Yqaa4yiAFtMGunkCw4IJOadrBJVAERP9n9PEH+/qVapCAPMq6iMWJZPrvfK9YfBdZxKX
         EUuxHx8DR0e8HBsN0EUMoU0wMp77JTMpGvX8+gj3G3wszfuAB2+SE+BKoI8g7EcX9uWD
         TtHQ==
X-Gm-Message-State: AOJu0YxJEAt4R7ofVh/py76ZTBV1SUhmqBNR9aiwGqhwc7lvFDzsk//M
	DMZ4qt9yXlPQ+PYGwYGdZF2F0fYT0Wa4Zr/g4UDZIYre5j0OO6/up97KUUwbBA==
X-Gm-Gg: ASbGnctlG/On8nEhJLxsLLP/KncSzAd8Km1kTkQBsQuwn70rQgFR34WJa0E08/hfsEP
	ZSIw4ex2kON9AxEcJxNy81x1qzGC3VQZk49Mz/O4TU3xAaJcdjkXJK2Qs5ZvNq0RYygn+fOKnuG
	Hs6B6DnkCnyDqokflFkNMZ/a002bIyt/pVBWfVtyeoYOat4E0kyo/eqj9cdJNSL7TMbyKB4eUCp
	xN9l4q/2z2X6hEq4pNKVdwyseOzLLMbFChaX20Mr+jv3T9w4Acpmp9eauu4MGg65boTnjKtEpN6
	zNqOpMn0sy2nEr0KgYsXXj+U36l4fWQ3UA1FxeZ4q7Xw3un96fGAEKRGwOuMXjCIf3X0xYsCn7H
	zAM0Gqj60d0vSFF8JNIw1g621REjz+HPl2XIQpzfEBSTQUwo7qUYeXpkbDuTCSTOIbKK/mJP5uy
	kgtFD5n9NTgllUJcA=
X-Google-Smtp-Source: AGHT+IHm5hvx3TolE0qjKX9Ehrktv5t5BwHnXwuMdqWkmOqtTIStKDv0azq/mlXrG+WUkPvwqMlm5w==
X-Received: by 2002:a05:6214:20eb:b0:880:461d:2e19 with SMTP id 6a1803df08f44-8883dbef881mr119732806d6.42.1765190445987;
        Mon, 08 Dec 2025 02:40:45 -0800 (PST)
Received: from [172.17.0.2] ([9.234.151.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88827f33177sm94660066d6.11.2025.12.08.02.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 02:40:45 -0800 (PST)
Message-ID: <6936ab2d.0c0a0220.11bcee.8d68@mx.google.com>
Date: Mon, 08 Dec 2025 02:40:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8755040598416068585=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [RESEND] Bluetooth: sco: Serialize state check in sco_sock_connect to fix UAF
In-Reply-To: <20251208095508.3481977-1-zzzccc427@gmail.com>
References: <20251208095508.3481977-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8755040598416068585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031328

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.46 seconds
CheckAllWarning               PASS      28.37 seconds
CheckSparse                   WARNING   31.94 seconds
BuildKernel32                 PASS      25.61 seconds
TestRunnerSetup               PASS      558.74 seconds
TestRunner_l2cap-tester       PASS      24.64 seconds
TestRunner_iso-tester         PASS      88.68 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      125.65 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         FAIL      14.61 seconds
TestRunner_ioctl-tester       PASS      10.26 seconds
TestRunner_mesh-tester        FAIL      11.58 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.70 seconds

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
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
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
Mesh - Send cancel - 1                               Timed out    1.792 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8755040598416068585==--
