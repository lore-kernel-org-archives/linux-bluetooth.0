Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362D309DB1
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302245; cv=none; b=H6zdBDN4At+mBBwDAnMe0YHKKZ2MAyW1T8zhwSP7TpEc0Rq3NmSRCGd5SfArkvD+UmYQ+gN+59jXucNoJYCMfP6AMjpaJ7hd+kDkqBmNpXEGq3YPg1LvyILwQo7/NgSRXSCZr2f9Zdpby+ta8dEAvY8bVPGwdymXYoJFvo6cQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302245; c=relaxed/simple;
	bh=zcjjs5dXV+aiaiZhajXnXDAzeA5UAcppzE8NEyROq4Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E++3FFot+hFEe4f242OD1918gfrqA3YyfRD3s/kVzUK0JP82Vk0fv3JI8PmFLWQjiD268Etdc9F9VYu35m1UL7y36LWX1k9wo2+xuoBaFF4UVvZyM06g6kEZinh+pR0wKyNtSVr5akqKjGH9eXPCMsyfiZLLXYLcYacusC+hyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQmub8ux; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQmub8ux"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30b9e755555so2002961eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782302243; x=1782907043; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hXJ9rV5bJ7RPtlQNBrNNMlzVUew5Jc9DzHduaB5QgaU=;
        b=gQmub8ux1ufMFdXrq9IRXSv4KYZuJUSZu/5v14ztXJM9926SLLvqtlpeBCZ69KiCAq
         whdndVwa7ybqy78F5bvkGTAlyqHksf1Yi7fgdSL4OBu9E5ibfEmziE7ZVPMg4+VLlrIT
         7sQl5/3n6Vu7sA11wFYO2O9PO4Jn3yAWNcuHU7qKzhttplZnWI+yon2QoKt7HBgDDXAV
         vWDgJxT5pbGkeD45Tz5Kpq/OYTA7DoYVmtcUp49815TPoWP7/QfKb/YrfRLJboUw6eVV
         yJLh/t3LH6dhhu/kOy4peyKYSLZz730OcZwaLl+enjwjx8ijzzKF3+xu7JwXSH4OOxsb
         JpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782302243; x=1782907043;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXJ9rV5bJ7RPtlQNBrNNMlzVUew5Jc9DzHduaB5QgaU=;
        b=W9PFZ2ZHbKFvg9uZolEborot3jDpbFSHMTdOAEWDw5V4vtmQYUP0OTCylxjwTzGs8H
         THxqseweEDhCXE4ogmxs7+rDfG5unTwG8Z4CLQlPo7XH/M4/BwMl6Ij6H7iDGFuSsohG
         8SfXM0XLXaCzTyK+BnSHnqfuiSP4VdEXXU2vmxVEt9baTdk4tNwsiyl1hpEoK35IyLpI
         yoccvm0m63NrKR42AgCeB4vyRHt3a2Pz5L2xVqZrb9+uthtWBBZM8QETzt9YMbXIrj8F
         OI+S8ytyLb57exhV1UCpjyT95FxR5LPgr5IsLxt0GZmkMNrX+0PurTh1QCS1g0/FPkLb
         cysQ==
X-Gm-Message-State: AOJu0YyVovw9uTvURmECKHerVZWUW3AvS9iA2xThdVKuHyWuXHplmlWW
	U6vBwKh9VpT2USC3CoVNk/j86Z+sSkox0HP/qDj4cKB2JX95fC2sM+dswnjp7g==
X-Gm-Gg: AfdE7cmLskHS4kt9NL3/yvDunHld3hPOGI/KwSyeAgiIxSsTWgD0EDSXqacrYl5R6eK
	CB/ahyJU11ZvjQ+03JfOXKJeIserCxe+EPl7al1D8y+WSsJBU3U12nAlr0N8FY8nCVUPuv230+6
	nEfx+zEV9Mb79+65nf0uJvwJAQOF9PXLrxMVsWMooHO48W1nY5pucdmOqnQ3Y88pMjm4SH1K/r5
	zNz8DlLk4nXXtZL0UbjF5VwB064vbWx9G8bDBeMytaEr7lQMEq7vroYnrU1xIB4d3GugKtSiXg8
	NluVK0PZGFX9LOfIxTd/NDpJJe6QJNfSzfj0QNNTNvlQ5pv1/MpD2yHz/7u3Z2Pc3lDQFsF1+Me
	69MdMqL4LixIl/m1mXJJIHW4XMkVtpkAutom2pZo9jlGdWSjb4z8sUCdnOulPXPsiiQAElxl6d4
	SCu6hw/a4JfvqCDGkQCg==
X-Received: by 2002:a05:7300:3081:b0:30c:536e:3a8e with SMTP id 5a478bee46e88-30c68c421aamr3056926eec.7.1782302242921;
        Wed, 24 Jun 2026 04:57:22 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.42.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c5c1056f8sm11429701eec.15.2026.06.24.04.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:57:22 -0700 (PDT)
Message-ID: <6a3bc622.a151105c.1c00b1.7ede@mx.google.com>
Date: Wed, 24 Jun 2026 04:57:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9014144723098642344=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, haoxiang_li2024@163.com
Subject: RE: Bluetooth: virtio_bt: unregister HCI device on open failure
In-Reply-To: <20260624084333.2885144-1-haoxiang_li2024@163.com>
References: <20260624084333.2885144-1-haoxiang_li2024@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9014144723098642344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1115809

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.27 seconds
VerifySignedoff               PASS      0.17 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      20.84 seconds
CheckAllWarning               PASS      23.20 seconds
CheckSparse                   PASS      31.01 seconds
BuildKernel32                 PASS      20.39 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      414.24 seconds
IncrementalBuild              PASS      19.89 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/346

---
Regards,
Linux Bluetooth


--===============9014144723098642344==--
