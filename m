Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] NAT connection established but no data transport
From: Marcel Holtmann <marcel@holtmann.org>
To: skrzypek-piotr@o2.pl
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041101214200.C1E5BD0B0C@rekin6.o2.pl>
References: <20041101214200.C1E5BD0B0C@rekin6.o2.pl>
Content-Type: text/plain
Message-Id: <1099347952.10948.19.camel@pegasus>
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
Date: Mon, 01 Nov 2004 23:25:51 +0100

Hi Pete,

> First of all i would like to describe my situation. I`ve got two
> computers: first one is a linux debian server (with kernel 2.4.27
> pachted with grsecurity and bluez patch) and second is a notebook
> running windows XP Professional. After many problems i`ve
> succesfully established a NAT connection between the devices
> (bluetake bt-007 using hciusb driver). The devices are paired and
> connected but i can`t  notice the data transmittion. I tried to ping
> one device from the other but i recive "timeout". I also tried
> l2ping and it shows that connection id good (i`ve pinged a winmac
> from linuxmac and it showed that data comes from linuxmac i don`t
> know why but i think it means that connection is good). I`m not
> really good in linux but i think it`s a problem with linux he can`t
> recognise it as a network device. When i type ifconfig it shows
> everything but not the bluetooth connection until i type ifconfig
> bnep0. Maybe you can give me some advice how to make linux recognise
> it and let it use wlan0 connection and eth0 connection. Please help
> me cause i`m tryin to configure it for weeks.

try to activate bnep0 and set an IP address.

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
