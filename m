Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779433F361;
	Thu, 26 Mar 2026 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563219; cv=none; b=XxMrK26FmKHBeTifMMztuOSKHv0v9wHEFA1ozIRe+p5ynwkDk8hiHtKjnL8oBaxqdfSNC9+99z7DKl2qarrpxNIvbDZcUmnY9VWT0Wu8dKpq+10mxMBf0JFKA+07ZP4nVqzPJRKQ5Zj81Wue1rjK7EWQfXgnePphfORBTQhL0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563219; c=relaxed/simple;
	bh=RVhTS+rSfnyJGM/kliwPbFcxsz7RD9CsUGsL6T806Xw=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=mJwEOmHeEKYmHilpdx6r3i0uqjGyJM1bj6nTbjzCELE4uaitAzPFhGfuac4EFduVoRuuEfjeGidr1D1nOehXOFnEPeDeA7KufGGygJ7NU3dAMM9Hyfv1XeJjIcHjxGWFY4bU8XqPHx4RfFComimZyR9S9ZRjUZqQsI5BbtNYDKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=d3NzGUvZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CWsBgfFo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="d3NzGUvZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWsBgfFo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 79A31EC021F;
	Thu, 26 Mar 2026 18:13:37 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 18:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774563217;
	 x=1774649617; bh=RVhTS+rSfnyJGM/kliwPbFcxsz7RD9CsUGsL6T806Xw=; b=
	d3NzGUvZCCCek0IdcQ+Z3AEOlme+tlgy//ftGm7/6F3XSh/ZzhGenuUBtmCzYymB
	mjoe3XUHXbavnHjaCiB0O8SWMwQ2Dncnect5tkHCvk9f9QIzHOs55SGKTuhJk8mi
	aYOQnAolthzhnn9rqImoDxcqss85ZvHpfLQHljsHcEvLF8x4QHwZ10/c7XuI40c5
	BjjcPHwAIR9tAucpVJh9zkpHhUn6DjKb8098hvLZAGGUIR54nrkU6X59OvaQcR9V
	vxC3wQQAyy3krTcDQj4K3Xcl+VQTyjPGaR4m/QDTICY78t8o/emH2JnlmPsnDPma
	2NY4q9fygGFfsrxH1zT10w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774563217; x=
	1774649617; bh=RVhTS+rSfnyJGM/kliwPbFcxsz7RD9CsUGsL6T806Xw=; b=C
	WsBgfFoauFDemzQiEV11ZhY871P1HBOwMH7IcRRyEI1kYnxl54ILYIUVQRXggUFE
	f5tfZRhgw6lYuAyp9Upzi7O4+CPfjYAFH+JLVcyVxgjUlXpRNVRjd3kZPwojRQSZ
	2+iok2U0hBqDNj294NiHLTK5ioZTFsFUfxDmxmpBVaHvLcZRB7O+TWP+KfLdXC0S
	0edtOz9rgGo2Axb6DomUzpbiRsxJBSPSbhjwg5Owmshb8toCGffZN6n4Op7pyt/1
	YKJYMbEPRq/fNcZgpUOEPSgn0Mkl3vrNb5LpDSgpoDZbIvV8wZ974IJCco+jQ7ST
	kBn20A0mEjukLfOBkoH5w==
X-ME-Sender: <xms:ka_FaWr6wrTaBWNj7a_DuGexI8MuuvfxwSrmZto9EJlJlUwy0tvpBA>
    <xme:ka_FafeuRsV3Qd7vL3bwMRCpm7aWU3YI1plBEuSBoWEmDNUFqm02_cCWdatDEDiTf
    JV6p1klri2o6AEy7OeQZ-vcGkFDsLkZoyLcZZhPqqwvoozXjUO3SFcI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopf
    hokfffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecu
    hfhrohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtf
    frrghtthgvrhhnpeektdffveejhfeffeevgfefhffhuedvvdfgfffhieetleefvefgfeek
    tedvffffgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhmvgdp
    nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnh
    hgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgt
    ohhmpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhgrthhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgigv
    lhhnrghgrgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrtggvlheshhholhhtmh
    grnhhnrdhorhhgpdhrtghpthhtohepshgvrghnrdifrghngheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqmhgvughirghtvghksehlihhs
    thhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghluhgvth
    hoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ka_FaW3v_uKhki4A7iMBwl-20BnPBe3izw8xGWM1E10mgYbUXI6BTw>
    <xmx:ka_FaXVlnFKujDYIYcSEkElF1_L524kX_yVUYrpu5VQq0-Cl_bhdlg>
    <xmx:ka_FaYOU6KRuFwTy1Jc2q-UzaH5ziaCjXxfcB6sw7vS6gEymapt47Q>
    <xmx:ka_Faa3AHaZDjL4JZRK4p8-P5-QXGfajqPzmyixbDsxQB5CoABeWrA>
    <xmx:ka_FaSZIjF8kHqM0HpZJNNHSDOP54yi7oYW5OJUydon4anwK_eMsw3jO>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 525291EA006B; Thu, 26 Mar 2026 18:13:37 -0400 (EDT)
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
Date: Thu, 26 Mar 2026 15:26:29 -0600
Subject: Re: [PATCH v2 1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ryan Gilbert <xelnaga@gmail.com>
In-Reply-To: CAGp9Lzrme_J2UyzzG+7AWGU4MKx4yehgUy4biy4ZbtP9OkbfnQ@mail.gmail.com
References: 20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me 20260325-mt7927-bt-support-v2-1-b892a3252880@jetm.me CAGp9Lzrme_J2UyzzG+7AWGU4MKx4yehgUy4biy4ZbtP9OkbfnQ@mail.gmail.com
Message-Id: <20260326221337.525291EA006B@mailuser.phl.internal>

Hi Sean,

Thank you for the review. Both items are addressed in v3.

On Wed, Mar 26, 2026 Sean Wang wrote:
> Using raw CHIPID=0x0000 to unconditionally force 0x6639 seems fragile.
> If another device later hits the same missing-ID condition, it would
> also be misdetected as MT6639. Normally this kind of quirk could be
> carried in .driver_data, but since btusb.c is shared, I'm not sure
> that is the right fit here either. This should probably be handled
> through a more device-specific fallback instead of mapping all zero
> CHIPID cases to 0x6639.

Agreed. In v3, the zero-CHIPID fallback is scoped to a static
VID/PID table of known MT6639 USB devices. Only those specific
devices get forced to 0x6639 - any other device reading zero will
fall through to the default "unsupported hardware" path. This
follows the WiFi-side pattern where is_mt7927_hw is derived from
the PCI device table, not the chip register.

> I would prefer using the mediatek/mt7927/ folder naming here. mt7927
> is more widely recognized, and using it would avoid unnecessary
> confusion.

Done. The firmware path is now mediatek/mt7927/ in both the
FIRMWARE_MT7927 define and btmtk_fw_get_filename(). This matches
the WiFi firmware convention (mediatek/mt7927/WIFI_RAM_CODE_...).
The linux-firmware MR !946 has also been updated to use the
mt7927 directory.

v3 sent with these changes:
https://lore.kernel.org/linux-bluetooth/20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me/T/#t

Best,
Javier
