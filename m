Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FE35A3A4
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552423; cv=none; b=lAUQY1bOPsFAkzpg8FcLuatj3YwRBgcjqTQm6GnYlLx0o7CVyfO7lhQqa2CQyI8csvKty5cD2GZxArZ+KI/enRnBevt7aU2HFPel6mqdjEAiXuoW+S6KJHyuZUXC5+NlNjsc3kQjQtYgPeEZjGl0wWhVLxMJlyG5SLX6YaDl53A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552423; c=relaxed/simple;
	bh=QF6CEkU+Fcprc8K8VutajtPnX04ggZSq6RAzsGzIx2k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LkxTfGsVfYM1iesHlQL5/tlqy53/kFAKXHvsu4MkMNjF81bKk6TMGPfOkPBkMSQtrEKjNF+a1rbwusDUn3geduPZWyvFXVtpt/1mvpVb33A5DpROW1cH6/JZWKcdjYQ4zaKAs2L6tyiIYRnZVqMfiKVdq6lu1EpNjFGGG3cY6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIhgbbEH; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIhgbbEH"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1815949a12.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 23:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787552422; x=1788157222; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b1x7GjX7jrQezstx0+CGfGWRwdJeOmXrzW5QrAycIRI=;
        b=VIhgbbEHkZPHnjM5SbNjsN8MoPNL8dsHloskJw5aqgp7gWj4mcgULn8Ln9n0PGoGuy
         mhs5QE5GQsvPpsUFAS2bhSvtNPUDUXkjcbyGAoO3NLmHYebcs1owHCkPEB5Gw/SlLxNV
         sobxrusG91YKQ5EEaQNPU4D+H4gu9UOIwJzOa7HcwISEeWYP7xD9KhrxyPzjMp0bz3lZ
         Qc65cZPu/RRmUdkv3o3clsfx/xJT6B6nOugDtDgauP+jDiw3o6Kbz4OyN62xu1r5Hfxl
         z5X1Pz1Md5ZxnYG9pOuuJz+uhVMhrxv7YPEJ3RZtR36yONl8j4N6OloWhLcj0i/JLU15
         RB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787552422; x=1788157222;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b1x7GjX7jrQezstx0+CGfGWRwdJeOmXrzW5QrAycIRI=;
        b=ElETcC9i7KzC2f5UnY9bApEImrfeO92nEQS3w9CHXui0ctx0BaTFbw4SS5S7T+woLI
         phr9nqg/1APwfx3s3kVMagEhXD787npwJ6guQEHQUOt2ycwcczRe1vFGFI4Hqf18mVfS
         9oHAFjGNXThgBOSibIJRvyVXDtqmRj3W2+qT1/j0sihNEW/ezi7PC6RhBNIvVJxUmD7/
         F31GTZQ0PC20bO8XrnlSc9fYcVUY5xvX9r8xFaDoe1CjawC3YRj0PzGA5gjScB/EEbnl
         Fqmb6Ll64TBiEvyJyrvHvxyw/iVxakmGlLu1iaV8QeYZv3I+zC0eRL/z+z4w3F/jwDiM
         bb6w==
X-Gm-Message-State: AFuF++mIbS02kbG9GxPF98IZvq0eXov4EUEzJMlSems7f8+M7/k6JaYT
	tf+m3RqQCaiFPViDnMSJdimosbJ2x2sMUVVhIOKh/sW+qGkdN0mQOvE/7hTsOw==
X-Gm-Gg: AR+sD13LmOZb0IPf59V9R59k393D1Q78tkMtxgOcvpM1VMRt385HzpkyaDf/+8gpheJ
	ZFvozp1e+28eUXgoZx/Aiy03ieWLDQgI9HE+KQXvMp7ejm1dHhmIj6a3PlH6Ha92ho36qV9BwPP
	UnjoWYbC5HXzk6ZGx7oCnzH22gPWi2XvJcXxtTzFvLLIJNqJ4mbj1elCefg1riED+kWmfDWfFOX
	xhmpp8Tx9KrcRRFsxyo9KdJh/fC1b7Pj3xa8Mpo6HWu7m6Ja5aIvEBRn/mueMBb6yGHMcWBMNSv
	c/UL8F8CmjCSNuHMfQTmz/LHw4GZ+XTjJbf6zb9kHeAtki+kHpEHkiuH8auhJ9si5tPZmiR46P1
	1mx0I1kqXEDF/3D6YES9uPsTPwQvnKJPgUMU38Y5kZcfVu6YLawGdHvra1ysm3UCnRzVQr73Bzd
	QBSsy49hxIIFa8TMLJrYvdsLY0H3UT/xDA5t2aIdjrWN5VX0PtDyHySoEDHFnhpDRhyCY=
X-Received: by 2002:a17:90b:2c87:b0:392:7f74:58c9 with SMTP id 98e67ed59e1d1-395c3a43766mr48892164a91.15.1787552421748;
        Sun, 23 Aug 2026 23:20:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.163.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418617378bsm20726335c88.11.2026.08.23.23.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 23:20:21 -0700 (PDT)
Message-ID: <6a8be2a5.46c6f052.5bf27.822e@mx.google.com>
Date: Sun, 23 Aug 2026 23:20:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2429682584190448178=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, junjie.cao@intel.com
Subject: RE: Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728
In-Reply-To: <20260824053227.317496-1-junjie.cao@intel.com>
References: <20260824053227.317496-1-junjie.cao@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2429682584190448178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150614

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      30.59 seconds
CheckAllWarning               PASS      33.52 seconds
CheckSparse                   PASS      32.10 seconds
BuildKernel32                 PASS      29.20 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      538.56 seconds
IncrementalBuild              PASS      27.75 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/641

---
Regards,
Linux Bluetooth


--===============2429682584190448178==--
