Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100816172238.GA27814@joshua.mesa.nl>
References: <201008121013.o7CADR8r004125@joshua.mesa.nl>
	<1281613299.12579.266.camel@localhost.localdomain>
	<20100816172238.GA27814@joshua.mesa.nl>
Date: Mon, 16 Aug 2010 22:47:08 +0300
Message-ID: <AANLkTi=p5WD+WELPNo=URLVTnpaKQ4xFk9Efu2HiviYE@mail.gmail.com>
Subject: Re: [PATCH] IrMC sync server support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Marcel J.E. Mol" <marcel@mesa.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 16, 2010 at 8:22 PM, Marcel J.E. Mol <marcel@mesa.nl> wrote:
> On Thu, Aug 12, 2010 at 07:41:39AM -0400, Marcel Holtmann wrote:
>> Hi Marcel,
>>
>> > A reasonable working IrMC SYNC server (only full phonebook sync suppor=
t)
>> > Support for cal and note by just returning nothing.
>> > ---
>> > =A0Makefile.am =A0 =A0| =A0 =A03 +
>> > =A0plugins/irmc.c | =A0488 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++
>> > =A0src/main.c =A0 =A0 | =A0 12 ++-
>> > =A0src/obex.h =A0 =A0 | =A0 =A01 +
>> > =A04 files changed, 502 insertions(+), 2 deletions(-)
>> > =A0create mode 100644 plugins/irmc.c
>> >
>> > diff --git a/Makefile.am b/Makefile.am
>> > index 73e2f28..ce8c675 100644
>> > --- a/Makefile.am
>> > +++ b/Makefile.am
>> > @@ -58,6 +58,9 @@ builtin_sources +=3D plugins/pbap.c plugins/phoneboo=
k.h \
>> > =A0builtin_modules +=3D syncevolution
>> > =A0builtin_sources +=3D plugins/syncevolution.c
>> >
>> > +builtin_modules +=3D irmc
>> > +builtin_sources +=3D plugins/irmc.c plugins/phonebook.h
>> > +
>> > =A0builtin_nodist +=3D plugins/phonebook.c
>> >
>> > =A0libexec_PROGRAMS +=3D src/obexd
>> > diff --git a/plugins/irmc.c b/plugins/irmc.c
>> > new file mode 100644
>> > index 0000000..96fd807
>> > --- /dev/null
>> > +++ b/plugins/irmc.c
>> > @@ -0,0 +1,488 @@
>> > +/*
>> > + *
>> > + * =A0OBEX IrMC Sync Server
>> > ...
>> > +#include "dbus.h"
>> > +
>> > +#define IRMC_CHANNEL =A0 =A0 =A0 17
>>
>> we did have a list of defined RFCOMM channels for various protocols, but
>> just don't remember where it is.
>>
>> Johan, we should put that into the doc/ directory actually. Can you dig
>> up that list and commit it as text file.
>>
>
> Any news on this one? Is 17 the correct channel for IrMC?

I just took a look in the spec, it just say that the channel 'varies',
which is not very revealing and it does not suggest anything. The only
record that I found was using channel 11 which apparently we are not
using too.


--=20
Luiz Augusto von Dentz
Computer Engineer
