Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2853CA7C
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922312; cv=none; b=iDy2tHqzAwXsQVfGhxYRf0xYbsmRH4CauwyLEM1gp/V+ZfMf6zPK2LJswBdgfhlLnZyGwTJewTPj497vVoI4pLPMBvNMhwa7hNoxVlRc3Y2Pv3dplwjlZ8yj1glN4Go+s6gMloqS2s9VELE8IIULtY1xej5A+Xl3W2rT6idQ36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922312; c=relaxed/simple;
	bh=mcU/Dk1+rhFVmx4ligIPNnS8IcG98k0jVT8qaxu9tQY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=P6B8T4Au+fzleH6QqcPOQbVSTiG9bHsNVuJeXI+2FIKrRHWvtcDSSNpyiDX2Dbv7czwWlrBV4w5MdPJDwAXhom+2evAyVs/gduPK9+CcsGTTsInJ52y5Sz9lyyM6Tz9okpdZxK01/dluJWKmPo8muI6ljd6pTnWbVXa6nBClUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rM9if+RK; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rM9if+RK"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6aa9606ddadso237905eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922310; x=1792527110; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fuEd/s7jLuccVB3JEanUWn5VkiFZoVDCIlXs2Jbc2j8=;
        b=rM9if+RK32lIVswOoakRfAEQarjPJV4WL/j/9Z4O8uUTgHmQPUGPAIWq+CHVJOblg1
         lRJrvQm5KXEuFv3DFyr5WkicufHgeX0tHGkfz+fwi7FgE4XHQrpub5pLMDTPKGmgOan/
         WsU1MSXMP5/XCIdnzZADj0ryyh5lz3ZQu3kiwS3Qx56kJL0IUWvumMPa0S4IQihwRkPn
         gwa3rHaOKfAWOVxFQBVCPDJZQg2k/v0Dy+QEQVeoy93xtVQ/f1C6LEUQ7fjBSw6HRgMF
         eb+Yb0Sa/C8nPMzamEtBS4BzeKQ0yNg6UoSaOOWLakf6KXmoP1mX7tBxx9kDAPydPgNY
         BKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922310; x=1792527110;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fuEd/s7jLuccVB3JEanUWn5VkiFZoVDCIlXs2Jbc2j8=;
        b=WT/x96dNhVDyTGRSLbwuYGDtmCWCCsMCWqjuolShOZ5rN7qq4/15Ax+H/h6oBzsG9B
         pml8YWuNfYn5ABIzFKJd9OUcZamzQhqXQxEcnCAO7jxDMtOztDbIdFK8dPhnfVGKS3rZ
         X89sgIWQklvg775JUawyrmQa3I7aIKVsRS5o0eNxY9T9lHGYqKaaT9OAXoneFCWvae73
         wKVeeZfgfUApZvQ3eP035V8IxWE/pCmqi1qMmWh1rdfWR7mDprLa4f2JRdcKJeNzkppi
         xiEcAzgXQi3MAw4pVsBe3qqHiOmIkdLnjcGdvMtsG71/zZsQnCIVHuO2vKYr7eStjwUB
         y5Kw==
X-Gm-Message-State: AFq9FYISJTs0QDKnm9ChQTtufqvgUIHoMOg2R1YWOV9dqQEq2LyaRsFn
	fzQUSGQS8J0v+cRIam9wXFOGlxOgQnEdAO/TuVNJNFERuRGZ6BjNbtVh5VetuA==
X-Gm-Gg: AYBFou14ueIncrDlLejeAbZGZ+t23IlhPTzJ1QwZD7wYzdcJRUItEg9LBfFs1dnd2JZ
	o4jKJ5K47Y++5PyOYPwgjTUoyM/txVchS2t/lhsNcStIGqAygKHrmNEJWBj/OZKC9K+lE9crP2a
	bI0+kVyeskE5bhUOW9BiHDTa/NYJ2lXJyGZ0LQhxvv4X5kYHx1UvIWqINOpzWR73W+yJxw8QcuL
	CoAVrznY6I6b3lKxKDD4XWQrZevqmDBXei3r+AErEiVE46MCLJ7dhYoY+3pFUnn0fRjWGreWowZ
	MLrmdwzq9RfYTadXew3SZyUuZ9S99ZnEtaLKwFB5oZfBaWN3NJXs+/DU/YFRW3iTDmirUPi3nXY
	eu1nXDZZxnRw9VU7TAZizhUwU30SQz1ytlOcTfb7FDrI3uDm3Fso+jKfALXP5T09nTNMLhlyY+R
	0w7pD8vA1NmrOIPDrMnZiuOrStsxGp1HiwiToGKbre0hVYzL6vQKFikY6KnDui4SymlU+/KPBxE
	KjDSK8=
X-Received: by 2002:a05:6820:99a:b0:6d8:1b5b:3a74 with SMTP id 006d021491bc7-6ef08c7872amr10275176eaf.8.1791922309733;
        Tue, 13 Oct 2026 13:11:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.156.84])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef02d91a5asm12664757eaf.14.2026.10.13.13.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:11:49 -0700 (PDT)
Message-ID: <6ace9085.2feceb42.302f53.7508@mx.google.com>
Date: Tue, 13 Oct 2026 13:11:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7458202141631663981=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, an.wu@canonical.com
Subject: RE: [v2] Bluetooth: btintel_pcie: guard debug dump before hdev setup
In-Reply-To: <20261013125241.1230408-1-an.wu@canonical.com>
References: <20261013125241.1230408-1-an.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7458202141631663981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184736/

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      9.95 seconds
SubjectPrefix                 PASS      0.42 seconds
BuildKernel                   PASS      21.81 seconds
CheckAllWarning               PASS      24.94 seconds
CheckSparse                   PASS      27.26 seconds
BuildKernel32                 PASS      21.94 seconds
CheckKernelLLVM               PASS      24.39 seconds
TestRunnerSetup               PASS      509.29 seconds
IncrementalBuild              PASS      22.73 seconds



https://github.com/bluez/bluetooth-next/pull/917

---
Regards,
Linux Bluetooth


--===============7458202141631663981==--
