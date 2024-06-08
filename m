Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC41C6BE;
	Sat,  8 Jun 2024 19:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717874419; cv=none; b=XhjP8tqDGBb23kFgNjKujLmej5Hu44UARezOAFxDAON05eFofbMdNohXnsa/J+LxFDDrjKnsoEN0SZHOenHnn76hPgDV/ZXFBFygtZTuZw3KG1GMTpRAnL5MZtMH7PQbNLhCVZd9SoVDnaPlocnFC441A2/QrXodGNmBxGoiYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717874419; c=relaxed/simple;
	bh=YPBWo/1TW6OyLktEGeZVaCyTmHOZ3JTo2WnUgif8pHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ok7N2gN+t5mKul/MrCBypnkr2CtRw9VJH6yWuiSXLPiWNVpz8QQDpQuVcCmi+DBs/DNtbROVWZGJT4MoFdbuWwLkcMIw8UMwAGAdaVe4W8XXKsRbO1WpsH+pyD/cDX7g9qYfVJBl0ZdAQBt+3TkuR8eojgNAkCal7r+AGuLi1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=DfWCAf0r; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="DfWCAf0r"
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sG1bk-0001CU-2i;
	Sat, 08 Jun 2024 21:20:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FMkcj0KhC0yh+Y1ML/8400xCeZKqlnRCVmgyWA2sJsk=; b=DfWCAf0rdnWt3XQ3DjrNOnMdQ+
	m6jpeBTdDkT0In4UhYtmuPg2QUdFByiCeiNK1IGTIuHFreAnYBTtdADGT2+3dRoMsDKb3tILfS0Nx
	UILLY754dIm2X6IxfH5jTs2OJCJVBhGm1slwT2iRQMnJOObDVi9JRIrvtyTtneqsMgrpHb6XWNFfy
	niTRJPt32WnfH9xisYt7at8b1xcURoTg/6kychlEflwe2/bxSohS23Xth9s9aeIauQqCuFdkS1gWT
	sfZScn6O+3/RcpqvpHZpBaJkDQK3nYzPA+SS/bd44x64ppdIVO7mo07NRXYGHUEintMBwGjbIAPQX
	Aapzcaww==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sG1bh-002vTe-0S;
	Sat, 08 Jun 2024 21:20:06 +0200
Date: Sat, 8 Jun 2024 21:20:04 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Adam Ford <aford173@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, marcel@holtmann.org,
 johan@kernel.org, pmenzel@molgen.mpg.de, jirislaby@kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?B?UMOpdGVy?= Ujfalusi
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <20240608212004.3707d8ea@aktux>
In-Reply-To: <CAHCN7xLhbiqTTOwPZ22KekALDn0KtH6vNQEJpSmSCTiMggX5Qg@mail.gmail.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
	<CABBYNZ+Fz2TLSNa28H3kjVKOSA7C-XOzdQJiHdJs3FKxnq01DA@mail.gmail.com>
	<20240606221941.333a9704@aktux>
	<CAHCN7xLhbiqTTOwPZ22KekALDn0KtH6vNQEJpSmSCTiMggX5Qg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Adam,

On Sat, 8 Jun 2024 14:00:38 -0500
Adam Ford <aford173@gmail.com> wrote:

> On Thu, Jun 6, 2024 at 3:19=E2=80=AFPM Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:
> >
> > Hi Luiz,
> >
> > On Thu, 6 Jun 2024 16:04:10 -0400
> > Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> > =20
> > > Hi Andreas,
> > >
> > > On Thu, Jun 6, 2024 at 2:30=E2=80=AFPM Andreas Kemnade <andreas@kemna=
de.info> wrote: =20
> > > >
> > > > Some of these chips have GNSS support. In some vendor kernels
> > > > a driver on top of misc/ti-st can be found providing a /dev/tigps
> > > > device which speaks the secretive Air Independent Interface (AI2) p=
rotocol. =20
>=20
> I think you may have sent me a file to test, but I can't find the
> e-mail.   Can you tell me what tool you used to test it?  I can get
> gnss0 to enumerate, so I am close.
>=20
hmm, /bin/cat is sufficient. It should spit out nmea now by default.

For playing around with raw mode, you need the ai2raw parameter
and then you can play around with read-gps from=20
https://github.com/akemnade/bt200tools

> [   20.759857] hci-ti serial0-0: using DT
> '/ocp@68000000/serial@4806c000/bluetooth-gnss' for 'enable' GPIO
> lookup
> [   20.770263] of_get_named_gpiod_flags: parsed 'enable-gpios'
> property of node '/ocp@68000000/serial@4806c000/bluetooth-gnss[0]' -
> status (0)
> [   29.221588] gnss: GNSS driver registered with major 244
>=20
That is nice.

Regards,
Andreas
