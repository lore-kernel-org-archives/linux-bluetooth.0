Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E55385521
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066996; cv=none; b=oUURDHPU7TonGOS7o9rEfsnmi7OU6M4f3QqobqShv353zq3GOjInrG0wcOg5IcV6tjnDvksDflcCwVWo/1MM8FfbWQogwgprlFvN0HBnyXm9at46jrBvdemz/C4SHOompbCWyVKNi3PLAj2hzHQI2/yf4nZE+jxyWFJ3cnxRBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066996; c=relaxed/simple;
	bh=PmZIAqaOTi+9kZUhMtzDJKlthtlr/432XU/Wrimed3o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=B6fzEHa+mvg/LklAvYC9jEOM+WFunvUt4sevXwlymoGYF9P6Alq2NWnvHFHyvD3PUuczcRgDxt4okcMOgfDkfJCKK6yuzt6tpIjdA3pZrwjV5+3BU1oH9cJyoTUZx4Oke8jx/bjyoOYZTt9xbLgNMJ3TwVVn9fixGrW+9aDaol8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzLL77a1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzLL77a1"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4b28b358eso195432a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789066994; x=1789671794; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ElHk/8ccCVwHh7pQC5G97iTBLDGe2iCJLSATEXbPI8Q=;
        b=SzLL77a1qcjA9i3TmVOxmA/uZvLV2Espuy/7JjaHwh5+5iB7B+GQlc/XabnrOI7ECo
         NyFoSf2XO/Y+L+5JFyV7E8FjdV7eDZ2L2XwyVOyyXVGm5ldPM6ptxYvIt1o+5kFsnw/m
         tgoxG3hiIobgK3PClmbt+SZfOvZkpnENzEB7/ew5CxOfGkjbRVwkCVSvzYcOBbBYZIbi
         o0AD1FHSAmx2YUu7G6lDyHKzv5AKGQk4iXCKLYz7ZRb5lDph3Q+rD791TUdFiF4ig5M0
         siPemTRboas+3dxHUkMQvNDdwghB20p8W+CRzVyZETsin+3LyW0F43PFTddiyb4Mxm6I
         lL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066994; x=1789671794;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ElHk/8ccCVwHh7pQC5G97iTBLDGe2iCJLSATEXbPI8Q=;
        b=LAn7x6g5buT6qIOn2zWe5zs/TGnDh2A0b/lsBTtSIXRlq5YZMsuhBq+KKadD/e2x9o
         uOMarlqlGrZQhk4/U0dt4aJnx363pfELbR3CSX+gfephXoQv5KmATxG2I+vR7urgyB8Q
         UgCFaPhAVIkl1cQQXApNLFZV+nR4RqOZINcp1OAIlsAmCLCR8bj+2xcBOghAcfScGsw0
         QdQURx4RaHumOKHckVPRQPW3b4vgto9aXe/Ov+IbhcODrHd6KDmagSOJsZXrgtbPZBbo
         L6T6MTh0vvSryX+7SRPBPx3EOPXRlxDyqAoI6PTTc03lFSOCmX/u3kHl358F7EVfTycc
         nFYg==
X-Gm-Message-State: AFuF++krzYITPe/LrZ0HIbmONCrKnVCVfSn30vzGJLs+rwEaIPScj9Bs
	EgWlh8WOvrDx4sqfQWElqF9amZsK5ILRl/EwI8Bu3Q0ls42Or8URx0yo6z4HRgZh
X-Gm-Gg: AYBFou1M0YE4omlCuAAzWqapzPbfQvZZVV4D6rse8OkWVVKMCz+EGjpDDg83bdNREO6
	G9GZT1JKAAAWJDFPhW+5CldZAZo71Z/jSAAAQzDxVTOf3Pz4pSeWsBXTLXzVVDsQRV0QEBPDQgI
	/hjXzn7m4Vqv+lsxtU1F3gnqIbqUVgyGfNmGSP21uW6hPWMkozq2+e/VgXJiJ6wyvGC4DQOP6Bk
	GBmFaio4cG/neUZoi4uUzV9VCWa8Ajjsq0YJn85+zIVX1h/DJZeW+MSD1C1sGj/EQMmBBi2ykXp
	+EjwE3pl6DAX3EsZHI+4ENSnkLpQLzxBSKVRsHLiR8wYGKV5Imap0A2dPtdOJxop1ttBBlJy7yo
	khM4dFgGCA5ZJLKOtvoiPHi6ra8WlsfWFjK0Mkj6YTd01gHizwgXhEMSTH1HUihTDOn5yVkXdNC
	ZhjW09hxrHu2+H95Ht9DKlIs1Vyoey6jtoJdTt5PjkveNl+rGDQdi4A4d6ajWi2W31bOBLsaBl2
	lY=
X-Received: by 2002:a17:90b:5287:b0:398:9bd5:490d with SMTP id 98e67ed59e1d1-39d9c22e224mr156684a91.20.1789066993882;
        Thu, 10 Sep 2026 12:03:13 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.5.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a8a9sm88492eec.13.2026.09.10.12.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:03:13 -0700 (PDT)
Message-ID: <6aa2fef1.d2196d7d.c2a69.3a93@mx.google.com>
Date: Thu, 10 Sep 2026 12:03:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4070094800682023686=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thuth@redhat.com
Subject: RE: Bluetooth: SMP: Zeroize raw key data on the stack in smp_e()
In-Reply-To: <20260910123254.408963-1-thuth@redhat.com>
References: <20260910123254.408963-1-thuth@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4070094800682023686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1162047/

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
VerifyFixes                   PASS      11.59 seconds
VerifySignedoff               PASS      2.08 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      22.52 seconds
CheckAllWarning               PASS      24.90 seconds
CheckSparse                   PASS      28.37 seconds
BuildKernel32                 PASS      21.87 seconds
CheckKernelLLVM               PASS      24.38 seconds
TestRunnerSetup               PASS      563.96 seconds
TestRunner_smp-tester         PASS      11.97 seconds
IncrementalBuild              PASS      21.06 seconds



https://github.com/bluez/bluetooth-next/pull/749

---
Regards,
Linux Bluetooth


--===============4070094800682023686==--
