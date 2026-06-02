Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7660D1ACEDE
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414065; cv=none; b=hZLiUa4IoCRHLsROcU10GIGdNbgjXJg5EEU1inEPkTNKzOFXet6LKVix1jxRa4ANPoeqzUvKdkhEUpYhiWNSHklsTiyLBrPled8s4ga6jznL9RpejEQ9EsdIj5oi8r0oPgNqPhyUHpPLm3KYZd64PV/oNcR+pGQD8wqHqUz4+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414065; c=relaxed/simple;
	bh=SVD/k5IuY8yj/xNOP/RnkdLxiCOfCVNDIKXdj7rGwOg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FeUkD1vTZqIbW8nzRHzJbYcJ72VGdLP2RbLbt8bwb1xPTJ3GqoZgGGKnEY2NU0yvgD27oZgSQDnXqMWUQcSM1PJ4S4G6QCLutOZbmdnqSDIFjms+LxBbmPXpoFfjAxQ4uIouPjEGizxnwO01ppi1HB2/eGo2YMy73GgBD1fD7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZSaCZF1; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZSaCZF1"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ccedaf0b54so24172836d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780414063; x=1781018863; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cGBugIDY16B4JrstiPn4Y+6oDvw3oHnTWn4Gau10TSA=;
        b=oZSaCZF1UhFQjsGcdz697muZ9RVgdR62nIZa87J6jV4hfrroR2pRjfMqR/zvQcqM6+
         tkFJ7NJWs5Z1HCRhliwqmwLm9srTnBIUip5I+TdYCJUFeodxBtBLUpFkWqLvwSy73VlM
         IhAV+z41sBneC2/Ngt1MPDV5sBqSCC4CTNae46DA5Ok2zK4w17x5kD8Pk9AJd5120jx6
         DuNpl0J5g/HJp7nGiBiQWQdBuke4oC+c/9aOMPdq1YFB2JiFSGJ7oBkYO6j1B36WAq0Z
         z85lp76DAaP0H8YDKoZpQpOWsOA67+XPwAFdoq4H2XJGnbXH6S3bbARjxIlP4wENtaR3
         0aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414063; x=1781018863;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGBugIDY16B4JrstiPn4Y+6oDvw3oHnTWn4Gau10TSA=;
        b=U3FRBn1DZea9e62GqeLBCHP1PdqXmFKStX0lQ30H4kA+d6eXVRv/2Y73NFG06a1jDq
         Al2k4Dnoikgpjl0l/br7GcwI9BPnYsYxjNQHw6/jgRlC+OjDiCLhLdDLwSVOkuPQ62Tv
         1n/PLQdcQugw1aS/f+rMDnK/G1JpiFZrJM5NJfm7GUBOhA+Ko3YJEGO/eQCcAHhtMy6J
         UteFF3At99+akM58dkFmBBpVoXw/PwlbnAjEtz6hlnXlpsSLBFiu8qWnBMcFBLiBOl4M
         PIb+gkaggQ/XKt2KrtopKoVV/dnIAcRN8CRcqTWgj1TfeOqa/ToV/G+LJ78NZEwwuvg9
         dbhQ==
X-Gm-Message-State: AOJu0YzNCTNDrufycMqI2Ck8rMOr1lEG6C2zaekeKTogCzu0AsyU8Qfm
	34VHFY1zuzPtVMzt+grDbb1mhLO9ZSA80mvDw5AEA6gLRUPaPA0vdu3tMJfxWA==
X-Gm-Gg: Acq92OG/7QKDx7zll/2nmMceWdrswnarRrjz2aKDSdcU4856eFnuHRU0z4VuxkhgApV
	zzVpmbCDFyxd+DIxdWF9phqWCWYZs+VsIMBIcqSVKWOT/hYh1wlWBDrzaVxxaXQTphKFba/5CFH
	DXHYBNmnzzdqZAkID7pawDkNN0OFHtieHOQ8KhpoXjxwqX/NCGv7+VZ0B63tLdjhklPmxevamEo
	yPO8kjS67kXIpU31ytoSaSGPtfKDDlOGYXKcNihO3uRN2KkMq38O71UWWhHqydqq+TYY1ity8BF
	Aw1AGVR0xy8//2pWBB2EXCJdzDShxrogzw+lvWgYi5W3eHc2sDALq+5E19NnpVRV9sAPD88uoqm
	kS+A1knYZRdCAJgSwpA7iJ0tX9V6BbWdoCq14PEEJJiXPPUU3FhALMyoJGAH73c7VTzOHOiYEXq
	NfsWTT697NBZBNfUbnSDqLMk9bPgMnAYcAqTSdqA7bVGC7/g0YptDo
X-Received: by 2002:a05:6214:4890:b0:8a4:21d9:bbf2 with SMTP id 6a1803df08f44-8ccefddc648mr224625516d6.33.1780414063347;
        Tue, 02 Jun 2026 08:27:43 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.200.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cec1d7de17sm20751626d6.1.2026.06.02.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:27:42 -0700 (PDT)
Message-ID: <6a1ef66e.faeca26b.17c073.91c8@mx.google.com>
Date: Tue, 02 Jun 2026 08:27:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5062971804391028339=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260602125618.2520506-2-oss@fourdim.xyz>
References: <20260602125618.2520506-2-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5062971804391028339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104625

---Test result---

Test Summary:
CheckPatch                    PASS      2.73 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.05 seconds
CheckAllWarning               PASS      27.86 seconds
CheckSparse                   PASS      26.23 seconds
BuildKernel32                 PASS      24.55 seconds
TestRunnerSetup               PASS      535.77 seconds
TestRunner_l2cap-tester       PASS      59.84 seconds
TestRunner_smp-tester         PASS      23.74 seconds
TestRunner_6lowpan-tester     PASS      23.40 seconds
IncrementalBuild              PASS      24.33 seconds



https://github.com/bluez/bluetooth-next/pull/273

---
Regards,
Linux Bluetooth


--===============5062971804391028339==--
