Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B343F091;
	Mon, 10 Aug 2026 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786392552; cv=pass; b=ILWujIQ+Mt6/nQTwqRp8+Ky5c2ZXNuODQCG2qS012GYdJhrXRinCdwk7sW1I3On0RgjU3oe9IRAPpIWt5MfIPbqwR4NXiAbnO8d3pxVyY+E2TWm4cDcJ0X+l0bFu9g9ve1VCepbQBpDQ51A5iYa+IQq2JUr2WVtWBKXW27gsDXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786392552; c=relaxed/simple;
	bh=WCCozJMhPP9/XuvSdx1lJY7SXkHp+hfMkQ8pVgig8s0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=hcQbqH7OQyIDXV+/a5VFFPKzUBa9ouTtbYAasjzJt987D0p57mVL1S40YJAZkemJWWStZ/fuf5gaPIJiYaePGkNFgvNK6TEIVU2S6vditA/T3AxF/KeTPD5C+TtJPLJnjXL0edjDjnXzEaRQRoq7ypdrfUctchcHOXi6A4VaAEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Owh4u13Y; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Owh4u13Y"
ARC-Seal: i=1; a=rsa-sha256; t=1786392531; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Tm0PUocv/gi2E6HcqYTQT2pDn6KnObWb7LePlfoVSlX1p14pKnfF/fwNp+ORfSQQ3MpZCd0QmGSDz/TagA6F6VKoIVTQa8fU/QN4LYpwWvtHzy1TlilhCDF6IY74tnsb7zSsuTDFi6fTUFkHebOuLu3m8OmE3gNtojL8dGHGxaA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786392531; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aghQrEuv07Kg/49XIOsAMbUc4OCdIaCvXcCyXwdlBcU=; 
	b=nIy+4B/HkFkqTW0IzpUNHE2CCy1o+ksIhCbzllmNl/rJxg4ovu1dnJoXNyxxFMCc29h8/sglY/faBWKKDcWKGl2iW46cCinvmuRM373DB3Ttp/jWV4jz+XHuXqesD4EpBcAkGvAliymw64FCWpwnGt/drN9zwGgZ4zX+USPyH+g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786392531;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=aghQrEuv07Kg/49XIOsAMbUc4OCdIaCvXcCyXwdlBcU=;
	b=Owh4u13YFFu/6vVccwUniknonGozUe9TD9M7C9qozuX8PByHKY1PZeimVCG2zmNf
	oyH3Q6Ds66IZWHjTHa+btnG5rtyom6UnvD61NHylPxxoFWIPULAlm74epQLzyszJie4
	EcsufKSzTTyou6vllmatKSiCKrN8nlz2k7EvgiAmb0tOswaAcV/JbS8w+zS+Vv+gsxV
	MZSY4c095GHRx6tQZm+SgpsvAA7+JjbafNb2+TIiuK2zV/PGZFiHZvgv6WL58DD3p82
	7RWrXz9tDdg1bBHfuGxGNDTsQxkVUsLG84t0oSBiTOvlyGXT2Bane23FMd1HkzAhaWB
	ff3FypMz1Q==
Received: by mx.zohomail.com with SMTPS id 178639252844422.461369694751397;
	Mon, 10 Aug 2026 13:08:48 -0700 (PDT)
Message-ID: <868e97331dc74f176db2d3efdd1c579049b8e493.camel@rong.moe>
Subject: Re: [PATCH] Bluetooth: btmtk: Disable remote wakeup for
 MT7922/MT7925
From: Rong Zhang <i@rong.moe>
To: Michal Pecio <michal.pecio@gmail.com>, Chris Lu
 =?Big5?Q?=28=B3=B0=B8X=AAl=29?=
	 <Chris.Lu@mediatek.com>
Cc: Alberto Garcia <berto@igalia.com>, sean.wang@kernel.org, 
 "luiz.dentz@gmail.com"	 <luiz.dentz@gmail.com>, Will-CY Lee
 =?Big5?Q?=28=A7=F5=ACF=BFo=29?=	 <Will-CY.Lee@mediatek.com>,
 "marcel@holtmann.org" <marcel@holtmann.org>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, SS Wu
 =?Big5?Q?=28=A7=C5=BE=CB=AAY=29?= <ss.wu@mediatek.com>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"	
 <linux-arm-kernel@lists.infradead.org>, "linux-bluetooth@vger.kernel.org"	
 <linux-bluetooth@vger.kernel.org>, "patchwork-bot+bluetooth@kernel.org"	
 <patchwork-bot+bluetooth@kernel.org>, "linux-mediatek@lists.infradead.org"	
 <linux-mediatek@lists.infradead.org>, "matthias.bgg@gmail.com"	
 <matthias.bgg@gmail.com>
In-Reply-To: <20260809223320.24431a4a.michal.pecio@gmail.com>
References: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
		<178050901239.1520440.2026593395539384648.git-patchwork-notify@kernel.org>
		<3f9c376a5dbfc9d737e2a7f83c5db8e591fb8793.camel@mediatek.com>
		<17FE08E9-2229-4C97-846F-6FA099E22C90@rong.moe>
		<CABBYNZ+rR71SKUEuZBTf+E3SwRNzV2-s-zt8EwNJM3PSx9qB_A@mail.gmail.com>
		<fd8587e97a48e49332a4ad36e51e18739d000250.camel@mediatek.com>
		<4e96132bcfb267af05c06dc277b5ba6895e3ddde.camel@rong.moe>
		<99fb847b8fdedb1464798230407719912d6585c6.camel@mediatek.com>
	 <20260809223320.24431a4a.michal.pecio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 04:03:38 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Michal,

Thanks for your insight.

On Sun, 2026-08-09 at 22:33 +0200, Michal Pecio wrote:
> On Mon, 29 Jun 2026 03:01:19 +0000, Chris Lu (=E9=99=B8=E7=A8=9A=E6=B3=93=
) wrote:
> > Hi Rong,
> >=20
> > Thanks for your understanding. We hope to find a better way to handle
> > this issue.
> >=20
> >=20
> > Hi Luiz,
> >=20
> > Regarding this issue, MediaTek Bluetooth team has already initialed an
> > internal investigation for problematic combination and will seek
> > assistance from AMD SOC team to investigate the root cause of this
> > issue.
>=20
> Hi,
>=20
> I have seen multiple reports on Arch Linux forum of MTK Bluetooth chips
> sporadically locking up and no longer enumerating on AMD systems, also
> desktops, which had to be unplugged from power to restore operation.
>=20
> I have also seen claims that auto power management is broken in btusb:
> https://lore.kernel.org/linux-bluetooth/cover.1774348119.git.berto@igalia=
.com/T/#u

I believe the proper fix of autopm failure during initialization is
https://lore.kernel.org/linux-bluetooth/20250319231235.812700-1-sean.wang@k=
ernel.org/

Some time earlier this year I was planing to pick it up and push it
forward, but it turned out I was too busy. Maybe I will find some time...

That being said, the bug I encountered has nothing to with the device
initialization though.

>=20
> This, if true, offers a plausible theory because:
> - URBs issued to suspended devices may fail, drivers may not notice,
>   make wrong assumptions about their HW state and confuse the chip
> - USB core doesn't reliably block submission of such URBs

Not the case of my devices. Autosuspend and (non-remote) autowakeup
always work fine. The only thing that triggers the bug is a random[1]
remote wakeup.

Usbmon always shows no URB between the autosuspend and the subsequent
remote wakeup, expect for the interrupt from the root hub.

[1]: it happens when no Bluetooth device is trying to establish a
connection.

> - they were also seen to break some xHCI controllers, in theory this
>   might be an HC problem - power cycling resets both device and HC

I also think this might be one of the reasons.

Thanks,
Rong

>=20
> Regards,
> Michal
