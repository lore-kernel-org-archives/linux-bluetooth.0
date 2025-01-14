Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA96236A8B;
	Tue, 14 Jan 2025 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858499; cv=pass; b=rtrbzQ6a/asiFxjMgb3QrF/1fTogFWTe48kKjeQM+zh3ys3Yr9NJoaqqttWkS4S/379+MOyifdP+TsJAfEbS2qEIZIHg8W2HI/UkAuxoDtKAh1JR/OMrkNA88FG8VvQb0F3FhLvGw971iPz7dtsA9DjRUkDFwXke40PKx9hCyvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858499; c=relaxed/simple;
	bh=Z3c3q5l0fdva0numU1uxhJZDw5GVhuiKEF2iVG1XVlk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q+Oy63DOyigaDqJFiraQ92CkZa5I1Q10ZqRG6K/t8XgOBlf/rlMucHHj2eT8B4MjBLV42lXhDcZ038GaSUFPXdXKJbkX7YZqll1XcHu4yRGB+/9M9vG/uH+tIlooJpmNlkLPy4hW9xlzlusjarHJgmP5wplvrBFkqiGUZ/XMSfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=oaRrkif6; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=14hA2RN6; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="oaRrkif6";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="14hA2RN6"
ARC-Seal: i=1; a=rsa-sha256; t=1736858127; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=odVJEw8GDpPX/TKju8dg4NQn76vk+kn3b8U35l+VR8FiEhcUPRyHTF2JV1uRyyuC0x
    +0fZ/gXopWgkDat2wcY0s4P0fwwl5rLsn0X5Ge6S4/CKrERDBeRf855zj+jPpgLxUOpa
    XLPPJlQpvRv3AZ1j0CNhFnV6PxarYfxhgYZi3OOZ3hQVbY6oRo4jPsWldJ7qD2vB6x9r
    i8byhqKlP77+A7acYaxSMsvbt5QBN8a9DUK7uWtFGboY5XF0FDPV/gDnEYHP0lRDJq5F
    1OhFbeSmoqASjqcggVNhHrHTvbps6fjD/yy2KjNbhSoORHItbvzepo7uQBmI/J8j+rWa
    T/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1736858127;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Z3c3q5l0fdva0numU1uxhJZDw5GVhuiKEF2iVG1XVlk=;
    b=ZyWULglHVckgLIQMIU/xrJHA0fBkx6z3rvmA7AEm07YEI2paxFgTTGqzup2O1zXkfJ
    l4pLbV5Xp34KDrn6HZe7cnHOx9d/Qaok9EYyAPf/2PbIfUfPwX5oDfsGSmUPP7oMvo4e
    QLFl3rkAICmy9gNQoBV63c/zNDpeSseSKXQgsX2bM/idoc9YW5El3VmD6N0CHBWZBtkT
    syR1gZgEurOyk/6Q3Xn8sw0VA+IUwG4VxdXg/DWArPpnRoqmGlOrY9PLiqwKVf2ex0oE
    SoTP3a6fmhfZSre5dTygbSkqG7vN8VmoJHQlfRx/ezVkkidtVXiXEYLKiSGmiszLJL8b
    9qOg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1736858127;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Z3c3q5l0fdva0numU1uxhJZDw5GVhuiKEF2iVG1XVlk=;
    b=oaRrkif6Yo3VxXOAfkc0T/ZKj7Ui1H5NmKlyJNg5FCD1UVWp/rjVEvzXEAoj9XUvT2
    K2bmYSUMj9DgzmmvleWjsO/WxI78bsgBjx8Gf4V9IS0pe0VxiVvUhumK36fNl0oJMuSu
    O5xqqOkzDE7I612lcZBSeUEVOw+nzQse0czkOQBuy/zqhKXxC2HzbysQsw9O0vE3JxG0
    1uVkMRIuaYw0zcETzGP1VjXc46zO7PPCKATKI1k4Xwh/Hyslhyhy4/9cSrlZ9eQ6OiPY
    U7Gwt7ZuEheDC+4RuhNDkGI5Z9BFReWu35+RFgBZmBcvj3S3j8zTs6JGicHEhOLCK2Hp
    MP3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1736858127;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Z3c3q5l0fdva0numU1uxhJZDw5GVhuiKEF2iVG1XVlk=;
    b=14hA2RN61X+DGf3XUcQih8hQmiaHWHcihdohLggc60nqsGOHKNYTGypdlfWY4AIJe9
    oIQ6l3OPamQmfpDaz6Ag==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeToZ"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.2.17 DYNA|AUTH)
    with ESMTPSA id Q8ede810ECZRfZq
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 14 Jan 2025 13:35:27 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <Z4ZREdC3aPkkxB2l@hovoldconsulting.com>
Date: Tue, 14 Jan 2025 13:35:16 +0100
Cc: marcel@holtmann.org,
 luiz.dentz@gmail.com,
 pmenzel@molgen.mpg.de,
 jirislaby@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-bluetooth@vger.kernel.org,
 Adam Ford <aford173@gmail.com>,
 Tony Lindgren <tony@atomide.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 =?utf-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <607BEE7E-861D-4CA1-96F0-AFF4D78D25C8@goldelico.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
 <Z4ZREdC3aPkkxB2l@hovoldconsulting.com>
To: Johan Hovold <johan@kernel.org>,
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3776.700.51.11.1)



> Am 14.01.2025 um 12:57 schrieb Johan Hovold <johan@kernel.org>:
>=20
> (And how does "TiWi" relate to "WiLink"?)

"WiLink" seems to be the Texas Instruments trademark of the chips (e.g. =
WiLink series 5, 6, 8 etc. [1]).

"TiWi" seems to be a nickname for this which is not violating the =
trademark and potentially distinguishing it better from the other chip =
brands?

Texas Instruments doesn't seem to use "TiWi", but distributors, module =
manufacturers, and software developers. E.g. [2]

[1]: https://www.ti.com/lit/ml/swpb012b/swpb012b.pdf
[2]: https://www.cs.utexas.edu/~simon/378/resources/PandaBoardES.pdf

