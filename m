Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE703BAD95;
	Fri, 26 Jun 2026 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472773; cv=pass; b=iJZoGSFmc5GcXnORLvWKOVICvwopuyUHy09o64WwgSTVlrK7AaG1HczmdFEwUeLRBpnmneFNNgxctmFXGBurQ2Xf5lAI5RKfMvu1Zx8tVD32ppQbJmOC8qlk+/DSYdGs/D186Gyw7JA9VEigE/pY08GpdDTXuJ+I9ruuSk4fCNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472773; c=relaxed/simple;
	bh=Xuly9O0tAMSVu+2hyLKWHwTaD+lUumrMQlikUH/DvvM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ApVg1W3rOWwmnHLHzq717yTEwWDxVVRLU1VHsQPU78i6jCnce5IXkPgGnGmy0T0ybs3PNw2DXgJ3zv3QS+gFyqj4MANCMyHhfI6zgyFky2NRa9g7hwCwJnEeU8tdxk5bnWQUKOr5fmCGTXiSxnHWOiGR/HsHFNq2mSS40Ngobpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=UOYFlsAJ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="UOYFlsAJ"
ARC-Seal: i=1; a=rsa-sha256; t=1782472758; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g8AUlxrBF5LH1GVl4lbltQSlbHrBtU+213LJQo5t+QW0EbW/YPv83nBSa8PkdbpQmX+vlVt7yl+FiQZlTVbx8T6scTC0OYIlUcfCKP+GYuphXNqVVr9NxVwVCxrT725U1BJUQefRwkeOGpPfm4CC8vE4jzQ7icbfL64n/bDlN0s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782472758; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Xuly9O0tAMSVu+2hyLKWHwTaD+lUumrMQlikUH/DvvM=; 
	b=kk47VyBMA9hd2okHqdwPc5hvmRv4AlSYFHEW7VIEeEt7ZljEZD5AWvn7AREOtXU2Ex9lNuuC1HLEPlHhCJJWgUJSLnHuI6Cey8ceBhQijiGfBH76tfJj732BrEtqLs3Xr28S7+rgnnxiehDWHqHjwYkuaxjStBO25ZAItT9B2pY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782472757;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Xuly9O0tAMSVu+2hyLKWHwTaD+lUumrMQlikUH/DvvM=;
	b=UOYFlsAJ4DQ/kmhSh5cHu2StIi3xJxPNds8AsvqRmV4iXu0AruvmZo29XeTfjfHZ
	q+8NskdgpCDSCeO9GEZA0GGj32fR2GLNmCmqcP84YJI6utuaLSRIdEESGIqR/7uq+Y4
	eAhkEeCEWyV3MU2H05CcB/JI/mQWP6So2P4gFm1d+tZXLpgGyeJPsfOLfmWizm8vkUx
	+UCJJcOjFhzNEbzHz0ikg+EBiF0jyJSx+wPt7uWahPs85JlGkEE2HUgTv+MULTrID7t
	wCLKzMRimxNy9cFdMksGnQmhSbjb40zsBdhf4CZZNKId92yoIxmsHuooUM+TKOY+kzN
	by9nK4CC5w==
Received: by mx.zohomail.com with SMTPS id 1782472755335165.29894146156312;
	Fri, 26 Jun 2026 04:19:15 -0700 (PDT)
Date: Fri, 26 Jun 2026 19:19:06 +0800
From: Rong Zhang <i@rong.moe>
To: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 "patchwork-bot+bluetooth@kernel.org" <patchwork-bot+bluetooth@kernel.org>,
 "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
User-Agent: Thunderbird for Android
In-Reply-To: <3f9c376a5dbfc9d737e2a7f83c5db8e591fb8793.camel@mediatek.com>
References: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe> <178050901239.1520440.2026593395539384648.git-patchwork-notify@kernel.org> <3f9c376a5dbfc9d737e2a7f83c5db8e591fb8793.camel@mediatek.com>
Message-ID: <17FE08E9-2229-4C97-846F-6FA099E22C90@rong.moe>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi Chris,

=E4=BA=8E 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 GMT+08:00 10:40:54=EF=BC=8C"C=
hris Lu (=E9=99=B8=E7=A8=9A=E6=B3=93)" <Chris=2ELu@mediatek=2Ecom> =E5=86=
=99=E9=81=93=EF=BC=9A
>Hi Luiz,
>
>Could we revert this change?

Please don't=2E The fundamental goal of the patch is to make MT7922/MT7925=
 *usable* on affected platforms=2E

Moreover, almost all recent AMD platforms ship with MT7922/MT7925, reverti=
ng this patch affects quite a lot of users=2E Almost every AMD platform I'v=
e met suffers from the issue, and there are plenty of bug reports=2E

Intel platforms never ship with MTK WLAN NICs, so I can't tell if the issu=
e is reproducible on them=2E

>
>Sorry, MediaTek wasn't aware someone submitted this change and it had
>already been merged=2E
>
>MTK believes this issue is strongly related to the platform's USB hub
>behavior,=20

Still, I believe that there are some interoperability issues in MT7922/MT7=
925's hardware or firmware, as reinitializing the XHCI root hub (by logical=
ly removing it from the PCI bus and probing it again) doesn't make it recov=
er at all=2E

> The product lines MTK directly support haven't reported such
>issue=2E

=2E=2E=2Eor did you mean none of the existing AMD platforms are supported =
by MTK?

>
>Disable wake capability would severely impact wake on Bluetooth on
>MTK's official product lines=2E

Could you kindly explain "MTK's official product lines"?

> Furthermore, this patch looks like a
>workaround=2E There should be a better way to handle this issue=2E We hop=
e
>this change can be reverted=2E

The issue is severe on affected platforms by making the Bluetooth interfac=
e completely gone=2E IMHO, we must figure out the "better way" before rever=
ting it, or else it's more like burying your head into sand by shouting "wo=
rks fine on our platforms" (TM)=2E

That being said, I think we can narrow the range of the quirk down to AMD =
platforms only=2E Does it make sense to you? If so, I will submit a patch f=
or this=2E

Thanks,
Rong

>
>
>On Wed, 2026-06-03 at 17:50 +0000, patchwork-bot+bluetooth@kernel=2Eorg
>wrote:
>> Hello:
>>=20
>> This patch was applied to bluetooth/bluetooth-next=2Egit (master)
>> by Luiz Augusto von Dentz <luiz=2Evon=2Edentz@intel=2Ecom>:
>>=20
>> On Wed, 03 Jun 2026 02:38:10 +0800 you wrote:
>> > These NICs are often reported to lose their Bluetooth interfaces,
>> > i=2Ee,
>> > their USB interfaces suddenly become completely unresponsive,
>> > causing
>> > the USB core to reset them, only to find that they are no longer
>> > accessible=2E A power cycle is required to make the Bluetooth
>> > interfaces
>> > recover=2E
>> >=20
>> > After some investigations, I found that their USB autosuspend
>> > remote
>> > wakeup capabilities are so broken that they are precisely the
>> > culprit
>> > behind the issue:
>> >=20
>> > [=2E=2E=2E]
>>=20
>> Here is the summary with links:
>> =C2=A0 - Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925
>> =C2=A0=C2=A0=C2=A0 https://git=2Ekernel=2Eorg/bluetooth/bluetooth-next/=
c/247570151789
>>=20
>> You are awesome, thank you!
>
>
>Best Regards,
>Chris Lu
