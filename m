Return-Path: <cyrus@holtmann.org>
Message-ID: <1327962821.2125.4.camel@sirocco.config>
Subject: Re: [RFC PATCHv2] autopair: add autopair plugin
From: Bastien Nocera <hadess@hadess.net>
To: Scott James Remnant <scott@netsplit.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	keybuk@chromium.org
Date: Mon, 30 Jan 2012 22:33:41 +0000
In-Reply-To: <CA+bD78jkORzLP-M+bGqFMkp9vHmBXW+LgLnFGhLczn92Rk2XXA@mail.gmail.com>
References: <1327448862-21964-1-git-send-email-scott@netsplit.com>
	 <1327952977.1955.160.camel@aeonflux>
	 <1327953929.2400.80.camel@novo.hadess.net>
	 <CA+bD78jkORzLP-M+bGqFMkp9vHmBXW+LgLnFGhLczn92Rk2XXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Em Mon, 2012-01-30 =C3=A0s 13:42 -0800, Scott James Remnant escreveu:
> > The PIN length hint is also ignored in the current code:
> > +       <device type=3D"audio" oui=3D"00:1A:80:" name=3D"CMT-DH5BT"
> pin=3D"max:4"/>
> >
> Because that's a UI restriction, no?
>=20
> I didn't put any PIN-generation code here, because I'm not entirely
> sure what the UI for "generate random PIN' should look like or which
> spec you're following.=20

It means that a generated PIN shouldn't have more than 4 digits for it
to work with this device.
