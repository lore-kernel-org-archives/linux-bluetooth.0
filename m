Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] build: Add support for systemd service configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 30 Jun 2011 12:44:04 -0700
In-Reply-To: <BANLkTi=K7f5n9Wb6KAoD2sCHiWG9tBRqdA@mail.gmail.com>
References: <1308275200-17393-1-git-send-email-lucas.demarchi@profusion.mobi>
	 <1308284110.2196.29.camel@aeonflux>
	 <BANLkTi=K7f5n9Wb6KAoD2sCHiWG9tBRqdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309463046.2208.56.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

> >> -DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules
> >> +DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules --with-systemdunitdir=
> >
> > can we please do it the same way I did it for oFono and ConnMan. I have
> > no idea what you are doing here. If --with-systemdunitdir is not given,
> > then it should be disabled and it should be that by default.
> 
> This is indeed the same code as in oFono and ConnMann. If
> `--with-systemdunitdir' is not given it defaults to checking
> `pkg-config --variable systemdsystemunitdir systemd'. So in case we
> call `make distcheck' and systemd is installed, this will fail, as it
> will in oFono and ConnMann. The difference is that there we have
> `DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles'. I may do the same
> and let `DISTCHECK_CONFIGURE_FLAGS = --disable-configfiles'. What do
> you think? Then I think I could remove the `--disable-udevrules' as
> well.

lets do the same as we have done in ConnMan and oFono.

We might just rename --disable-configfiles into --disable-datafiles to
bring all three projects in sync here.

The --disable-udevrules has to stay since otherwise we would install
into a system directory. However we can put that under the DATAFILES
conditional.

Care to send a new set of patches?

Regards

Marcel


