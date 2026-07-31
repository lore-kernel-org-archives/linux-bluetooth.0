Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA123E358
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509078; cv=none; b=nokGD1zThq3UG0sXTTMlO+JUCRb1D3X4EGm7HKGK1wnG60NDFTbP6VZRck3YMlWE2o5vbJT1pxZojoWjuxExGBrT8UPX6jKWSm7Cv+1g5ulek6F27yWvcyyUYLMAf4rl6NU4IS2t75zUIXQU9Py112zLM94wx+1Ha2FgT6J2NGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509078; c=relaxed/simple;
	bh=0iqNsQQqdMUs9HS4Ddxx6nCJmXuHFHBkjeQCYDGD7X4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AUxriVDKm6fPd7h7meOdtsas4jwW3A9dW60qUyGfs+nwzJcw567hfv4aEdezYN2x4z14nNVHVJodk1d0/AlxPwkmn9ODHeKkxTgIU8hwUc1EqJWm39MhcKvtiWlgR3rOc9alHKXxjSD7Ez6Lsrfitjvdpq9lxbrlvk0D0rNNTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2p9t/SE; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2p9t/SE"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-930f618435cso62994885a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785509076; x=1786113876; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0iqNsQQqdMUs9HS4Ddxx6nCJmXuHFHBkjeQCYDGD7X4=;
        b=s2p9t/SE7980nZ0BYD+oP6t7V3RmxrKOLUhGSimasYvqN08k8nwhlf59+nzTOilLGf
         BJs/+e2eDcJmrSVZpYPqSxnBG15G/brQ13vbomqqsX/1iWtCp2p4ELCHRfQImWI3u+V2
         SggPG2IPl+SQiwlhx9CnroNu0rXbxnnHePuqXG8cI9nYeJTw823n1O+pSsFWeyFcfWQr
         M419TmU54+5I4MbzrRg8XjjgbtO6Rj25V9IXFSRSuMTwnJzO/LJ6d9sCOlIS5LYbGst5
         gRCHshnAXvSVuOmDVGzxfQUmYaJQRq89A2GbBeHLHFO7PaVU0MRiYYCRBoxA5QGX6JOS
         3ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785509076; x=1786113876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0iqNsQQqdMUs9HS4Ddxx6nCJmXuHFHBkjeQCYDGD7X4=;
        b=jhShXGg6krXe3RC4m0zIs9eY7WUak/EC4mFTIMHQ0P5pXGTF8kPtHSd0SpUaxTAzRh
         /+OprNyRrxugPR7umcduykDoQcEErmfDDJt7yOOVcaENhqbWyHRCZb0MBAB7wa6+0rBl
         PTBj0fU140k3jSxn68L2n98GHEYGIiU8aubGbLMnXOqctWvfbu2SAxyifv3nxlDwoz6y
         S856ca07bGBXI60B4+s0PHe6IlFfO54L3tzq/2F+ijilE8UEt7536xfk0HAqcCpoUVal
         r5h7vGQsGHYC1g1Kw0F2MuuAmsCQQeXoG5swOJH3XBEwknme+ZfbbmPKRlAo31xgWD/m
         /jhw==
X-Gm-Message-State: AOJu0YycL6BAmyn/LXh8ofpRGz4gbonaY2aOehd6+NnzDrzvnvwjqwrB
	W/i0cYf6TmSDouRC0WjiMRfvRnOBTNI/Xhjvlro+AMCktWSN8YNoHZu2zt9MoA==
X-Gm-Gg: AR+sD11bnAFgOy3aCnIMaW5R2PfXYhWSzWvVj7Ob+ifRgRXpY0FCWbd9d/5l7YOotGS
	eKlmt0rcwmEc7p4S85G5cFNRkZeDZ14SDuHU2Ozej8pqhpOdBmvyhtET3d5rV9bxv2YILOSQQZB
	gsCUTMZJgr6tqhLzhvm8IZ+7OL2prB+jMQLxRFE5Wrjen4tV2SswSEGsVvpShzaxgykYztk096a
	FsEJmKqWtQTnbL1moC8ycMD3wl+/oTsNWJ0XzhI7fFp4iUVODN19cIQSjYUard90kqji0k0Opjp
	7IJ5pvPKJSKGPPMNBQnO3KKsi0RNT4REKZO3gRCuO/f+uy+dyESjCUFjZjZtG0yXUIubUg1y2GH
	iCxet5vNT/VGbhPovOjrn6rF7oZHlIC6kdaTYv983TAQtllzdPJDVhmsluqo66YbA6SF5sy0vRJ
	jNJg2VFH98/5B4k3EKS0rbqFFsxqMpY9ZWDaLKZ3P0zlzgwuDLI4ILfhcJYZ1Qj0kHmqk=
X-Received: by 2002:a05:620a:3712:b0:915:9a39:1d68 with SMTP id af79cd13be357-934a0750f2emr46181285a.5.1785509075712;
        Fri, 31 Jul 2026 07:44:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.244.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c199c2asm67669085a.28.2026.07.31.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:44:35 -0700 (PDT)
Message-ID: <6a6cb4d3.044e2c06.de95e.a39d@mx.google.com>
Date: Fri, 31 Jul 2026 07:44:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1192327379284031598=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@oss.qualcomm.com
Subject: RE: [v3] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
In-Reply-To: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
References: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1192327379284031598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/core.c:966
error: drivers/power/sequencing/core.c: patch does not apply
error: patch failed: include/linux/pwrseq/consumer.h:20
error: include/linux/pwrseq/consumer.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1192327379284031598==--
