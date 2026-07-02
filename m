Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2932A3D7
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018134; cv=none; b=EfVi8e+RJZGhE2/Fv8upqP0OG/QET8fwChKbyKhYFfbvVK0jnRlcjzYDAVGywiQgz8jEucsAV6MAVCUoN8+f2LO66P9BJj2nSf+0OZ+ie0Udbhe5dORGxpOWFY0PHWgEz89yJLjpBG8g+lGxuySot/2cpHikYQuaQJUDN/RN980=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018134; c=relaxed/simple;
	bh=JdjnX1uEKJ2YauMVXZwqJeGbhXR4h/KbvCNkTJwWSQA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ATBOCmisMlEGeMZXvZcsS0+ZGBpETFoWVUMcIgGdhqfDyXeyrgHEB8XDmtCTMlQeFNSxf/oHU9R+L6aXQcgWHTE4dp8eLt8WI5sN5TDA5zBMo4b21B6JgRqx6X935GpsMstos+54kjuXy5cqYd7MYczs4mBMqufje4Hcn3haquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/rp/pNM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/rp/pNM"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c88cc025f54so1428640a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 11:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783018133; x=1783622933; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Qh5dEYxLHE8+JG36x7lx341HNgaKIsd6H9UMAv3DP0=;
        b=E/rp/pNMc8UuB68LpZUf6F4r7SuLvdMDw7d9Pc/fbpM/Pj8W8Bo3/jmkmkf9jfO6mH
         ehg51dATedaRvBYazGjUUbe5CpHVrRPV4PF6VJSf/vlUglVniFrALZuqsMbimRn8nkQR
         zbr+ZGrS9ElR0VKLQSe7er5bt/KW90GAw1Bn2oYHyd3d119aZ/ALXyFLoeOt3NTej1Wo
         0gWsBZmK+6Eh18pKORc1L9KOBUCMlQKIISSiRkUlP8hfXWXqDumni9XvpBoESOCbnPl+
         fZjYSdhZ6NnrZQXcsf8rRTsxwV7Webb4pwJZLLa08w21PHfnKw0a/ADo9yMV0OfjXvLf
         w/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783018133; x=1783622933;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Qh5dEYxLHE8+JG36x7lx341HNgaKIsd6H9UMAv3DP0=;
        b=VjTng7pvRTxvk8ZPw3/486X0wwY5aS5M8CoaYFSf1qceJasGnL2NG+Y5RuiIdPdFKZ
         fEBHf7Oj83ShDepPCJUAIDELbu3ZpXyjwQ9I12NU0GS4xnylPas7VTMTjocET7OzANbi
         9dXkscu30OX5LU8Vwa85O9F2S4uTGUrRZ1xSX87UteMF6+M5TIy1MW1lZRAbTLOSsS9G
         MuPtTb9v9Ft05siDabD6vLz7Id10thulKVEB7k40qApBsOfs2GuaUvGyZ77AXV28iGQ7
         vzptzpmInxkkPI99Sx2aCgQIBVNlPCtsFXavzhIfrXRAetHvBZKXrQGBSkohB3J7e/Wi
         Vj1A==
X-Gm-Message-State: AOJu0YzhGx2H54FJ1eP8Gh6fxYEMwq0KhZahwovjadYFBo6QMgPPOTce
	10xbF7xZZSPue2hvCx5pY/RMgpQZVwR4UXHEWlQkZMdF+7q8M5Jkm5cPw/UY3Q==
X-Gm-Gg: AfdE7ckmPH3680tuABGFFCmKguFcLxiipB10yBd/JBOqYPeNsTpF6fStj9fk3Or+AOK
	qWicu51jA4NpQBpalrV2X4h9EqhOcmCkRUbv4vwcQWV0OOw6kPqjF9o6PhrXlcjCWUYlcXraZBC
	e/leQVk7FebVGQUlowXdhwRMtvg2r1kPxYAqdSPAklAyIdfEgxHPQU29UkjSWUYkaVIMte/vqZT
	EiI/NI9Q881A/bIQYRj6Hz/QCN6FVPdRFsU57cnCoco2Wd+ZARKdXco/oIAN3DZb/MhD87JUz9w
	l/I1dkUXbR9EroNnCB21/VACyIL9Nj3YwIm1KJaAoyUPZpfC1joEyAvd42FKFqp0Xd2NGTdqzBj
	4mt2ldNVQOq9uGxTrI17PpnAR6qRlivINosbV2/mtxVwqCxdln8pX758MP6c+XUW6CcLQKxawXG
	28Fz9IT8TJg8s8s16AW//ycfJUeVEhBA==
X-Received: by 2002:a05:6a21:9d84:b0:3aa:c93b:625b with SMTP id adf61e73a8af0-3bfed1bf82amr7954380637.3.1783018132659;
        Thu, 02 Jul 2026 11:48:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.178.97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3ececfe4sm11160146c88.8.2026.07.02.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 11:48:52 -0700 (PDT)
Message-ID: <6a46b294.30759430.1908d3.fc40@mx.google.com>
Date: Thu, 02 Jul 2026 11:48:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5536632929897270120=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: split coredump worker into per-trigger works
In-Reply-To: <20260702170359.26233-1-kiran.k@intel.com>
References: <20260702170359.26233-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5536632929897270120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120618

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      20.77 seconds
CheckAllWarning               PASS      22.84 seconds
CheckSparse                   PASS      22.37 seconds
BuildKernel32                 PASS      20.13 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      362.20 seconds
IncrementalBuild              PASS      19.90 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/386

---
Regards,
Linux Bluetooth


--===============5536632929897270120==--
