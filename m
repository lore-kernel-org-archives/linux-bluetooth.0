Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Tue, 13 May 2003 10:55:31 -0700
Message-ID: <000401c31978$d903f130$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5.1.0.14.2.20030513095851.0d257510@unixmail.qualcomm.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

> >Having the messages appear on the console is enough to pass=20
> testing. We=20
> >shouldn't need a special app that monitors syslog. We could submit a=20
> >copy of the syslog if necessary.
> Hmm, ok :). But after thinking more about this I think that=20
> we probably still need=20
> some way to tell the apps that link became unreliable. I mean=20
> parsing syslogs is=20
> not very elegant solution :). Also even though Cetecom=20
> accepted it as a solution=20
> other BQBs might not.

Technically Cetecom hasn't accepted it yet. That's just preliminary. The BQ=
B
hasn't reviewed the data.

> Here is what I had in mind. We could add L2CAP socket option=20
> L2CAP_RELIABILITY, which will be used by the apps that are=20
> "paranoid" :) about link reliability. Then whenever we=20
> receive corrupted L2CAP frame we'd check connected sockets,=20
> attached to this connection, that have this option enabled=20
> and signal error condition on them.=20
> i.e. read/recvmsg will return error. Application can then=20
> either clear that error with=20
> getsockopt(SO_ERROR) and continue or close the socket.
>=20
> Comments ?

That sounds great to me! That's the sort of thing I was hoping for in the
beginning, but I knew too little about sockets to suggest a workable
solution. :)

-Daryl.
