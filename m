Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6715E5BB;
	Fri, 26 Jun 2026 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782503911; cv=pass; b=cNfmF9wOv6bxBY1YcJ+/CR1xh7OH9eywqNH32Ea5Zy5uPXYdveE3BWeFth7+FR88hbccEynEuoUP56HR0mQzi0ujzHMkmDLh70am/F8/jf421bWM/Kt7Qx88SSO6+hkt0Hilfpzhx/oSyCCZ10kVEbGtRbZWpG6oL00bES9mp5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782503911; c=relaxed/simple;
	bh=hN6IJrxrkBeM+8JFP5IBkHknLb1SWS3twmt3qdin/0U=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=N+wjL5IL2BRydv7OLgeyjc1k4w/M/PVBBMlSGmVgesFHAxRf7L8y8b5cGhO1KfplIrp7vWwz19sNd6n6dc5t9ar3/pM5MCEkXSDY7xSbLq6J1C9kDTSSN6Bd2xj0syO+AaLgLvyXeV2qzrLRiynp0g0p7FiPRiGG5P9BggVtrXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=IP/eqXj9; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="IP/eqXj9"
ARC-Seal: i=1; a=rsa-sha256; t=1782503894; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D3WZsCftahOcMt4cxKE8kIy3vHriVPJPnKUPnh8TUb+BgXjDnK5xKTeOwa4HCNB1DC3Ep33o256HPWq79ViBnTMoDbFe0iVYvxUzlAHu0La1cQXkWqRpvy5r6FJ1Qz+xT+jtotwbPhsZhBVNX/OJsc60h/cBGQHStt92JvtauNk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782503894; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q2IKUBOjt0LLv1AclgrcUtUEkkgxk7U1S1o+izpivZM=; 
	b=hlbDxphJYgUIeqgUFmtVBIi8eI5XeJcBXjXmBnQMWRaenqfkQw7/jWHxXB7nbMbtDBBrL4FPyGY4nL8u9OAHNUYmTj6XrN9mGPWqYLrtYwoRk6omt8QFiOU+7MkuoUBY9lJ0pNYsA6bZ0Zi8+HMOuACN/xnepnB80yfy/1xGigI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782503894;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=q2IKUBOjt0LLv1AclgrcUtUEkkgxk7U1S1o+izpivZM=;
	b=IP/eqXj9LaZbSwoZ+aUFHMNf6IRTAjnG5jLWdv1XxZVhgU6mMLc1woFm1XdMrl26
	+pykSvpr5QQg4Z/UTtctPjAty0yauWOGz/9TouvKEOX+Go9Fuox6yuczQLQfGk72uir
	CYdhds8x2b+QUYfjOMsThqJiNWk10M7BJtvc1Ik091ogbCtQ/EkzU+oJwIM7FtyG04b
	766vU8hNA0Ijde6vXNRrgTnl7p1L4180KX9jD/zQ7tamxZSkCYqJ/KmK5ZOendQabNF
	KZKg5IRJOswoLRjmTCiornuVnxY21iO5l4mz45LmwSn6EY16+5mrrykL2voHTxui1Y2
	Wnmbp0p9qg==
Received: by mx.zohomail.com with SMTPS id 1782503892877670.3110593257745;
	Fri, 26 Jun 2026 12:58:12 -0700 (PDT)
Message-ID: <4e96132bcfb267af05c06dc277b5ba6895e3ddde.camel@rong.moe>
Subject: Re: [PATCH] Bluetooth: btmtk: Disable remote wakeup for
 MT7922/MT7925
From: Rong Zhang <i@rong.moe>
To: Chris Lu =?Big5?Q?=28=B3=B0=B8X=AAl=29?= <Chris.Lu@mediatek.com>, 
 "luiz.dentz@gmail.com"
	 <luiz.dentz@gmail.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>, AngeloGioacchino Del Regno
	 <angelogioacchino.delregno@collabora.com>, SS Wu
 =?Big5?Q?=28=A7=C5=BE=CB=AAY=29?=
	 <ss.wu@mediatek.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-bluetooth@vger.kernel.org"
	 <linux-bluetooth@vger.kernel.org>, "patchwork-bot+bluetooth@kernel.org"
	 <patchwork-bot+bluetooth@kernel.org>, "linux-mediatek@lists.infradead.org"
	 <linux-mediatek@lists.infradead.org>, "matthias.bgg@gmail.com"
	 <matthias.bgg@gmail.com>
In-Reply-To: <fd8587e97a48e49332a4ad36e51e18739d000250.camel@mediatek.com>
References: <20260603-btmtk-remote-wakeup-v1-1-5c1006442f36@rong.moe>
		 <178050901239.1520440.2026593395539384648.git-patchwork-notify@kernel.org>
		 <3f9c376a5dbfc9d737e2a7f83c5db8e591fb8793.camel@mediatek.com>
		 <17FE08E9-2229-4C97-846F-6FA099E22C90@rong.moe>
		 <CABBYNZ+rR71SKUEuZBTf+E3SwRNzV2-s-zt8EwNJM3PSx9qB_A@mail.gmail.com>
	 <fd8587e97a48e49332a4ad36e51e18739d000250.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:56:59 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10 
X-ZohoMailClient: External

Hi Chris, Luiz,

On Fri, 2026-06-26 at 17:56 +0000, Chris Lu (=E9=99=B8=E7=A8=9A=E6=B3=93) w=
rote:
> Hi Rong and Luiz,
>=20
> On Fri, 2026-06-26 at 12:54 -0400, Luiz Augusto von Dentz wrote:
> > Hi,
> >=20
> >=20
> > On Fri, Jun 26, 2026 at 7:19=E2=80=AFAM Rong Zhang <i@rong.moe> wrote:
> > >=20
> > > Hi Chris,
> > >=20
> > > =E4=BA=8E 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 GMT+08:00 10:40:54=EF=BC=
=8C"Chris Lu (=E9=99=B8=E7=A8=9A=E6=B3=93)"
> > > <Chris.Lu@mediatek.com> =E5=86=99=E9=81=93=EF=BC=9A
> > > > Hi Luiz,
> > > >=20
> > > > Could we revert this change?
> > >=20
> > > Please don't. The fundamental goal of the patch is to make
> > > MT7922/MT7925 *usable* on affected platforms.
> > >=20
> > > Moreover, almost all recent AMD platforms ship with MT7922/MT7925,
> > > reverting this patch affects quite a lot of users. Almost every AMD
> > > platform I've met suffers from the issue, and there are plenty of
> > > bug reports.
> > >=20
> > > Intel platforms never ship with MTK WLAN NICs, so I can't tell if
> > > the issue is reproducible on them.
> >=20
> We still have non-AMD platforms with MT7922/7925, where=C2=A0
> "wakeup by Bluetooth" is an essential feature. In other word, this
> change will have a serious impact to them.

Oh, perhaps I missed something before. Your words were a bit unclear to
me at first glance.

You previous reply said "wake on Bluetooth". I interpreted it as USB
remote wakeup upon Bluetooch device connection.

"Wakeup by Bluetooth" is clearer. You meant using the Bluetooth
interface as a wakeup source to wake up the system from sleep, right?

Hmm, it makes more sense to me.

My patch was inspired by commit f4292e2faf52 ("Bluetooth: btusb: Make
the CSR clone chip force-suspend workaround more generic"). The
mentioned commit is correct as the quirky chips can't perform remote
wakeup at all.

If MT7922/MT7925 can reliably wake up the system from sleep, my patch
could be a burden. I won't insist anymore if you'd like to revert it.

>=20
> > We cannot really remove it anymore, since it has already been pulled.
> > Therefore, I strongly prefer that the issue is fixed somehow or if
> > there is no other way then a proper revert patch must be sent, since
> > I
> > don't have any hardware with this controller I cannot really test
> > this
> > myself.
> >=20
> Got  it.
> > > >=20
> > > > Sorry, MediaTek wasn't aware someone submitted this change and it
> > > > had
> > > > already been merged.
> > > >=20
> > > > MTK believes this issue is strongly related to the platform's USB
> > > > hub
> > > > behavior,
> > >=20
> > > Still, I believe that there are some interoperability issues in
> > > MT7922/MT7925's hardware or firmware, as reinitializing the XHCI
> > > root hub (by logically removing it from the PCI bus and probing it
> > > again) doesn't make it recover at all.
> > >=20
> > > > The product lines MTK directly support haven't reported such
> > > > issue.
> > >=20
> > > ...or did you mean none of the existing AMD platforms are supported
> > > by MTK?
> > >=20
> I'll report it to corresponding department to see if they have such
> issue. (I'm not from Bluetooth with AMD platform support team)
>=20
> > > >=20
> > > > Disable wake capability would severely impact wake on Bluetooth
> > > > on
> > > > MTK's official product lines.
> > >=20
> > > Could you kindly explain "MTK's official product lines"?
> > >=20
> Some products are module makers selling our modules to downstream
> customers directly.
>=20
> > > > Furthermore, this patch looks like a
> > > > workaround. There should be a better way to handle this issue. We
> > > > hope
> > > > this change can be reverted.
> > >=20
> > > The issue is severe on affected platforms by making the Bluetooth
> > > interface completely gone. IMHO, we must figure out the "better
> > > way" before reverting it, or else it's more like burying your head
> > > into sand by shouting "works fine on our platforms" (TM).
> > >=20
> > > That being said, I think we can narrow the range of the quirk down
> > > to AMD platforms only. Does it make sense to you? If so, I will
> > > submit a patch for this.
> >=20
> As I mentioned above, we have many platforms using the kernel driver,
> not just AMD,
>=20
> If this change can be limited to specific platform , it would be the
> best way so far.

I plan to submit another patch to properly fix it next week. In general,
I will:

- narrow the quirk down to AMD platforms only
- disable USB remote wakeup for runtime autosuspend only
- leave the wakeup source as is, so users can enable "wakeup by
Bluetooth" even on AMD platforms if they really want it

Hopefully it will minimize the impact of the workaround.

Thanks,
Rong

>=20
> > Ok, then you guys please coordinate. I don't want to start requiring
> > Sign-Off-By (SOB) from driver authors because this instance shows
> > that
> > response time can be very long. Therefore, the best way forward in my
> > opinion, is to have the issue fixed in a way that works for both of
> > you.
>=20
> Of course, Mediatek BT team also agree that any issue need to be
> resolved, However, original issue for this change requires further
> verification of Hardware/firmware and even USB behavior. A device that
> can reproduce the issue stably is required in order to experiment and
> identify the root cause.
>=20
> As mentioned, I'll deliver internally to relate support team. If they
> have similar settings, MTK will attempt to reproduce it and provide an
> official solution.
>=20
> Thanks very much for your input and understanding.
>=20
> Best Regards,
> Chris Lu
