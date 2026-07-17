Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3072F7EF4
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327703; cv=none; b=PNpMu1gd5xR3ayGSH68AouxsMzchYTGyTD7+DLkxmcCmeXw/c94dBhHU/QvEBTN+tbg7KcFrkSXRzpZ1P0BvFVLzq1e+GRO+WTlKKPGlv/3OSfWHEH/1PmfjY6umPKAlWY7S8J4yCv/ZnIkzKfKsvaSDoGHfzL4a2yXm1M4WIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327703; c=relaxed/simple;
	bh=Bs17UGS5GqCTdv9DZ2qZHxoHC7C6eio0DrPpSshuGIM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RWzFRmDMjFxFv5GEBACh19Q5cGkK8VGqADuZM/UXvRBJeaHhLp/P2LhcRMEbUaOvg2dtSQEGRatrDohMWJdc0NPrpuLABpWZ643CB6pzMCvBajQs6ybBz15FibqVrobmq4SMKE1LunDzbX75abO88xgkoMr14KRDyCkIB2xgL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbSEtNAq; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbSEtNAq"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso5567233a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784327701; x=1784932501; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WN5SuOpz7YoFaLmod9NHKmpfbsCcIoWwURKIu+u1dqc=;
        b=cbSEtNAqgSbRfN4+bIci71UFp4FJ5YzaXkjzzgB8c6zamZNJ6DPFlZPMPjzMYeGzw8
         V7DhAvNpHgJC8N20KYMsqF7sTvEA/LSdW8RVsgVnpc9T+WsXXDdFYCVvB5ul0UjPDFTu
         AF+z4hBr9bTbKOAWZCEPhR6u8rXkWoFg+f+W+hWRYhEdMdSHB/LQVH1YxA8Gtn1tfjvT
         vajhIcY3O+ueyyiXVTNmDFDtNgHlWGw+31jTWJjOc/jpKqxia6BzwdMHsTNbmL13LkdE
         SooSQrhefvjEGejF1RKyQlCNxb0FOljBLiHdZqBLNhWtT2ApuprflmpxzSYKjo0d8Mpa
         KqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784327701; x=1784932501;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WN5SuOpz7YoFaLmod9NHKmpfbsCcIoWwURKIu+u1dqc=;
        b=ky7LyZwWnpQSSF52TwmbmyyEx6o0EeN/h41t3zHeyGeRPVMxxDyRUgNVZxoOC+E+kO
         khIXlc+zRDZkpLqUX7JuXnn27LI+7nHLnu7NVFjWq8o9uT8h5ilnq9WFbPpz9SLn1UYZ
         vvo1s1hrQEc4XaNLjdajwkzjaD/AxrS38+NxU9rRkbBSj+unLX95QhqC2DaDFv7SSt8m
         kcJmo9X36LEXSvgj96ciQRJ1ThZTWWgKujdSd9VEokajlD0gU0PzNefgQtFdRn6uLmzs
         Di0Snn+d5XiQqYNlnrwZXQvSILmsJhrmIauC7hQh/kNPxoaQcsV3of/m491LR3tHd4TU
         2d4w==
X-Gm-Message-State: AOJu0Yw9HfAfCqb5v3pneJxDcQ3Mq+oQ1CURhXUtcdKDUK+tC6xzkrXt
	Ku10Yypmlqfs2e9r2sg84wWixbE7Q5ZX1RNUSCmkN+cmKysUOU4wXc9UDilX2g==
X-Gm-Gg: AfdE7ck5qKC+fBI7/Na/Z4OG+araPaEruuMxaiCs592ultRYwKuAgeARIRRnYLIqgpW
	9n10nEGnUHNg+U8opDfN7MmfidXMUW82fyKeEI3Z1+i78GAyeeDwxXfzvjNe0leIHU0gb7nR1pG
	XQmsAphF2TcuC5RcFL4twzyYujCYa2U2hWn4uXy0mU2vBbnwK/Q2vhW/HxRTYxrx/ZhLJxKsv92
	pSJ86A2lhy+GuPJDMHAwji9tnAy2t8WkXSHA198Jc8ErcDmWG4Ocs3mQbiNgag9PQIqeWVrC9GA
	c3zp5/SE2ml/8Cy8z3uJVbG4wdeAKPKZMDD0Mqnj3Anb4yhLH8qv7uKHwJMXNxRUl83qwAYvZwk
	PBlHqExMPhkjTrGmOIMAeXqWy5rF9e8pmwvSgmWiNO5IDecMI7jX81kGZ2GBja0NcZWy+czi5Vl
	a6rc/LsyJl
X-Received: by 2002:a05:6300:2284:b0:3c0:9c19:65a1 with SMTP id adf61e73a8af0-3c3ada952cfmr4712965637.73.1784327701353;
        Fri, 17 Jul 2026 15:35:01 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.62.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d44fsm9727297eec.1.2026.07.17.15.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:35:00 -0700 (PDT)
Message-ID: <6a5aae14.13be6df8.22eac4.84cc@mx.google.com>
Date: Fri, 17 Jul 2026 15:35:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9150717277369613084=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, webgeek1234@gmail.com
Subject: RE: Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
In-Reply-To: <20260717-bcm4356a3-bt-v1-1-ffa2d5233360@gmail.com>
References: <20260717-bcm4356a3-bt-v1-1-ffa2d5233360@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9150717277369613084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1129847

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      1.51 seconds
SubjectPrefix                 PASS      0.67 seconds
BuildKernel                   PASS      29.41 seconds
CheckAllWarning               PASS      32.67 seconds
CheckSparse                   PASS      30.24 seconds
BuildKernel32                 PASS      28.53 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      528.47 seconds
IncrementalBuild              PASS      30.05 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/451

---
Regards,
Linux Bluetooth


--===============9150717277369613084==--
