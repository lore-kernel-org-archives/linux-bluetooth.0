Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64B3B960F
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785684137; cv=none; b=SBDmp3BNwawojKIG32QV0FXLkAtMeY1x4IkTwDRXDEsI6gzmNgtqZ2JLHI75kyzuxah0jiui0z6DSpVGJqFmtv1y1GX7TcRxWLaCM7a3yzPUQV4aebBnlc6MXBVSiWWCdV5y0IQViO1TTxHWnrjFz9DTA+efVofvvwGepYCa2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785684137; c=relaxed/simple;
	bh=FvyDA7s3f66OhEt4x/9YnZSeHzuZEXWE8ZbJzTiRoCA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RzNJsuAR08d9hPwnSOEK/LctpJNDxtZyBR67gLqmIIPExj8PVpFYr8kCfO44Rw34DHaHtHrGafCbioJq94G8DprwTAgEC/GP+KiLwrrJgrGKY2ROKCjlpRVUr3vx8MYQZMMW+mOB4jAbsGRWj4k+JIgK1NjJLmh6+zd0PdSrAuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrrWVh2B; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrrWVh2B"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d02b4c3601so28677325ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785684136; x=1786288936; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=irFXHAUWTR1zS0F1tJTyTutIwe0VCx6Uz4dw4TdZ5ow=;
        b=nrrWVh2B/HTKicD0cn5yLD1K5FPVUndeSfb6np+JVAnQZHvbLDwT4x2NPcSRRQEGvA
         2edwBM/E58uidVTFiEt4h4r9YdT943qdu2SGtd35JvkWbjy4WM5/K930CTOCuBO1mIsU
         9n9cGZSSZyJ1zN7D2UTce2qOIZMTQxBE0n/bRmb873+Ka0odZOQQOs07Qh9YG+/UuUrv
         u1B5VE+1ysT/nggT5G5S2aW3ExLdqebLZWKFo3qQJbwSmiBgxWiwqJNbMiOZPcFJZBB8
         prlZPNhderU8Z3KNYaGFbPP8hdDhsZGeT5jSrD2H6TB8ecHZtWE8ypZweCKwvRcsQf22
         S7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785684136; x=1786288936;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=irFXHAUWTR1zS0F1tJTyTutIwe0VCx6Uz4dw4TdZ5ow=;
        b=jVlkbZ3XQG4R8uJkfmpLs1xxATIj4DhvZut4jAGIcvtiKM8v2ZAfdzpXlf+68mbxWr
         /Oyy+7FGK0zsFqdiY+wryxDtkko67XXs2NtqQAeeoKExi+sqW9B6RZjAJg5dAa2b7SR1
         o2QCYGiqz6UgPz0A1LUAfdaTQhvqnuSlgrvc4iUb2YYWXVyDWfrSzRCx7RcXlJCWR6Xv
         yI7RyIGyNFE5AryLQEznv3m3OWa5Py7kjg5Ks6gkl8LSjFC7WrSHd66vkaU6BmWn1YYV
         hsbJKvHd36vYr8j5HiDgA+4+G2CzoFATDxQeZLfvqO/BLP71eFvJ3ZxOtCtJKbsbfvmY
         bE5A==
X-Gm-Message-State: AOJu0YxG1jIkDvDL30SKiBFg4wqFVjKhUdHQp2DPEuZhd6XhAV28A2kc
	SlcwhZQAu6thpoPGuc8wKH2+fJgI3MZu4Abhz+KjZHgY7aVb02U5UGTdrd92mlj4
X-Gm-Gg: AR+sD13ksWtc3km7mHHxy4AEYBQTnslUo9DladqpliPpFAw4LNq7OHlCKJTRawRHACc
	0RqNzi1FZnYwu6dmjDUbOOLAh7g9+vlDHWfr7r59rpjI4o3oKFa1BQp7HoTq2msZNbPE5t04lIH
	qqQvj/pW7lPCQLCGszaateoN+EQmQTNw0G+0cZNjIH5fBRV5xDyD04s66YULFbyJXYfLHcox8c4
	Ka/RmvFEvdnEKD6LWu+VM6AneVBOtVYPAqVBcYD2ZQIKtiuoAHnN2iCtj5jya3ski7fXAOQFPNc
	dlPg2ml+fb0rlDSqK9BAvWbXZRG+XrDG64n8CwASPo0/BgWzArKGymzOFNt1155/zmR6XFnAVvt
	oxg1zxMSULneVfeG6i7feksvD3RqADEa7b4qbM8qyQxO4LQA6A3M2KMbc5N1B0S04rA+NqANKz+
	MzmPH/0QlgJ2Z73Jfocpbmp8nYxUEAR5xY81pEASgpIuhHTnb8wvuzvfz3yCi9dX6x1y0=
X-Received: by 2002:a17:903:234c:b0:2c6:8d95:fd6d with SMTP id d9443c01a7336-2d052282256mr67846025ad.21.1785684135641;
        Sun, 02 Aug 2026 08:22:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.21.217])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm26069004eec.14.2026.08.02.08.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 08:22:15 -0700 (PDT)
Message-ID: <6a6f60a7.0c05e68e.38dfad.7e2e@mx.google.com>
Date: Sun, 02 Aug 2026 08:22:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4545774053280377709=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, doruk@0sec.ai
Subject: RE: [v2] Bluetooth: L2CAP: Fix list corruption in ecred defer recvmsg path
In-Reply-To: <20260802132029.5118-1-doruk@0sec.ai>
References: <20260802132029.5118-1-doruk@0sec.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4545774053280377709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1138908

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.16 seconds
CheckAllWarning               PASS      29.35 seconds
CheckSparse                   PASS      27.12 seconds
BuildKernel32                 PASS      26.23 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      457.28 seconds
TestRunner_l2cap-tester       PASS      68.95 seconds
IncrementalBuild              PASS      25.52 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/529

---
Regards,
Linux Bluetooth


--===============4545774053280377709==--
