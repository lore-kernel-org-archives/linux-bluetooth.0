Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B334214A64
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484630; cv=none; b=ZeRGyRaLj9H83Ofc8jblWE7yThKXGNNyHRFhUazfVQgeuOmLniikASWEJbhULKhDKp7wbHkH+9SQArsJP4Mf5zp+VylYjQytf3/SX4rjRiJQO/E4zNW5PaGy9LZo33vQaxUy8Lz3KAK7B42pCrtuaoOhG569LEK+d8NwbXwPFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484630; c=relaxed/simple;
	bh=qrleg9vBvliQVWMBDUBH8lNbSBSo21hDzjvysYLLmsA=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=U1xOezrAl17rF1eyrqMsACmbq9HD+R3Q1yDcc/oX9Kp9Fjh2LpVbRetmzfaV5hZ9PQHz1WFPt3G4SGjY3OXGnf/rSAAMCTMuMLcvJBnuapYeaMPvgXvkOlvIoattC3RzRQfcQAeli8cPFxopGjC1y85+3En/fYi5bMKQrQJ4SfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=X5iGYnuZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TxM80vX+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="X5iGYnuZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TxM80vX+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 806B8EC008E;
	Wed, 25 Mar 2026 20:23:48 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 20:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774484628;
	 x=1774571028; bh=qrleg9vBvliQVWMBDUBH8lNbSBSo21hDzjvysYLLmsA=; b=
	X5iGYnuZbAQyM0yfNsG13VvSK3hR2zgmwNn8bslY2Ray4byRPBjc2XHMEyr4nE/3
	wHOQ93rL2QJomaYwsIcYw7E937tXUm4vlICsaVktrzqnaO20tecdd1p9vSbox9YQ
	gL4AWgZvJhf2VR1Ih6c2aJODSpqvLVk7HTl/B7MA+NMqqU02D8rroXQqAfZOA44R
	jZ3x5hw0/Y4EwAy5Vpv268OYo0amMm4o8GF21Z8ABsV8M1TYNp0KyYpwRNHON8Ua
	4qmh/iD/ji3GaSgla1ylAjYxisuw3OVAtqd/CQjrfnBeT+hEIE8PVf8xxgyEnIeN
	ydP4Xa2eyGxiaB78ImLqvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774484628; x=
	1774571028; bh=qrleg9vBvliQVWMBDUBH8lNbSBSo21hDzjvysYLLmsA=; b=T
	xM80vX+BJW82pd2LBYrynxK571qUK9GThRmbZ/2DmDKT67dnJr9rHycIcGOKGWaf
	k6+J8XP+PLyUnXgyJqHJcSM3mywFe+plRZ/5IFPwGq9704t/NJlhKvXpZtcplneJ
	729dAch9Z3v2cdvb7iX34moyV8MoSve2Bn01xca6JsqIS6TloSP0LAsDKTo9rW+v
	N+GxKlH81e3m30t0gLPzHfo+/zR6MPG7x4TU+EwJ7jlOh70Ii7Wvprqi67lW9xK9
	GAuLgkHtsj4DoT9gp7rNzra+hFQURW2CFMM0Vo6rV93n37pqxbjLt1pEU/wCdvI5
	zQubnrd2czzdgJGjFSDHg==
X-ME-Sender: <xms:lHzEaT5IiXk7rs4jP5lmjMUfWmP60tD453qu6jg_5dU2AWjp3UdlZA>
    <xme:lHzEaTtKEk9gSwq1kEHzviqO_YhcAdmbF0HHQXfRuB7oO58r2XEHNq5ILJ9P55pkI
    UQlLSOmt3jX4zObWd3LlMuhvciEeJGZM663i7S4Ztfb6nnlLt1-IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopf
    hokfffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecu
    hfhrohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtf
    frrghtthgvrhhnpedtudejffejkeekteelueefvdejvdeuhfefteehkeevtddvleduteek
    leetvdelhfenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehflhhoshhssehjvghtmhdrmhgvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprh
    gtphhtthhopehsvggrnhdrfigrnhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhmvgguihgrthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprh
    gtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:lHzEaSiEzOmxJ5FHdidzeJPc3seH3ZwgRHxCqrXg-dgrVtc8uc654A>
    <xmx:lHzEaeeCRh7MYugIEmfVOZ-IyUHOOPCMsbmRwBCVD4q4J8QYCVKkbg>
    <xmx:lHzEadlZgMTsjVeb5sBh3G4beq7tfCz7k8C6gayF2pmz6ujPK6-Dbw>
    <xmx:lHzEafsdmBguEFUgrZSioE23DJSj3I_tJ2NltGas_1Ghw7eyrNN9Zg>
    <xmx:lHzEaYFCX30Y_xYOUSUdLbABtrbtltmkU6YDd3RQhux9927W1SqagXgY>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F98B1EA006B; Wed, 25 Mar 2026 20:23:48 -0400 (EDT)
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
To: Sean Wang <sean.wang@kernel.org>
Date: Wed, 25 Mar 2026 18:22:52 -0600
Subject: Re: [PATCH 1/2] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
Cc: linux-bluetooth@vger.kernel.org, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
In-Reply-To: CAGp9Lzrysz8Tyh2KUMWVgHMsfUqojiJgPseG+CTULTqH=QQhaw@mail.gmail.com
References: 177272816248.352280.12453518046823439297@jetm.me 20260305162928.5E8F11EA006C@mailuser.phl.internal CAGp9Lzrysz8Tyh2KUMWVgHMsfUqojiJgPseG+CTULTqH=QQhaw@mail.gmail.com
Message-Id: <20260326002348.4F98B1EA006B@mailuser.phl.internal>

Hi Sean,

On Fri, Mar 7, 2026 Sean Wang wrote:
> BT and WiFi use separate firmware.
> I'm not sure why those WiFi sections are included in the binary.
> Another concern is whether it is appropriate to upload the firmware
> used in Windows to the linux-firmware repository,
> The firmware files are probably intended for dedicated OEMs.

The section filtering remains in v2 since the binary from the ASUS
driver package does contain mixed BT+WiFi sections. The firmware
upload question is being tracked separately in linux-firmware
MR !946.

On that topic - would it be possible for MediaTek to provide a
proper BT firmware binary for linux-firmware, or to sign off on
the one extracted from the ASUS driver package? That would resolve
the firmware provenance concern. If a formal submission from
MediaTek is required, could you help coordinate that?

> This is common logic for the other mediatek chips. It only takes
> longer on the first power-on.

[...]

> If the firmware download is properly handled in
> btmtk_setup_firmware_79xx, we don't need the extra bit.

Understood. The BTMTK_FIRMWARE_LOADED flag and skip logic are
removed in v2. Firmware persistence is handled by the existing
framework as you suggested.

v2 is sent with these changes addressed.

Best,
Javier
