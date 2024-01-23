Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C056466
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997578; cv=pass; b=DmmZpEnwdTLcnFKG7BodBygk+tntLH95mivRnqxxxYqNM6BdUBFfqGuyjwMxyFxYYrADTsz7It59N8+esNLkOvQJT0B4OVPwiFcnbgES0MuQrnxyCXruT3/BK95We/DNIH5YO47IXiYo0ReNX7YzpmeH5pk8LuUZk2jXL2Ip5Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997578; c=relaxed/simple;
	bh=5rp2riqkvsGJPhdIbBrmLgw2ga/G0F68ZHqxU9AIxVY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mPo48kgEBaqeb20RBhCBGelkUjK8wqjqVYqCI+Rbs0cpp26LcT4Q8uz2ZWCbNLQeFlxD4rkxRwHFIiDXrmE1sY1vgNdpJCaMbV1UWwrjaokOPRKVRQ8c/t+x8nE0q3x/6es628XeXYUJSkC4jaZCkqLromjiQeGX0eti03nzIYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lab.zgora.pl; spf=pass smtp.mailfrom=lab.zgora.pl; dkim=pass (2048-bit key) header.d=lab.zgora.pl header.i=mk@lab.zgora.pl header.b=QO5+SNH5; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lab.zgora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lab.zgora.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lab.zgora.pl header.i=mk@lab.zgora.pl header.b="QO5+SNH5"
ARC-Seal: i=1; a=rsa-sha256; t=1705997571; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lGGgiuvLz+bsXNiEEe6eQCdS5LdCDC77W94ZYkk3czL5jMXxVXMOKOeRSDTDXDm+H1X8e2XgXF2CrBb/dcuBxzLSrhOBMSSqsaASC9yLCbhXX/HB1z/CLvDJ7oW7vNMywMW7EVitCGBp/HZ1/cyM5EkKPFTDI5TJ27nUolbB+TQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705997571; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u0hGewnMe8MiZjaczX5Y4JoMyC/+nvPp4QlA4aMsrFE=; 
	b=IRG1FmCH6Qt4PcfIlfYzJMyZjnRaNe930EdVk7W836n3Yee2OC/bUNPZmRiV8fY2qss+XzIOzKTg5KKhYLpFZJyCXS9zf8wY+LkbquZ+BZtXEWo9FYMdxebtcgj6XwQMDBqv4NdEFNdL61DB38YAcMa53iIucLVYOZbdsIEMlxw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=lab.zgora.pl;
	spf=pass  smtp.mailfrom=mk@lab.zgora.pl;
	dmarc=pass header.from=<mk@lab.zgora.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705997571;
	s=mail; d=lab.zgora.pl; i=mk@lab.zgora.pl;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=u0hGewnMe8MiZjaczX5Y4JoMyC/+nvPp4QlA4aMsrFE=;
	b=QO5+SNH5eN1/RTtmz7Mhdg0QoWh7Qad1wWULN6RbaFDFyEpBB3gQpAeEE+KcoeDe
	+mOvuvMwfD1s5NQvgNE+06nCFoJHVAYYQghSTutZRem4nfGU1PGaJgOOKR1La8ZqfVx
	EFlAYUmJkZ7cPGeksELIhPAPsG9kRLAQoT4oFeKds51rKtbCxrmu7P0WByNBlWYWu81
	YHg6VnCZEtFCrmSaoL2jWtxvXpnZkb49phSRqXuG5pbAcpd73uThx0nr9kWdslnyxfY
	VOyvMVexyCfwAJXTU+HzQpgy77ugg9n4LlihVuf5W8wZEz8Bp4+vaPn/EbjgnJ3YUa/
	xzLhOrQQ8w==
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1705997570309264.1077689101212; Tue, 23 Jan 2024 00:12:50 -0800 (PST)
Date: Tue, 23 Jan 2024 09:12:50 +0100
From: Mariusz Kozlowski <mk@lab.zgora.pl>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "linux-bluetooth" <linux-bluetooth@vger.kernel.org>
Message-ID: <18d356110eb.1120f313b408792.7694888926917426249@lab.zgora.pl>
In-Reply-To: <CABBYNZKW8odyLb_BQcXXpjAKjPzHRhXVCbxvcg54VkoeULeHnw@mail.gmail.com>
References: <20240121100328.1200839-1-mk@lab.zgora.pl> <CABBYNZKW8odyLb_BQcXXpjAKjPzHRhXVCbxvcg54VkoeULeHnw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] btmon-logger: Fix stack corruption
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Luiz,

 > Hi Mariusz,=20
 > =20
 > On Sun, Jan 21, 2024 at 5:04=E2=80=AFAM Mariusz Koz=C5=82owski mk@lab.zg=
ora.pl> wrote:=20
 > >=20
 > > Version 3 capability masks are 64 bits in size.=20
 > > ---=20
 > >  tools/btmon-logger.c | 12 ++++++------=20
 > >  1 file changed, 6 insertions(+), 6 deletions(-)=20
 > >=20
 > > diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c=20
 > > index a770ad575..1f6db3751 100644=20
 > > --- a/tools/btmon-logger.c=20
 > > +++ b/tools/btmon-logger.c=20
 > > @@ -161,14 +161,14 @@ extern int capset(struct __user_cap_header_struc=
t *header,=20
 > >  static void drop_capabilities(void)=20
 > >  {=20
 > >         struct __user_cap_header_struct header;=20
 > > -       struct __user_cap_data_struct cap;=20
 > > +       struct __user_cap_data_struct cap[_LINUX_CAPABILITY_U32S_3];=
=20
 > =20
 > Ok, but this doesn't change the field, it makes it an array, or are=20
 > you talking about the following note:=20
 > =20
 > Note that 64-bit capabilities use datap[0] and datap[1], whereas=20
 > 32-bit capabilities use only datap[0].=20
 > =20
 > In that case Ive just pointed out to this note to explain why this is ne=
eded.=20
=20
For version 3 caps (64 bit masks) a single struct __user_cap_data_struct is=
 not
big enough and capget() writes past the end of cap structure on the stack. =
To
accomodate version 3 cap masks the cap structure needs to be 2x bigger.

 > >         unsigned int mask;=20
 > >         int err;=20
 > >=20
 > >         header.version =3D _LINUX_CAPABILITY_VERSION_3;=20
 > >         header.pid =3D 0;=20
 > >=20
 > > -       err =3D capget(&header, &cap);=20
 > > +       err =3D capget(&header, cap);=20
 > >         if (err) {=20
 > >                 perror("Unable to get current capabilities");=20
 > >                 return;=20
 > > @@ -177,11 +177,11 @@ static void drop_capabilities(void)=20
 > >         /* not needed anymore since monitor socket is already open */=
=20
 > >         mask =3D ~CAP_TO_MASK(CAP_NET_RAW);=20
 > >=20
 > > -       cap.effective &=3D mask;=20
 > > -       cap.permitted &=3D mask;=20
 > > -       cap.inheritable &=3D mask;=20
 > > +       cap[0].effective &=3D mask;=20
 > > +       cap[0].permitted &=3D mask;=20
 > > +       cap[0].inheritable &=3D mask;=20
 > >=20
 > > -       err =3D capset(&header, &cap);=20
 > > +       err =3D capset(&header, cap);=20
 > >         if (err)=20
 > >                 perror("Failed to set capabilities");=20
 > >  }=20
 > > --=20
 > > 2.34.1=20
 > >=20
 > >=20
 > =20
 > =20
 > --=20
 > Luiz Augusto von Dentz=20
 > =20
 >=20
