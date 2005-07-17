Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to transmit hexadecimal data and voice?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050715064552.34058.qmail@web15701.mail.cnb.yahoo.com>
References: <20050715064552.34058.qmail@web15701.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1121607163.22662.9.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 17 Jul 2005 15:32:43 +0200

Hi,


> I use two CSR(Bluecore2) modlues on two arm platforms respectively .
> And now,I can create ACL and SCO connection=EF=BC=8Cboth l2test and sco=
test
> run well.Even,I can transmit files using the program obex_test.
> But still,
> 1>I don't know how to transmit acl data such as hexadecimal data. Can
> I use "hcitool cmd"??If I can,what is the hci command?

use the L2CAP or RFCOMM interfaces for data transmission.

> 2>I just want to transmit voice data through bluetooth modules so that
> I can talk with others using microphone.And I connected a MC145483
> Codes throught PCM interface yesterady.But I have no idea about how to
> do now.which profile should I use? sdptool add Headset?I think it's
> not the right one! And if I add the right profile,what should I do
> next?? Maybe some tools just like btsco?

The scotest program shows on how to create SCO only connections.

Regards

Marcel

>=20



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
