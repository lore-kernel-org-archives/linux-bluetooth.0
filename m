Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDA285C8B
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249914; cv=none; b=MSPb8lWpp2rE4eajegtx1ozLcTGngwRoeKSGCbf5PzpwsexSDZr11xKqhX5VBkoAQN/nIFuxH4e4Na1qccDCVxYcYZznhbL7rjrVhaU/iwyTL0yYa4GJzOYPA7lm1PBQpISWZTKueo3vTmSF8PEv3O/rIvPyc2ZGszj6g1scwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249914; c=relaxed/simple;
	bh=O2SpNfyc1vOOCMQj7dlOocrV/PEIsIGvsrh7PZdvGF8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fY70AQ277gz4BMKhXkjrPCGudpBiqoHCU7kDfGIeyvWWTpRjEz5VEU0brY08Ilf8ejVu09bIKMSemhDr0FdZqmOPNvYKV1B5HYT2z0bUhHGwcYTLlAwbKZqjZb0LDgu5ZsjjjrnpY0JxtdQFOxqF2xlW6qwxH9Op+gMrQN4rXt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+fsvjnk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+fsvjnk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235a3dd4f0dso43990945ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750249912; x=1750854712; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O2SpNfyc1vOOCMQj7dlOocrV/PEIsIGvsrh7PZdvGF8=;
        b=f+fsvjnkC5lbJexHq//tEuV1YtuYVhJKU0vLOTlpAxs6ADgtO7sU+YwDj7AslgmPAa
         F+odwYodYVKUS4yR7bJPtuCHXjMUbKU/mb5v2Eh0kNLamC/BIPC/6j95AEi1E5LzKQyX
         sYYScJtOqH97s2ikcEvFDME1iGzX85K+u4XVAbm0aGwmaLs3jQq54fDsCgayAg57qgod
         z6vRWafrOfY4hMaH0Uo6lD9NNifOdUgxFcQw1+muEbAwIHYcqsjQrOcgFb2Xdt/yfKh0
         oLUstOHLTRr86rxkWXpTxEgkZEytu82cQTzPwicaFS+4Gx99kPoOLt3MmyYiNS0SGE5f
         2kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750249912; x=1750854712;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2SpNfyc1vOOCMQj7dlOocrV/PEIsIGvsrh7PZdvGF8=;
        b=kzx/5JNg0XBIKk8X7WqjNWLjQ3GVu2l/n5CJ1TUpPoYT7E37fmu6sK06Z2GPP/3LGy
         S3dYtmRS47xwMn3n3HpqtOVI0wEtMsFKovE6qYnFmJF+4rNsQPTA+mrPjAJK+lguHPmK
         gS082Zk6HZ4LutjoMHgoOco3QLbA13XF384Hn8Cf5FoIzJEmt9zII6F+pSZlTXk1PSym
         76lXB+vcoK2uDnAdD4h+AN3DKAlj15NTmzHWwlRqBA2+OUp1BUPWU7NkDcqCT9Wbd6b0
         f9xLBhFW5RYaMYZusLIsZwt+Hzy+Zi+ZBKXK1+Ju4ehn3CxuE3dRaeSbNtlaeB6u7ceJ
         6tgA==
X-Gm-Message-State: AOJu0Yzf2YueDcBVRam2lRk6/MX7H3emZuvRruu9GgopIrJfGpG7qcvO
	16VFKs7oc/qplcENXBc9YynQsE8AiLWMcKj/GwWn/C8R9K6TR4LRkmQENuXAIA==
X-Gm-Gg: ASbGncvSZt447ODHfEZdanW2cGBOToEPYEFHe8yj9wXg0JwiF5wZQ+x8Bn5snBbmj4A
	NURZwd823TpSkuf52ESJSGvjkoARrVJdrizDQURhH4E4h6sDe58GPBvy2JKcBNESSndq6nQWL6p
	M6E54Y1eYuWgJF4NfSomdy6UiPJFNg45PWyLGyU4kM2o/boYSE6Zk5zYPAcGXswG++CpZTd++K6
	LK+jkySui2YgIyS12aiyDnuMDIu58sxkIQQE49g8xxeONRshuh2ix5KGeR3Twm8TpyGcw5sBSpQ
	wBerDfjW7KvsFyAtdNP/az9QNL5UU6rB+3fDuW1tm/mKgnLC7Vuw8rexpyRWLN9Dg/SM
X-Google-Smtp-Source: AGHT+IFjaLaaFhGENBud395gHC54nj7k8lZnmHgyRA6C/ET4baJ+wT6IP+tdZmx1VIkhGEExquFfLg==
X-Received: by 2002:a17:903:46c7:b0:234:9066:c857 with SMTP id d9443c01a7336-2366afe7d1cmr275673795ad.21.1750249912468;
        Wed, 18 Jun 2025 05:31:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.46.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfdb9ffsm98501185ad.242.2025.06.18.05.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 05:31:51 -0700 (PDT)
Message-ID: <6852b1b7.170a0220.39d3b5.69e8@mx.google.com>
Date: Wed, 18 Jun 2025 05:31:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3307046398032509775=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, d.privalov@omp.ru
Subject: RE: [5.10/5.15,1/1] fuse: don't increment nlink in link()
In-Reply-To: <20250618114409.179601-1-d.privalov@omp.ru>
References: <20250618114409.179601-1-d.privalov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3307046398032509775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: fs/fuse/dir.c:807
error: fs/fuse/dir.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3307046398032509775==--
