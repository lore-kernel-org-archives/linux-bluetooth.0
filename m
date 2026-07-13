Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497435DA78
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783983028; cv=none; b=URhz2v1vd5sA14w70DjOWDRLNXcGZfOPAvstCLc4Payn4YLXSyDf8x+PZDb/yK6vEV5Sks6uR84O/PSYByQla3BbgTeteysUCLP4w/c2gbYzko0NXZdh5TSMQs68F0tCN6N68QASlHrxysYDOuL3NG2yAy8j0o/bYT9fFmlhWw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783983028; c=relaxed/simple;
	bh=5SewTj3ws8dGFoYodOl9sjNwKy6K38zGBPTAGaBozKQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MeZRC0wJ9gddkXUfbq74XwRXg/aiXzZglg3h7OO/RV1q0Fmop6RkcvjR7SJMRfizos99GbrluKh4WljItFIGl2ew5qjq7FTAkRV8LlKNdvGx2SZZcrVGc0u8bkbnFykWPMnTIAC+c2rQSci4qgB2UITusSqqIk098pk19gT2JUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCPcsQVK; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCPcsQVK"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso2885097a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783983026; x=1784587826; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UKZg8plGu6xV88L8HcqVexdDuT6hPu3EdisY9Ds+O84=;
        b=rCPcsQVKEU5KI/qjjPu30cwbTFebdNNGEtL/jpAEl1YjSEK9rccfGBBU1vd7Y8EMYY
         U/G4a/tXwjEB88LYDYyMGtaws9Xhan7J+MeNy9tL1LMMm0mneoxJ0xB298/6YEJVM5dO
         fQXA+m5NAlE+45zEz7qdEzrlqG3JIv0/Uckwn768z/i++vQ4TE6P6wIzp5jEPYLT/y5V
         hsBnBnPXyka43pQC1xgZTHzc2wkUxACE8mgtkImdePr36Nsm6QG7E41tZfdClGVfQRGF
         /kAC+iGoKU1K3u9o65SYfrlib5UXDvaQUQc4DHzNqhhDRgUZu4mRaI8CvpI5Lsjw7D6I
         0H0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783983026; x=1784587826;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UKZg8plGu6xV88L8HcqVexdDuT6hPu3EdisY9Ds+O84=;
        b=Z+GzsCIXfBlYXsncJs8G7VSCcwsWTsyJiSMwvrZyibAiGReJeQS9tqwVwMMCbFzvx3
         9c5MSArQhIF3cbPbwnxaJbhwyqrSDDYJ5ixGjk53vY5Rnz0OqV/bpF2kDzLb87TUWbV7
         D8r7/30aYwv9ewI0VphzTFhOgB78Db2i1h9HO2gtl+SOZbKKBiMDN2Eybhxm+GUqtSNp
         R/26Uwyle0cRcrL1p3hsZeZ3hJQ7MrLqu/HS746qXuZmFHVh/v6cFaN0bcpl8OFP+X1h
         1tldxnhdB9/WMpUuW737uSVXT0ylSihzQBtwLagClOLUad6vj2qD+GMGdL78My+g/o2g
         m2Wg==
X-Gm-Message-State: AOJu0YxJGN+6vlLLcLZF9CuA9w2PzUrdnPm6hJSuYb4wgfVS61P1eiQl
	1NHYUC6n5a3O5oipwHTRBctuEa6w+T7tvJBd4D+e/fTB1KrX0b1DFoosbEzy1Q==
X-Gm-Gg: AfdE7ck52djHN/FWT2wrRYfhJwqw20bc+EE7FnVNyHRkTEN95AO+Vu8bKZTAH0cradK
	xQsOSZmOUyDaOAj2pKFyxgKbbADsA5v8SXW+W9qHDlkitJYdgVwgxG1YGEqTuVWYf7NV7/7PXj+
	5lhZwCcnUdz0O6Y51zfXMHM4SGw72E+gpb7ExvzvXYelo6m3kR3ZGfs1c6wLwVrWIYXxOa6OwRl
	0F8WOSyI1BtOCxjU1f8EsLoTfoCfqq8rNh/L7pTHvEAltTNCHivo6/jlQ2zTrm9K/rV8ekl1DzU
	Tt0hAvu/46ok+WHhTnGIykG8uZCBCmw4cxzwElhixxuzpYNfU3PBu8ksVISdOB5leTr1FoMnvD4
	dAR9XtIjhNh/zElhFl5YkdZmEnG1kwUxaLQUYLAS0UkbNwa2B/rDlAjgQethu9qNdrKu3Hp5HsP
	nnsERxQlBBj/WXgh8Uef4=
X-Received: by 2002:a05:6830:6aeb:b0:7e9:dd7f:7a83 with SMTP id 46e09a7af769-7ec09302286mr7211459a34.0.1783983026094;
        Mon, 13 Jul 2026 15:50:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.19.195])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ec2183a32csm4892121a34.23.2026.07.13.15.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:50:25 -0700 (PDT)
Message-ID: <6a556bb1.a29f8321.394f63.d2c4@mx.google.com>
Date: Mon, 13 Jul 2026 15:50:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7575926918220352637=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ameenaladdin@gmail.com
Subject: RE: [1/2] Bluetooth: btintel: Fix spurious error on FW download error recovery
In-Reply-To: <20260713215537.81222-1-ameenaladdin@gmail.com>
References: <20260713215537.81222-1-ameenaladdin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7575926918220352637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1126920

---Test result---

Test Summary:
CheckPatch                    PASS      1.72 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.57 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      25.29 seconds
CheckAllWarning               PASS      28.08 seconds
CheckSparse                   PASS      26.83 seconds
BuildKernel32                 PASS      25.24 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      456.79 seconds
TestRunner_l2cap-tester       PASS      57.69 seconds
TestRunner_iso-tester         PASS      80.99 seconds
TestRunner_bnep-tester        PASS      18.81 seconds
TestRunner_mgmt-tester        FAIL      206.36 seconds
TestRunner_rfcomm-tester      PASS      24.99 seconds
TestRunner_sco-tester         PASS      30.51 seconds
TestRunner_ioctl-tester       PASS      25.57 seconds
TestRunner_mesh-tester        FAIL      24.92 seconds
TestRunner_smp-tester         PASS      22.74 seconds
TestRunner_userchan-tester    PASS      19.71 seconds
TestRunner_6lowpan-tester     PASS      22.64 seconds
IncrementalBuild              PASS      27.18 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.237 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.901 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/432

---
Regards,
Linux Bluetooth


--===============7575926918220352637==--
