Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA01392811
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785881355; cv=none; b=IGwcF/evPWp8Y7Etx8j1Lelj9XxR2wuBWAcdcoJQG3JWQgcSXh1a/4kCkgQUm33lBtVWDFsD5Xjr/aYDJlZXJwUUS0hcKkDlT0vVZvXlFksH6LnOoMZ9onRkrysHw2+fKzuCcfZC7QuW4D5Tl1b38ofuSRiujwjxcnIQ4sescu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785881355; c=relaxed/simple;
	bh=DMXNJeTFXPQS3fDwfWi1r0Z5FSGpx8OCJAPv3GdyyfE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Caiav6uyDHIeaQaElg8ITuG5cmNkKaBgpzTZMkZe1OirjXJzd+2SN/RX3rk+QjveGuTf/N3OhpH6YKAZ3WWQSNNTqXr/3ImIHKQUB2H/UBYtVEk15uDnDadjm8x77X9af/7M1Ytd9ljsyzTYXKrNtjjrw2q+4eGqqc1Bz8Nx/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nulb4Ft/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nulb4Ft/"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c2b2c9eccso2109731cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785881353; x=1786486153; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DMXNJeTFXPQS3fDwfWi1r0Z5FSGpx8OCJAPv3GdyyfE=;
        b=nulb4Ft/8aLR8tHDxfZUK4v5/7cyGKzjnCyobmJ0q9sT7D/m9LU71bYP2Tma/qJTW6
         NdzmLGKy1+OUoeFIiZX7zrXfQtdfRKYPzVnWxwB1N4mcCWrodFZToGvkCG79VewVp7ws
         5ErYN6xqGLQ+r86/dYqao1StT/8bs3k9ZHnN6K/JwfC0icK3RCiKCNf8Qgm4cGfQNuGS
         p0xNpEJcIpx5MhdoPwt2fCcu3cPGW3nPrR+pHLi2TfPxymDyLEMi8bcX9/07XAEXVFfR
         fdardItqgpZKFis1G1n0o1FVQdDa0XUcYlXXDxQG7MRtXFik0Tn2Q61c4H9VCsPJcAxK
         MXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785881353; x=1786486153;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DMXNJeTFXPQS3fDwfWi1r0Z5FSGpx8OCJAPv3GdyyfE=;
        b=sYDFSQB4wi8ZxAka7TRMlkcSERpTEyKI7wwGnB+88juZBKTOQ8xlH3vtl8QHQxbXjF
         YzC+EOA45/SpATmmNQWdBs5upy+dYTjNQYsLoHsLgj5ztwmU312IWzD1pGjxKcQKahbh
         zdsS1suAHYLWdJDfqlmr2mpIVBETl1q6+7nzJWCHymc25u7b9fEUKGS1LkJ5tCGs0zpv
         cQ+uUVNSdueOBbGUrvJhGT2H16+lgVYfWyQ7248eRP8fd37CO7bDHMBb9ZZZTMKTHimu
         Em/U3kXjF8JtgJIcAGxfMecrUD73qAFf2TiHkKyBUzztZxWTw+LrliT4M/tgVo7jX1n/
         dEiA==
X-Gm-Message-State: AOJu0YwAkPqN5nyac/uHTb6jtV6dbDKFJowBRaVuMD0mF7/fmg6TJrUw
	ZnWShAcurJscSHrT0K09JOc631okN+izY4oKdG14CsWd3/SdiMfYIyU2QRZkgg==
X-Gm-Gg: AR+sD10CyChTGZ0sOPacykczCZWihw3WaEjOSmVTmhUpnEaivjlH7dNwV5OveN3ocdK
	9s+S9cD/D3cN2Kg49IuKVfYvuyN6imTSFqE5ildwfgRKmgq9dehExER338xV5Td6qpbuo0WWYhe
	AkA+DSJMqnszhInIRzj9rD7T81NjM027AtDtjKZpoCslRP+kXwimVQ/HSLA0GANfqRQ0wLWw3sU
	F8wC7mn5bxKLNilL5hmQmoP2bxpglGYHczBiS4aQ4yXiKgTPCX2uixS+orDwGUGiSSxBuCn4opI
	ZS/pfDEc124uGRrFzYqAQ00GFW2v0je7Iu28cxksLmiVbSmuPUPWj7aSQF428a4Z6EgQKTm4lMV
	XnoVM++G8eYKPRUEKv0WcVejqwng2NdbfuzcpNPq7bLSvEFSv5jlGrVHS0wg4lukv3COWiwsFqp
	RStawYgO/KyEhMcYAa14VE9n7pf/+Yb5x8R80Zfm4db9JYYpP+kxHN7ykmi3INrt4mkffati7iB
	WE=
X-Received: by 2002:a05:622a:2615:b0:517:8470:2d2d with SMTP id d75a77b69052e-52ce614eda2mr26881451cf.29.1785881353170;
        Tue, 04 Aug 2026 15:09:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.8.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ffb8f76sm13461626d6.11.2026.08.04.15.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 15:09:12 -0700 (PDT)
Message-ID: <6a726308.a8f5276e.1eb58a.e2f5@mx.google.com>
Date: Tue, 04 Aug 2026 15:09:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5478596183310558252=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tkjos@google.com
Subject: RE: [1/2,5.10.y] Bluetooth: SCO: Fix UAF on sco_sock_timeout
In-Reply-To: <20260804214406.750710-1-tkjos@google.com>
References: <20260804214406.750710-1-tkjos@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5478596183310558252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/bluetooth.h:317
error: include/net/bluetooth/bluetooth.h: patch does not apply
error: patch failed: net/bluetooth/af_bluetooth.c:184
error: net/bluetooth/af_bluetooth.c: patch does not apply
error: patch failed: net/bluetooth/sco.c:76
error: net/bluetooth/sco.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5478596183310558252==--
