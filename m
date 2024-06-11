Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E4174EE4;
	Tue, 11 Jun 2024 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094793; cv=none; b=T+gmOwDVeQmGYpHMWA2PhIL7ftGWy7FworP0ZEVLk8MLfoM8Fx2rnRsvbUL+KN7ioGjVvhsqW3ub/+4f3wSfrxW3+5H6AOIrPOG3+KpulLxy8UiWEPY4piZBGZ87o8S6j4ZB9SY4KC2rHHeMnC8Z1wPr3IHqZ2qOngiRSoUm7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094793; c=relaxed/simple;
	bh=CtnVECJ3Sqv+zIcHzuKNfaum0O8bvOkhLfRsNVVkeVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuOMX4f/idTgQ10dynkVmxDBfi5FIR6UtIzmni1SoUNYvAVGfk0iNX8rBVAjnGOSpNI9vp7L73+J6HrsTXvEcHFdQxD7XuiF3y5buD/d/jn6wVfQq5nhgaqYASd6+i43RcsZLdH5pQJDMaarJBppaOz2LQJyXZ12ThaDriCb5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=bY850SoV; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="bY850SoV"
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sGwwB-0007za-0M;
	Tue, 11 Jun 2024 10:33:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uxBtCY19yODZNGkHF7p72TwtLkbwXAYNX7XgY9uZj5E=; b=bY850SoVU4kt1ak7F0R7JsX9QO
	DdB29QsoOvKrafPCzplJFZTJdsKy1JFENOjrDVwyoJYHEd8vNRSL/KBSdsnpHl/rydwRwOgBieTLC
	DeSmCQ1iQsjOilOeG+bzK5Gqih3Qq3l2tICIOBxbBFceynZg6wUtJJiby5kxqIKwgk3OPDIqI1ZmU
	AL0HPjcA/xmWYeSMTyTsT9IEAIgyxIvW5ElKBtEQ3yw3A+MW1jtv+BRqHgRfxttKYEzCko9nijKlJ
	f/uBX51kv2UL7WRP5Brfxh3O3V2Fc9jsn6xZA3AEJYrfpkkMEw+d0tUpChXY63fD5L7AFmCFYfG83
	/DOPLVxQ==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sGww6-0031HS-0Z;
	Tue, 11 Jun 2024 10:32:59 +0200
Date: Tue, 11 Jun 2024 10:32:56 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Adam Ford <aford173@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, marcel@holtmann.org,
 johan@kernel.org, pmenzel@molgen.mpg.de, jirislaby@kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?B?UMOpdGVy?= Ujfalusi
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 0/4] Bluetooth/gnss: GNSS support for TiWi chips
Message-ID: <20240611103256.4e64dd16@aktux>
In-Reply-To: <CAHCN7xLDjnW1gK8DF4codzFLEvC_hDgeACR8wtWF8nxCJ=+RBg@mail.gmail.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
	<CABBYNZ+Fz2TLSNa28H3kjVKOSA7C-XOzdQJiHdJs3FKxnq01DA@mail.gmail.com>
	<20240606221941.333a9704@aktux>
	<CAHCN7xLhbiqTTOwPZ22KekALDn0KtH6vNQEJpSmSCTiMggX5Qg@mail.gmail.com>
	<20240608212004.3707d8ea@aktux>
	<CAHCN7xLDjnW1gK8DF4codzFLEvC_hDgeACR8wtWF8nxCJ=+RBg@mail.gmail.com>
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

On Mon, 10 Jun 2024 18:17:05 -0500
Adam Ford <aford173@gmail.com> wrote:

> On Sat, Jun 8, 2024 at 2:20=E2=80=AFPM Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:
> >
> > Hi Adam,
> >
> > On Sat, 8 Jun 2024 14:00:38 -0500
> > Adam Ford <aford173@gmail.com> wrote:
> > =20
> > > On Thu, Jun 6, 2024 at 3:19=E2=80=AFPM Andreas Kemnade <andreas@kemna=
de.info> wrote: =20
> > > >
> > > > Hi Luiz,
> > > >
> > > > On Thu, 6 Jun 2024 16:04:10 -0400
> > > > Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> > > > =20
> > > > > Hi Andreas,
> > > > >
> > > > > On Thu, Jun 6, 2024 at 2:30=E2=80=AFPM Andreas Kemnade <andreas@k=
emnade.info> wrote: =20
> > > > > >
> > > > > > Some of these chips have GNSS support. In some vendor kernels
> > > > > > a driver on top of misc/ti-st can be found providing a /dev/tig=
ps
> > > > > > device which speaks the secretive Air Independent Interface (AI=
2) protocol. =20
> > >
> > > I think you may have sent me a file to test, but I can't find the
> > > e-mail.   Can you tell me what tool you used to test it?  I can get
> > > gnss0 to enumerate, so I am close.
> > > =20
> > hmm, /bin/cat is sufficient. It should spit out nmea now by default.
> >
> > For playing around with raw mode, you need the ai2raw parameter
> > and then you can play around with read-gps from
> > https://github.com/akemnade/bt200tools
> > =20
> > > [   20.759857] hci-ti serial0-0: using DT
> > > '/ocp@68000000/serial@4806c000/bluetooth-gnss' for 'enable' GPIO
> > > lookup
> > > [   20.770263] of_get_named_gpiod_flags: parsed 'enable-gpios'
> > > property of node '/ocp@68000000/serial@4806c000/bluetooth-gnss[0]' -
> > > status (0)
> > > [   29.221588] gnss: GNSS driver registered with major 244
> > > =20
> > That is nice. =20
>=20
> I think I am stuck.  The closed-sourced GPS binary that Logic PD did
> was done a 3rd party which has since been sold, and Logic PD never had
> the source code, I just get junk with this driver:
>=20
Well, the whole thing is kept in secrecy. But the junk you get is just=20
plain NMEA which I get also when device is indoors, so you got the chip
into a mode which common user space (like gpsd) understands. So IMHO that i=
s a
Tested-By. So thanks a lot. I am happy with that result for the first step.

So first rpc was tested with a Motorola tablet and the BT200, this one now
with two different devices, so it is a good situation.=20

> $GPGLL,,,,,,V,N*64
> $GPRMC,,V,,,,,,,,,,N*53
> $GPGGA,,,,,,0,,,,,,,,*66
> $GPVTG,,T,,M,,N,,K,N*2C
> $GPGSA,M,1,,,,,,,,,,,,,,,*12
> $GPGSV,1,1,00*79
> $GPGLL,,,,,,V,N*64
> $GPRMC,,V,,,,,,,,,,N*53
> $GPGGA,,,,,,0,,,,,,,,*66
> $GPVTG,,T,,M,,N,,K,N*2C
> $GPGSA,M,1,,,,,,,,,,,,,,,*12
> $GPGSV,1,1,00*79
> $GPGLL,,,,,,V,N*64
> $GPRMC,,V,,,,,,,,,,N*53
> $GPGGA,,,,,,0,,,,,,,,*66
> $GPVTG,,T,,M,,N,,K,N*2C
> $GPGSA,M,1,,,,,,,,,,,,,,,*12
> $GPGSV,1,1,00*79
>=20
A note: contrary to other GPS I have seen, this one does not give
out satellite reception strength if not much is known about
position. So this pattern might continue a bit even if antenna
is there and gps reception is good. Much development of this
driver was done in a hammock with keyboard in a sleeping bag outside
so I know a bit...

> I am not 100% positive, but I think the antenna might be required to
> be powered.  I'll talk with the HW engineer who designed the Torpedo +
> Wireless SOM and see if he remembers anyhthing about the GPS.  I know
> for a fact that Logic PD doesn't have the source code for their GPS
> demo, and I know it doesn't work with modern kernels, so i can't
> compare the performance.
>=20
Well, and demo tools are not easily available anywhere...
Well, I think if there is some special antenna powering stuff,
that can be done in a second step. Probably just a gpio or something.
But that would affect both the testing tools and the in-kernel
solution.

As said, you might use the ai2raw=3D1 parameter and try the read_gps from
bt200tools. Or the demo might work if you symlink gnss0 to tigps.

> :-(

Well, no, correct is :-)

Regards,
Andreas
