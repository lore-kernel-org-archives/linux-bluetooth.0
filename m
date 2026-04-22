Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A6E3D1CA5
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857985; cv=none; b=LQICL4qSJnmFvOQmeGai6TjCUTG1hHwJw2iak3j/okNVPDC4ROfpaM09l/Ix54LCNQh3OHIjfLqY+e56MVLkNUrlRNLJXeQT2nIFBu8x9yJcXOpaP3SUFO91bB27O1uYmvOGPXCgLfcBZXMECU+DKuICaa81Gi533JLe764OiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857985; c=relaxed/simple;
	bh=nsLh/r0poKxjDIJnZjXpW1SDLEoniT4zd0F0ETY05iw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WnH+FgCvH5K34Q9aNgQ/+MiL6Fss49TkhB1xEGBi6o/KZU+k8jQi0rP8CzZCINB7DRf5/7HoubeP/1S33k4nWrbnxooSaCdJkYvDqUK9/mT4oQGlkILqjNEvBK8PAVF5rJRc0SVn5//gxSWZ0bhDVPkg8knvb0nc6hosOoOVwqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/ToQS7M; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/ToQS7M"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d876329bbso63150671cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776857978; x=1777462778; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nsLh/r0poKxjDIJnZjXpW1SDLEoniT4zd0F0ETY05iw=;
        b=f/ToQS7MSEikj4KUSJYPqwTqmIGCL5/pEMwZab4UlwMDbnpKbqb3H2EGKMyO081D5A
         H7iUc8G5QZSK4TLDOfeGNMkUWQ7zekjMqAw8/iBQVwb2KGTOe4f8R8Re4HcNOWI7nHA9
         Y1wMmF3wjAsBSYuNzcwr69EkMWkQNZP7qDQh6M5buqWzNcdpCOaRlWIx5GH6DhCeJfiv
         GwP6kpHFulSOakAu5YVWZ5ptAckWHvSewHxIyqDCdPyaa2UcvUhjrnx4//TOcoLbUeO9
         +5E4NB7KqnmmqszeXQUHMNOQZh3rg00FFFbC+lH1ZPkDPLiETL0ElzHPJC1/nJe9EnXj
         3kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776857978; x=1777462778;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsLh/r0poKxjDIJnZjXpW1SDLEoniT4zd0F0ETY05iw=;
        b=DLtOUuA44mcBDEdci8QCYn0NiQLuMyMthUxObmD5ARyu3l8ArwYZXpthzEZ+uGasxb
         vdReB7mNB6oDNLvPpGtML4cU6XO5F/WFPXG8D6ofo5je4DuP7GJlIuFDracuwj3XvV2a
         IBihan3LCitptPtlX6+38uXtuThJcyE0R46U29i4cETH7Km2NiAftXuQPvM65lgfA2y3
         QHSrZ6k0P+gY+qBguglyQiWxmdvGkP1PjjXicvxYr89jxUG9o950U9ndIeeZkiG618eD
         ZcsDYPlLFScvEZf/IX5RYt4ejWwcqA19CYtdPBw3z9ufouGCMbx0MVAWAhSd/V8+uWYz
         4PuA==
X-Gm-Message-State: AOJu0YzOM0/Lj7O0IMCAjqlN4sSAQldR+uYi3Jl5pxHrm7B2iBFE+7kp
	fsWPqhtZrHrRo4ueFmev6l36fL53dgInkerHjXLOqLIZt2KkVVXneWcsJaJwbw==
X-Gm-Gg: AeBDieu/yJbGK/3DcBw/aa1yx+3w5e5Pd5194Pn0oJ3lloU0cb3J9AC6ZA/VePlKFYw
	ZOeouC2ayqJTVr8FcF2sPnz9cMHEKQhP8Sdo2LIyWzUij261UKe8EMUTvjsA+WkhwPGTc/xK9Fq
	BhCsbZgB8HpLLF1Hpqf0EK7lAoSgdhjekMMJcu2kdoaOPYEPumuPdy0KihSENveBlDVsiuSLQno
	43wWaTX2prN6yNxlDnLjHKSC3DOCpeKdf8kXCRuJi7EMcOSxgAsp4nGqBWUisUOccE/R78Kp1eB
	duN7fhg+slcC7hQAB+m4nVpqZe+0zTB9MHTD8vu7SKcDBp+h3OXccmZKz+sLJInO+tdQSi2cEMw
	Erqrbs/zjHKGySXhBvHDlCXRFy2OtfjiEpB5nENsVuQu8yxGZr7pVrrlzRnzsNfn5epwk7VNpWZ
	8jF5TXBkPSZEL0dFxilfvRwOE0T8BPNWsaxItAYN6E1uI=
X-Received: by 2002:a05:622a:a647:b0:50e:490c:7432 with SMTP id d75a77b69052e-50e490c7907mr180242531cf.48.1776857977988;
        Wed, 22 Apr 2026 04:39:37 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.177.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e393ffe64sm151226681cf.14.2026.04.22.04.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 04:39:37 -0700 (PDT)
Message-ID: <69e8b379.050a0220.1026f2.97df@mx.google.com>
Date: Wed, 22 Apr 2026 04:39:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4896586532198798907=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: RE: Fixes/improvements for the PCI M.2 power sequencing driver
In-Reply-To: <20260422-pwrseq-m2-bt-v1-1-720d02545a64@oss.qualcomm.com>
References: <20260422-pwrseq-m2-bt-v1-1-720d02545a64@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4896586532198798907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/pwrseq-pcie-m2.c:121
error: drivers/power/sequencing/pwrseq-pcie-m2.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4896586532198798907==--
