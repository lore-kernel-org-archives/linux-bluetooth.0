Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] NAT connection established but no data transport
From: Marcel Holtmann <marcel@holtmann.org>
To: skrzypek-piotr@o2.pl
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041102074127.9B9CAD0B0F@rekin6.o2.pl>
References: <20041101214200.C1E5BD0B0C@rekin6.o2.pl>
	 <1099347952.10948.19.camel@pegasus>
	 <20041101235513.2017B3816E@rekin11.go2.pl>
	 <1099362451.10948.22.camel@pegasus>
	 <20041102074127.9B9CAD0B0F@rekin6.o2.pl>
Content-Type: text/plain
Message-Id: <1099392282.10948.25.camel@pegasus>
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
Date: Tue, 02 Nov 2004 11:44:42 +0100

Hi Pete,

> >> >try to activate bnep0 and set an IP address.
> >> i set: ifconfig bnep0 192.168.0.1
> >> and when i type ifconfig there is nothing about bnep0, but when i
> type
> >> ifconfig bnep0
> >> i can see everything just like it should be: the same mac adress
> >> (read from cover of usb device), ip 192.168.0.1, appropriate mask
> >> etc. but still it doesn`t send/recieve data. 
> >> 
> >> Maybe it can help somehow:
> >> I checked the transmission status on the notebook and it says that
> >> the device is transmitting (especially while pinging) but not
> reciving.
> >
> >are you sure that you are using the latest -mh patch for your kernel?
> 
> There is only one patch for kernel 2.4.27 and i`m using it.

do you have some firewall rules activated? Check the syslog for more
information and check with "hcidump -X" as root what goes over the
Bluetooth interface.

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
