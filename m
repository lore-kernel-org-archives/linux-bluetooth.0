Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0241DE0A
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826109; cv=none; b=QRmaZf1VB5ZHIjM3L9R0OTfROuEeayb6anDqCHpGVdCJhfPIfoB8lXcbZbsesAglroEYvi50JnPwJDHCRxma3d+KLjQLRJgKzZgeKEXKW6DC4dx5gjzP0dXI4DPHRzfPBchO0mbySDQ+iPGl/bYAyQSGLL00QpqNZrw0R7tQjpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826109; c=relaxed/simple;
	bh=AXdyOooEc3hDa63HwNXV9g3HS0K5zwoBhEQ215I6LyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqnX0qeNc38+ybjd0tI+8xerh3G9rWX4X5AvEtVFqS/RMc6WJeyNILF3dWqUocM6xCq7qPMw+WGd3XaqnUSz3JOLwut9b4mWkVOqSH2iSx2TkdBMk+6EaDLZ5GK2K7oov34pw+IXnbCnxAhTvRhICPpZseoWvaJyqqi9KW9j23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdzfDXY8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdzfDXY8"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b060ec084so1318936f8f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791826107; x=1792430907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YveKtGz1EIX08GUJXyM9GGRIHFuaJbA/DcyfZ3t4Uc4=;
        b=sdzfDXY84WUlI/Rjx0/3TOTE0KP0+vd63gknL13AM1rdJfJLV/u4yYhUtlvhPtJUUs
         lYGjfioxJl1JOhQ7ClWZy6xrz1UzjiPZuGXSUO/dkG8N1AuV0bPXKceg+UmktExdavP5
         P69v5Zd7ztAmc42LZUnglhryjxXpdwibbTiL+b4ijR9GS+yZxdmz3oFnd94I7hAI28y6
         C1dDGIspeYH5oLVdODTup1N9G8cY3kvAxzavacNBfM4k8wOYcdiJ9Xd+4+i/2ZRJOAzB
         M4TTDYyKMQQ4T9A4kmMFFj07JinW5Mea+YXvCisg2HwC5ZbmW6dP7G76r7RJ7An48wgp
         vY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791826107; x=1792430907;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YveKtGz1EIX08GUJXyM9GGRIHFuaJbA/DcyfZ3t4Uc4=;
        b=1gX9/lPFcsStG/1YsonaSkaOr0+hX36XQ4ZUEd4T/HFx7A7GLkjKiZZEjGb8PftC6Y
         yFnrXfxq0+juc+L4TFG8izEjO6b8worWHIzyI5YkVtVV+7WxnTx59sssqEt6/zXvOI1i
         LEw0xBetpDfq4a+BXj879IFO/BMXP9GB4HSda+2MxFyP+MCrEhjlOslbcjMjHeO+SPgS
         iP1aqlAKNP29f6DS3j3pbY5BKWqMPjuYjEzI4NLBdMGDM372bg2iykYphViflSjzPO1V
         Hx/3FgoZj/8hgusCxAOTNsZ88iUL59Ny2i9KXGQ7pIK41Tsuw3wobrcC9RSfoHSHFonp
         SiZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHwgnfKqUYsICLl75zTR7D1dzmkuvcDu/wD4/hnmz7eGp6K1mNRuMbpxxqGsJnlFXzfBw/Q20eoabQscVBv/Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2dUIvKu9N8QH0jU68iBVqX/dty0l7cyZ7taqNZV8RgUyyyFlL
	0fNc04iEIgk3J3ocxhf5b3UcLk59UyiIvKTh6HRiEz7uc8SumoLikB3F
X-Gm-Gg: AYBFou0TQ1zR+xfOkV2slb36WMDpKu7kiZq/7thAugBGoWdBEKNqPe+4YY2nIF0ziLK
	u0j2YbbnLGl56mw6Qsx3WzSKuUfbTl0Z2nuhKabBQjL8wMUCH8EQn8KPj5IPrWO/i0u7q3ZC5OQ
	NSN7hoqhHkplV1DNkdJiXLK+7DIc7cEO4jyfxS4ko/f0B9GasZBMk7Lp96EPm3QsRxOMwGic8wY
	aVaAlehodT1UhrxLI5vwmSzSRKsGOeNsoPw6fI/BvTOzlfBiITI95lSAdVHabGV32mXtsxluUC6
	5K9wxVIZ/Btwtq20WsgH/7ScgW55eKusxvT6sGzKBz226hWvwsfRN4atFVMqfXULpj7+ORxsx9x
	4zYrzlWyNBmHfCJP8TtQlVeRMZZ4+mrrvGlcQxUxLOTqVjdFOvSi3ZdRdZes/JU8H9QmWYuDRUz
	+g7XX+7yrNlL779Fpm/yrOtxukjN9fqef3ypTQDnkm1uCgKV+eIWR/rW2kfac+jcsj1bdAkeKH2
	lApHYqDHTn9iRM2vr8lQYhmsBZ4GinaWA==
X-Received: by 2002:a05:600c:310b:b0:4a1:813f:2a5b with SMTP id 5b1f17b1804b1-4a18e4a9da8mr184355265e9.14.1791826106280;
        Mon, 12 Oct 2026 10:28:26 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm480991455e9.8.2026.10.12.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:28:23 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 0CEB6DC09FD; Mon, 12 Oct 2026 19:28:23 +0200 (CEST)
Date: Mon, 12 Oct 2026 19:28:22 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Brangs <erik.brangs@gmx.de>, benh@debian.org,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, 1149377@bugs.debian.org
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore
 working on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests
 firmware)
Message-ID: <as0YtvgukA-Gp-D-@eldamar.lan>
References: <179104011040.2214689.5921682013387867802@eldamar.lan>
 <2026-10-04-1-daily-reply-0007-bt540-asus-firmware@kernel.org>
 <24ce058a-28b5-4499-9ded-eec9544b80ec@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ce058a-28b5-4499-9ded-eec9544b80ec@leemhuis.info>

Ciao Thorsten,

Thanks for looking into this regression as well.

On Mon, Oct 12, 2026 at 02:00:18PM +0200, Thorsten Leemhuis wrote:
> On 10/4/26 18:29, Sasha Levin wrote:
> >> In Debian Erik Brangs reported that after the update from 6.12.107 to
> >> 6.12.111, specifically with the backport of 980084de4d9b ("Bluetooth:
> >> btusb: Add ASUS USB-BT540 for Realtek 8761CU") Bluetooth is not
> >> anymore working, the full report is found at
> >> https://bugs.debian.org/1149377 .
> >>
> >> | [   38.138881] Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8761cu_fw not found
> > 
> > The stable code matches mainline. The failure is a missing firmware file:
> > rtl_bt/rtl8761cu_fw.bin has been in linux-firmware only since 20251111,
> > and Debian trixie's firmware-realtek 20250410-2 does not have it.
> > 
> > Marcel, Luiz: could you, or Christoph Zwerschke as the author of the ID
> > commit, send an upstream revert, or a fallback to ROM firmware when
> > rtl8761cu_fw.bin is missing? Stable will take it for 7.2, 6.18 and 6.12
> > through the normal Cc: stable route once it is in mainline.
> 
> Hmmm, that was a week (granted: with the LPC) ago and nothing happened.
> Anyone working on this?
> 
> If not: Should we revert 980084de4d9b and its backports? Or only the
> backports to older stable series?
> 
> Strictly speaking it should be the former due to our policies wrt to
> firmware -- but I guess most users of a more recent kernels also have a
> newer firmware, so I wonder if reverting the change might do more harm
> then good now.

If my understanding is correct from a earlier fixed regression in the
ariea, aka
https://lore.kernel.org/regressions/0fd8c1c9-7f56-4bcb-a727-e4386d8ef094@online.de/
should then not only 980084de4d9b ("Bluetooth: btusb: Add ASUS
USB-BT540 for Realtek 8761CU") be reverted, but as well along
6f0624b4427e ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek
8761CU") and as well 4a23ce935f74 ("Bluetooth: btrtl: Add the support
for RTL8761CUV")?

Regards,
Salvatore
