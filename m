Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8037416D0F
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681817; cv=none; b=dqpNEtX5EYUysVOcDzHDLi25GEXtiliOWXPjzWh8rZueimELnKgy6DwvL5HY5dYp4ekIF+rSVl2DZx1j1OBJ4qbmL2mdeM9uzmTi5Rf7v51iLGxcs3v3KQrXSSYmnIOwD/sQwz139VwyGYzZgO8hdDemGJ4wWi0NSPIuF3oXtBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681817; c=relaxed/simple;
	bh=gizZMMGFFC5g17BPSbiKytvHEZeHG7BOuR5i68U8/oQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ECoV6LL0NdT3Pkt+Hqo/Kh/tEjdksGocnq60fRJWBDcGmWnjJwEN9N/ajN7YNEE3sa1DLhhtrLEYDPNu5JjSdHnw71hwxYskcBGh4kM9wIuDQiSh7WMXtQRVVDT9rA/jhSlEEbkAAMMKYXtUzfhX7wLVYZ4+s+xG6stKuj3yN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0xWZlZ4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0xWZlZ4"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3811f512167so1061051a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 04:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783681815; x=1784286615; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qt1cG7ArKd8DP/20TvoLn4XWC3gsMOc9Mib/GRdMLt0=;
        b=B0xWZlZ48OaIzAQvs+HE6HaQL6YGOOY/7fRHl4HQBvNatkmPa6bJfDoepJw3QILEvN
         SVVXkSzAFW3HotHSmaWai+56h5SCaF+xgyPh9mAoXkH69iGq3V2mENDYWQ6ItyHGO575
         eQyC6xdJ3mkzibRCfr1XxNUOzsd+XaD8PToYjoPhYgbEisCsKh/s9GXVRJTHvSROlcLI
         dZBfq86qpp1AgifB6biTaAnOtDgfbMljOQqM3eWlr/Cs2lf8i8Gq3tAXOz1Y9UIH8b3R
         leKCsx94wtPUexAjB4Wu7BcJbm89X6pzHPB5w68WbUXnf+6nz0P95qYc2FGb6/1Ug+6Y
         148A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783681815; x=1784286615;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qt1cG7ArKd8DP/20TvoLn4XWC3gsMOc9Mib/GRdMLt0=;
        b=Tejx+Q72CKKx1obuBNgsSFoUUk3WskjCoIL4yRSGBH3QDxxoh07FknLq7zdAtthLsu
         EkEbOMcP46LdVrKk5QZV1XZq/VbhpJ+K/jCe2DRqgCvEZOCVULc0wUNyL7rJdK9KhVV8
         Aw/jN6vA0Hngtl/7AgQpHF1nFEmyPNiEi1mQZvhjGtilT81rLcJEVDYHZd6kw8kKYOCd
         V15/NAjD6nPe+9Zs50FKO5ghjDxYFGd2fv5Kfva/6NneUhJRmC/eWz37pdDLfADHdvk0
         CzU6l14LDnkz4/tUhHncdoG/OsgNMWPSovSFbLL/Ws+oRyTjNbW/mCJ4tgevjrYPRxdY
         USXg==
X-Gm-Message-State: AOJu0Yzpia3V/7AIBbhu/Ktv12lJnoqdelPQ/2BDN+v2PeIVBix3J2zv
	hdHDr9o46IxTFA+7NNHtUZHf5fq5sKDgbgPBk+w7h5/xjf2lLmaVUezqGL+m9g==
X-Gm-Gg: AfdE7ckNsL8m8BhPsG39Vez0lF6sqkTImMitWXhEe8m95Rtv109elsN4Xxvk2dbk43q
	grZ9HAPezIfgVtJ/Tl/fNuYlwzhtS+xhujuUbu4Oww1tpGslpzRqfSR09Ax46AAtYoMKSJT+xxF
	Z9XDLB+hT+xvUl6MWKAruMiJNnX3HiMjLOx7Obz6ex48any2Y+2GPlARiFV/DKhB7wZchqt4L7z
	IUjQNLR96s6K26QqsaIPbk9wKzI4Ul5QnO3Cn5LeF3YiCgCf3gtCeJt54APZnTgrnJY3xNVllNN
	9Ha+1w3tmSW3reoKx7ihypBKlpREl/omPwKNlkDexJS07UqxdFf6Z9gJY7LLRljg5rPM5GMNkPL
	GHmInNXxZZYBZPNzqbhI8GVGcW7i9o5un8+o0OWrdFHml9VUQJxYzLVo4ibC4CZ+p8GCv+621ss
	Ckq9l+71n6QYrKCKnbCsm4Nw==
X-Received: by 2002:a17:90b:1cc6:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-3893f694da8mr11995606a91.4.1783681814857;
        Fri, 10 Jul 2026 04:10:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.226.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313af819732sm6667147eec.16.2026.07.10.04.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:10:14 -0700 (PDT)
Message-ID: <6a50d316.d76d81af.39f9be.58b0@mx.google.com>
Date: Fri, 10 Jul 2026 04:10:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6706655591689837504=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nihaal@cse.iitm.ac.in
Subject: RE: Bluetooth: btintel_pcie: fix memory leak in btintel_pcie_probe()
In-Reply-To: <20260710060334.136987-1-nihaal@cse.iitm.ac.in>
References: <20260710060334.136987-1-nihaal@cse.iitm.ac.in>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6706655591689837504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125145

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      27.95 seconds
CheckAllWarning               PASS      30.08 seconds
CheckSparse                   PASS      29.87 seconds
BuildKernel32                 PASS      27.09 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      510.50 seconds
IncrementalBuild              PASS      25.66 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/419

---
Regards,
Linux Bluetooth


--===============6706655591689837504==--
