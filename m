Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C933290D2
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786311425; cv=none; b=HEU5ttdZPzzUw9/ImLsnmPkVloVa+ZTDA40PaSKbaUdWeXmddSQiyA2U3uYimwJmQUPE/T/Q4IFJ/AtE51Z3cbYIPDlrM4kJxVAYlylEnZoLZ4wONOqAqLgMhE5bFcPqgenDWlb1khHvYtU77XoQzsGDWzG+dDweMW637P6SokU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786311425; c=relaxed/simple;
	bh=82kqrKsq4kHcYaaLM3VGGgLT5SO2g9lVzSKLUKY2rk4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N2iJHcneVaoutgRDQbJJKZ33813xLoYzD+K39lXFO1qEMr4ZB75JOH8W+WWnxgtctKgnP/UVvq9pxp9l2BBLSAp+dXdKVu9+st0erOfQZrJf9IphqKS0dnnj6yuxbXp+xotr09m8kZ3fw8Pm+m5/8Im71MBkdG38iSUEuTRbVkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwzTFiGP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwzTFiGP"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9aea40d799so564733a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Aug 2026 14:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786311423; x=1786916223; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qOqekPe54yz+zvKifdOxCdCOANTpsfvOyoefM9I3r4o=;
        b=DwzTFiGPyOBuOzIMtgE2SosvYLeJ2GFY4nwZyptOVTyXhF6eXwxIEym5odiMvlpqcu
         j9BubKMFwho8gg1CrTJfnWaLa09H2r9TSKE8EFajygzLmbBBNm9Jbv1PKXsZogf8kMbj
         soWWGjkEq2od6GUK14hNTVjPWaiFjVosGHw0HLK7D695sybbx70UAF8ems6e4tWBw0Of
         izj9kfoa7/jjqAHI/MSEFP/FtWtsGkY9YzMBAAAiLxAeQCkFOCUFO8FHG27hlHtgVLM1
         Ua7PM8NJnhMrqVJLcMvcku+RHpDBnMSN0HiQ6aEf7gudoqeqpoVf28uJKHQ1buCHoque
         dtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786311423; x=1786916223;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qOqekPe54yz+zvKifdOxCdCOANTpsfvOyoefM9I3r4o=;
        b=BJCGgiJLRxnCRtrYOEsBrWqsAjc/umUK5I1Z2ZvTnO7Mc+6spvrIs/Csv5Pv+o3c/P
         dTz/pc0IsPDxpn47IATvmHJCk0D0BEUicfCBxNauN2OAzvgGCNsqjZq5QHEd7CMTK5zQ
         IbwkP6oMJ+2g8ZkzGM1ZMXiuAOTCSVQdt5lAIdC75ELTuiqkBkNh92eIP0v5Hi1OEFnz
         W8HlgfgHHjcBJFBuwticRFQpM/hU/mPGv2U8sQYiqXL8sjkKPfSlFCNxdTAbZjboQJVk
         tfGx56QRCXS7H7Q/mWzyXrK+y9m1z3v0r0Qpo/AuFBaS5s25jwiAZvMaclawd9j2LFX6
         aZeA==
X-Gm-Message-State: AOJu0YyoEm4Yp2UD3wlqXJEO0k7KcmUcwR1dBc5K68VyPJTj/dFoL7Mz
	t69qI4gWay/i69C16I7vUEU4V1Oim0RAj4GCWYEu4u88/r/7Dhc4TSKANtw3tQ==
X-Gm-Gg: AR+sD117udz4+rlv03xZpw93WIm8jSNQ/Y+Srl3t1SaGGdGbrIviatzShXB3UKMZNiN
	6QvTq8XjRoNImJFrftWFpq5hLh45DgJb6UQ9/PRBmDgqmGxxHy5mWlHe6/KUDIPCmGF1AoEQZDn
	yycMZhSvN0v9W7rknnsVgqxnYcpe+Ap9TuLzUMz/INbpUui4EvikIwoYP3CU7YZqYgTDZugFK63
	MQPewi1DCW/MfmPn7zAY56nTyKu1Sw/YBz/PZ1ituoA0SacsvKGmlLmnQxk5pOFSB/KBKMlhBKI
	Kfitt5t3GTmenG8jTohIEQlugs+Kzzr/VhGhAH8HE/uNRbtAvHNGIo8sk7dsmNPRX6vAz5Deq7i
	BdDJc9E2tXWT2R/Up5MrTzuE/LTgqgKTAPBmPQ5I1k1Xu4G86Ojay26tHwLoWtmr9RZIM+TK3tb
	+KQ3h0w9fzhRU6pYYO2tuv6RjH1Z20TRESEzVGIaJ0hFAMAT0MdP93r/jie465SahIA5xWQw==
X-Received: by 2002:a05:6a20:e212:b0:3a2:7ef4:81df with SMTP id adf61e73a8af0-3cbce960c19mr13021510637.26.1786311422704;
        Sun, 09 Aug 2026 14:37:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.134.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86d3fcsm35222297eec.4.2026.08.09.14.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 14:37:02 -0700 (PDT)
Message-ID: <6a78f2fe.af4834b4.254dba.ec3a@mx.google.com>
Date: Sun, 09 Aug 2026 14:37:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1333309680019227629=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, richard.w.nunley@gmail.com
Subject: RE: Bluetooth: btusb: Add Realtek RTL8821CE device 13d3:3558
In-Reply-To: <20260809-master-v1-1-c62bc61debdd@gmail.com>
References: <20260809-master-v1-1-c62bc61debdd@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1333309680019227629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142999

---Test result---

Test Summary:
CheckPatch                    PASS      14.04 seconds
VerifyFixes                   PASS      3.99 seconds
VerifySignedoff               PASS      3.69 seconds
GitLint                       FAIL      4.80 seconds
SubjectPrefix                 PASS      1.71 seconds
BuildKernel                   PASS      27.58 seconds
CheckAllWarning               PASS      30.31 seconds
CheckSparse                   PASS      33.96 seconds
BuildKernel32                 PASS      26.79 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      507.97 seconds
IncrementalBuild              PASS      35.52 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: Add Realtek RTL8821CE device 13d3:3558

28: B2 Line has trailing whitespace: "--  "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/564

---
Regards,
Linux Bluetooth


--===============1333309680019227629==--
