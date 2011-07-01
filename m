Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309463046.2208.56.camel@aeonflux>
References: <1308275200-17393-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1308284110.2196.29.camel@aeonflux> <BANLkTi=K7f5n9Wb6KAoD2sCHiWG9tBRqdA@mail.gmail.com>
 <1309463046.2208.56.camel@aeonflux>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 1 Jul 2011 19:45:01 -0300
Message-ID: <BANLkTinSB_DGVHHpb8PVy3j5SuWrDdb1dw@mail.gmail.com>
Subject: Re: [PATCH v2] build: Add support for systemd service configuration
To: Marcel Holtmann <marcel@holtmann.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jun 30, 2011 at 4:44 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lucas,
>
>> >> -DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules
>> >> +DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules --with-systemdunitdir=
>> >
>> > can we please do it the same way I did it for oFono and ConnMan. I have
>> > no idea what you are doing here. If --with-systemdunitdir is not given,
>> > then it should be disabled and it should be that by default.
>>
>> This is indeed the same code as in oFono and ConnMann. If
>> `--with-systemdunitdir' is not given it defaults to checking
>> `pkg-config --variable systemdsystemunitdir systemd'. So in case we
>> call `make distcheck' and systemd is installed, this will fail, as it
>> will in oFono and ConnMann. The difference is that there we have
>> `DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles'. I may do the same
>> and let `DISTCHECK_CONFIGURE_FLAGS = --disable-configfiles'. What do
>> you think? Then I think I could remove the `--disable-udevrules' as
>> well.
>
> lets do the same as we have done in ConnMan and oFono.
>
> We might just rename --disable-configfiles into --disable-datafiles to
> bring all three projects in sync here.
>
> The --disable-udevrules has to stay since otherwise we would install
> into a system directory. However we can put that under the DATAFILES
> conditional.
>
> Care to send a new set of patches?

Ok.

Bastien, are you going to do it or I can do it myself?

Lucas De Marchi
