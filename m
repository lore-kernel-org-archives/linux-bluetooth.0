Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030513095851.0d257510@unixmail.qualcomm.com>
Date: Tue, 13 May 2003 10:37:02 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000801c318d9$1040d500$1a01010a@baked>
References: <000201c31771$70577930$6400a8c0@baked>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 03:51 PM 5/12/2003, Daryl Van Vorst wrote:
>Marcel,
>
>I'm replying to myself again. But I said I would, so I guess that makes it
>ok. ;)
>
>Cetecom is happy with the decision you guys have made. Sending the error to
>syslog so that it can be displayed on the system console and put in the
>system log file is good enough. If an app must know, it can monitor syslog.
>Everyone's in agreement that this is the right thing to do.
>
>Having the messages appear on the console is enough to pass testing. We
>shouldn't need a special app that monitors syslog. We could submit a copy of
>the syslog if necessary.
Hmm, ok :). But after thinking more about this I think that we probably still need 
some way to tell the apps that link became unreliable. I mean parsing syslogs is 
not very elegant solution :). Also even though Cetecom accepted it as a solution 
other BQBs might not.

Here is what I had in mind. We could add L2CAP socket option L2CAP_RELIABILITY,
which will be used by the apps that are "paranoid" :) about link reliability.
Then whenever we receive corrupted L2CAP frame we'd check connected sockets, attached
to this connection, that have this option enabled and signal error condition on them. 
i.e. read/recvmsg will return error. Application can then either clear that error with 
getsockopt(SO_ERROR) and continue or close the socket.

Comments ?

Max
