Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Running L2CAP & HCI layers without OS
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050222151413.99069.qmail@web53206.mail.yahoo.com>
References: <20050222151413.99069.qmail@web53206.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1109085919.8506.24.camel@pegasus>
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
Date: Tue, 22 Feb 2005 16:25:19 +0100

Hi Filipa,

> > There is no easy way and actually I don't see any
> > need for it. Feel free
> > to start another Bluetooth stack, but this mailing
> > list is about the
> > BlueZ and Linux and not any other operating system.
> 
> I really would like to be able to develop a new
> protocol stack... but unfortunately my knowledge of
> linux or bluetooth is not enough for that ;))
> 
> So, from your answer I suppose the only way of having
> the l2cap and hci layers running without OS is doing
> what I am doing (change the code of these layers to
> avoid the system calls), right? 

BlueZ is tightly bounded to the Linux kernel and thus I don't think that
it is a good idea what you are trying to do. However as long as you
respect its licence, feel free to do whatever you wanna do, but don't
expect any help from this mailing list.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
