Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Network Access Point - pairing problem
From: Marcel Holtmann <marcel@holtmann.org>
To: "D.W." <sword@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <002901c4c1da$b4d3fec0$0300a8c0@supercomputer>
References: <002901c4c1da$b4d3fec0$0300a8c0@supercomputer>
Content-Type: text/plain
Message-Id: <1099512925.7125.161.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 03 Nov 2004 21:15:25 +0100

Hi Daniel,

> I use kernel 2.4.22 on an axis devboard82. The bluez stack is not the
> latest(PAN, SDP, utils, libs are still seperate packages), because I
> had problems porting later versions to the devboard.

you use a version where many fixes are missing.

> But except the pairing problem at first contact it works perfectly.
> Except the PIN (it's a static one at server side) there is no further
> authentification necessary.
> Security mode 2 or 3? What do you mean? Can I check it?

What does "hciconfig -a" say?

> When I try to connect to the server at first contact, I have to enter
> the PIN(client side) and after entering the right pin I get the
> message :"Authentification failed." 

Run "hcidump -x" and we can see what really happens.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
