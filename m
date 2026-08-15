Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5C140BCB7
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786797409; cv=none; b=JJDNVBVbOrOvy4mrLDm6aPKnNN8Bf8SXPQA4Ju7uWTfAsZo56tzQmmj2nXQ/07Cnshg12jhvH5DhjF3HDcU305RMtcgqD89oUklg74vYFYUxUQVgMyfqifUfrLpk+a/skrUSnQzPFE509DxYzxvEKiq801/TFTVoK4Rx3J3/F4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786797409; c=relaxed/simple;
	bh=WFgingOmUYInvcpmBEWbPkt+t6ywLqYfGyyr91SdfP8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I/Ua0Ledz2bnIO7a289PdPE0hf07/fZzqHDfjHhckAa9fceR/1KDlLifAY1Mi1tbg/w7aoSbEiyZaQQVA8fk6ROd8/KMYfxl52TO8V5fLnico5b9kzi4/G/wKnxKmRwtqiHtWve5OmciVaXUlnYoOagcxxAosvGPbmQJXLkW/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjzTdmo5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjzTdmo5"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab973140bso30687585ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 05:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786797406; x=1787402206; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K+Yy/GN/6idXtxLmUU6Hewr8hxqIok8MeoklaWfa/5Q=;
        b=gjzTdmo5z/qfrPLQoV/R1kXSXLInZQWSaSwPRfEu0R01FpS3DRVpBI8zyYACV0NAnN
         etbWf7tM9oaZbW2atk9oOsuDf13vuFoXGJ5n0mDtpaKAXPJw1YMCnBq+87TN7smfzTvG
         /6dbRWtBa1286ZWckXJuN7Ffm9WRERQz5niv8/YBu4k0G8AMDESjIRvmXo0uwZjWhcDl
         WG3NMO2XNIKTHOe2pnY3kdHKFXmk6+EdIWITqHxx2SXXAnJy+pApSusNYhylTfRSpiEM
         bsxk8slsJ+9MvjOSG5ixAC5a3vteOv1SeYJV1hKGQMx3Prle9ltc8QZ4ze9/aNiG4yYS
         llpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786797406; x=1787402206;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K+Yy/GN/6idXtxLmUU6Hewr8hxqIok8MeoklaWfa/5Q=;
        b=KxKbpHs1hDtzUlrhuFnS6TtVkM9o0g6xMi35p7kicLQsyfDmmB6lTHLIUxMn2+35ng
         6eEtaWp+WMrrymDqTWxfPxi0loz5SSrG9koNsD4kdPysgX91J5mm5mcohbFnS4R66QT/
         N5tfBe7ayC5mUyCrPNYtS5ek8lDFe/BZ4hB8spNWV03M6p2umWk/J4K1faiaHXaLfhRg
         kWZQjfqMQFjvswmB8ncRL7Ev/dFOhoApazRnwrW/oQo3IVwyTNaz5FYZrc0X/Ck3N2fM
         Qapa/9VomFcBiydLVHjdl/wqIp2ERzfYYSNa9s6bp7KzuTVzXWHEJEtqoF5SoTS3+iZh
         c4XQ==
X-Gm-Message-State: AOJu0YzKS54ewwmWRBg6ohr0FgniA+utAC9317MYTHOJ2zj8rxQzIWc3
	/LlWiFVyzPUJA4NA9F0rjB37d62WeM9mTaIrgFtGevry+elZvs0sWqR7VJWmsA==
X-Gm-Gg: AR+sD13BhFqNEICysKWg+TlIIlLx039vFMIDNHG77nUti7FK10H7FJt5d3212pX1bLL
	LbfpzbIMNp96wR0dRJqx0HusShL3EB8PJe0cCfkJfMxvEdpuPKe6kDvWzCi7e3mkmKL87dLweXY
	SXupifhO9z/sP6O9pOe8wwlxXuKOGBe7zlCny6oFgTlURvSd0mCPW0/YMWXukAn5kCJdX8aQY/n
	07LREuaK2ug28PXI1w1sI2s845uJLDAwSv3+JfsQg4JupL1qPhrzsCnl7jF3YXTBkQnl9TKuDrH
	LkTlWMsVAzga7ehvgc/fJgFDWHaEWhO+wdORDkIgTphdOrQMaYFbGHlYxYWxBqfmlkJTdE+kiEk
	h51wzIwhfDvgWYIktqY2MY3FX1yG15Y0ufvm1kxJlKhKCEWTXAGyWKgLj4kLsd8Rt+OXgSI5HQ2
	nv0wvY8Eq5JAzIRb0tBsVmMTxBZNTm3bONlQ/LFzEKkccaCXoifxps6oY7uoMyEPyU/vdQeTyKK
	kQIKg==
X-Received: by 2002:a05:6a20:938c:b0:3c3:8c91:5da0 with SMTP id adf61e73a8af0-3cc71c09a2dmr14685095637.15.1786797406314;
        Sat, 15 Aug 2026 05:36:46 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.61.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df68ccsm15812216eec.14.2026.08.15.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 05:36:45 -0700 (PDT)
Message-ID: <6a805d5d.871e6cae.1644c3.3f9c@mx.google.com>
Date: Sat, 15 Aug 2026 05:36:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7828044927067632891=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ismailtarim7@gmail.com
Subject: RE: Bluetooth: btmtk: fix subsystem reset error reporting
In-Reply-To: <20260815115624.8309-2-ismailtarim7@gmail.com>
References: <20260815115624.8309-2-ismailtarim7@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7828044927067632891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146494

---Test result---

Test Summary:
CheckPatch                    PASS      1.12 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      27.42 seconds
CheckAllWarning               PASS      30.15 seconds
CheckSparse                   PASS      28.90 seconds
BuildKernel32                 PASS      26.56 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.09 seconds
IncrementalBuild              PASS      27.86 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/590

---
Regards,
Linux Bluetooth


--===============7828044927067632891==--
