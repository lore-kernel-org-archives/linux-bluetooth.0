Return-Path: <jjbrucker@free.fr>
From: Jean-Jacques Brucker <jjbrucker@free.fr>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] =?iso-8859-1?q?R=E9f=2E_=3A_Re=3A_bluez_=3A_new_bluetooth?=
 =?iso-8859-1?q?_keyboard=09supported_by?= hidd.
References: <OF6F05A6E3.87C65DE9-ONC12571EA.005C0311-C12571EA.005E2464@sagem.com> <1158408734.6839.3.camel@localhost>
In-Reply-To: <1158408734.6839.3.camel@localhost>
MIME-Version: 1.0
Date: Sat, 16 Sep 2006 17:07:56 +0200
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609161707.56327.jjbrucker@free.fr>
List-ID: <bluez-devel.lists.sourceforge.net>

OK, thx. Gonna use it monday morning, but it seems that the do_search=20
option(function) won't find the device.

Note: You dislike my doxygen comments ? ;-)
Being serious I still ask me why people (like you) in low-level free softwa=
res=20
still don't use tools/comments like doxygen to make their code more easily=
=20
understandable for others.

 For exemple doxygen comments could have make me understand the fakehid=20
variable before to send you my patch...=20

 Cordialement,=20
Jean-Jacques.


Le Samedi 16 Septembre 2006 14:12, Marcel Holtmann a =E9crit=A0:
> Hi Jean-Jacques,
>
> >  Thx to answer me so fast, sorry that in the precedent patch i forget
> > to clean fakehid.c. This is done in this patch. As, I have see in the
> > cvs you should have a J3 Keyboard too... :-)
>
> a slight modified version is now committed to the CVS.
>
> > About my Nokia, I know the applet but i don't have take the time to
> > analyse source codes.
>
> The hidd needs to be D-Bus enabled.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
