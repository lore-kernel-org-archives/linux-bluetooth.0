Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D190393DDB
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135887; cv=none; b=iMeeI+Al7bShRe6yh4qjiSh1kcPLh28+k8uUY7UuD/oqUpJvBois2+I0unQPL51ywd8WfSUH4lTWlZ3oMWmTvh7XUdHPvoJKxI+tjBxft0PBWwCXdoVnPGTjMRIq1qHtqB1ImrMGHI+EPeB1jUicClvvgFpp0dXTdOH5HQfZ4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135887; c=relaxed/simple;
	bh=MwEcPIWT/h5rPRRwn4mUjZqrcqTe8yEOu3hUU7s1/ak=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R3y6y5QGgFhRDMILnNNxhSBsynMfrhDSS4qMbAOBCd9LDXjLH5eFJsePl2pqGSMPrQDa6gM1ZIJ9z1SkhAMJnVsWnRjaDMyCoEbWrdjeALwau2Rkjnfek8TiItlOlVelBU3STxvp83Mr0xuZv24hajY0VlZMW6XKeGmN68WT+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVnEv/Tg; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVnEv/Tg"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f3ff92cf4aso676596a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 03:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787135884; x=1787740684; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4oittXiuwNnPSozoZYQEGx0bQJ+JiOFj6e+NLuFCvhk=;
        b=OVnEv/TgUEzDXMaVA7p3w8/guTfUISIo0WU9zaVbDOf4KpFdlJtrLjLlvnqWhza3tS
         IREgU3TLOMEUJgrt/lyAk2z6cQhFhZn5NnkI8+3GfXjCGe97SwNJsyc03j5jhVyBqM8x
         evuAfEEWv8hdYnh3LSV0yIgYQwepQ+sJKfoeGnLVxJcozCQunTWcBSAR0xNQqBYDwlvV
         Ki1CVPuzt96w9kX/EMpKCmyD1v9tj7nf5Ytfa1IhxA8/US5ZonMlR7xl4gsw+YLOydD/
         k908UQx/cjLKH0UiybAKw4CQnmyqIBV9H4wKsR8YSVcFCuozgERKbVrzEOwb1auaFSRN
         9y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787135884; x=1787740684;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4oittXiuwNnPSozoZYQEGx0bQJ+JiOFj6e+NLuFCvhk=;
        b=dzgFw6irHF30FChrMV18snPzgA6VZzcpV7FPlP1fPzbD6em15PmLbCjLyYh2EveFmu
         wSIEhapEr+0S5GxaK2uz63HlW7ld2x7glsk12J+GfJXLps6yQlA8dIK9OmEOET/ozGak
         sChOKuWFEzTHZNynlnTjWK+yr6MBWG1sfXUB+detKbTuG10nr2oE7Mc1aPV6fyEPbTcf
         QdJX8u2mq4VCSLYLYLWABkvcqZwpJIOil12DQB5M6BS7ksBKG8loZRv/QCURlaHxH+XF
         F7/rPi2mQ7/kNKjgYNbtIQn5Mx4oPV7QpJ414lVroi1xunMoJ2RRWTJIosxu1ASVTD8s
         oWdQ==
X-Gm-Message-State: AOJu0YxfVexhwDPmnf76FuUVaJ7LwX0j21S+Ctv7ZjwCrSYD3x8tDZH6
	rJqL9jO+u2iW0VWzFvHHN50DdU88Hr0KLmf2Ri0rdsrnsOLI2wpDjl2+LGiN0Q==
X-Gm-Gg: AR+sD13Vp1w7VLHeX9rntSWr8jcnSAcPJ7A8i6gJEj+zKmqXESxWGWS+VuFP5JZmDMd
	qSWVXwiOyvxJYl/qp41g79JycKEUoPccOyzR1hRUZ2E5jK//4eKMMfi5of+Qh2HvriO5+hf85R7
	27oJQhWfEQY7B72Th4jPacCP8nX/JxY11cXbh+eLv0PJBRJ0Q781b9phWfAm+R/PmmszXRfiADe
	zXgQrIt3jqGU884GJOr5T/XftuzTWSVDm/6L9gg01kU3sKDsa2b/z04Sb9ETIleM60D4MCIh8y0
	nODtjRgy/t2sWtM7qQtdpSmgETGPPce4BCHNmTFiBIOtwMEIcl3fqZJHveMCnAR1Ci+ZeNR4y3T
	kb3BflpGYuDoeNbL8SEvDaLanG0f5k9AyCAUdsPmvPT94545cAzc9wlPg6qT2vOfbfJxRpXq+D/
	/yyffjpdXPl26M1agyaZZjmCwnpQZo6wjbSICvE2bfEN9gkinjwXsKFxTz3TVHHG8oGnKd4qw/l
	V3aKA==
X-Received: by 2002:a05:6830:6617:b0:7dc:dbe4:3f21 with SMTP id 46e09a7af769-7f43f916379mr3889856a34.1.1787135884168;
        Wed, 19 Aug 2026 03:38:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.101.53])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7072csm1354037a34.3.2026.08.19.03.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:38:03 -0700 (PDT)
Message-ID: <6a85878b.1059eef8.27703b.28ff@mx.google.com>
Date: Wed, 19 Aug 2026 03:38:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7159382329738935642=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: [v2,1/2] Bluetooth: btusb: mediatek: Fix leaked runtime PM reference in reset
In-Reply-To: <ec23dae6c247005e8eccd312d326a626163ea491.1787132512.git.liujiajia@kylinos.cn>
References: <ec23dae6c247005e8eccd312d326a626163ea491.1787132512.git.liujiajia@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7159382329738935642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148367

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.50 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      18.90 seconds
CheckAllWarning               PASS      21.45 seconds
CheckSparse                   PASS      21.55 seconds
BuildKernel32                 PASS      18.68 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      319.97 seconds
IncrementalBuild              PASS      20.72 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/615

---
Regards,
Linux Bluetooth


--===============7159382329738935642==--
