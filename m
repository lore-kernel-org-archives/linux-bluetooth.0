Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'Max Krasnyansky'" <maxk@qualcomm.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Mon, 12 May 2003 15:51:45 -0700
Message-ID: <000801c318d9$1040d500$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <000201c31771$70577930$6400a8c0@baked>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

I'm replying to myself again. But I said I would, so I guess that makes it
ok. ;)

Cetecom is happy with the decision you guys have made. Sending the error to
syslog so that it can be displayed on the system console and put in the
system log file is good enough. If an app must know, it can monitor syslog.
Everyone's in agreement that this is the right thing to do.

Having the messages appear on the console is enough to pass testing. We
shouldn't need a special app that monitors syslog. We could submit a copy o=
f
the syslog if necessary.

-Daryl.

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net=20
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of=20
> Daryl Van Vorst
> Sent: May 10, 2003 8:57 PM
> To: 'Marcel Holtmann'; 'Max Krasnyansky'
> Cc: 'BlueZ Mailing List'
> Subject: RE: [Bluez-devel] Qualification Testing
>=20
>=20
> Marcel,
>=20
> > Daryl, can you please check with Cetecom what is really
> > needed to pass this test. From my understanding we do all=20
> > right, because we notifier the application (ok, in this case=20
> > the complete Linux system) with an error message in the syslog.
> >=20
> > How must the testing application react on these errors. Is it
> > enough to put an error on the screen, or must it close the=20
> > L2CAP connection. I think we should write a test application=20
> > which reads the syslog and deals with the L2CAP error=20
> > messages in some way.
>=20
> I think it is enough to put an error message on the screen.=20
> If necessary we could make the application look at syslog -=20
> which would definitely demonstrate the ability for the stack=20
> to notify the app.
>=20
> I'll verify this on Monday.
>=20
> -Daryl.
>=20
>=20
>=20
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003,=20
> Santa Clara The only event dedicated to issues related to=20
> Linux enterprise solutions www.enterpriselinuxforum.com
>=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net=20
> https://lists.sourceforge.net/lists/listinfo/b> luez-devel
>=20
