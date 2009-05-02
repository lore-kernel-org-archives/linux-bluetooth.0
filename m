Return-Path: <cyrus@holtmann.org>
Message-Id: <49FC2455020000BF000290DA@mailgw2.hevs.ch>
Date: Sat, 02 May 2009 10:45:41 +0200
From: "Marc Pignat" <Marc.Pignat@hevs.ch>
To: <marcel@holtmann.org>,<jkosina@suse.cz>
Cc: <ext-roger.quadros@nokia.com>,<linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.30-rc4 hid bluetooth not working
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

>>> Marcel Holtmann <marcel@holtmann.org> 05/02/09 12:57 AM >>>
>Hi Jiri,
>
>> > Subject: bluetooth: Fix serialization when adding/deleting connections=
 in hci_sysfs
>> >=20
>> > add_conn and del_conn should be serialized, but flush_workqueue can't =
be used
>> > by the worker thread on it's own queue, so use flush_work to =
serialize add_conn
>> > and del_conn against each other.
>> >=20
>> > Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>
>>=20
>> Acked-by: Jiri Kosina <jkosina@suse.cz>
>>=20
>> FWIW.
>
>nak from my side since I think it is the wrong fix. We really wanna wait
>for all works to finish here. This includes work from other connection
>attempts or terminations.

IMHO, there is no need to wait for work currently running, since this is a
singlethread workqueue.

But it is perhaps simpler to use a lock (mutex or watherver locking =
primitive).

Regards

Marc
