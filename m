Return-Path: <david.krapohl@halifax.rwth-aachen.de>
Date: Sun, 31 Oct 2004 11:27:06 +0100
From: David Krapohl <david.krapohl@halifax.rwth-aachen.de>
Subject: Re: [Bluez-devel] l2cap.c fails on compile
In-reply-to: <1099215756.16247.33.camel@pegasus>
To: bluez-devel@lists.sourceforge.net
Cc: Marcel Holtmann <marcel@holtmann.org>
Message-id: <200410311127.06861.david.krapohl@halifax.rwth-aachen.de>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <200410311038.10680.david.krapohl@halifax.rwth-aachen.de>
 <1099215756.16247.33.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Am Sonntag, 31. Oktober 2004 10:42 schrieb Marcel Holtmann:
> Hi David,
>
> > Can anybody confirm, that the latest bluetooth patch fails on compile?
> > I get this error message with patch-2.6.9-mh3 and vanilla-sources:
> >
> >   CC [M]  net/bluetooth/l2cap.o
> > net/bluetooth/l2cap.c: In function `__l2cap_sock_close':
> > net/bluetooth/l2cap.c:77: nicht implementiert: =BBinline=AB beim Aufruf=
 von
> > =BBl2cap_get_ident=AB gescheitert: function body not available
> > net/bluetooth/l2cap.c:284: nicht implementiert: von hier aufgerufen
> > net/bluetooth/l2cap.c:78: nicht implementiert: =BBinline=AB beim Aufruf=
 von
> > =BBl2cap_send_req=AB gescheitert: function body not available
> > net/bluetooth/l2cap.c:291: nicht implementiert: von hier aufgerufen
> > make[2]: *** [net/bluetooth/l2cap.o] Fehler 1
> > make[1]: *** [net/bluetooth] Fehler 2
> > make: *** [net] Fehler 2
>
> what compiler do you used?
>
> Regards
>
> Marcel
>
Hi Marcel,
thanks for your fast reply.
I used gcc version 3.4.2.=20
A try with gcc 3.3.4 shows no errors.
david
