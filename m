Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9572F7EFD
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409951; cv=none; b=CQovI05r6GPmEouu1dBzSlTUGw0BWbt+9vf6Qf12BZwOoDUPe27C3VgSbPVaWH6TdSZdgduSKbpXAfq3uGVUlCNJ+aHZ91ARiMqFqdEPEWBgebO1npB1w/bz9mNp33+vbCqMW9cf5AuJp+l0NdACjuDixMpcJ9d9DkTHmJPDHEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409951; c=relaxed/simple;
	bh=pSqzYuu81wGaz6fCDEee1ztvHDhU27UaLpAc2rvb79U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ix5hCgjSGRzygAVsfwc7CGChDCX4fOXn8y+PSIfKWxCk16GyEc84Fz1nHLgL4BBp6srpIMS9t1ndAAkGmSEBXYULCmY91Y7f5ublBMWTXhgG3uPEa4RB6ARU2CGJKdI0PdvsS0q8/acdXun1ayUM1sD5erSTpNpsgTeM4sBj714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXQLDp+Y; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXQLDp+Y"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37df416c44bso84856a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782409950; x=1783014750; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ESAPw8hYspEqhpSM4OioY76a+1jYpamo5cETCosufQI=;
        b=hXQLDp+YoXFDuJ/pehTHXYVjNp32PL/QoGye3hRlpR6PxAXlU+WsHmfWQME5GIELh4
         booJ1YZ8wY0NrbWs2zy7Oi/xSyCpP09Tl9hLLYFF7BUiwLbpOx1Qi2CINQPWO/PZKG+b
         1X33xJKTyMgb35y1IfbKnX/c3ncSDskvQC/aooYpgUbD3wN6IytrtwBVTIJuNWY8YP+i
         EYTBGVwPSfiVrUHavnqHHoGiS8kpN2IRf/M+vsz7vDdHQczXT499rW0+3BOOfe6dDiXy
         vRLnZXdS9KHdJpQDbRMW1XniAncYrVcVrbXPSXgx23RxnUBztexIK0ci5ks72qzkff1G
         KCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782409950; x=1783014750;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESAPw8hYspEqhpSM4OioY76a+1jYpamo5cETCosufQI=;
        b=ijDKMzYElVTeyCH81OoZjgyUNkSToEkjWx3QUJ7QdbrqygfsTLNZTG924ZPKPXv2Hs
         u63Ql6yXglL+SWQwwb/1lCxAfJpO16c5q66BS2XAbKIFU4e5RUo4aOtPszwgR8ycsDrI
         S7faU5rB1fihv6Mqsnso5L/bMtiDT0XCdy8H6JKSivE1RnhZerxE11WH0SwYO2nWMDgC
         eCHjzpR0J42dEyR0ZkXoXUZGnxSSSttY0zyr+582TBYMV/6Yn5KNINSWk6WLwpNhlrcN
         inQrhKsDaUGrop+ExGUmjdTQO0FiWsdgRnhb76VR0gtUxwmYe0UCRdoBwpLIgeVtsfOO
         8Jfw==
X-Gm-Message-State: AOJu0Yzrxnxr4zHtafPKonaUdXTb8OkyWMqZvnMFN2Qn0iMrk4kuCLT8
	UU7HuSgre45vVf5i5e9bSblKQJ7fYscsSVFe9W1Hf/a6nB3sr8l7G7xBDQor3B2J
X-Gm-Gg: AfdE7cmYRIdCh1GeUWn62ohtnWFHF65g2WJjoviGWs7cgjyQrjGCqrFkJw8FyRT9FsU
	KnI605Lp69hNFZQE+Z715a+/Bbb9jPqMozQzZiYv/rfc52rddREL8VQ/+rMFVlfqvPZrrrDYHe7
	2wk1lcV1MFC2LQmetHl8HRvBGRBSF5wXwfxzP3bdeUGjpqXjBhqfXFnghqLZtaxW94i5Fz4I4uH
	NnGWqC5pVwfI5iItzNzPb+4udJdSYGulpyWLVUMgETqKRb6Dy+GVruhFhie6en2aJgQN1uq/b8Z
	5jVzqvk9GVCSt0+wyXmI34KHQVKk2BHx8b1wUHY3XT4SxaVX2sV3xetJOSfu1fyIVIIWa4TAK4N
	f/slxB+tyAtmc2u92Ka0wfnnW4n2YJIm6Cr6UQ7i2l7a1wY9EG8jM5NK7MxUl1TWsbTDn0JaDJC
	CW8fWU+YnI8Q08flc=
X-Received: by 2002:a17:90b:4a12:b0:369:7421:b376 with SMTP id 98e67ed59e1d1-37dfa26e771mr3603786a91.19.1782409949926;
        Thu, 25 Jun 2026 10:52:29 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.22.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3b657b3sm2377594a91.15.2026.06.25.10.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:52:29 -0700 (PDT)
Message-ID: <6a3d6add.8dc4b177.2617be.f9f4@mx.google.com>
Date: Thu, 25 Jun 2026 10:52:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0062677651225230882=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vulab@iscas.ac.cn
Subject: RE: btmrvl: Fix hdev dangling pointer and error code in register_hdev
In-Reply-To: <20260625160607.81615-1-vulab@iscas.ac.cn>
References: <20260625160607.81615-1-vulab@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0062677651225230882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1116653

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
VerifyFixes                   PASS      0.21 seconds
VerifySignedoff               PASS      0.20 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 FAIL      0.20 seconds
BuildKernel                   PASS      26.32 seconds
CheckAllWarning               PASS      29.01 seconds
CheckSparse                   PASS      27.79 seconds
BuildKernel32                 PASS      25.65 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      490.64 seconds
IncrementalBuild              PASS      25.84 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/353

---
Regards,
Linux Bluetooth


--===============0062677651225230882==--
