Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm problem
From: Marcel Holtmann <marcel@holtmann.org>
To: giochi <giochi@telvia.it>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040426225552.68b1ab36@bizio.slackware-italia.com>
References: <20040422233858.1bb6a766@bizio.slackware-italia.com>
	 <1082697339.23959.84.camel@pegasus>
	 <20040426225552.68b1ab36@bizio.slackware-italia.com>
Content-Type: text/plain
Message-Id: <1083023063.28880.167.camel@pegasus>
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
Date: Tue, 27 Apr 2004 01:44:23 +0200

Hi,

> root@bizio:~# find / -name rfcomm
> /lib/modules/2.6.5/kernel/net/bluetooth/rfcomm
> /usr/bin/rfcomm
> /usr/src/linux-2.6.5/net/bluetooth/rfcomm
> /usr/src/linux-2.6.5/include/config/bt/rfcomm
> /proc/bluetooth/rfcomm
> /second/bluez-utils-2.6/rfcomm
> /second/bluez-utils-2.6/rfcomm/rfcomm
> root@bizio:~# ll /usr/bin/rfcomm 
> -rwxr-xr-x    1 root     root        45547 Apr 21 01:13 /usr/bin/rfcomm* (the only executable that I have on my system)
> 
> root@bizio:~# sdptool add --channel=9 OPUSH
> OBEX Object Push service registered
> root@bizio:~# sdptool add --channel=8 OPUSH
> OBEX Object Push service registered
> 
> root@bizio:/home/disco# rfcomm bind /dev/rfcomm0 00:0A:28:B1:9C:6E 8
> Wrong number of parameters.
> root@bizio:/home/disco# rfcomm bind /dev/rfcomm0 00:0A:28:B1:9C:6E 9
> Wrong number of parameters.
> root@bizio:/home/disco# rfcomm connect 0 00:0A:28:B1:9C:6E 8
> Wrong number of parameters.
> root@bizio:/home/disco# rfcomm connect 0 00:0A:28:B1:9C:6E 9
> Wrong number of parameters.

as I said it is the wrong rfcomm program. What does "rfcomm -h" say?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
