Return-Path: <n1c0l4s.l3@wanadoo.fr>
From: nicolas <n1c0l4s.l3@wanadoo.fr>
To: Marcel Holtmann <marcel@holtmann.org>, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: inactivity of my Bt
Date: Thu, 24 Jun 2004 20:15:13 +0200
References: <200406232055.06709.n1c0l4s.l3@wanadoo.fr> <200406241932.24780.n1c0l4s.l3@wanadoo.fr> <1088098323.4296.68.camel@pegasus>
In-Reply-To: <1088098323.4296.68.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200406242015.13230.n1c0l4s.l3@wanadoo.fr>
List-ID: <bluez-devel.lists.sourceforge.net>

Le jeudi 24 Juin 2004 19:32, Marcel Holtmann a =E9crit=A0:
> Hi Nicolas,
>
> > if i enter Hidd --server  the console    tell me:
> >
> > # hidd --server
> > Can't listen on HID control channel: Address already in use
>
> then there is already one server running on that PSM. Check with ps what
> daemons you use.
>

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
nicolas   4344  0.0  3.1 22748 8128 ?        S    02:07   0:01 kdeinit: dco=
pserver --nosid
nicolas   4397  0.0  5.0 26560 12856 ?       S    02:08   0:05 kbluetoothd =
=2D-dontforceshow

is kdeinit: dcopserver --nosid   my "ghost" deamon ?

i have not succeed to have bluetooth as service
> > and if i push the connect but or use the mouse or the keyboard nothing
> > work  i have to use a ps2 one and do hcitool inq  & hidd -c
>
> You don't have to push the connect button. Press a mouse button or any
> key on the keyboard. If you press the connect button you unpair the
> device.
>
allright i haven't understand this

> Regards
>
> Marcel
>
And sometimes if i put out the batteries and i put on all work well whereas=
  pressing mouse button gives no result
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
