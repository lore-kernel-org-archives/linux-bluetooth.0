Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10C3839B7
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787204026; cv=none; b=QKP4BKzdBLQEkiNRL6jndUEZ5YSJ2n/JwWDNvbNMVACf7J38CdB/mOgQ7Ydi9WiotsnPXgwSo5OAM5H/XbwW6QjRpD0tBVwo4MrMiibOmxsC1mBwNGBcgpqM0zmg5grfo6N2uWreUkgrsYIe2nPDbukO6MAbwcj/B2u6TgwCtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787204026; c=relaxed/simple;
	bh=JuetriwRn7UUFZ7wLQr2eRyYJt+mEUGy3PE5I/oYOZc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aWpOoz8hU4iGjfOQ6LHIYWhpMSRh0XfMUKs1kVN7BabtdlIGPHVvQrwAq7FynAprTYJgxMZjLvHrm94VnNKfSuBdkcsMtC8L5/9HZXGuXmS9L5LeQeLj+WlsCA/qm6hyAdfD5a6dzGN9/KJZpv53mi6TZNRiX0AGPQAXcUeqDlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqCw0ZZE; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqCw0ZZE"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-44aeefa1c00so711963fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 22:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787204024; x=1787808824; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M+XnLKVzhgmXEM/y3oRhLaKtghO083YFdmrSi2XYE64=;
        b=bqCw0ZZEcceyv3yemt1vaVkXU4DJM2xGpRLENtNNwYwu1sHZyhnNw6NxaxKCYli93a
         ANqQJwaTK2e90bov7znbgG5vWd+hjtPqSuOr3ia2davG6JYOYu9jGqQk4upfRSqUh3dS
         rNLnkicwE88EwTy/Eq3yIKg1gq2ZXgnUyeU0oEROl0w3YkDCBHROyEiQKOdG3bGfTvk3
         0UCZUqNI3nTOggKkUB+SjhOEdN0Zr9on8lByG0sRaCnFkwcQ79Z28GgH014XF/KwROPU
         hpB7fxzvG+fQEz4SQt7DmTQ/9qdzU3eW/XrPfvfcXkDDTyBIWhG8XfgqihAkIkD0Ebpo
         flOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787204024; x=1787808824;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M+XnLKVzhgmXEM/y3oRhLaKtghO083YFdmrSi2XYE64=;
        b=WAS4ijhhZNdfnBjkUWUjP3wPHaLoVhqouB+JPwz6sxontvKc0ccJZsvTMD3Qn8S+gG
         zNVI1CRh50gIRo69TdK6y6LYO6xe/GNZU5rLqKZOcPX1uhhtl1Bz9Pt8sHj8NH7VG2t0
         n4cAycOukKvV7KNTHkOTusAy93sZ9eU7XQ7iGChdEvRwNslw2xhm582Av3hDs68iTAo8
         PEny65r3hrr3dysLVOWuE3d/QtvhtZKx1Q9hD3fqpqrWbFdjfjuIg05qKEfzpZD1eZd7
         ydECP7+kDY9eXc1VRGWcy9Pk0+ytZpwngFpbj7tH3JwPFlpgIspRYLW+P9AKoYz4r78R
         qAHg==
X-Gm-Message-State: AFuF++lmVd4hz2rDg58Q91ol+zTTVn2CvGlen00mfGBpx9lcAT9IisnH
	UwjobTR2Z4hEaKpkgz0LsLlw3MDsv18POkutQM+XVxts8JT+geKjDVPUvR3H4JpU
X-Gm-Gg: AR+sD137m3ufjcpCDMgGtpJH23tPbSUA4g+71zhTAA22krNNrFNIJ+04BIrmrVNdXxl
	yETxlSBVWCwU7CgvbAkZggEDoQaJYlHlF2KA/YcEmhPMff9/gkPvxadJwo2bfanN4Szm0yiB/EZ
	pZvDCC54JTMD0ZbTsWGF5s0PEsKNw2e5nStc4iYvAPUcXRd1A6ExLfXTU+1pXqa3KiCCfBtkbrv
	UwNhioiXatk/AzqtwF80RifqwWvfpGDD59CJqEyM95wKKP8B7pcqGNokUX8CPd4ZmIRDBtbjoX/
	CgkXviY9fdgibjCHyY3XlBHTN57yP9mZtKyMsimrtfUxPm56wrH+hNbVjMKsy49Op1xzKin//aQ
	V6iONbuab17V76JViI93hamopdlEKiAwBQT6itQs5nYMDJrTAEtDL/i2N6fQMFy/E36hBwjIEx2
	/Zu3r+POGvvSKgchxIdSTpPbh4ayLFCVCAUttH5AoTZcAxKkDuTtoJZOoXVD0vSWOxOdIZ/KNaJ
	4z2Im3t
X-Received: by 2002:a05:6870:de0f:b0:457:f4e1:a1e3 with SMTP id 586e51a60fabf-4631b06994dmr4208432fac.7.1787204023695;
        Wed, 19 Aug 2026 22:33:43 -0700 (PDT)
Received: from [172.17.0.2] ([128.203.190.119])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a54fc4esm757358fac.3.2026.08.19.22.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 22:33:43 -0700 (PDT)
Message-ID: <6a8691b7.0c3a67b7.329f72.d5c2@mx.google.com>
Date: Wed, 19 Aug 2026 22:33:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2977040593350884263=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, triet.hoang.dev@gmail.com
Subject: RE: Bluetooth: hci_qca: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
In-Reply-To: <20260820044258.1954272-1-triet.hoang.dev@gmail.com>
References: <20260820044258.1954272-1-triet.hoang.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2977040593350884263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148805

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      28.72 seconds
CheckAllWarning               PASS      32.28 seconds
CheckSparse                   PASS      30.49 seconds
BuildKernel32                 PASS      28.02 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      521.26 seconds
IncrementalBuild              PASS      26.80 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/621

---
Regards,
Linux Bluetooth


--===============2977040593350884263==--
