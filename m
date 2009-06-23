Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090623200401.6c7e5ea6@stoetzler>
References: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
	 <2d5a2c100906210930q394fcf77hcd2bf39c26ae74f8@mail.gmail.com>
	 <1245603529.15367.68.camel@violet>
	 <2d5a2c100906211047n31b9d4dajac290601c184380b@mail.gmail.com>
	 <1245611096.15367.76.camel@violet>
	 <2d5a2c100906221449y6e37cb19x1bc27085bac318f4@mail.gmail.com>
	 <2d5a2c100906221608v5e3e3d8aydf66b13826ad88fa@mail.gmail.com>
	 <2d5a2c100906230651m679ccfat5bf4bfb20c130955@mail.gmail.com>
	 <1245768036.15367.78.camel@violet> <20090623200401.6c7e5ea6@stoetzler>
Date: Tue, 23 Jun 2009 15:13:47 -0300
Message-ID: <2d5a2c100906231113p23a7249u13de2ecd2a0d5482@mail.gmail.com>
Subject: Re: regression introduced on v2.6.30-rc1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

On Tue, Jun 23, 2009 at 3:04 PM, Stefan Seyfried<seife@suse.de> wrote:
> What if the remote stack went away completely (machine crashed, out of
> battery...)?
>

iirc the link manager on chip detects this and send us the proper disconnec=
t.

--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
