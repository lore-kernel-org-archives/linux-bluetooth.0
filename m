Return-Path: <n1c0l4s.l3@wanadoo.fr>
From: nicolas <n1c0l4s.l3@wanadoo.fr>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: inactivity of my Bt
Date: Thu, 24 Jun 2004 00:28:07 +0200
References: <200406232055.06709.n1c0l4s.l3@wanadoo.fr> <1088028819.4296.7.camel@pegasus>
In-Reply-To: <1088028819.4296.7.camel@pegasus>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200406240028.07415.n1c0l4s.l3@wanadoo.fr>
List-ID: <bluez-devel.lists.sourceforge.net>

Le jeudi 24 Juin 2004 00:13, vous avez =E9crit=A0:
> Hi Nicolas,
>
> > i have with your advices installed my bluetooth  but i have a big
> > problem, if i let my bluetooth alone a time too long 10-15 min   i lost
> > my bluetooth and i have to use a ps/2 or usb keyboard/ mouse to reinsta=
ll
> >  ( hcitool inq  scan and hidd -c )
> >
> > there is a way to keep it alive ?
>
> mostly every HID will disconnect after some time. Start "hidd --server"
> at boot time and your mouse or keyboard will reconnect after a keypress.
>

and how can i start "hidd --server" at boot time?

> > i hava a second question which is there is a way to have my bluetooth
> > launch when my kernel is launch?  ( like in windows)
>
> Not needed, because HID devices will reconnect.
>
> > i mail to you directly because when i post in the Ml i receive this mai=
l:
> >
> > his is the SMTP Server program at host wanadoo.fr.
> >
> > I'm sorry to have to inform you that the message returned
> > below could not be delivered to one or more destinations.
> >
> > For further assistance, please send mail to <postmaster>
> >
> > If you do so, please include this problem report. You can
> > delete your own text from the message returned below.
> >
> >                         The SMTP Server program
> > <bluez-users@lists.sourceforge.net>: host
> > mail.sourceforge.net[66.35.250.206] said: 550 "rejected because your SM=
TP
> > server, 193.252.22.26,is in the SF.net RBL.
>
> The error message is clear. Get this fixed, because I want to see such
> questions on the mailing list and thus in its archive.
>
> Regards
>
> Marcel

=2D-=20
Ce mail a =E9t=E9 =E9crit sous linux mandrake cooker (www.linux-mandrake.co=
m/fr)
avec KMail 1.6.2 (www.kde.org)

Kernel: 2.6.7-2mdk
Kde 3.2.3
