Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C266298CC7
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773727899; cv=none; b=ErFmSjAMR5O/BBLAeYVH2ma0uIBpnJLJKBDQ2qmeWgIDnuzkuFXSOgHiur8264jhZsEqmj0GlMCASTPXUd2yXErbDyXtYiXEr4ulniraK8wQWeem9bbr4KytjjallvvZB8C1wgqcOZ9Z8Ux5H7jGt/QGIHtzP4tbI/LjzWDaDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773727899; c=relaxed/simple;
	bh=EI/TLkLFcktlxO2JwVkhXKJsQbtePQNXkMBXt/7GUFM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dEbg7FA/l+FfYsuF+/ufEUZS4G2ps/VprfQg+QKFRdQbUzRfUPIbFio9ADxH79THjAetUkCGXiVeMPgu0A6/Ck7R18gXbCPthg/VGXdMX4DV83U/bKvXkg+1OrkTOCoeMeecj8Tc9ylKwR+NwuGttPFVKd7kK2GLx+QUI/R+4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYjBjvzl; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYjBjvzl"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89c52db6231so20847716d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773727897; x=1774332697; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EI/TLkLFcktlxO2JwVkhXKJsQbtePQNXkMBXt/7GUFM=;
        b=bYjBjvzlyBB34USkuUdjsso0wpsLA0TqJytFVh4QGJNX1+ehFDAwtGTIAzZ3fd16m2
         Us6/35HjLHKgzcyp00pBg/aCSRsw9M2eZRuDjs2goz0hLl19IQRDB/LERaS/yaOrduxP
         PgBCAP0+8KhhmmuDKimMYP7NRDNuRDw6OiXXjEg6fo8sPbepbe9aMLoeTdKnuP2E71ei
         30p+psI+nbhMUxt59EfnJMy5z73JR71s+UkJrRXoksyRBu33ii4ChQ8u2VL88wtst0hk
         ttf2dMPAnhIVeTkFieBhf8xG5X8h+PflipH2chJJMKh22HtI0QYp8bSEduyTSAOuO7aM
         PNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773727897; x=1774332697;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI/TLkLFcktlxO2JwVkhXKJsQbtePQNXkMBXt/7GUFM=;
        b=Xvwp+R8ZnJDI0MAW8NVHHYYGDV/xpnPrTjCXfvZ6bRWVbzkowiat6yljF90/hzMkHB
         dRiC5M+HanfWtFJoESbjKwU5SyChNDqnt452zoxMSGQ6Fs8qA+tF3/5M4excqP4uSrNP
         DTPIWX0j53qCLMn2f0x8us+03aWePwgjaMshfxgthM5v0gaF1y5utICW60udmszn1LRu
         Z5VvtPoPxHib5XB1rpriHa5OwQR6ul/oFgqDqxw7Cq3TKz6MKtTFbjGn5Q08UncePzeg
         yYMUgKvlRK/fJ85c9UzSB1mvORwm5+YTo2mQSG+6Y7+Iywa4gO/IFg7+PmH1s03Zj/6/
         A+HQ==
X-Gm-Message-State: AOJu0Yz6LHh5KxskDAuQwS00GuYIKsyjBoLMXHalXQNpqETS9dpl0lhS
	baws+dcMd6AooP8GOh2K56TELHYFDeLIvDotVTfE9gKgcQLzqhXCSjEqcHZISg==
X-Gm-Gg: ATEYQzz9aQvQlCGgmsFH0SiNgcVFAExpPWa1/gZ6k7+B6GbkXPJTTyjFWCz1FPgJmlc
	vHZViqFJTAlQMEYhauPrfxhmqGrEgqEPKZKOKwI5/nANKsP4tc4+EVNifcBT2b2g3upVddMd29n
	8f4sYVabK5SX/ti6uFaXxk4PJZmeag1aDOnQaSUtQI6Lh5YtG35Qt+JTM/PiNrnJT1/sg7UKR2I
	rz+buguNDVAqw2zSnFYuVnLRsSnSiKB+DZgirn9S07Fvaj1EbPqqC0lNLvwxrhsx9XFrgZ6pi37
	nk6/DUmyuOXxOyNbn/4XVFh2jeWiwqcijbTEDvegs7dw9stXtO2hN87sh+X9NaJjhjojgelurG7
	hFm5e8VKZPgAyK2zT/UqxoGUly7sNfOzwOWVWIgQbqvlv0bgMQ+84IH/Mx/nMLwbH00q0X4HBg+
	IgZbPwtMUBGBnQyA5y34olYkB2qAcLhw==
X-Received: by 2002:a05:6214:495:b0:89a:12da:374e with SMTP id 6a1803df08f44-89a81ec2663mr208595816d6.31.1773727897233;
        Mon, 16 Mar 2026 23:11:37 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.176.149])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c597254a4sm26557726d6.31.2026.03.16.23.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:11:36 -0700 (PDT)
Message-ID: <69b8f098.050a0220.2366fe.d241@mx.google.com>
Date: Mon, 16 Mar 2026 23:11:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4514049515819266598=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: client: add public-broadcast advertise helper
In-Reply-To: <20260317055855.4096-2-raghavendra.rao@collabora.com>
References: <20260317055855.4096-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4514049515819266598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: client/advertising.c:28
error: client/advertising.c: patch does not apply
error: patch failed: client/advertising.h:35
error: client/advertising.h: patch does not apply
error: patch failed: client/main.c:2922
error: client/main.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4514049515819266598==--
