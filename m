Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833A31A556;
	Tue, 31 Mar 2026 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977046; cv=none; b=m6yy8siBCzlGSZLKbWWb80n0XoTnoAp8HVVtU7ASucd9DwR441iJIMCG8MzaPk/RNqrkiu1eh01QrFv4ITCvad/m/z06VolQkRvZF7XoRZKC9fV0lG/yoDaxnsIdloDfHssY30sBmvBZ6jr1JMg2TTEfT1J+lc9h9hfbIF9qvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977046; c=relaxed/simple;
	bh=XTvwZiI6XXt5aLepxKkrF2jBdcrNF3oVow3PxnNHfxo=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=Az8y8WzEZsq7QVPzQrTumVxWySkbErCkUGFNWKp4ZJI4tToW4UG33NNWmOhA05yxxo23G2nSutBdxun1Lbk/P7ztEhvg/YXG9QNcge/rHgIagP1ETUvcV7ObbY2VDGY/mC0S53dWwYABfhxkdrYaJ+5d+9nGUZydIP+Hh9ZjdGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=lWCnuegI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dgthWYE+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="lWCnuegI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dgthWYE+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6BF2D7A0017;
	Tue, 31 Mar 2026 13:10:44 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 13:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774977044;
	 x=1775063444; bh=wCj3dftpVU3GpBVKt3lynWlhu2vzbEQlfi+/kTc3Y9I=; b=
	lWCnuegI0gtC9O4eliIV4tXGF+x9qPXFrdjUUisuivwJMT4vk5JktwbBtw1DPAP5
	ndwDN+UqdlAnPm+vXMN/6JRYO8Jw1sl2XzFSxNnknEMmNIWx37qSaJ9cKPvQKZPg
	CFcX2T0Jl0uhZdEFugW6s/DwOvf4nKEMbeJhlGwZNfzuvETns6XT5+gekiRfdFo4
	/A4bTFByaaIdFSWWc1398czsPKNyHhti+zXF6ygrwE+hGi5oXrychQZhTbO+6KD0
	spugdL9Vlfw9MPTPMfG96H5giTAIPfISAJUgng2jcgFhKc0fZaja0Ns2cvd/6+83
	Q6UGWrU6P4HwE4Soknapog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774977044; x=
	1775063444; bh=wCj3dftpVU3GpBVKt3lynWlhu2vzbEQlfi+/kTc3Y9I=; b=d
	gthWYE+ndY4ZJyDnscsxhQJHJmKZAWIEGgJXqdTgMNBfxgporJn9qcm7Frp404zw
	UND7ODlcaJM+ZUNIdCVGDMwuFrZ7DEfennREErxxAQcnaQJNcTLoIdhQSFSgs/IC
	Am7emB+zfcdhT8EyGFP8lG8eHrgGvsLYBvZR8nVHNH/prp1nox4VS++KGfaFgyUM
	NMEnlNpn90XXd86yBxWVhUSZ5VpPggPpvPV3GcA9fsx+Rv08CgpEzyayaloO5rwk
	f4rF1gi5yvs6MygT69SrcLCxJF/IQck0IWk+eI5fiaxVco7oyC3PniFdcKtWqeva
	sq3T1RAGo0c+UQYy/tRDw==
X-ME-Sender: <xms:FADMaeXEYzkJHL5CEv5cDkFJtzUcVrnu6ZCLhITQoDsXKCRMKn8ahg>
    <xme:FADMaVZnCwdqayDJJXyMYdeNbeSBXVwU37qrGGAtgJPTPT6OcqRPyQnxkgLR4bXgB
    dnnckw3vqAitPSHABPCM7Oug0lUY921h6db8EA7IvXPvkhdYoCqYvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfpohfkff
    culddutddmnecujfgurhepofgtggfghffvfffuvegjfhesthektddtredtjeenucfhrhho
    mheplfgrvhhivghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrth
    htvghrnheptdduhefhleehvdeujedtjefftdehfeeggfejvdfhkedvkeffueeufeehteel
    udefnecuffhomhgrihhnpehsrghshhhikhhordguvghvpdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhhoshhs
    sehjvghtmhdrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgho
    lhhlrggsohhrrgdrtghomhdprhgtphhtthhopeefudelfeeifedusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgt
    phhtthhopehluhgsnhhinhdrihhvrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplh
    huihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthhthhhirghs
    rdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvlhhinhhkohdvtddtfeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehnihhtihhnrdhrvgguugihkeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepgigvlhhnrghgrgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:FADMaYZDV5-erLfmX3oNSncQKKMaApAqEays0jplSuwfYNEG1pPKQQ>
    <xmx:FADMacxvwIMqp4CwpzPz0yZ5QjsYqtUyjCyXAuQx2Z8RFc18MCrtEQ>
    <xmx:FADMabcfcMXCz69OnkyfCCwWXczlfi5zmSkYFSbCzXS3EA5ixniVCg>
    <xmx:FADMaSJpKPj3gqnD4XcsFAnuz4AWpsuJb95YfzOAyjDuit3g6BCmHw>
    <xmx:FADMaQ_d2sgQ6C227okyu7QGPX8ZiitSe8QJrRgBR3lV0Uq_-QaJe95r>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F1C481EA006B; Tue, 31 Mar 2026 13:10:43 -0400 (EDT)
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
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 31 Mar 2026 11:10:02 -0600
Subject: Re: [PATCH v4 0/8] Bluetooth: Add MediaTek MT7927 (MT6639) support
Cc: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ryan Gilbert <xelnaga@gmail.com>, Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>, Llewellyn Curran <melinko2003@gmail.com>, Chapuis Dario <chapuisdario4@gmail.com>, Evgeny Kapusta <3193631@gmail.com>, Nitin Gurram <nitin.reddy88@gmail.com>, Thibaut FRANCOIS <tibo@humeurlibre.fr>, Ivan Lubnin <lubnin.ivan@gmail.com>
In-Reply-To: CABBYNZ+MFJU=LLEaizYEt1b-7VzosErkav7dyneZExr_rLUnRA@mail.gmail.com
References: 20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me CABBYNZ+MFJU=LLEaizYEt1b-7VzosErkav7dyneZExr_rLUnRA@mail.gmail.com
Message-Id: <20260331171043.F1C481EA006B@mailuser.phl.internal>

Hi Luiz,

On Tue, 31 Mar 2026 Luiz Augusto von Dentz wrote:
> Ok, but on 8/8 it seem to suggest the problem still exists which
> trigger the following review:
>
> https://sashiko.dev/#/patchset/20260330-mt7927-bt-support-v4-0-cecc025e7062%40jetm.me
>
> Perhaps we should ajust the commit description if the 19 seconds
> doesn't really occurs when 2/8 is applied.

Good catch. The ~19 second delay is indeed fixed by patch 2/8, so the
note in 8/8 was misleading as written.

I've updated the commit message in 8/8 to clarify:

  Note: boards with this USB ID expose only one ISO alternate setting
  (alt 0). Without the fix in patch 2/8 ("btmtk: fix ISO interface
  setup for single alt setting"), this caused ~19 second initialization
  delays. With the fix applied, initialization completes in ~2.6
  seconds.

This is addressed in v5:
https://lore.kernel.org/linux-bluetooth/20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me/

Best,
Javier
