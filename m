Return-Path: <cijoml@volny.cz>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] MS keyboard and mouse problem
Date: Mon, 27 Oct 2003 21:20:08 +0100
References: <200310271958.55594.cijoml@volny.cz> <1067284808.24042.6.camel@pegasus>
In-Reply-To: <1067284808.24042.6.camel@pegasus>
Cc: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200310272120.08176.cijoml@volny.cz>
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

YES! That helped! And now please tell me where and how could I download
your HID implementation.

I don't want use bthid when official HID exists for BlueZ..is somewhere any=
=20
howto too for this implementation?

Thanks

Michal

Dne po 27. =F8=EDjna 2003 21:00 jste napsal(a):
> Hi Michal,
>
> >         # Authentication and Encryption
> >         auth enable;
> >         encrypt enable;
>
> don't do this, because the mouse didn't support auth or encrypt. And the
> keyboard also works without it. It is the job of the HID service daemon
> to enable encryption after the L2CAP channels are established.
>
> Regards
>
> Marcel
