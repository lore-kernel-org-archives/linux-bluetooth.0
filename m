Return-Path: <n1c0l4s.l3@wanadoo.fr>
From: nicolas <n1c0l4s.l3@wanadoo.fr>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: inactivity of my Bt
Date: Thu, 24 Jun 2004 22:35:41 +0200
References: <200406232055.06709.n1c0l4s.l3@wanadoo.fr> <200406242015.13230.n1c0l4s.l3@wanadoo.fr> <1088106990.4296.131.camel@pegasus>
In-Reply-To: <1088106990.4296.131.camel@pegasus>
Cc: Marcel Holtmann <marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200406242235.41539.n1c0l4s.l3@wanadoo.fr>
List-ID: <bluez-devel.lists.sourceforge.net>

Le jeudi 24 Juin 2004 21:56, Marcel Holtmann a =E9crit=A0:
Hi Marcel,=20
> Hi Nicolas,
>
> > > > if i enter Hidd --server  the console    tell me:
> > > >
> > > > # hidd --server
> > > > Can't listen on HID control channel: Address already in use
> > >
> > > then there is already one server running on that PSM. Check with ps
> > > what daemons you use.
> >
> > USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> > nicolas   4344  0.0  3.1 22748 8128 ?        S    02:07   0:01 kdeinit:
> > dcopserver --nosid nicolas   4397  0.0  5.0 26560 12856 ?       S  =20
> > 02:08   0:05 kbluetoothd --dontforceshow
> >
> > is kdeinit: dcopserver --nosid   my "ghost" deamon ?
>
> there must be something like hcid and hidd.
>
> > And sometimes if i put out the batteries a
Oh sorry i have not see that i have also=20

root      4902  0.0  0.2  1620  552 ?        Ss   22:16   0:00 /usr/bin/hid=
d --server

> > nd i put on all work well=20
> > whereas  pressing mouse button gives no result
>
> I have no answer for that. Here everything works perfect. May I asked
> that already. Is role switch and sniff link policy activated?

ooops  i don't understand your question   why do you mean?

> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
> digital self defense, top technical experts, no vendor pitches,
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

=2D-=20
Ce mail a =E9t=E9 =E9crit sous linux mandrake cooker (www.linux-mandrake.co=
m/fr)
avec KMail 1.6.2 (www.kde.org)

Kernel: 2.6.7-2mdk
Kde 3.2.3
