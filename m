Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAD266565
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787543585; cv=none; b=P2Ki4maQNiIo+aJwDNMNdVNZkz8PIyd07BcBMjgxwNrUWvVAOp8FVt5a/IJ7QMNu5RHo4rkaBebXyMOWIAco1W+TRCv5gXyEDfbfUAsXAfh2wb82FNjofV26MnJ/nkNgW1lDB9RnxPWhK0O7tVUal+tAz0394K17tEaALl9QKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787543585; c=relaxed/simple;
	bh=9krsA1n9GDmteucMDl9TGvhMggodOpPm/VqDDu/Vlhg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SRdzQdzqixy+6txzPW9BRuGrRAWk+Ac5q9HPR6Pf1PHcww4TPZ7/ntEMbrXOAUrtJCbQ28B6rD3aOm7cMXxhZ9XpfTENtTYZNYfHu+COpMrTfgIIIdAiGT1av2HpNhw2SI7m+4VcV8WmWmO/i21zpf+lCC4rDynWS2tTmw8xxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jio3negU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jio3negU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceb096e675so33880205ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 20:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787543583; x=1788148383; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LtoWoDGm808RXwLwdYAI89sjlwHveM3brZSeROv1MIk=;
        b=jio3negUiqvySuDd5/wQZytsgPiB8OdRNidG+U5aQuZmHOEVW56dFaQVq1QLy+LVZz
         W+VFZjzpEI75a6FF+p4CT8E6fDddpQh2IfJgrDbw4yDN1g5B3v1Cb8GVmvEiGcN+gQ33
         WQ6BMRzCHWBlJ6yVUzD6yzLB6m4Ru+kH657tyLybCbENqS5hBEFOhSOxTB0IwszOfUa2
         BS0eoG0cO+As9CxlK3Oy52FJU4lEdAs4QvEmiEu/BcM3flClnNDab5t5+P/+JS8Eo53u
         X4XPrdBJaUlBR/2RdXgxmnY3OXAeWxttHseq6AkTXZQOzviI7QIzGA7Blk2O2RZbZzyz
         zKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787543583; x=1788148383;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LtoWoDGm808RXwLwdYAI89sjlwHveM3brZSeROv1MIk=;
        b=ZWSfoiNBWyV23aflH+QQuIKc6PQQOcoG4BM/OphQkvBaRZC19VbubjipxpEfIrSNv1
         WXyRkykQkQepxup1CCroT0EbP4vMGhU8BxZ3NcUEspOP85zcVkOprgn+Qyp9g50oays8
         U7kjrJjTcEhopVO67pa2X+Jk/rmntVwX5BMnjcGF8hiNJrmiBWj9xnxFek9bmh8Kko9k
         KUmMc+Ni+oy45rgWKMRZNbCqUnm7Gvsw6TZj/+Jak70mPCdinFFX+dFwelyNKUTsq5pZ
         1wklCQFSBbGG9EoyfBYC6f9NYION3bd2xFLqt+rKHWk3mThifrMT3M+SVwk2Ksn1lJBd
         RgGA==
X-Gm-Message-State: AFuF++m1rnwBSOnnuPSL7xg1I8tNBXp5bxv/Qh9/k6dzZ7rLepr7izzg
	NRqD6SSsIunZWTuCSS4KYeQSM8rZTmIhGpOSzE5txG0uAdVwWf+63tMKdmkReg==
X-Gm-Gg: AR+sD13a6N9YvLtOaQYItOwqox8Td4Tq12ncBKac82WSnSwsTL14YR6a8GgDGLRln+k
	iWez7rSedcVSc4xqPnEqnkBdzvO+NaO7jn0FF3HNiy4cdwhhnScDcDh1cBu7i643G0EVu80cR71
	hbZdZIsJcU6MpbeRFFUAxzmDL/e0Vdrp5pWtEYBc2JCzLCWaFNqtbEm81CIvvKmFrFk/LLL1UNl
	FBQuRngzu9gSUBFoS7YhhNgqBsMzBjMpV98r6VnvLMFIHs9cqFhqsFKr5QQssxCYY8s4R2SDNe0
	ONkmUwOM5shPxjJVf2uCvgQCm38LAus2DWPE1qKJjeOV5ppfMAQBWPriWzDfaaXmEdPqdk9GNE2
	oebPD3eUS94z33SzeiQa7vtu4B35tOSC3ugup2QJIoU10sIN55ii9/wgi65TKBePKNj4K4mspzn
	DAYEx96nlBTdiJH7TKPHmGyd4DOnti4PbiWIZumT3eXMKZxpg16BXjMoaATgrtP6r79/2kafFwR
	qpuiQ==
X-Received: by 2002:a17:90b:3b48:b0:393:1cf4:d972 with SMTP id 98e67ed59e1d1-395dee55f7emr24400103a91.3.1787543583305;
        Sun, 23 Aug 2026 20:53:03 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.58.246])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183c0esm31932212c88.12.2026.08.23.20.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 20:53:02 -0700 (PDT)
Message-ID: <6a8bc01e.af6ba3ed.3be20f.02e7@mx.google.com>
Date: Sun, 23 Aug 2026 20:53:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6004332370401305790=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rudi@heitbaum.com
Subject: RE: Bluetooth: btsdio: Do not bind to non-removable BCM4359
In-Reply-To: <aous3PktDH5KVAZ5@0d3a7a881997>
References: <aous3PktDH5KVAZ5@0d3a7a881997>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6004332370401305790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150561

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      28.84 seconds
CheckAllWarning               PASS      31.46 seconds
CheckSparse                   PASS      30.01 seconds
BuildKernel32                 PASS      28.05 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      520.30 seconds
IncrementalBuild              PASS      26.41 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/640

---
Regards,
Linux Bluetooth


--===============6004332370401305790==--
