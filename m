Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Low bit rate
From: Marcel Holtmann <marcel@holtmann.org>
To: Ramin Rezaiifar <ramin@popak.myftp.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40DA45E0.9000207@popak.myftp.org>
References: <40DA45E0.9000207@popak.myftp.org>
Content-Type: text/plain
Message-Id: <1088068716.4296.35.camel@pegasus>
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
Date: Thu, 24 Jun 2004 11:18:37 +0200

Hi Ramin,

> I use the bluetooth link between a Palm T3 and a Linux machine.
> The data rate seems to be noticeably lower than the rate when I use the 
> Palm device with a Windows XP machine.  In both cases I use a Linksys 
> USB dongle.

actually I don't use Windows, so I can't tell. In general the BlueZ is
as fast as possible. Maybe it is a RFCOMM flow control problem. Make
sure that you use the latest Linux kernel.

> Can I increase the rate with the hcitool by changing the pcacket type 
> for the connection?

No. Changing the packet types makes it only worse. Let the link manager
be able to use every packet type and let it choose the best for your
current connection.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
