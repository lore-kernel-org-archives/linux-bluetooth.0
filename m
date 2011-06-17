Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308284110.2196.29.camel@aeonflux>
References: <1308275200-17393-1-git-send-email-lucas.demarchi@profusion.mobi> <1308284110.2196.29.camel@aeonflux>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 17 Jun 2011 08:51:41 -0300
Message-ID: <BANLkTi=K7f5n9Wb6KAoD2sCHiWG9tBRqdA@mail.gmail.com>
Subject: Re: [PATCH v2] build: Add support for systemd service configuration
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jun 17, 2011 at 1:15 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> -DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules
>> +DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules --with-systemdunitdir=
>
> can we please do it the same way I did it for oFono and ConnMan. I have
> no idea what you are doing here. If --with-systemdunitdir is not given,
> then it should be disabled and it should be that by default.

This is indeed the same code as in oFono and ConnMann. If
`--with-systemdunitdir' is not given it defaults to checking
`pkg-config --variable systemdsystemunitdir systemd'. So in case we
call `make distcheck' and systemd is installed, this will fail, as it
will in oFono and ConnMann. The difference is that there we have
`DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles'. I may do the same
and let `DISTCHECK_CONFIGURE_FLAGS = --disable-configfiles'. What do
you think? Then I think I could remove the `--disable-udevrules' as
well.


Regards
Lucas De Marchi
