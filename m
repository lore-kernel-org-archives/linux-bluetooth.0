Return-Path: <cyrus@holtmann.org>
Message-ID: <1327964619.2125.14.camel@sirocco.config>
Subject: Re: [RFC PATCHv2] autopair: add autopair plugin
From: Bastien Nocera <hadess@hadess.net>
To: Scott James Remnant <scott@netsplit.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	keybuk@chromium.org
Date: Mon, 30 Jan 2012 23:03:39 +0000
In-Reply-To: <CA+bD78hQcBm5-94RHNSPXUsM1kAD8pYJ5Yu=-jPv8T=iedr6bA@mail.gmail.com>
References: <1327448862-21964-1-git-send-email-scott@netsplit.com>
	 <1327952977.1955.160.camel@aeonflux>
	 <1327953929.2400.80.camel@novo.hadess.net>
	 <CA+bD78jkORzLP-M+bGqFMkp9vHmBXW+LgLnFGhLczn92Rk2XXA@mail.gmail.com>
	 <1327962821.2125.4.camel@sirocco.config>
	 <CA+bD78hQcBm5-94RHNSPXUsM1kAD8pYJ5Yu=-jPv8T=iedr6bA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Em Mon, 2012-01-30 =C3=A0s 14:35 -0800, Scott James Remnant escreveu:
> On Mon, Jan 30, 2012 at 2:33 PM, Bastien Nocera <hadess@hadess.net> wro=
te:
> > Em Mon, 2012-01-30 =C3=A0s 13:42 -0800, Scott James Remnant escreveu:
> >> > The PIN length hint is also ignored in the current code:
> >> > +       <device type=3D"audio" oui=3D"00:1A:80:" name=3D"CMT-DH5BT=
"
> >> pin=3D"max:4"/>
> >> >
> >> Because that's a UI restriction, no?
> >>
> >> I didn't put any PIN-generation code here, because I'm not entirely
> >> sure what the UI for "generate random PIN' should look like or which
> >> spec you're following.
> >
> > It means that a generated PIN shouldn't have more than 4 digits for i=
t
> > to work with this device.
> >
> What generated PIN? Which spec/profile says you have to generate a PIN
> for this device?

It's recommended that the UIs try to generate PINs for the users, rather
than relying on them entering random numbers.

> How does the user know what PIN has been generated?

You will display it to them.

> Do you display the PIN in the UI in any way?

Yep, in the UI, because that's the PIN you will have to enter on the devi=
ce.

> Are they expected to confirm the PIN with a remote display?

Not confirm, but enter.

> Are they expected to type the PIN into the remote device? Or even the
> host, perhaps it's displayed there?

They're supposed to enter it. The device is a Hi-Fi with Bluetooth
functionality:
http://www.sony.co.uk/support/en/product/CMT-DH5BT

You have a UI to enter the PIN but it will only allow you to enter 4
digits. So any number longer than 4 digits will fail to pair.

> Or do these devices simply just accept any PIN without question? In
> which case, why does it matter whether you send a random PIN or 0000?

It doesn't.
