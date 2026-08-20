Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254842FE05C
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250644; cv=none; b=W6ermZoe1CbdpWc1DM55vuNWitLsdO3L/nKMTQU9aydoynvdhpGkkOY8sBuUQIdDCrKXcFdfC3HY7GVf5V3l+y8vtIzx0BkfhXfzVLCbgxgWQdjiVi7X3RbMCbsIF5nxxIA2DRFy93b5HGoygpwdFhB4bwlxUw16BEkq/mGZd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250644; c=relaxed/simple;
	bh=I2Y65jqsu91EHVwNCSoCfUO6EF5d8DX2gCvxwMnxHE4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gR5+h9J2TjyRcV2vi5kF9mFEAWfOM+Ko0WLjmrWfC7+K5DJWsg5h9zEkV18HkyiS/BzLkjLhKHOWzpXdokV722KbaPQo5zDrVJqXXMB3BQyOGyXCUREovvdx+v6z3J2YcRE3hG8rHn/P0J+b9kiu+mEtJh1DSR7zlXeb23ksgXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xrjj7aOk; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xrjj7aOk"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso138174a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787250642; x=1787855442; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0Je81l3P/GVVp4vHSDU0QwadLSF2v26AUtzOsjJQ80Y=;
        b=Xrjj7aOkdLRTXHp1IZrckWPce1N6bU64FUl+zx8pNfjUWCOmVshNHju2jX+9/5Tiyo
         PXVflmZ+X1/HQFnOEKaXk4drFja0wcyQRFFq/Geoi4+yIqfkqbwOojQjRNdT4Ovii8rb
         KVfAKyFyv2vyWju774gItnNZg6odkKCRjIbD8h9JUewX28PlOL3TZdiK2T5KZcp+kj+F
         JwX/FCx/9iKhmE4TZgVPJlcAYTsHycIplcNjTOT6hktjiy0V1Zxi/wqW80dkd0tPCFRf
         NwTJWgbw3Sr54AAbCIVUDAs5kgRmHkFJSSQPN5zrYTlAF0W9BBXMFZCJSENQpKwWqaVF
         4N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787250642; x=1787855442;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Je81l3P/GVVp4vHSDU0QwadLSF2v26AUtzOsjJQ80Y=;
        b=q/lCv6vo+CgpKSWTdTdNldOjTKNk0M7kr6O2H847F7Tf2owUwZLDRGAqQXPupMFl5W
         /2OziV4D6wc2+IQTdhR4XDrItPJmiB4ZwIVUlADWj6CinK6Y6WQrcB/yANfBng1CRrU1
         mwW8/AhkIl9GnO9gAgCvq043h1fm/g2WoQOhnY6qPYzljoC5uPm4938JO5JMrBfEuIGl
         xiSGeove7bBETiULyu15vzJwKUo4rRwZIA8AFRjdm580QQGZ5GwHL/4jUUHC9WzfFsKI
         yPwXtk1dPcta7b1CR6THGyAccgT8RdGiBBQJpO8NFf2DQN3iHgFIXHAqALH6z1UYiYbn
         8BhQ==
X-Gm-Message-State: AFuF++mzofRrIwYxwPnwABwCasHD93mPZ/pqL5/UQymLZkR9dn8Doylb
	pGBTMGvz5VG2euVLure6YfRw3mTx2DacWKLokR8O5u9Ou7E1Fu+fKpWkf/iqTbK+
X-Gm-Gg: AR+sD102X1df13XAaB5vDojFCpQ3hhcsGOmpvt0RpD8yIKk9NeMo+06FZQff9Cs2dvb
	JIf+2EyCJkCu/8WNXxk1Z46dnbRZD60hu5Mu6+Ldm81UTB8PCro1UWIB63MSr7CaOnIouk/pWn1
	SPvO8qjE+lGXEz5zysQqKuVPqgTV7UY6/fk9Yc6NrO5DXZD/64lSpnvsi8wZJInbxMWlj02Om5t
	ZnZu9ewUefFaVkvEEHYCwgyPzNPqeDg50OnLCv6Ouik3aMLC5qhIl+TzV3k3aS1Jdyv8jMBIqb+
	Bt+IYiDwbI8JdJAtZmljjcBdVoLO+Iyx07qtYtu/Ypk4YpwyYSJvV/ZAyTS5XXHHo1mi5gCKA8p
	w4BRjLmd9x/FM7gmHBDn2upFhJ2FMbeDeSqJjwXZ1StcX37rPOpLnZQIxnCs5hxnntBlEejyyp+
	2iRPY/0Z3K56p5iwq9NUG9FT7URVqdWgibbGiQDN4w4L5tZJ9Wr8Dy5i37Y1MSH8lkc5I=
X-Received: by 2002:a17:90a:c88b:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-395c2f4b17emr1215570a91.0.1787250641979;
        Thu, 20 Aug 2026 11:30:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.47.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf1a1de1sm19751083eec.31.2026.08.20.11.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:30:41 -0700 (PDT)
Message-ID: <6a8747d1.633cb3bb.39123d.63d1@mx.google.com>
Date: Thu, 20 Aug 2026 11:30:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3023500644643788330=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alishmery18@gmail.com
Subject: RE: Bluetooth: SCO: avoid deadlock in sco_conn_free()
In-Reply-To: <20260820174633.1570398-1-alishmery18@gmail.com>
References: <20260820174633.1570398-1-alishmery18@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3023500644643788330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149255

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.72 seconds
CheckAllWarning               PASS      30.45 seconds
CheckSparse                   PASS      28.92 seconds
BuildKernel32                 PASS      26.52 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      510.39 seconds
TestRunner_sco-tester         PASS      34.57 seconds
IncrementalBuild              PASS      26.14 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/625

---
Regards,
Linux Bluetooth


--===============3023500644643788330==--
