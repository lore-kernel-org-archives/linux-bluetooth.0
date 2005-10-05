Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] no route to host
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43442E4A.2070509@gmx.de>
References: <4344185B.1030401@gmx.de>
	 <1128538606.5447.42.camel@localhost.localdomain>  <43442E4A.2070509@gmx.de>
Content-Type: text/plain
Message-Id: <1128545657.5447.71.camel@localhost.localdomain>
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
Date: Wed, 05 Oct 2005 22:54:17 +0200

Hi Rainer,

> >> when trying to access rfcomm devices, I get:
> >> minicom: cannot open /dev/rfcomm0: No route to host
> >>
> >> rfcomm tells me:
> >> rfcomm0: 00:20:E0:3A:BC:28 channel 3 clean
> >>
> >> I am using bluez-utils version 2.19
> >> I cannot find any log files, ...
> >> I can connect to my handy via bluetooth with e.g. wammu
> > 
> > run "hcidump -X -V" to see where the problem might be. What is
> while running minicom, I get no output.
> 
> > "hciconfig -a" telling you?
> 
> hci0:   Type: USB
>         BD Address: 00:20:E0:3A:BC:28 ACL MTU: 192:8 SCO MTU: 64:8

the address in the rfcomm call is the remote address and not the local
one. There is no loopback support in Bluetooth.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
