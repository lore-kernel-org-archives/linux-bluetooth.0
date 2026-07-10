Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA52F362B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670044; cv=none; b=Zbgd5+HmkzUjW1emsxrDdqzO0UIzWgbypj9ek2aA/b05bpl50XVmYGaCPv2/SZf0tQTYiVuvGjNdISkl4Q6DYr4aAAlqw2g/rshfONKrRPS6ih/CqSxVIRc92a0RLqNuFwiDnTk+5N7D314CahwVqQggDPdcLemcxEk3q8cex+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670044; c=relaxed/simple;
	bh=JkCM5QoDD554bL2uh2K6WNZSi3f7qB2cTsYbgU/ZAuM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z/obaRW0V9p/ItHIjTfOOVXTEAmUZduNfHvL6kQ084q7Dvi5DL+xhF4tr1oGmSaP/oMwGScuVSYccYziI91PBqyzVQTmk/rovAev8ihCucoErpQ+ZVUsvyU8T1RzRuBWRG1YPkVGQLUWvadhnG+7VF2001wPcn0zDIHegJ7PzXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7jL0+Cr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7jL0+Cr"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacb8416a1so4881795ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783670043; x=1784274843; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JkCM5QoDD554bL2uh2K6WNZSi3f7qB2cTsYbgU/ZAuM=;
        b=s7jL0+Cr81MaHGA7ce5B7/Y+X29pE+7dE5ODTed6lpCRYhOJiaKlJcazK/1zzgmvHx
         8ljKt2pJiXzRUXdG87nTw/tlpjPYCUEXvoiqvXuUPA7E4m6wZyqrqvvc7sSwl028p613
         di2dJ4CdRrIftTwsbZ0G1l5E/uucnnv292sDz7OwwOpi1j+e0098XIbYksE6X0AhK/3F
         5JKRKD+DpkSf2Xv75rkEBvMdOjlrmurPwZRelE/LC01gSL1YiyH2EaS9TSNaoQCLbVjk
         JGyrfuCiKLcMM8tibPY4KxfR5lekWAlOxjVJRaqbPETWGBfaggegKh/77j3S84TPP6OB
         qbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670043; x=1784274843;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JkCM5QoDD554bL2uh2K6WNZSi3f7qB2cTsYbgU/ZAuM=;
        b=UJ7CGKsNqUtNE42qQWWQ1pGLciqvHJDb7awYnbCqM8RZ5KF1DrL6bdyqDRpyzgfoR1
         qsu+8hGfoAA/00zyZW4bKvH2bPFVj3NHhEPJD8cTefOi5sSaVJPcjLHpLJSLsiLHOj4m
         iHd5sP620Ahig9Hcy1vCKNWbPWuzMwE70A53z2b8aZzI87ZDqDSivZjNjT/weHfKOeR1
         XLq74Yb7bnNHuOTN5GFcbE1npT4hRuqTBKMQmT+lAT9NDDoIpFvVyoKYcJxEogxle38c
         lhb8D2qYOgvkHmdbIMbC2Kg1nHc4Pdljyv+LFSgvtV5Q2tJfHbn9y5Cb3RWm4xCuxLHm
         f7aA==
X-Gm-Message-State: AOJu0YzZCmfHXOfpxsvDyE7q9uzmALs3jYdaQsSyM8Fu47+jsG1f0aF9
	tU5HN41IyxBedQgsz8zo+i/KL5rIidraWb66/LZloUAetp2kk2CR3dOaXJwgGA==
X-Gm-Gg: AfdE7cnQyS2n5iKF3sjxg/TjyfzMdn9v0LRU6SOdciTHYVrrTezE9Z6MvRD5pRR4nqs
	hzwhM47cJcwY9mRbRM3O04tuGlvcF6yXKKDPsplA2aInssCTwVQTSp12XqR3fXPzs8/7lwyramY
	UgYE2dAbN82C0+52oW5uZGDs6IlVDfZ/1BbKFHlx863kR2cJZyhhc/GmSZNJiiu5Yflkz+QwZgn
	UGNbyMAJHsHwwfkkqHpNAhnOuOdIVQlzKD+Ks46x25+mNxhejiCwCSnrndybnuOv32IITw/oHnk
	9xRDrwInY5E1E32P22SWqHCWBtxeMYoKByrWdrla2p5VR9XH356gcae+4E65mPqLJKcypxiTiVv
	GWNugoQnDgTC2tQ4ClNjWiZ+MPQ0yLoeLj+iKGbMVUsB57CQrVynJDdRr/smkzK5iW9jj9CWReA
	dhQmp79WgvGZWe/nDt+/1D
X-Received: by 2002:a05:6a21:a49:b0:3bf:9a30:3a12 with SMTP id adf61e73a8af0-3c0bd1d8b2fmr12290450637.50.1783670042707;
        Fri, 10 Jul 2026 00:54:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b84d6ce15sm4096696c88.5.2026.07.10.00.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:54:02 -0700 (PDT)
Message-ID: <6a50a51a.4987c784.63cbc.5270@mx.google.com>
Date: Fri, 10 Jul 2026 00:54:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0608418989483711549=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mileskrause5200@gmail.com
Subject: RE: Bluetooth: btmtk: use bool for first_block
In-Reply-To: <20260710-btmtk-first-block-bool-v1-1-e6ac61d918e4@gmail.com>
References: <20260710-btmtk-first-block-bool-v1-1-e6ac61d918e4@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0608418989483711549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtk.c:79
error: drivers/bluetooth/btmtk.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0608418989483711549==--
