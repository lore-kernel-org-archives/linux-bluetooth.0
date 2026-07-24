Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA53AD518
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925256; cv=none; b=NS5w9aO2wYP0ViwAimEx4RRjiRtxszkC9pSkyWypFV31bk7oxDf/D6s8N8MQt6Ei6DR3f7nooxWz+Z02WfC/gJUe3WoIbPxlvqJbjczziv2Yqe/K2ng6pnRWxavkHZw+kXV/MlAALrC+uY9NZ/sN88ShUNBm4440tLH5kPjNYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925256; c=relaxed/simple;
	bh=LGb/2KJ19iJ0Zs5kIEW67Orbbq0QHe/RhnPMaMmtWmo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o3TgOqq+hZGXDV8muNzsbAudhekkA619D1E8eDcuNaOZrlYPXp+AQ5j2cIUsWULK9xiw4Un0PZVCqj0hLJxnvQfbZUFmPRoqGY53lmpQOh4iL7CU05jKg298i55FlcOYExyPuwR1bLUtgtX+7z11WhKHqf++x44zNwn4wWb6l+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJQBZJkt; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJQBZJkt"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e533aacf2so46643685a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 13:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784925254; x=1785530054; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kHndIylK2+dhU38kDBnaEW6EujvgEUrjMd5ZUnp4sFU=;
        b=KJQBZJktaJnAR6DpVSLTQVtiDXnL+2dVkUzyQYxPIH4U2avxIhLABpX38f+l5tjxQ/
         ErK3kTlrTwSwuIw7+00iw/NkTnXmizrZW/VKyrkY0kSmMykRWh3aaTFMpRaRU7tpX+YK
         1bpyCmP67or0GeWEDoPw2hucR295DcMTq2LHCz6f7T8dP+ciYU5EyA7OpTPbt3SMb5yJ
         R6Mx25BbaMGc11v5B3AVXNVtk/3MQ9MuZxOCSNfny4xK+p0FNachm83aFxdeNd4NrCaA
         FackAlx0TzACNO5Z3kbf9jw1yh+GvLYrrtagErj6pwr9SegJYEuxjlpPRfxU2f7vQmdy
         267A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784925254; x=1785530054;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kHndIylK2+dhU38kDBnaEW6EujvgEUrjMd5ZUnp4sFU=;
        b=TN+uaD8TjstKXxrFE1tMg10GmGExmF7Wa3fLstScKdseIEONRgWkPY5Cq/E1TRFp3Z
         giCTOH6qQDTshxBR7v+ZpVpPU/azMPowlepfcbVpUp12WUNBXr+k0LwcdSvIsgnwo3B8
         VdhjFSOtW8G06p+2iB0u+UZtxMf245l05YmFV9qFqyIR7Y0lYeVEy4qnndb3PqP3DKUg
         tnL7X5XsUa5vb8zuatDAXVJguXglxXvpQDieczrsT8tAfz4WSXiPNA0scY9l5RBacRca
         vwYHRMcfb/nKBotLps7CY8p+IxrUSMoLicySeIX9HDTxswPhTG9qRVPnjxUo7Sc7waFE
         GUBw==
X-Gm-Message-State: AOJu0YybQUxUVOIwsesoIe6BkfVeMbr1lM41iBCIoRiQ7jErkucVnsNK
	NSS5rw91vgAO/n51KwUZmmDcbmxsknIIJ6EwWcotFfOqrJmygDLtRMGfs8nR0Q==
X-Gm-Gg: AR+sD11oQIgeLVQFGOZw+JgcV9t23A1XmfqTX/dUZUpcVxI8sIXnGnhr3YjH7zxLS3X
	ZpF2haXzxnSGY83sUAuHVDHx+5BXM4MvSyinBhF1lec3xRYLsyRWUfqhv2O+nqriPP/DEc+nUvj
	Wj2tolxrYQoBL/SYmg9rCG6TohTWHJ8Bbjm0OA18z6NyvOnWUbTZWeUGn1+27wpgYsoj+OlTTek
	0d3XVkBeptpbjbymDU5ZD5RwfWZT0+ItgFJpCd/OwybDxVCQg4NHshFCUKuMuV4XCus4YCh7rWO
	EauHga2uHSiaIpLWn8TdSWAqoYe1qIqNzYlLkR1HeK7MD94qBJFtJ6CqcQMqOL7Z5aJAu7nCBr6
	0i0V6VX3cqYj3qTebuyF33y3sxLxBeFvQjuKwCFJhwbIjIaismUj1xPO3mh5zlzTxm0Nfdc9xPc
	9O46WYLaBvnwM=
X-Received: by 2002:a05:620a:390a:b0:932:dd83:c54 with SMTP id af79cd13be357-932dd8335a8mr50225785a.42.1784925253680;
        Fri, 24 Jul 2026 13:34:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.157.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de63500csm514985a.24.2026.07.24.13.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:34:13 -0700 (PDT)
Message-ID: <6a63cc45.4567b959.13b688.1253@mx.google.com>
Date: Fri, 24 Jul 2026 13:34:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7501658998200395212=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v4] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs for PLDR
In-Reply-To: <20260722012158.813793-1-chandrashekar.devegowda@intel.com>
References: <20260722012158.813793-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7501658998200395212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1132022

---Test result---

Test Summary:
CheckPatch                    PASS      4.22 seconds
VerifyFixes                   PASS      1.11 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.88 seconds
CheckAllWarning               PASS      28.01 seconds
CheckSparse                   PASS      26.80 seconds
BuildKernel32                 PASS      24.78 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      463.60 seconds
IncrementalBuild              PASS      36.99 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/489

---
Regards,
Linux Bluetooth


--===============7501658998200395212==--
