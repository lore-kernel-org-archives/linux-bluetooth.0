Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13613DDAA
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207658; cv=none; b=fbeTgYDzq8lc2hKhbzmb4uvSwqs47ROAZUJECKaF76lJI8Btu2AglUPnJhjJJLCRW+ggQRkYlJ37s3R3sVxM1JvDGuyTdx1EIkA4cagCNvAf9c2pyi2u/3RXhIM8Xze3lkavQdIbo3yTRUnkNeiCLvkdYRyB/BPKp24xQAQyCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207658; c=relaxed/simple;
	bh=yYR5WJZfZHvYSy9OCId79tkNva5IpO6qD/d2pPOBvk0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ozrlIYopcNhkfHhdz2U3W9UIyxLAbnLcFAOHJwY5SAE1DClV7Gr90yPf/H+z+ZOlVyqQsciUE3WFfCkDrp29+xgqGGEg+w9NYprmD3AwVZ7x1EFDZEJvGblyu23BKqEbDlS40CIxJfpQERHQP2a+O4TqKQdJkrkb+x4WKlIc3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHp9F1d5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHp9F1d5"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso916856a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 08:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732207656; x=1732812456; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yYR5WJZfZHvYSy9OCId79tkNva5IpO6qD/d2pPOBvk0=;
        b=cHp9F1d5YLAkAaCcVYxxOyAG770WeeIingGmnaPYEO6T2Lh++pvIuha6d/HXpmCJCj
         /euYKKQLGqLV0KDx+1V/GTTliVCjcg5tw8XatjHUHGtPj0h18MRpmMvHZLwpDYQE+ptl
         tV3zHZTiAnC8I/TwJ/6RbU03j0vK1x7qZYRo2ECX9p6Fjr0H9/jTUNqOnSRx5aQwTOZ7
         /ffzVHP1bDFN1P61vXhC0bMpLUP5jWtOam4tkn1OqDn5Da+4HBTc7OYE1akgNRfQjjRW
         bp8D/ZdvtuGU+ammuOr4roMcsyfV5BZ3t2NUWgUi5yGT+kDbKchNECZMCXUmIex/GHso
         TSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732207656; x=1732812456;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYR5WJZfZHvYSy9OCId79tkNva5IpO6qD/d2pPOBvk0=;
        b=MzOEZAqdx9hWRWYpxjcbr8gogTO9rCudGEvpFRpxaY5+Qwq2W4GMaZ9ZmCfoaDBy1e
         o2AyUWUx5JJrK+7eEHa9ikbsxBg4/c34gcNKJjpJfswFHKOsH8Wz7qfg6kvR235ArVR3
         wBdQoAQ08w18xttlU/PO8pSsCf0hv2dtV7qI9jAdFSus+YeWJHI9riStmaqvblFyy3kj
         wwbwlCVIp1VERHRK9scxkSb6KvVgKL/WOiiFlaDiUQzdHSMiEgypD0aVPb84tmctHev8
         SCpIUGNgg+F5KzXrCYOtCDbCHSGvy2nRWNEdwsye7uIIKK1Tk/ss/fB004/OqnFicYR9
         XwkQ==
X-Gm-Message-State: AOJu0YxbJ3BQskt0Z+Y2xSOo37uzh0UMAqRt3+lPYViCvUaMkXgf4aTn
	JRdXBa9u1F5QTpNlXbYkNVZCKv4WnTy42YMv1gAH8KuGNbzzF0wsim4WHA==
X-Gm-Gg: ASbGncuQowHpH37Vafn8bnno1C0GHghrwErBOVeIPCh2jgU9ETOmeIXqsTFGC7126JH
	buP6gLT9023ZdCYs9xk2MFE+9fJVhFo4PyWy4/2TWTa3+R1x0qcT+jVXWFFG6IHi97g6FYYvG0a
	aIu03aMzulem7m0Gqb1HHAlZVQUudOm0El2Ndl8nXA+fCOi9NdQu4z6n+QVOVD5kuu/QXIOZDNp
	2ekyFdS0q9UmkTQflWRYVuWJmZeLEsE5hROm4wt4PDwduplEblcO8RfQw==
X-Google-Smtp-Source: AGHT+IEBw3W92lq/0htac1usd/vHv3j/wapk/793twRlv9gkIiGi5JPpuMaJKq34Jdr9m8XWuwza6w==
X-Received: by 2002:a17:90b:3d8f:b0:2ea:5e0c:2843 with SMTP id 98e67ed59e1d1-2eaca6c0247mr9421687a91.8.1732207655905;
        Thu, 21 Nov 2024 08:47:35 -0800 (PST)
Received: from [172.17.0.2] ([52.190.141.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead0357b42sm3483604a91.29.2024.11.21.08.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 08:47:35 -0800 (PST)
Message-ID: <673f6427.170a0220.2d71fd.4584@mx.google.com>
Date: Thu, 21 Nov 2024 08:47:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5891134920249699283=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, greyxor@protonmail.com
Subject: RE: Bluetooth: btusb: Add one more ID 0x0489:0xe10a for Qualcomm WCN785x
In-Reply-To: <20241121163259.180589-1-greyxor@protonmail.com>
References: <20241121163259.180589-1-greyxor@protonmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5891134920249699283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:371
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5891134920249699283==--
