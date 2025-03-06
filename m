Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6325CC6D
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289836; cv=none; b=dtVkd6GvQw4rKcrARxVmCVHJ3aePI9gy/W2xyyGP0sgKAKmwB3JpvYNf1fhrhuRzIp1MDjwCy2ja9ZkOZgIfmYghA6bZC62R0HmayVL3GJH9Ap7gYxITrZEy0mss35au3h5hI6ob0/RsVuzkiHjAQy/wXi/bCKPWEDOXb/ZB9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289836; c=relaxed/simple;
	bh=gkoqhAUW6jQcRffrB1RWQsfkR6jch37J64n+B0684uY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pVwjqnu5+wkD4OQvvhNOWPJyTCByxncNVhl4x2MfGBedh6iB9CeDMIQowmFYnUr7wDN3Vx++kzfqxcdqoo3EDRQFXcG6MWTc9PrK1WRzXBVZAppTXWgScBXygT9k96xs2XFVTGnyu1+BCYoKRHMGjAK0yprZJFHr2biMQyGDuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5yxTPRP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5yxTPRP"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso1785654a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Mar 2025 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289833; x=1741894633; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gkoqhAUW6jQcRffrB1RWQsfkR6jch37J64n+B0684uY=;
        b=d5yxTPRPdcJNHTrR6qCKC+UkBSZlvazL7K03JeiNltPHmHt51SquZLrTq8jtdxGpfb
         kuSGhqiB4Y3UZCTInLTnVR0foU12+v/d62I8Qyt6QUG4L3YhQvoh370JQ+AZy6iv6GaI
         OpS2wzOKPfv6oO3P+sh8BKg8eXloHNqXvjPt1q1oakaMEJ3e9C1qJy6WVxxz2AlBCcXf
         +1L0DEwd4t5YNx3Xa4XzE72FsftxPYNxMpoSJR3gryy9duRSKPWl6hGnHTV9warJ3kd0
         8wCGjfn7aYxASrQtSYRCYuffbQDisR8zNMwUBG4xTFQHNgPC8a4E77rEExeXXqOTSH9x
         yw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289833; x=1741894633;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkoqhAUW6jQcRffrB1RWQsfkR6jch37J64n+B0684uY=;
        b=PfVmb2aPZBQyBuoYEJi1qGWLg37Pkkya9FQYOIw13UE5XNSLWaf8XMf9D3gBEpFdcl
         +ghRaXZsuqEIDAvvEvLY0kH03jtrW11apqzqM8xUMxcNc6HEmVoQ3EVOeHSjQinlCAS6
         6lr781O0KYyysjbcnyksDsO1LVPo8aguzdVbVcC5K+KJou4tKbp0l2aJ4gAYsDX8w/XH
         fWWWzoQ7d6BUMMtR1PouyzfCq+ycigmt3cV+LFSzomX9R0ogZ6OltiINWjcC3w0r4A3l
         ElAxdh+2FARB1PwcmIjzBh0SxaxLeRW3J8f9wYqTWeC2yOi7haf/GnNebBj6/SHepRZ6
         KPKA==
X-Gm-Message-State: AOJu0YzxiswKH1cHTScJS+75BHtFVX0au/RvhVT4cVegjE1Ne6y68whs
	o9rawLoEdXH0Lo1YN1lDCQLHEadHEQrLBRdfut9O47XzdSKxz12Coct3tQ==
X-Gm-Gg: ASbGncu5RF9ulL0lRYk1pjz+NM1BQ+U1DQFRD+N67RG64EZJbGhilvUZtu1JMds/xE+
	aAKBuJ5pyyxhB0AJ7pWBpvN4BW3N51NAiQnRlLGuJWpttIXZjAbKRRgbaQl3pF5QMCDjN5ko9Ua
	okQBxEeDCbP9285GGTaQHedryE9NJ+aaTzRMlaGTAVWEHy497G8sABPe1dG9qrskVDroIq+Prta
	ptNxzExWU0g4aE+1qhUf5eC2uvDlMlSf/nR9hXI6Gd9FQglAdCxjv5IHK5KVY2C5yJPx5XqVfNG
	ososwoA2YabXxHH64CSqqM9iv6laOEmbZMxl9VwFZJ8HqCouVQ==
X-Google-Smtp-Source: AGHT+IE8HaBP/PXheWZa+/9PGAzD07z/WLbtdi/w+tBygsG6k9Ua8/i1DK2WKRMoFnCDFlpj1Nv+RQ==
X-Received: by 2002:a17:90b:4f87:b0:2fa:1e3e:9be7 with SMTP id 98e67ed59e1d1-2ff7ce657bbmr718434a91.5.1741289833400;
        Thu, 06 Mar 2025 11:37:13 -0800 (PST)
Received: from [172.17.0.2] ([52.225.37.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e822bd2sm3562700a91.41.2025.03.06.11.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:37:12 -0800 (PST)
Message-ID: <67c9f968.170a0220.b7250.8a12@mx.google.com>
Date: Thu, 06 Mar 2025 11:37:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7662079783663742292=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/6] btdev: Add support for Sync Flow Control
In-Reply-To: <ab105eb0ca4c2e91218ff76a9040e46fe5f64a2d.1741288951.git.pav@iki.fi>
References: <ab105eb0ca4c2e91218ff76a9040e46fe5f64a2d.1741288951.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7662079783663742292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: emulator/btdev.c:1415
error: emulator/btdev.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7662079783663742292==--
