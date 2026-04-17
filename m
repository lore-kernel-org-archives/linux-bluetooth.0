Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC74308F1D
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435105; cv=none; b=GuTG0SpqpZWXBB5vsUTGvUOAO4gFr6tHzlUiCSOqnsD1+mmHVkLvuBVy9Z861MF1pVaLweC1YYL6An9ammxqO9JouN6OWTtr7vxJCY76qxtXOHVQYGrQTY9xWT7UeGZ2tZHE/awFaJ7FSw4c9Kyv0ZdyYyLlFknkhFSmk7izKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435105; c=relaxed/simple;
	bh=y2NgZ1IEdtaxOnEriRaaObGJ9XIurNMxRypD10iwv2g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OmGJME1EBnrkABzlGwuzthH1rEWzCyVS+oW5l1JpJnKzEpOGB5Hkt3TldYPiUxw0rkrtmFXlWAc2urqCmtnhjiCRzxRw4Y3FOyD+WSEzRVbrEJVWBrL1yzgO7SVVKEu8z2g/1uid+TSDuj9V+BrcQcBr2Z6t5dOD5xyyKj7DMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWv21vNC; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWv21vNC"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1274204434bso1338010c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776435103; x=1777039903; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y2NgZ1IEdtaxOnEriRaaObGJ9XIurNMxRypD10iwv2g=;
        b=rWv21vNC4r6JdZuYhtx2lVnDm+SYtTTJsZsdOV66mv4uY2hNviVjL0m1RNaSPPA8Qc
         FDJFgTXAdtOKWkKesD4ML2OJeWxOgPBdXxFz7egR0cDWhmIjfO1w6grLOi5b1LHgbTTi
         gu7JLvf2n1atDbFDgKooy2SrS4DobMDI12SPWXEHenE4ManLYmpIADhFIIDzN+oQDA12
         eLsViKGPqpRIm3sXMuCWT8x8n4AhpDF+VH/8zSzck/40TXhllo1RsyHjoT4RcHnsFgK0
         cLb1XhX/600Er8FBd7runvUapW1G/4OIqgHisB5jeXgaMTN9RkMFTQoejTh+XWleWcQ/
         NzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776435103; x=1777039903;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2NgZ1IEdtaxOnEriRaaObGJ9XIurNMxRypD10iwv2g=;
        b=iF8Gi2tjxFd3BICqwIbval/bmJADB+MrWcLmmHPLUJhb4Cv1IqHAMbAf/QyJ2qBK+3
         4Pii/BALEL33RVLtcYh29eQniat+pc7ieuo6T8/5G+kMmkgUIvFy62ubN4d1+DUqLK14
         m9M5+c0ICrBlBySd3BIyFE5T+JNZtT8PcewD04gdrwTEamipapPyarUNtNII3Evg7IxQ
         ySL6cqtMYrOnclyUOIGTDkZM/esCHDf+nwQexItUqyoBmNJsd9aY8DnHZS99XTQB8m6G
         NxxaK2vp9bUc6VooYI8xVPbgn6PRcP0Xo/sK/gaoK0fs524QGS1N8Y8ekF7EDy/HvWcv
         pcYg==
X-Gm-Message-State: AOJu0YyzwE6oz0SX7+EuQWqjgPCvx/OD9w+8iEEogTSb6jumSoQlr3Bk
	0HpCEVcmyzGK2T3G1IXxzHOc/U9TpenuTIIu8cRL0O2wFq8RxK3j7iyZhaePeg==
X-Gm-Gg: AeBDieud82tfYanO3us9GyOQ84UTX6keNk1pEN575NtA3SqHHkPsYXqmvFWTqHPzPzu
	XDoIkji3kH2qNOf4q7Ngx8RVjLBZ9yI4VrPEjHvJ2ju31mGJiVUw40n5OimKE0zfYg18tcB+1ge
	k+nvJnmZt+mOJrGdMAT1pSciz4132SXyGOIeQE+QPP8jy/DON2OSSTnGjjRy9OQDa949vhSTz3l
	Wv6DSCJAD2/BP8lTS4dctxbl7NBoBX3wp1KTO2jcQkH1fNWR8fTYFzs07XlceS2EHBOi5l2GXs+
	anSTrTbARS93tfu/0VWJ7X4ZCkVdk7wHCtHKFJcgNzNKYy9X3FqbCqjgrwnMkEXLPGfgZ2OcKkd
	iqYT/IMP1ULmjHbt+g190YFxL7sIKZgOil8V2QmFH0rDrG8CthOsdQUAhQbHDl1gec3J69LwYNz
	dwqWMfPQpek2hfuhs/QAuejO42HbjQPPmZ/s1NFSc=
X-Received: by 2002:a05:7022:1283:b0:128:d5bd:3557 with SMTP id a92af1059eb24-12c73ae5574mr1192134c88.4.1776435103392;
        Fri, 17 Apr 2026 07:11:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.153.48])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20c55sm2259280c88.13.2026.04.17.07.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 07:11:42 -0700 (PDT)
Message-ID: <69e23f9e.050a0220.17c124.ff26@mx.google.com>
Date: Fri, 17 Apr 2026 07:11:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6908605737915211761=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, u.kleine-koenig@baylibre.com
Subject: RE: sdio: About pointers in sdio_device_id::driver_data
In-Reply-To: <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
References: <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6908605737915211761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtksdio.c:64
error: drivers/bluetooth/btmtksdio.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6908605737915211761==--
