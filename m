Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Jun 2009 20:04:01 +0200
From: Stefan Seyfried <seife@suse.de>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: regression introduced on v2.6.30-rc1
Message-ID: <20090623200401.6c7e5ea6@stoetzler>
In-Reply-To: <1245768036.15367.78.camel@violet>
References: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
	<2d5a2c100906210708x1816e5d9hb9a80c82d76da6dd@mail.gmail.com>
	<1245595707.15367.66.camel@violet>
	<2d5a2c100906210930q394fcf77hcd2bf39c26ae74f8@mail.gmail.com>
	<1245603529.15367.68.camel@violet>
	<2d5a2c100906211047n31b9d4dajac290601c184380b@mail.gmail.com>
	<1245611096.15367.76.camel@violet>
	<2d5a2c100906221449y6e37cb19x1bc27085bac318f4@mail.gmail.com>
	<2d5a2c100906221608v5e3e3d8aydf66b13826ad88fa@mail.gmail.com>
	<2d5a2c100906230651m679ccfat5bf4bfb20c130955@mail.gmail.com>
	<1245768036.15367.78.camel@violet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel and Luiz

(me commenting without any real knowledge about the issue, but being
curious and having seen similar stuff on other protocols... :)

On Tue, 23 Jun 2009 17:06:12 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> > Moving ahead, what about the timeout, 20 seconds seems too much
> > doesn't it? Are you fine with the places where I clear the timer? =20
>=20
> the timeout should be 2 seconds. At most 5 seconds.
>=20
> I still prefer if we just send DISC and then wait for the remote stack
> to do the right thing. If it doesn't then that stack is so broken that
> whatever we try to do is wrong anyway at that point. =20

What if the remote stack went away completely (machine crashed, out of
battery...)?

Best regards,

	Stefan
--=20
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=C3=BCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=C3=BCrnberg)
