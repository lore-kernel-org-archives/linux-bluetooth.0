Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D13D3486
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412860; cv=none; b=bPP1I7ahvQ5Y8Htl2eZMYAjctnfsF7TdB42/WEm2biJ7q3taLb1YR6MjgTduy/wqIE+WKEyKpyYPNIIpTt2mvzJe5uLThupsMwgVuCLgZ8j0p7lIfw4i98H+apqTLrx/6vOATdDnjQgxqp59brys3SxLRoT0S89/0RrNygQHPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412860; c=relaxed/simple;
	bh=hOg59FIkmTfZJfUSLCjmL0vpehKN3LLLbs5sjIpREf0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KFihUN7VbfTwQCQtFrIZzau3Mbsrtwx8RbDDBmXJVylCYSA5qKhdfOiksE5zSnpSAbuJoHCagXZAjt0fJmDXtTW56lAJaxmy1wxTSDAp/nEuTjvFwpDGuXh+C9aOhSx0zmnp1GfPKD+gzwxCVJHpQMfdGvCMsCO+riHHzOXNvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpZpu6x5; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpZpu6x5"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5218927884fso19707831cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785412858; x=1786017658; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ht28gacb/peoWDoJvyr+6U7oNuTIjlf0VDGwq2laoG8=;
        b=QpZpu6x5Dl0ggaCrwY7E5VTMK63L4le5CX/YbzbQHu6n6pcxupa209xt6SWLUxm1mC
         zv0cJuPi9MgqtYrsNWo7835gEs9Q0GGfAtsvyzq9xZdhcOuvyyj1BLf8QqBqHIghk3Io
         Err60/0RJS6HNDjUCimzfRbi03sMvjnn70sneyeu56lVgTIbbz7myuvr0shQa0bn2kcl
         pHIpdg5Uz9V73oUFLga2nnRH2GInzD5e9sfL8Z4BwUfA7eY308g2LxCH8YBkcGTNh+Pg
         PEkWe4qXXDAN8Q0E9nGxvbGE1mT/w/Lb/X314TTT3G9uREf1hqZuQvz+EOBv4v49hDRz
         6g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785412858; x=1786017658;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ht28gacb/peoWDoJvyr+6U7oNuTIjlf0VDGwq2laoG8=;
        b=SZtXhZgzOFIqhfR0nXQn7Krv1fvC8sh6+ckCdDhrJcXL1dtkpeQDQD0vp6Ky1ORQbE
         h361QWDI322+UjMB5NZ+MdQjtF9jwp86d2y+LHfsDttsP9unSoqZkcfsCI6/uvvitysg
         xUuCraHZrbVp/WleCTJcqOPBpgbSCkMbOGz9Qf3MCPH44EGpyhWeuPHEwHTMOEMtlukJ
         CP+wiXiWYvFqTT5gep6Il5uMWdaux3uvqEvJkZhUJsD873ESf9w2VWlvYjxSgM7CvbJR
         E1MX4U1ixZ8qIP9Z6ib3NAXPej+Mi+Ve+xaIx10Y1VhuhLj/rZ46EYKTOZUwabCxTp4+
         2qKA==
X-Gm-Message-State: AOJu0Yy99kFm5ilcA+rHTmKBbdF7mgShRfUSsVDVSteVdsEmV2P6wiqs
	UsNIPt9zkefSvtlz6jWo6XApfqPSv1Vh4bS5DhBSFq5KIB3RoNRtc89yQoiN8w==
X-Gm-Gg: AR+sD126v1Gty30afeEPB0gDpP0hkIk9eUCyxV7CdYnBhktUWLKfqTkmuLLEGi1Ogdp
	3lNRBTpXreNJQzMINl5i5Bf99PF/QY05fpYIhCgZ6goaFt3pzCLuMinMc/Gi5z4RZPB48h3RbaW
	p/T4XGrskqy7fGRaMFWF3dnIjZgJjZlEzOcaMD7omsRGgQAE70GNe0K4DnywPlG3cgcCTD3NuuT
	q1heh8Ha5AV8CUcIjKhCpKG77DbP9quhN/+Vx/yKlJwkEtMlI9kuQVzlQ040KPUK/eZqAxw5z5h
	VRRuauYK7p5e+y4tuOI9kPq+9yxweWCaS6U54utn7A7Rn0wfAoDRnXjaRc0GTGIpWiOooewdSo0
	yCuUxWFwRIVC4RTP/KktLqL+lQCvp4NNVbyEtsMVl6t+SKuod9T/5q2DjeRi1b+eq/pl/qSQo9e
	q7j55s66yTorxUKaVE6NkLoa1KG+jJKOOZDzeGImHI90LO+YzjrSxBWkTizE1G25UZk0YvWwVLi
	DDJZcum
X-Received: by 2002:a05:622a:5292:b0:51c:85e:a05a with SMTP id d75a77b69052e-52b386c2c48mr20125941cf.66.1785412857201;
        Thu, 30 Jul 2026 05:00:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.196.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323324b3sm15875956d6.21.2026.07.30.05.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:00:56 -0700 (PDT)
Message-ID: <6a6b3cf8.4aa243c6.2ba1db.2758@mx.google.com>
Date: Thu, 30 Jul 2026 05:00:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6252320088944608698=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_conn: hold conn for LE timeout work
In-Reply-To: <20260730104103.2080325-1-nicoyip.dev@gmail.com>
References: <20260730104103.2080325-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6252320088944608698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137329

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.57 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.09 seconds
CheckAllWarning               PASS      29.13 seconds
CheckSparse                   PASS      30.71 seconds
BuildKernel32                 PASS      25.55 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      492.27 seconds
TestRunner_l2cap-tester       PASS      59.61 seconds
TestRunner_iso-tester         PASS      76.14 seconds
TestRunner_bnep-tester        PASS      18.81 seconds
TestRunner_mgmt-tester        FAIL      214.67 seconds
TestRunner_rfcomm-tester      PASS      25.22 seconds
TestRunner_sco-tester         PASS      30.98 seconds
TestRunner_ioctl-tester       PASS      26.20 seconds
TestRunner_mesh-tester        FAIL      25.90 seconds
TestRunner_smp-tester         PASS      23.22 seconds
TestRunner_userchan-tester    PASS      19.91 seconds
TestRunner_6lowpan-tester     PASS      22.89 seconds
IncrementalBuild              PASS      25.05 seconds

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
Read Exp Feature - Success                           Failed       0.247 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.372 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/515

---
Regards,
Linux Bluetooth


--===============6252320088944608698==--
