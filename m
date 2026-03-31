Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980C318EC9;
	Tue, 31 Mar 2026 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991045; cv=none; b=V+KqTIJUO5ZRNHnIrcpMzE5jMh6s1cy0l5wYRcZOBH7F1G54aOfvLXjMAOgk/m2pcmzHH59Wef4PA3CIS/o5Mmn1u7LdkPr+/RlrCi8eLFaQEkXnnrJOTJGBw3FFDsvlk/Ut6doqffm/0Qd5Jyl+hD36KcE4xMFeA2s3KneEtXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991045; c=relaxed/simple;
	bh=sj6js3886wGHfj5xx6QGKhfnpja05XIyyQKvMY+cRc8=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=NE7o47wEIilV0F8+/H3/lcmzPC3ogKPGYJx46dPtpntjQO51ZOjFgGrjMIQA/VvtP55odN8cOaLZ2+K0SZxSgqTj3p0jWKVICIkO7649S9s2eRXKwwM/yPhPOVTZpoWl1WJTLzLw3E+F/C7NQSGS7sOEq0+fH6rA9P3rgUAd3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=WbHnLido; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N1rpNS0N; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="WbHnLido";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N1rpNS0N"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 83AC1EC010A;
	Tue, 31 Mar 2026 17:04:03 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 17:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774991043;
	 x=1775077443; bh=vxQdo+GsTGHOPhfZ6KDq0AqryyH8iiUIo3Vw21bj1s8=; b=
	WbHnLidoIW2uJNemwQMLAKmulHP7ovrIKEeCf/LVykpvojSwY737G+MhZWwv+rVK
	bC0fzvudtk/i83wzwcgmKhXDQX0DfKTkkUeD6Ht+iOWOVniyAtmgSdL40wr16J8i
	1fp2mtQgn/n0lgl/mAevyCPcZ0t1dlbP1QdEiFfeM0o6OWm02yVkN1bubnd2sVxK
	DxktENQz9opbwzTzQO6X9u+Fs1Y53EEFSTahss+8eXdukzlYe6E86OQXRSmO7ybf
	9M/ybFoTdswaNhzlNBszo0TCXSNWEwqOvO9NjRrRRVGcmxPQCtPo9bb5rKlmb3u9
	NWX7+PkywVu3IktFyKgBPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774991043; x=
	1775077443; bh=vxQdo+GsTGHOPhfZ6KDq0AqryyH8iiUIo3Vw21bj1s8=; b=N
	1rpNS0NIljt6lBHkass/SqUQKRptAEZDWmcEFRkrBKknBQU0eehYAnoD7Np7Edge
	3mjEvEH/gDJIEHzpdZnOBscXXuOC0m+QK7C0sQrwAO7DS6gEMUKSMvM1ft7ZwZJQ
	TrNYoFIZoScyWvgwrZWe9EV0AnbuSU3EtAbHYl7M0LAUaN/VqsEwxBImEuSwzpX3
	ElhcQr7B075b4kcuCmDGz0yZp72bycQHfUkJkSnLFlP9MF81m13hqKLX4IGDWA5B
	R8W9N39y12FwlZ1lYvMwtaqCM1nqeCCozxCSIeOzzshaq6gxfqGzCitaWGNYRqCB
	iTlGHV7x1cJ7Fn+xwytLw==
X-ME-Sender: <xms:wjbMaawEEtpRe7-HS-H1k4HgXYOa8XEupNgiH5i7bvvt8pIZIdO1KQ>
    <xme:wjbMaRFZ_VsKThOkMj-VzSblzkhxZZXqXh46DX3qsHHRm5D0vRyxjFlHMmLnxLWZ3
    HVNKajvhkLfjtHfSX8Mrn_Ph1DVBDvPwghrpAxA52ZZURwP0oJ0a-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopfhokf
    ffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecuhfhr
    ohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtffrrg
    htthgvrhhnpedtudejffejkeekteelueefvdejvdeuhfefteehkeevtddvleduteekleet
    vdelhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hflhhoshhssehjvghtmhdrmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvgh
    hnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehluhgsnhhinhdrihhvrghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgrthhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgrrhgtvghlsehhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhmvgguihgrthgvkheslhhishhtshdrihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopehjnhgvthhtohesmhhinhgvihhrohdrihhopdhrtghp
    thhtohepphhmvghniigvlhesmhholhhgvghnrdhmphhgrdguvg
X-ME-Proxy: <xmx:wjbMaaosQq4Hksquv81s7VGSNdW4bTZ8xFCZH-eBkp6CI-zCuqxB1w>
    <xmx:wzbMaQySBGrkHaBIKT-227T9WR5RuzWhcc1IVk3ZdivdsWoeSJioag>
    <xmx:wzbMaesE0hMsTfirkDkLlQTCGRxT0CZ7P_iI3aTxw404KrFvn8Uy8g>
    <xmx:wzbMaZ245cWpETaqnvIXTd-wD2zx1aRU5CsSAaCSodkc_7UIFzsf2w>
    <xmx:wzbMaX5gXIfDYnYJBNWm2F7U5cHU6zflptQYTRcz5_xWX51S638s9YCG>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DCE821EA006B; Tue, 31 Mar 2026 17:04:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Javier Tia <floss@jetm.me>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 31 Mar 2026 14:58:59 -0600
Subject: Re: [PATCH v5 8/8] Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creator
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>, Ivan Lubnin <lubnin.ivan@gmail.com>
In-Reply-To: 11effdbc-4eff-4430-a22f-3320f84859fb@molgen.mpg.de
References: 11effdbc-4eff-4430-a22f-3320f84859fb@molgen.mpg.de
Message-Id: <20260331210402.DCE821EA006B@mailuser.phl.internal>

Hi Paul,

Thank you for the review.

On Mon, 31 Mar 2026 Paul Menzel wrote:
> > +	{ USB_DEVICE(0x13d3, 0x3588), .driver_info = BTUSB_MEDIATEK |
> > +						     BTUSB_WIDEBAND_SPEECH },
>
> This is not sorted. Is there a reason to place it here?

The placement is a consequence of the series structure - each USB ID
patch inserts after the previous one to keep patches independent and
conflict-free. The existing 0x13d3 MediaTek entries in the table are
also not strictly sorted (e.g. 3560, 3620, 3621, 3622, 3563, 3564),
as they are grouped by chip generation rather than numerical order.

That said, Luiz has already applied v4 of this series to
bluetooth-next with this ordering, so any resorting would need a
separate follow-up patch.

Best,
Javier
