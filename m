Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253725;
	b=VYesiFfax4gH1MXJ/SV6owgx0qDjVp/vvr1KNUbxLvp3eYVStELMn3l550xz2TAvaDDA
	 jqXGWgxnA11yzwMCKwe1CTgYl0UVfnZXvKgbxFugNW5kQ5efXn1LTGmMC5uGQ1TD4WQLu
	 0ZFPDdo0UADZ6/L60UY3aMcO8xpcPIArxl0Q2RAxTWEqNdAkSnJtFpOfanjYV4wNK8viM
	 cZLEz5I0A6VcwnAV5WAsKWTTzG+fYbTVT5ZdYCtlc983BI8x2fsbD65BEcOeEhnsDBIMD
	 roDwc58p50j/LE+YdM4X8AyKXqgRjn8h2uBbHlVyH2mbNpaoAMu/5g31+CbGxyrg+9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EdAvBAcKZJXO5bQEx4evcyI+B32P4syy7lujkQHXbGg=;
	b=E8vwD96JuYC4rbzDTPgOfuljRLei96pWE54aU5RMrFYvFfjeLRgbf5Y8YpsuwCWRf3fp
	 1s85aYoynaKfIHHj9siFFA77wwRAFy1b3D1Ni0H0Q8MtCM04bJ61hBk9FjuD6ruhSuW4F
	 fxm8YGjDgLq7wEW9QsNzWdjBCFUoIir/UM0YRLUNveeLFMjsBmYaXZh6d10knTIKeBRJc
	 6YYROaP4WZDV/DFcb5Wvalp5OrYbl3k+itmp01M6wIVPoW9PZIU0EkK7suc0fbh9UGQO5
	 fON5j46+ZGPKZzZcte0+sVq+z9TEgzj3rfZ7wJWTqjInZwVaWR1oOGinv/Zb1mY8RyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cpDEZWT0;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DCB606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 06:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18DCB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cpDEZWT0
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so10564925e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 23:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793253723; x=1793858523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EdAvBAcKZJXO5bQEx4evcyI+B32P4syy7lujkQHXbGg=;
        b=cpDEZWT0hgSN5bxsND+H+HVmvhlRTYmbsfLYWJlgj+j5CQHKTECdAoNRIKabG/brsN
         YYvzkjVzPxkAny9dEfvnIGkU8soU5Gdc4z6WK482dPcTuo07fVFo/I6MIIE6a+cehczp
         8oPuRsySj7m3EkpyOcB6eijJ6A+J9y9D8DAHA0noxVu6yDSKXntsbbYxKjd4MICjbhLK
         YgGQTbKDHYgl8tZdIKXiZM8SqHsy7gqlgV+H73ZaPyuEamFjZ49NVm2osJQdey0ZRxQO
         cM8eU50d/wYGUFoatPm4Raf2PbCXc1Zk6cyHvlbuScCEj9QtSmS4zW0amVrEMJYt7Cni
         NAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793253723; x=1793858523;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdAvBAcKZJXO5bQEx4evcyI+B32P4syy7lujkQHXbGg=;
        b=FymDe+FJcfJCmU5/NAVIvVgSBJe19hYPly8RANUf3dq+q094O8axEXkkFaaLVG/kKk
         SoZ0qE6Gfo4UPxMAWArbOCQayDown8S6LhGK8EaMgHX2YjoaoViOdAAXILuBYiuEI05p
         IJSCq8HpDbMK9TK9RTdLsfvIItDQVoP/dmBQqtiPsSM9T/fzfbVZa654dODCap0Wc9jZ
         +5UgS3tGNK9NMGLi2FFHh0WdUQRccMURmeRrfeZewkcoLpv+yYm+8+SHCBulUswclGlP
         4exeTdskkifOCA/CvbK43XGhDCMHsNANQHP0Najzzf9Y9KvhCfP/GoCT/UXKktZNh20w
         DqFw==
X-Forwarded-Encrypted: i=1; AKwUvBzPD47nfyk8vgQE8oP7d09q9KIeGOtpUBJw5UV7N0l7PyVV6Zihd1CcKOR3Bo8cI/xYrc6E5OyV/Ao9n+MG1sI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYIBeQ5fM1SSoIJB3aY0aVqd9YJgfFNvR4BwZiybGXJ7GGBArW
	/pajDESVDvqjUECDbhDJ+4L6O8lCNAXrKDwksoYpWovR/pZQfF3en7cc
X-Gm-Gg: AYBFou3rOpPVHl48sTDuUdgL/iGzPKpmiDU19YOD1vTxl9j1f/GYASPqeIP9/yxavNu
	eBwEihNT4z9HmdH6mN0zw6Ylp1R7Ms0mdxjD09tiuyQEn9TCumluWIxkH12Jk43zx1hFOi0AjOO
	6ZgdHlAsAcnxHl3klixtYgZhB1sk8mY7bfhvzoXWLQZ5K1i9n7r8xEXVAz4UTs96f5lrqtMvjoL
	fa0Wtc0K4MC33PDQsSu7UpXgIFHevHzZy7pp/MpmcbwDSsw7NIE0+NeoA+3l/yIFU4zHG91zFJS
	dw0gVKbHZBwxfr7Id1dphHHKFGpl1vz9mhoN1KgOg+oCmIGADn5Z7EF1bTExpaeuGH9g6/sVUBF
	E03OOgidqvWE+cxRcoYd2fT6aZZ3QryBMmy2erZHo+0fe1INfe0Sp5nPXsDSvM0tQFkVD0DUI6H
	oxO4bjiJDOFBR+ziZ/aed53RH/sMb/wyBfRt6vNwWXHyyTV8h8KX4Tl6HjOUTKJXSg/qdrU7HRy
	x5gTp5a/jrUgfQwhBpw4z9BjOZjBobWzpzuqlMULz+DlBcN3ydSvNj79dcW4trb+tlZpimhmhDY
	Z6mOP0YENVWPlU2JeAJMI3lAE1mLmNRj6ndIjRYnhG7hT3ALBlUfA2pJaFVUTBe5
X-Received: by 2002:a05:600c:3b8f:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4a9643d381amr107367955e9.2.1793253722974;
        Wed, 28 Oct 2026 23:02:02 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94f05e4e4sm64585985e9.3.2026.10.28.23.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:02:02 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 59608DC0300; Thu, 29 Oct 2026 07:02:01 +0100 (CET)
Date: Thu, 29 Oct 2026 07:02:01 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Zwerschke <cito@online.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Erik Brangs <erik.brangs@gmx.de>, benh@debian.org,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, 1149377@bugs.debian.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore
 working on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests
 firmware)
Message-ID: <auLhWSOpMQg6cALq@eldamar.lan>
References: <bdafa01c-f75a-41fa-a264-407400a2cd81@leemhuis.info>
 <2026-10-25-1-daily-reply-0004-bluetooth-asus-rtl8761cu-hold@kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026-10-25-1-daily-reply-0004-bluetooth-asus-rtl8761cu-hold@kernel.org>

Hi,

On Sun, Oct 25, 2026 at 07:29:50PM -0400, Sasha Levin wrote:
> > > If it helps, I can send reverts of 980084de4d9b and 6f0624b4427e
> > > (on top of bluetooth.git master, with Cc: stable). Alternatively,
> > > btrtl could fall back to the ROM firmware when rtl8761cu_fw.bin
> > > is missing.
> > I didn't see any regression reports for 7.x releases about those
> > changes, [...] So I'm still inclined to say: leave everything as it is
> > in mainline to avoid any risk and revert only the backports of those
> > two in 6.18.y and 6.12.y.
> 
> Yup, that would be appreciated.

I'm bit lost here :) Who is now going to sen the reverts for the older
stable series? I'm bit worried that it will fall through the cracks,
but at least from Debian point of view given we want to closely follow
upstream stable releases I would pick the revert only in advance once
I know it is already as well in the stable queue for the next release.

Regards,
Salvatore
