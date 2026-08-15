Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB53542F8
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786784822; cv=none; b=Y4mCfYK18x6mhnTyqpDmlEJlNmL1WeqeZOXxt/yWfUvA5kk8W2PPMqovGE4PpgesTk6vFuve/kgYoJwhbPxmfUaLfW1PgWKGv/mf4mk6qG9x+ajBSn4jlpxlMHXoWk1JKnUroy7BClr32MGy+il6DfZYa28nJR7cFF1HNMKzDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786784822; c=relaxed/simple;
	bh=BQrN6c9fbf4xP599KQ1n7zPJfOZ5TxqwkEeFR8rqpKI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mBcTlzxW7B4Me+gVf+xTAsDFa2QL9RTGi79GeXO3EtukfuOXn6CvxHmKwPrKUYRXcExDQCe4MUgY8c5IZ+7H1xXsuS9NkxnZGWuuXOofKjF3sHgqNZ+ax32uws67ocJLg1yJsbh7aDE8VwOY4XfrxVTd0ysM16FyY/zrMvNTKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzkQZ1/U; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzkQZ1/U"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a2dcede83so2436006b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786784821; x=1787389621; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BQrN6c9fbf4xP599KQ1n7zPJfOZ5TxqwkEeFR8rqpKI=;
        b=TzkQZ1/U1aOCTubFIziT2P3o3z2obsT9b87hFOO3ZXsWOxp8rSuccEwkb8IO2dc+92
         xnz5mYbxAZ7ItOTjCYSpVmwmredddYJTzElukAXPX4jLhpd2mK9RqbvOupffx2zZPGav
         adJd8Nqn7BqedSEVJTntu5AaceZm2ddOZKNyO/mXwU/Z8SpK37XyVCrQm0MyArJ9O93a
         qIgzw5YkTLP0IGuWCJ0tgVtvYC78rMFfJefJU79I1INW18PNIBcXTRkzFjGivHv8sIn6
         ypt7eVd52sMbOQ3xseDN9a/3NgQFmLpMyhSU3/RgDu/VQWE6AjuH43S/PLoz6wIM0GRo
         2gNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786784821; x=1787389621;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BQrN6c9fbf4xP599KQ1n7zPJfOZ5TxqwkEeFR8rqpKI=;
        b=LY0Ox92mOACIQhnGh2ojtY0KmS0ZMQZRD4iuPCd09QBXbW8kodE0kGAnG3Dk07hZ0H
         6TFnO0qW3EJpjzsHAINwCXpN+xie4rEsFiND2FB+KxuHr0+5/FpzmbEgYOpEO/jQ5+23
         f6XNPH1PD7dsBd+wDcQ4uZE8pcr8rtPjH0mz0GGnfw1DcFDvU03l2hJEt7MI2rPWdpvI
         ZM5V65bL5nZwnuVr0QOwk4Kq09KpsnYexibL1qXujOCWhGRDhrZO7AD5xN6K52TdSCfI
         U4DWwdW5G2MCxMZXpiSwmg1E5B6ASSk3HGyxSQoyrnGtEWmz/6PbAIO3k+IVrQfQ8gvX
         ui3w==
X-Gm-Message-State: AOJu0Yz+4H1WTC+YDEGSK0WLbu/n6P/5POS44eJQvi92QcoGYYYSRBH3
	hT3oiXppXvJkGkUenzT6MolsGvhZ0rkLBV6v1k646JjzZgN/VL8dDsVgT46Q4A==
X-Gm-Gg: AR+sD13dXSTTKpn+mR3OrR1LyiC7Y4gvXxEW30TVTC+I20SdjRgpGrSwzJFtYpIBOVJ
	KQ5YUAdlUdV4sZhiadtcXFYIgBEi2+DhZU82zPOACrENud8IK22epp3NoXvc1vx6l1mwJsfD0I9
	Ukgp9HgcqjU1AMSe5MONutGB2vAzFeFYVyIM16dHdMYo0wns/5nsXsc7ZChNYXuq6Ato2ozKaEJ
	RXOFeKatUN+NWbDEAvO5d4O79pq/ZhbQu8x3jSlAAA8TcZScBcfcb808i2wVtdwzpO1V33AJuAP
	DYhijO5wpiSjUhY5zageeaSpaXYT3NNNirWvsDXumRBaJ3lpXkzd9qvI0ssyjOwn4ECyTqlsePN
	+O0CUoVQihZFMPrwn/qLN9Eoq0y+sSKwY6MiL6ZCIW1jq69CLojAIfauIYIvhxOlSyqXO6rbw03
	QlAaMu95Qphbfr5y96WLXHPXizVP82IH9cx44nGuzyN1Gn92nXimSenJrmdHAtLALjpGX66A==
X-Received: by 2002:a05:6a21:3282:b0:3cb:96dd:2477 with SMTP id adf61e73a8af0-3cc719c7361mr13660170637.8.1786784820619;
        Sat, 15 Aug 2026 02:07:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.211.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ead105a9sm12996344eec.31.2026.08.15.02.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 02:06:59 -0700 (PDT)
Message-ID: <6a802c33.436e7ae1.187f9d.41a1@mx.google.com>
Date: Sat, 15 Aug 2026 02:06:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1138624486627957380=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrewbille@gmail.com
Subject: RE: [v2] Bluetooth: btusb: treat 0bda:0002 rev 7558 as a generic HCI device
In-Reply-To: <20260815084838.27092-1-andrewbille@gmail.com>
References: <20260815084838.27092-1-andrewbille@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1138624486627957380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:4089
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1138624486627957380==--
