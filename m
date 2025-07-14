Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C76262FFD
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513036; cv=none; b=g0xA/MUr31JABScuBqLEXuwUT+ejRrlAGSlYvyqrHhlIQdKnbwC0Y6DmpB8VeJG6X2Blj8zpVYg7XyTy73gPSOUjoJ03jZhqBb24RrnPwIqM80lxehBli1ZokwPbm3uLBNRnrb/fsbh1LvJMaAB5HvULZDTSTPT4iCbaEMHqhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513036; c=relaxed/simple;
	bh=OhWNT8M+/BnGD6kqRn+qe0wpgHi4dzts6EfYbOi+B58=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qjQYDyW9BjsybCMfiGzDlCJgcVcDFXdmRKf1vG5j6WdyEue+STTbtjLxG7cM+QiRwpdcpNjdlzPmy6FT0uvS123vgSuXLi8uexZtzcCjsFUa3Mrk4G2L2UUzFkEL60ESOZTBy+kJa8d6X+KpDkI2T+Z5sln1hhMmSa/Q+U7mAHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMJ9iCPT; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMJ9iCPT"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e334de8df9so41665485a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752513034; x=1753117834; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kOwINx3t55tQAXGurvEO/lLjLlmf46O5rhoreumAroo=;
        b=bMJ9iCPTIAObGpvGgytDy6fibFL27nCfLX2IWVP72i/cEsK8fFLUyAJyiDIfMRrJaG
         0vTtJ7XebCIHsZRjWuYSeOShcyuG+hj012vRdo6Ul+BWR9Lrf8IsgEG3HlNMm8BiHQbu
         Vl6mBBteLkzdsBR4QRaHbnxqUe5a+mqEfgmxTlbtlG6x5FDdAzY2pO7en2DoCcb+5GoC
         9Gbo6gvba5lSZ5xAfj1Jd2y6/eFigokZ3/v4pgdsxfVCmcmW4AtZVBDYLll8r4Wz4+4/
         aPG9y/JBadnWVrfUHlikukGW09lrctbbdU99iBbw/KCVoLtIc65uUdAjqujv7XIQRSRn
         ziOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752513034; x=1753117834;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOwINx3t55tQAXGurvEO/lLjLlmf46O5rhoreumAroo=;
        b=oB9iVWXtBAn2uPBcB8+7/HCqByj8Bo3/eTEXB/M03tWVJtCDgVi2ks3IP5Wobuhl5I
         Xv618FuMIYX6EpDitjaL5OC3IIKfq62PMsMtJSTK3pEVoti9/d1OWVxnZ56DB8U81arg
         zC0TlfqMo0w3DW8qQ8pkdrcReyk9SD2Mg6wjqu2WGUdoxXuDVgK14+OCa0EARsS+M7su
         RkC9CrTnyy0H6QYdOQ47oL3a5ajXUrhTapHRCjb9wwR0N3CQxY1o++ZB4m7wVqRcotxC
         vEVhRpuMJ2hNs0dJ8Pa+7dfnJgOe5OkD7V0YvkugxSzP2nPHv0utua5yjOksZ90jDWkb
         R8Og==
X-Gm-Message-State: AOJu0Yyvsm1BXUuRi0JTh22P8rjELmHxBf/aW2XxGrcHvLvXUFgi0R2Z
	Lm3GpUCgwhDcKfEfQYLnbxn9wCWOVtgsos/mtYrAeRfZHxQQ96zsX+Qdkq9yMb6n
X-Gm-Gg: ASbGncuL7oTUlRiZ+mzoRCqvuOhRDc+KprWX+aedxfKYpErqJOj6aekPz6XabqQmokn
	hork+qHCXFynva2k5UPlVmiwGMvDQMxRF9hVfBqWf96Ynebh7PVIKgD1FB+zAUcbpUGNioKo/Js
	0ZlashQcEGptGTRKpmKyvDW7LZ7RpeKUpVNMsTFPk/eONK7z0qTYNcg+ixw17wNT2QCp8CPU4IZ
	PPPrja/gU16evkfaN57y4xRARF2tv+HlcB0u1KiNCqJY3Avm6qkpmrAWvFzeFXBVAxIbiO2hhM4
	K5dl62gOF7Llrr1JcSTRXrh4rexm152JsZkCtHkwGigP4Thi4DE+mRf/k0IV6cGK2HS4AFO2iAc
	aELy345ajMKJDaUG0IWYTVcTRmpXT4ZU=
X-Google-Smtp-Source: AGHT+IHmS1AfWM2H3CbdHmetDFFXmdsEtKY7AyTCB+zcYKRyPb/SKDm427C3DUC7Cs115xg3J8WGww==
X-Received: by 2002:a05:622a:14ce:b0:4ab:5929:21f1 with SMTP id d75a77b69052e-4ab59292490mr147323151cf.17.1752513033517;
        Mon, 14 Jul 2025 10:10:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.191.224.255])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9fc780367sm40303641cf.61.2025.07.14.10.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 10:10:33 -0700 (PDT)
Message-ID: <68753a09.050a0220.2ac963.e30d@mx.google.com>
Date: Mon, 14 Jul 2025 10:10:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4041322612158712622=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [v2] Bluetooth: ISO: add socket option to report packet seqnum via CMSG
In-Reply-To: <712e0e6752a8619bdde98d55af0a9e672aa290c2.1752511130.git.pav@iki.fi>
References: <712e0e6752a8619bdde98d55af0a9e672aa290c2.1752511130.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4041322612158712622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982160

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.14 seconds
CheckAllWarning               PASS      26.36 seconds
CheckSparse                   WARNING   29.81 seconds
BuildKernel32                 PASS      23.98 seconds
TestRunnerSetup               PASS      467.63 seconds
TestRunner_l2cap-tester       PASS      25.08 seconds
TestRunner_iso-tester         PASS      38.25 seconds
TestRunner_bnep-tester        PASS      5.89 seconds
TestRunner_mgmt-tester        PASS      129.51 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         PASS      14.69 seconds
TestRunner_ioctl-tester       PASS      10.05 seconds
TestRunner_mesh-tester        FAIL      11.39 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.17 seconds
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
net/bluetooth/af_bluetooth.c:248:25: warning: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.157 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4041322612158712622==--
