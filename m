Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3533D7D86
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307608; cv=none; b=DzD4asZsicuhkGzmRkmn/kWloO5LAA1MMYo158nz8y+fQxicEE0Y8YMGkmWkaO8ph+paWXG3bDr/ksQ9LpSip5MvzCNhSY2UnCVTSdcGDL7av1NFQMSJ8vtyf1cvu4c+9PZbYrNl1Skec4RWdELDtRjboVKr2tenm03QLq6pNLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307608; c=relaxed/simple;
	bh=4agbAAkAGD3oMiSpZdvKCh60G24wNAGbSC0k/Kyiixc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSpif7CJUDI5kYRihS/JCIGw6LfCDFIk91p/gOEiUUkDBYrZY+FU6TVA4LYMfbPkgsX0m040ClEEihHL9TUl0k4CKOIvI2DzQ0ZXul0bSGvm/x2akE7KTC98vyKtaym1VVlwc49fmCUfcbNfrGa6km2XN91EKGI20so5vol2k1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSWHqKVp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSWHqKVp"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-480001972b8so403533f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Aug 2026 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786307605; x=1786912405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JKlBoJdds1FSyyPDGWKzuyJx/ZI/SpDQ5zKS7eJFwdA=;
        b=SSWHqKVpumtPqCiZRNRH7l6sDPzFPvLavFh23s5jod4Cr7jA+DM5QlqPQ2UsTl095Y
         U4I6Afvq9meksCIikuhUDB1TzjHVLiFSHimr45WBY/KGmXznCRCGbjbaysbKzddGQGv5
         TDYKNbqYOxAWbaUogQETof6LZapGUsOYvm4qyr5ZIoCqNjvF3phlnptTRvSb8D/N1Kc8
         L0ORck1wwAqdWm02b5TD3ZHiKtXcSZUF29vB8PDVXT1CifUAbrv81aS0hFL92nPfEVN5
         t7/3wDH7glJVxmXJ4DkaslBve6PHb3wuf+brM4hs/kLkCLio0UmT6/Qzf4cgbjNWtnuf
         qVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786307605; x=1786912405;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKlBoJdds1FSyyPDGWKzuyJx/ZI/SpDQ5zKS7eJFwdA=;
        b=eCpFYPU5esYpgnM7JodtjC/T4NP6oGt22jTmqkG8DSvKPEh2TJmw4n4YjZxhRtnzMM
         JnWTxECqXVZ2UmWaj3tCAlGpYMvY7cQroL26f3iViX9jak/luIOf/2zmmMbJ31CchvQI
         Kl5YcCAu4P09PBkwqUjKqcSgcRGGP6ixGuxfz2afHrjNNCTpb1g6I5+Lj9CMGaUgEABa
         KjRrb3mbWVzKteY0QMzvWLPvKK3FinLQEfWMtNp+Iwq3DE3Gh32HNkJ79/9PtRhPohwn
         Xho4fxPKZepUQufnGl3IF7OOrr9ax9qAtZy/4SYxqwfaiSamvh4UlQAZH5Apv8EJ7fo1
         dazQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5f4Y6hfYvINSF1ZJeR+jxfbdLbVmD57cu5Pk4B+oRw9sTWNU0Bb4d1brDPpcxrU/EORqkJOmw1+VaOs2EcGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOATKvVrjosKCxuxiFAKmvVagIfdMycLqmE2Dr5LQGa1uA1DBu
	GT8/8eAwBw19jJLt5n6r0w8zhybdB2t+CX1nSfZ26G+h/Kiox87azLxt
X-Gm-Gg: AR+sD12siVz/g1ESk4Mcpzl70hcPHWODnJhHh+HiP3cCqOlAhUIERQAOxGhJDXVTjEU
	njFkFZl0ujgCNYsHyOAOMOQrDb54x5Qhc1HvKuNXymZHYCv3cylWBdmIuJpkLCd7AItxJU7K+N8
	LkHnxKnVwxQ6Gtkg/8RpQDZ8W3V7ZvETJDfRq15+DQ/iCqZozQwVO3QZTpbqwZOlMniAzkBanXA
	i3DLu3lNI6aoFarLzuu8Tb1U/PUU59i1W7MtoeUfmWp2/89qypYG5c7GjIssusfmAYOAafB3WAq
	HCd0GFJCQgtLFDSztuDavhEBefQatFsRkpaOh+ITm8IVWvwymAKEr3ObF/LGiosYGd62nWE1Ddo
	FN9Ja03Fyi6iYEmJZM29SljeYkkFJY4z30XcJQK+sYEA2e1WE0DBWLNF04vyj6mrIjljvgG/4GV
	vVR1oNJonJW2AzYyBzxejTccKXTmMEAEsy2TgGNLPvTMdO9otA5kgmYGIw9yQlf35y+3/P/QdMy
	0pEUKn8Arc=
X-Received: by 2002:a05:600c:8b35:b0:493:c634:952 with SMTP id 5b1f17b1804b1-4994e79e668mr477347155e9.7.1786307604765;
        Sun, 09 Aug 2026 13:33:24 -0700 (PDT)
Received: from foxbook (bgt135.neoplus.adsl.tpnet.pl. [83.28.83.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995dee21dcsm231804045e9.0.2026.08.09.13.33.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Aug 2026 13:33:24 -0700 (PDT)
Date: Sun, 9 Aug 2026 22:33:20 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: "Chris Lu (=?UTF-8?B?6Zm456ia5rOT?=)" <Chris.Lu@mediatek.com>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "i@rong.moe"
 <i@rong.moe>, "Will-CY Lee (=?UTF-8?B?5p2O5pS/56mO?=)"
 <Will-CY.Lee@mediatek.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "SS
 Wu (=?UTF-8?B?5ber5oay5qyj?=)" <ss.wu@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-bluetooth@vger.kernel.org"
 <linux-bluetooth@vger.kernel.org>, "patchwork-bot+bluetooth@kernel.org"
 <patchwork-bot+bluetooth@kernel.org>, "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Disable remote wakeup for
 MT7922/MT7925
Message-ID: <20260809223320.24431a4a.michal.pecio@gmail.com>
In-Reply-To: <99fb847b8fdedb1464798230407719912d6585c6.camel@mediatek.com>
References: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
	<178050901239.1520440.2026593395539384648.git-patchwork-notify@kernel.org>
	<3f9c376a5dbfc9d737e2a7f83c5db8e591fb8793.camel@mediatek.com>
	<17FE08E9-2229-4C97-846F-6FA099E22C90@rong.moe>
	<CABBYNZ+rR71SKUEuZBTf+E3SwRNzV2-s-zt8EwNJM3PSx9qB_A@mail.gmail.com>
	<fd8587e97a48e49332a4ad36e51e18739d000250.camel@mediatek.com>
	<4e96132bcfb267af05c06dc277b5ba6895e3ddde.camel@rong.moe>
	<99fb847b8fdedb1464798230407719912d6585c6.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2026 03:01:19 +0000, Chris Lu (=E9=99=B8=E7=A8=9A=E6=B3=93) =
wrote:
> Hi Rong,
>=20
> Thanks for your understanding. We hope to find a better way to handle
> this issue.
>=20
>=20
> Hi Luiz,
>=20
> Regarding this issue, MediaTek Bluetooth team has already initialed an
> internal investigation for problematic combination and will seek
> assistance from AMD SOC team to investigate the root cause of this
> issue.

Hi,

I have seen multiple reports on Arch Linux forum of MTK Bluetooth chips
sporadically locking up and no longer enumerating on AMD systems, also
desktops, which had to be unplugged from power to restore operation.

I have also seen claims that auto power management is broken in btusb:
https://lore.kernel.org/linux-bluetooth/cover.1774348119.git.berto@igalia.c=
om/T/#u

This, if true, offers a plausible theory because:
- URBs issued to suspended devices may fail, drivers may not notice,
  make wrong assumptions about their HW state and confuse the chip
- USB core doesn't reliably block submission of such URBs
- they were also seen to break some xHCI controllers, in theory this
  might be an HC problem - power cycling resets both device and HC

Regards,
Michal
