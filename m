Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55F413780
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620598; cv=none; b=VYq+nb6+4VBaP7zYNaOi/fUtXftIy64hKubCx7F1VvUwbhcpnGkUuAcx4T5l/ODj8z57A80if27gJRACe+FhgOuZaSSZ3xojoS5OILamB4z+0kb0hPc58nJrfggs6E7YR99/Kqi6qxKce9f78x3VSSEnjslKmgjnhhOX/x/hsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620598; c=relaxed/simple;
	bh=AOqTq4m86BsrlmBZyTkbEatIT3UnUPURS4YK8Jf9/ak=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IF3ECe7L8VSJIkZ8uAyPaQlL2EHgAjrVicLMFyJOVEfweEXfoa/IfliOACCd1ybjvW9jZwLAVw7NE1USm503da8a8agGjUzldRqQYG+KTTF/J09K/ZXXGVz4+CxInBCANtoTTiHFO2eXAdVfZS8+FBkZZjNYBuTPB6MaP6uwvmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nya6XiZK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nya6XiZK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so30204265ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 04:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786620593; x=1787225393; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DSs6xv3dCDrIJVvC+aXGJW33Zo4B9PGc9wOsEGoh/2M=;
        b=nya6XiZKXwkj6j4dhikBfBoR5sBkW/lbl9lCKVL1+edHTYCRd3n6HVwUj4bwku5GlO
         TIBoSl7ec9E/Cg1tmaiciLpt6UG+PSW247+voVFGMLvOZq8ecFT1f2yCnP+svcDxHonb
         hLun2MyfX3TPh/2b8vn2xpIx4VaR5NZPzPw9aejEBeCobKopm5WIxXGox7F/hFDKMfR4
         6ZbRLHcDn+IDu/1DVZcPC9bjG5ayUn2nbf5KdKq7plrT4J/rKBMccHufAlmSTfekKX7m
         4BL8qE57G83fb0qtykb1umXmGlda5bBaeD3spspCEqHdWcDbLOEsmLFepaLSkYhfbYS7
         ta5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786620593; x=1787225393;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DSs6xv3dCDrIJVvC+aXGJW33Zo4B9PGc9wOsEGoh/2M=;
        b=eBBFg8a9CqnXw+JLlBK93liX9m6vba9Gf5z3Fi2Zre4NcFfwBDnz1KTbj8ZGBnLQcp
         uhE0lK2HXoQbMHCTSWvsALdmSp650FGknaVgXf4/17lAeoOxDhi3ck+v2N8UP1ktlvZo
         2tnCGDuC8Acq2exAfCF9thp84iIx17SxbjhP9pQgLMrIoPO7YKwGXDhKCg1KbPxp5/A/
         5GkREnXVsLvxt9cxNxKK8vUzWM5r7rV4jgrmQsyoITh2Z6cW/v6WZ42cI3IaqMLCQdKR
         QzP7LXkYFHPCftMhYn85xDoMZXXqNIZiUVjpcFbA5gK+OxIOUyC7Xc+k0fvAeU6eL8za
         DPvg==
X-Gm-Message-State: AOJu0YzsZ7FTCobKuc5nYkXawVBeOqV1JaQ4WOLkz88JruItLjNQNYN1
	Me1SQLwGxZiOzkYV8pO8QExbIcjghop+eghkPCROym6FyAyqViy8d71QuMsf77ij
X-Gm-Gg: AR+sD10s6eJm+NTF4Jj3eMeFDMCTE9kI3O7rvc62TErNNtISqMw9d7ZiZR/HhcsiFYn
	nOfCBHKelP5dJK70CESCkfGooOeDXgRqtx2RUbsHVnqSK01uBSo3SlFS1Yd4WIf8+JCRbCfc48W
	oSlFXmpetrDwr4Yn54LAmQCNXoJEnVi8+5azbKjaqCrFm7SguVSR8Cz8NYa0nXAVhohFYZpF62A
	aArYVxovheESPCmpMYDsSjRbW/C4rZrCMceMT3zbn8d8hBtUrTjKMFQxrSOlmOovQJwX+XwIfyz
	Wxq78xCTtiS39kZbowiGlP4w+OhB+8sIEb49gf8CcQFlED+rp67T9D3L3I6GqdX852MvfH8o+Hm
	8P0yXw217BUbdHF4RdeMLVidQau+gVn3CW2nswdJ4nxnu+c8/ZLkizXusjIV82WNyF2A7J7fLkW
	uzEfYQdaqwdC8a7up8n10dsLp4Q/RGvEvuD/G+qkpc9xVIyV574Y3q3r74OJzz2cycL9Lzc+yoL
	3ww
X-Received: by 2002:a17:902:f64a:b0:2cf:84bb:1ebc with SMTP id d9443c01a7336-2d37e856fd9mr65109915ad.15.1786620593052;
        Thu, 13 Aug 2026 04:29:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.3.231.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c49ce11sm7822215ad.67.2026.08.13.04.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:29:52 -0700 (PDT)
Message-ID: <6a7daab0.014275a5.292b07.fcca@mx.google.com>
Date: Thu, 13 Aug 2026 04:29:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5933833467440952855=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaojinming@uniontech.com
Subject: RE: Bluetooth: btintel_pcie: Fix array bounds check bugs
In-Reply-To: <460316663D6D34ED+20260813103734.222955-1-zhaojinming@uniontech.com>
References: <460316663D6D34ED+20260813103734.222955-1-zhaojinming@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5933833467440952855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1145362

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.07 seconds
CheckAllWarning               PASS      30.27 seconds
CheckSparse                   PASS      28.26 seconds
BuildKernel32                 PASS      26.37 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      499.32 seconds
IncrementalBuild              PASS      26.11 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/576

---
Regards,
Linux Bluetooth


--===============5933833467440952855==--
