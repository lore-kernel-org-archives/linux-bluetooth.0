Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951E133993
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023077; cv=none; b=ia9+x8+LOCCQx6kZshLdCzsiumECiwsvbjf/ybZI+Hv6RAkFX2LlH/W4q1I1ehcHNTbry6AQcqEFqPIEjWGDLvkLvrhCNbi5qiskq3FOdORcq02+20/F3Wb9uMFGm2GNN5TgOOIy8UMJT9JkqyM8NnoQifEawni++d51FW6Rqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023077; c=relaxed/simple;
	bh=opRaNXstDHYeA/8kVcPXzfJ5HA5c1oVnLvtdFkF3oVA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Xk9ciWvwOjygKdll9JU/Y9M8cngYYnCmKOa+b/y+k0XmjHXrxWGl1wo0cX4X5YNyTpR8bbDsa2GSE4x5j9cZOCDszLcneFuytwWRH08JctZLUQifGcicd8wZZdyai41ZGZ0x3EnOGVLF7O403atVI+5A/rjau1azo0KzZWOlpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nj4RJxWw; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj4RJxWw"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so2393000eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792023076; x=1792627876; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IV7P6bfmKgRWNWOe2aYBFgBOux59+6RW6vxFQufoUVI=;
        b=Nj4RJxWwaf8T+01eJNY0ltmbCWOYNiz5Q9OtsCm8HMXFLlvawfAfqEK8OhJFJlRpU9
         2lbEL1cTv/n/uRlTy6Bm8fL36B7EmrLX6pj2zn6TKhbC/I+2/CyoBtkfEDWfKEQOdTGJ
         9OUVUcIqOduHdSfLKfQR3wUIt3DAtei6tPwwkbSXG3f+zu4GLXkM9/nS5ZcQ9Qs2CSmS
         7FMuHH+5i0j+T/ZKqLrv+6KvjuFlcko3UnApRu5AGL7/Zp3uW0CuYdujFZ6iCnyEh9O1
         Ci7cppZIMEwCxgn1om4lJFAqCh4cLJFAzmCSd2Tie7YLpsKKW7DwSw+MvhvQ0w0Vqz+v
         ayPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792023076; x=1792627876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IV7P6bfmKgRWNWOe2aYBFgBOux59+6RW6vxFQufoUVI=;
        b=qbnl3L/FVzUa/ER3AekVzXn2TMkVu5LRbfZGjVlSopviCxsdaz0L2Z3cV5ilGb/zSX
         8/AmGb1ZLzSaNXoFJH0ketwrefLRpXajoZW8quZkwUVPiC+OQMRy6prL6JHFNUcz/MLV
         SskYkKc5NOemvlj7J5L6g+6T/sJmZxkypewFfQijWASRlnbHQPdxfweQw7rkDn78pe/v
         iB5xD7w32mfppMbBYVaXNOEw8uz/hSXqmFKfrSQKLzxoM+2DB39CKbb4N+3JMxJqlT2r
         l7tiyBgxwaIZDPRmvWv2MroD4fvvoNxdQpX39KS/pwqlyOrM5l45PEudd2gfgn0bzqA9
         Jdaw==
X-Gm-Message-State: AFq9FYJ0qHNjKh1cFpot0nkaLyXvuh+gPBB9zrZ0ndxMyhuYPA1NBiBK
	SbPs0YO95ltL872IhH9Q7RWmiROjdatXSHm0UCpig8fdJ1OhjmbhwYNGAX4OZw==
X-Gm-Gg: AYBFou0QxMDEWyx13UeP7c+grweMr5SKg1yu1GR+rAGchVBQakYBRLyWygtdHVQ0FY6
	IGQoVzeWdckolTWIMkQ4QGIq/vgK/Nl3JOp/H767+l5GhU7iJ1xa9yQOAPc+yhgVxdPM0auJmBq
	969lyyq6kum6lx545HE0VZDtssUj0l9tChYaQd1NjCsk/DBLp0B/we+1DDSpBmwxHTqdiZl8hLG
	iMvNDGnighyxYAurhSk1Nl32pas0PqhBDBE+GGKVNNTR0PSKipi0YAZ1oGR2vkygJKv7cZ43PGL
	ryhHkBP93vxYlRryZ2uXHfXzOaAN1N8/THN/sqxqE6k0NfRbTTaXm28L5x4POWuzt1Swm8z0ltW
	2FLKVUu++1GXfFOp+v1V2Czv7QmoF8Lu5eyej2HShpWDPhvJeTAjgLgvNf6CtCBknhNw3jarpB6
	q2AGU5kbNZQc6Ca6DyU5+U3crw80Bt2r1YSHL293G0QLgG4ssRjvEcE3F6O6LG31Kn7ZSvT8NcA
	eR5ug==
X-Received: by 2002:a05:693c:4090:b0:351:1230:e379 with SMTP id 5a478bee46e88-3537df59719mr27419065eec.6.1792023075297;
        Wed, 14 Oct 2026 17:11:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.102.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm60660784eec.27.2026.10.14.17.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:11:14 -0700 (PDT)
Message-ID: <6ad01a22.bd274c6e.190902.f3a5@mx.google.com>
Date: Wed, 14 Oct 2026 17:11:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5526319330940361021=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: RE: HID: Hardening report validation and unnumbered report handling
In-Reply-To: <20261012-hid-core-report-validation-v1-1-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-1-e0dd5cb60b2e@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5526319330940361021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184349/

---Test result---

Test Summary:
CheckPatch                    PASS      4.79 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      1.94 seconds
SubjectPrefix                 FAIL      0.81 seconds
BuildKernel                   PASS      22.01 seconds
CheckAllWarning               PASS      25.11 seconds
CheckSparse                   PASS      27.51 seconds
BuildKernel32                 PASS      21.84 seconds
CheckKernelLLVM               PASS      24.35 seconds
TestRunnerSetup               PASS      516.26 seconds
TestRunner_l2cap-tester       PASS      13.81 seconds
TestRunner_iso-tester         PASS      11.62 seconds
TestRunner_bnep-tester        PASS      2.81 seconds
TestRunner_mgmt-tester        PASS      83.12 seconds
TestRunner_rfcomm-tester      PASS      4.13 seconds
TestRunner_sco-tester         PASS      5.04 seconds
TestRunner_ioctl-tester       PASS      4.13 seconds
TestRunner_mesh-tester        PASS      5.11 seconds
TestRunner_smp-tester         PASS      4.01 seconds
TestRunner_userchan-tester    PASS      2.86 seconds
TestRunner_6lowpan-tester     PASS      4.01 seconds
IncrementalBuild              PASS      31.37 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/938

---
Regards,
Linux Bluetooth


--===============5526319330940361021==--
