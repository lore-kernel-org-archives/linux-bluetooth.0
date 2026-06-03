Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7693E5EFB
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508302; cv=none; b=H7Ld3jIJf3u3FBy/KFiYltVK0vZWlqAlqXx+uV2wRylA38bHPPkGIt2+54SRldbUu7TwlyKMHmino9rKo1ulXKp0YzYBtaPUBU1RWKQNA5SspXieIr1NI+F7nvdVdeZucodoYBrbI8TyQ6r1DO1eHrthUHTOJaL4Zhmw/ixah8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508302; c=relaxed/simple;
	bh=8obXzPvx6AQNJueeKjkksnU/xfioRyb9Dj83DG+/h2s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R/NzLvtLQBJjWZYZLd029oramXNfiucUWeT8SXveBJPtdEjur+WtqmXfriVt99t6onsnHlfWcf4/hjJNzBAh3W/PnpaDaUNpLpSF0sAigLk9kFsS5LeJ1xconq2h/mjrjzPsB8h/Psp5Sh56aEjZW64AevZaEbfwZ4IQUMvzOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bibiFEZR; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bibiFEZR"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137dd51129bso110729c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780508301; x=1781113101; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G4C3RFIKvmCBzKDDm4pwpUFQp0SZPE5QC2AXLF1HjMs=;
        b=bibiFEZRUclEn1V0twUTLiPesTHCFPhtRoFuzuUMzr5t10gO4EM5Sg/wBPv6QV6bmw
         OgV4lS5oipdOrtCplwRmCo3w1X1A4rElfpJFNXK8AWOVFZWGqLBAnKuQlt6LT7wQWoxe
         jp88onFt/MvEGWi68/pslQwd8e0W4aegGSurokBmE56N3oqW5W59alHgV/6toSDcUYGA
         QocpXnjYGtprIXGrOjxR9aRY0OeHFf7+SUgnWP/w0gmLOQ4S4Tm/jBzbxts5tL0E2YgN
         jNFU46MbAMCmsMfd6K6nQf8EGAcRBG4cqSRMFW1RJcd7kFK9l3CPEil6N7eoaoo3251S
         IG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780508301; x=1781113101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4C3RFIKvmCBzKDDm4pwpUFQp0SZPE5QC2AXLF1HjMs=;
        b=Zpc47pPfyNFEt5AxgTmw6FCvsBrm7GuK2qRKi5Tnh1RhXqqGutrYKoCjz4BBE6IZTT
         YrWoZMD7b9ScvDHCSa37NJtgj+HVs7LVHUkkLgLY93gcvhwaYJ98WXlybY1ageu5brsh
         jhvr1VMSTXrQJ6SBUYCwlrZ4xlo3oAqkyfYEeTLlSLR93/+22hSgkqoj3h9CrNcdf+R6
         qG7Ag8f39Et0sKNu1GbosWPPNbfdNUe6nI/mt8zAZILZka83DQBYj7enJWkMWArRRA5I
         nn0gkYosrOJPCf01O54vFwBlQYF9BLUtj8OO7uoWLEUY5xfsOwiAupjk7YWvFGF8mY6L
         GFdQ==
X-Gm-Message-State: AOJu0Yz2FxdxU6cN/yRl86FNAZSYWvui5lIYn63PJqhhp/p+AvA4x+rx
	x1Bn+X2HEtItHop16AL5yasiwVzChlOutpOtGv5kJTX07UHXbCFyznGkhLlbEQ==
X-Gm-Gg: Acq92OHFplYrRnEFz/iIF6GO7lSqrqHsgq92154VZMsTcVbeqQY/MXbqT7fzhSEmdzs
	uGP7rjcDK/xByNuI04c4yL9m8EJGEB3YrKnwCu4KNqPE4sKIkvgzbdJEisuogoeUs0SgAbJAbYE
	6jZovSHtVZ/HthiHSrYRUQAVXDKK/mdyxMb4SWs/sjVnh16P2dBIRi+VWVFffCemEWDHGUVcSI0
	nuiITod+7wiMYWnYp/BOaOw4Y7aAEDqtFa+EPt8AVwZ0q63Z+StYRf98EKh0dN8aDkxOjJksLo4
	+Ont9LiU/ipMg7HI/AG51WP5dMFWUJysIk7FkuDFtfDbtfOXMYp8yCw3s5H+fIpFAIsRTgACrYK
	ExHnmFmri4sC3xKpXuk1CMU3fzRt098OjhLxh/AbuEepCCSyPpXdTLiUe9pLjzNdEKWcuon+WjB
	723V1U0PXJGG0/qUDVNiC74Lo9Rr/rREEgjIAraVoc
X-Received: by 2002:a05:693c:300a:b0:304:d4c0:82ea with SMTP id 5a478bee46e88-3074fb81f39mr2267342eec.21.1780508300813;
        Wed, 03 Jun 2026 10:38:20 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.56.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074deaab1asm2664374eec.17.2026.06.03.10.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:38:20 -0700 (PDT)
Message-ID: <6a20668c.d08db960.1426c9.4acf@mx.google.com>
Date: Wed, 03 Jun 2026 10:38:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2162395587051003177=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Add support for smart trigger dump
In-Reply-To: <20260603155415.50855-1-kiran.k@intel.com>
References: <20260603155415.50855-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2162395587051003177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105419

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.70 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.31 seconds
CheckAllWarning               PASS      29.14 seconds
CheckSparse                   PASS      27.48 seconds
BuildKernel32                 PASS      25.47 seconds
TestRunnerSetup               PASS      569.85 seconds
IncrementalBuild              PASS      25.57 seconds



https://github.com/bluez/bluetooth-next/pull/284

---
Regards,
Linux Bluetooth


--===============2162395587051003177==--
