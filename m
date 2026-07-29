Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3241B8FF
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321034; cv=none; b=CeeHw0zk2KnHs6iK0/xKnZQEypF0EG3nEoBzvif9HMW3DLjKSPU9DEYeMZ9x/Ks30GFd2FoRKdhJw0XS+5yPDthMyV7Rs6/TB2vEAIppr3Jlkys8DT2I+b5S7CLyJhpYSZ74nHo44JrD1vudGfL0t6hl3Nbfzp+9Goa3fyryWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321034; c=relaxed/simple;
	bh=v1uRDjxq4mX64zW9aBj2nJCgydY2gp4HV57cRfOjnho=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I5lDMACjDbKG7bWlwKglxWI5NsB7OTvwAB9IfnhsZjAam8CkKN+z94xBQGX/+WQouRHGFFHL5xrUJuifzei85L58TNnKrTqBpjN4r3uD88ofZ4H8r+NvYPt5YrLzLg9PEZoIU5GRuYC0io2RNIvcZ2syeB0Sv0k42gXEANMijEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PphN16le; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PphN16le"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c5382806fso7373241cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 03:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785321032; x=1785925832; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LMzwmuNVNFaE/+1l3zHXzBjO/DdA1qBxOSLokb+lCA8=;
        b=PphN16lefIES+BSVYv/y1I0OOB+50kT3AZDdYRkwZ+RodnuSIF0mt1c2Hc322ycAuX
         YvLxH6vqgoC16SjpBmFW36/nWFAos57JUW+TDTrptgjNHYdANPH2rv27vBLKO2ZyutMz
         Z8v46rCiYhOpyzgmw212vfmpN+wd6iTAeUrMUUjaA90Fo6B2Wf2uVh3HgJh8mlkxTxfN
         xOYd6R4/dBDJNBGTfxd8y4K4kFwUOzYAN/g9nest2oSuzR+QdG8yjHVjlVcRlDi387Pw
         eV/U/xm3q+0vjwq63jzeN+UppskC2bT3Ja/FvOeyIJfvm2S5yD+Efo4V9ixEBTDfccM3
         GGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321032; x=1785925832;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LMzwmuNVNFaE/+1l3zHXzBjO/DdA1qBxOSLokb+lCA8=;
        b=gH+nlykJXWYqvdY9klXifBkyt7HOO7BcEe/tEaj3EF2EtNVv6OkCJp074bhH3Ace9n
         i1BIiDwsqqZ3kD3I21A4ORGIH2mTB5cpggzZGWGmKcE30LmT6f7xlpYl9HGImPp9bLTr
         P7lfmLccvYm8eNOsIVTsuwxn02v88/viyQHKJjwe6azgk9BcQqaE9Fj98e2FKUgIDf3A
         VCsovpMwgEfas4wb6mpbM47mVXN0+h3kxrB0lC/j/YB+YWSDUzDr1EwjIRUggmtnn7MU
         Q43rkPDAeR+qRKqS0Qv59I8+76XnWeMHb2NYw6DarJyQwFb+6swHAPc+CPEyJTGd8E6+
         jQ9w==
X-Gm-Message-State: AOJu0YyRdkPEUlmIoMUD1qzOVXnSA+sdkHAjm0H7sADy0674r32pTQND
	1/5xG1Xgq/MdnDlkiI08KL4ej19ora7Ag/l89/37m3j/9uh2TsKr3mtLfuiFuQ==
X-Gm-Gg: AR+sD13gAEE6RZ0d9Gx03UsM/pclqFX/4M8absgfL78Yexrakden9rNs5RcljwPyrP5
	ayWWdBZ1T5e3q6qQ5658KsCDP1YRZhTVgPYAzHdXkgBdlEOV222wKDLB+XY/FpLurpk9IPEwK1P
	v7KHCUa2J1I6Su1NVLTHPGNgmZIpgHj5PwLQfZtrhyJiNf+Ag4Yz9X7pmYtDRgeJ0XS05IWiekh
	OS/J3WPOvNMnMW53kVkt2+Cv86wOUrIm6IwIy9JiY1IedOlSmnLo4M55BgYOTm5Lwl8WctfDQD4
	ps9Z/cDH5SukYXzILU8wEVVviwxv915fbcHhi1ZaYFjnzQnRd3jTVm+zht8ENt9I19Kj2ydHGYb
	ZRtj+pzsWP0PWJLQQHF3OxH7Y/TztFMjrccB+OusWf7QQ/HitaeDDsd0bJP/MHoN4upUhH3UIsR
	GEAyVI4XHud9N9SfG8wCJp/krZu37aDSIJS3r2phvVu/UUT0yrQvvu99Q3Hgw26SwlZzi9
X-Received: by 2002:a05:622a:1191:b0:51c:fc4:a144 with SMTP id d75a77b69052e-529d70557e0mr57770921cf.4.1785321032447;
        Wed, 29 Jul 2026 03:30:32 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.103.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2efcb4esm15385631cf.26.2026.07.29.03.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 03:30:31 -0700 (PDT)
Message-ID: <6a69d647.e0fcf82b.feee.f5e6@mx.google.com>
Date: Wed, 29 Jul 2026 03:30:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1385583332826112749=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: Bluetooth: virtio_bt: Fix memory leak in virtbt_probe
In-Reply-To: <20260729082615.308918-1-zhangchen200426@163.com>
References: <20260729082615.308918-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1385583332826112749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1136470

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.93 seconds
CheckAllWarning               PASS      28.56 seconds
CheckSparse                   PASS      27.04 seconds
BuildKernel32                 PASS      25.13 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      464.28 seconds
IncrementalBuild              PASS      26.13 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/507

---
Regards,
Linux Bluetooth


--===============1385583332826112749==--
