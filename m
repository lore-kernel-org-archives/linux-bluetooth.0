Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF02DB780
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046261; cv=none; b=luz62s/SombTJoYWdRJi7pG6tfZXhDnPX2nIdbTny5elMJoYNTBku9UkDTT3+h2HCGUHiGeHiHvVXOXEctkGWsmFHiidM2j/RcyNbhmro1JIbFsBwHWz+cBziMyrktQRPC4XlXQxtaCbZ8azCiPfEEsLbNJbcL1GAShzrQOx1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046261; c=relaxed/simple;
	bh=mbJ3vaxcIyoKfQhlKHty7ZwwrDX8pkmDvTjX8kG8Yz0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Szny5/LqeS1QQ1BtI9iyUeWpXmuKoMFIp9nX0sd2ep5Mjc8pZlwn/EJDxr+DZyUssn+k/sMCfpTyB3qKF2X2Z5wpwlbOG9fjkpuKn6TskqRDTA+j7HNY5eGsazK93iYchbgOWALO8B5QWjUaFZ3UWHTfxi/4S/LToswKWIa07Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiESKYEY; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiESKYEY"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-440d9bfa309so4619739fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 16:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781046259; x=1781651059; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6rjJI/ZmGZb+jwECOJgrtpRmbUH9N1skNRi3sBMbE+Q=;
        b=LiESKYEYi1W5V+/l8BRXrFW8ApkPS8m9luoRJj13ckCZQlWuqw0amk7ofMVmFXsOdH
         NHmYTzdvPczQtYdQ5IAkT9irIv60cQS+llIvRW2+IHqx2iVNB8GO/E3+/WTe2MsmNVwl
         dQpdWHPRMGi4s83UPjpw5fKBSdpfS+eLicO6xRSoEI6aG/8xB/3jT3aot5DNUr2I7a2W
         6V1M8M6iOEXNxti265cpxWWy57XLZFbvOSTu7fY+ASZbkDH6RdtAS3OzXV4of5zfuO5E
         DKPTbQBy7jBa5d9zTItaWWfbzCIUWy4u4heYcp5qarRxnhHs3y16PSSDl1QmNaPjT4WS
         M9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046259; x=1781651059;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rjJI/ZmGZb+jwECOJgrtpRmbUH9N1skNRi3sBMbE+Q=;
        b=o4KG3MJ8jXsF5Z5umLjBL5LUY4li9oPFJC1HgerfiouiK8TuWQzdTFWNkc5cDcGRhu
         L9HCdqFdjAFjBq7OoR8uCQq/kCf+uLwXlyFp2f9zooIFZFyRts5K/oysT6oBXUMtug+6
         IJxuv8qo+ns9cOn2DRfqr7mBlj2WcGQBDd+7FEOCr1AsUKOJV5Kkn2TQ7+we40nyIppB
         f/mtLSo10xU1gXFTggjUVGbJQ37XUntyFyBaNKHtnBy1cTOtJHFFjIRMwnDkyzaPk8vW
         jHGB2X9BVD4FPkF7ApQZ5/DqEXvtVcND9ZCXXSQS45BJtdRyEEBUndzgvhsKmVpJf6PR
         60Hg==
X-Gm-Message-State: AOJu0YwL7V5qfomBlY7cI4+dlrypWWSTuNhZsVHASPq6qXh8yrtNWIgC
	lD9TnJhMGogDQlol6Xg9JoyFXnPKzkCG1xNHEMRHAStc57xc0KCqbE6alcaKPY64
X-Gm-Gg: Acq92OGQY608Kq2TVLQc200WcCHyb2SIkCv8IGQU5CKLAz9FsWE07hxDsFvKz//hdQg
	gGYAME2lFmN1rFcA6L7vEI3coYKVKaTe22rZsMLvYNVj4bc7nBJJOGFXsdEU5iqKJ0OdeSYj3ig
	3mlLkaX/0OOdSNJ0EVbXqOVPukxRrmSpHyIoaS5FzR/quLXKYaDw0lGb9v7DwbAk9NEtabjvBaU
	imMsufgK9UGYUzXz74J07/igb9ICW302hXnHntGOSCLlg8rofEGAVYg1iyMCWAsHndA8AbvCGQH
	B7ujHKKnZLNgVfDbfjbB0D/y0z+xw2p15OZhyOqt82nFd7QF3wzj39/YQL3pu1nCqEsPr5peHcI
	kif3/mfDjngjpL7JfNYKF+jFdVb3ltHIYJ/XiwY6kae8dRVjGgnj6SsrQVApE4uNC/5213TlwoK
	8fHxdm2W5HOOcCkhKhb7087gq9qF73l4cVPHh3c9kd2w==
X-Received: by 2002:a05:6871:5822:b0:42c:2421:5781 with SMTP id 586e51a60fabf-4413dc23d59mr11925891fac.28.1781046259165;
        Tue, 09 Jun 2026 16:04:19 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.200.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7d3c2casm17134510fac.7.2026.06.09.16.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 16:04:18 -0700 (PDT)
Message-ID: <6a289bf2.d41004a9.3b3abe.8a40@mx.google.com>
Date: Tue, 09 Jun 2026 16:04:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0058355007950435951=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] transport: Complete Acquire for Sink ASE entering Enabling
In-Reply-To: <20260609211130.3887817-1-simon.mikuda@streamunlimited.com>
References: <20260609211130.3887817-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0058355007950435951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108826

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      18.46 seconds
BluezMake                     PASS      675.35 seconds
MakeCheck                     PASS      15.28 seconds
MakeDistcheck                 PASS      227.96 seconds
CheckValgrind                 PASS      260.62 seconds
CheckSmatch                   WARNING   315.70 seconds
bluezmakeextell               PASS      170.28 seconds
IncrementalBuild              PASS      665.24 seconds
ScanBuild                     PASS      938.94 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2210

---
Regards,
Linux Bluetooth


--===============0058355007950435951==--
