Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827FA259CA5
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695814; cv=none; b=Utii/YhxZAf7y5aLI52zK0UuK8rrq7EWYEqq8+zg1KzzV3dj4Hg9S1lFRhCriZSSX/l1b9fYddB3EHY7eCE7TKzp7gwrLZVTsPgXDXNuw7ueElKTUx5WZvHGVitWov6Ast3bdlzuZgzMXfA14JgMzvdtSn0gIWMDcePRPGzouIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695814; c=relaxed/simple;
	bh=J+z7i6PjhiVPePYcLKKVP5fie/BXZ6rSYTeQDxAWKvA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QCXp3c4QYp7hqpOe5ZmM3qVSpXAWhgqhO776Pr/hVChi2didwJbsGAxwLoVwEpp7MnER71cIg1N/Wg6RqeSpd+KO1XBbI54MtW7Qofn4kI2EFMS9OlBxSSRtLyaekH4jdJ8gQ+AljFd6NKy0XjsfDsRk1EJtArRKn73j2v21h6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPS+aXPR; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPS+aXPR"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7074bad0523so3997616d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753695811; x=1754300611; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rLk9vOifudrrRnA8I+BOqIIdDS2jN1LyRXk0CPPtaSg=;
        b=PPS+aXPR3E8R34NzsFd9e8qLhfSyVvRYoJii212FR4SbC5qoXFYC+1hBbP/Ywbw5lT
         FD7/0HyUohEJWNepHxR1fZSGvE15j7OP46qCHYSLcWQvmQUJLzGNJOtEwhePlpPoyeBe
         NXkJstMUSzM/pkZNHXfy42yM2cGHoxpDZcsvu6DwxtfCOSsgRkTB+VF8CWrxwThtJRFK
         bfVBWZJdjTjBBOyfwK06miJOEnZlVZQsiSvyZGcqJSyW5/BK923V0KiHemwkkIpZoIbQ
         O9HWYv6nsNTBnhWzgdFaLMEKTh4jbnaB9mAFZSEmyP5PfRkOW0rmnCOH9a42Ktw0fIYR
         6wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695811; x=1754300611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLk9vOifudrrRnA8I+BOqIIdDS2jN1LyRXk0CPPtaSg=;
        b=fJ+cVMaFKMYR4X9By2bd55/6OYxc96dxFFe7VcHPh5vDIayPLVCkzYOd/0eGhApofC
         5hWLeNqD1YN13wTPi64JXjar5uNMj+ywneG+Xcw6FYzcnh+KRdMkJNvVIjS47n3DOYPV
         MXfKM5n/KwGqWqBWhKI4VJi23K4Kf7/qkERXk8WmPa/kQUTt7JSFL/usge/OKD1zfNf7
         gZQ+EKlX1QLh0ikdcwPTF3X2kw+JeftFiw3bw1mu5KhieeI7oD+mQtEEYBKVITkw98+6
         WNW+aoo99VNeBSOiTEL5DYwfOpD9mOHKd+n7VO3DG271CXZm1Qq4aNtxiwwPFjCOT84x
         qB8A==
X-Gm-Message-State: AOJu0Yx2Z1FiPACdSjeB5j+ZUfu0ReMebYRyyWaxL2tExX7ysK8C2e8G
	UVszErsGaQHVoyd6GRa3MB17PAcuoEZoxEmK7G3zi3QSeP020A5N0bhifzrkMQ==
X-Gm-Gg: ASbGncsTdRvEACeoaZ9huqvKaxZv+CedJxOAH12BagsIMYM84Xof/1nowRw6paZwM6U
	oEBY97TAdypm/rza17Q01cAFAPvvvgkvzZBpTwBeVUYLFmx7x2Q/Jh+2p/YE5MxaqPyp+NBLoaL
	OKBN8tNVkwqlFOkGWxVWvZorP4ckfiCUOVxYpx8ImHx6S1o9rftQuGXQvy5/D/O2ZbtvQZaeeQP
	gdtAAEEDpu2LjIBXUA94b/zUX4rQPL1JtIKd76QF1lzMg7smPfat+39jrkpeUuZZwCIGCQlSPCh
	KUXC1PgwgXFxOkaU0I/CF2kESJfHnveazq91VhZuANG9mFc/p8x3Qn98ZFLKpfHaH1A1Oxxn/mU
	0jvfmwiVZ2fm7/SL8sRmVQzCRGT+Dqt5kVqlsWQ==
X-Google-Smtp-Source: AGHT+IFH0c1hyUscgN3fG+I0WCanl19jQ6JOT/4PRCky8gfrUu3almUtuM0Gv/x3rDbZboMQpgsIfQ==
X-Received: by 2002:ad4:5dc6:0:b0:707:4b51:a490 with SMTP id 6a1803df08f44-7074b51a669mr27659256d6.5.1753695810500;
        Mon, 28 Jul 2025 02:43:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c712f1sm28876306d6.87.2025.07.28.02.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:43:30 -0700 (PDT)
Message-ID: <68874642.d40a0220.9ee1c.c10a@mx.google.com>
Date: Mon, 28 Jul 2025 02:43:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3851330861862713243=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: hci_sync: Avoid adding default advertising on startup
In-Reply-To: <20250728-default_adv-v1-1-a1164ff502a7@amlogic.com>
References: <20250728-default_adv-v1-1-a1164ff502a7@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3851330861862713243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=986353

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.29 seconds
CheckAllWarning               PASS      26.85 seconds
CheckSparse                   PASS      30.32 seconds
BuildKernel32                 PASS      24.24 seconds
TestRunnerSetup               PASS      479.76 seconds
TestRunner_l2cap-tester       PASS      25.20 seconds
TestRunner_iso-tester         PASS      37.78 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        PASS      129.69 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         PASS      14.65 seconds
TestRunner_ioctl-tester       PASS      9.96 seconds
TestRunner_mesh-tester        FAIL      11.57 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.26 seconds
IncrementalBuild              PENDING   0.84 seconds

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
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.116 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3851330861862713243==--
