Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] NEC usb bluetooth support
From: Marcel Holtmann <marcel@holtmann.org>
To: Mitch <Mitch@0Bits.COM>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FDF2875.9030706@0Bits.COM>
References: <3FDF2875.9030706@0Bits.COM>
Content-Type: text/plain
Message-Id: <1071601584.27574.3.camel@pegasus>
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
Date: Tue, 16 Dec 2003 20:06:24 +0100

Hi Mitch,

> Just bought one of these, but doesn't seem to work on 2.6.0-test11.
> syslog spews out:
> 
>   Bluetooth: HCI socket layer initialized
>   Bluetooth: HCI USB driver ver 2.4
>   hci_usb: probe of 7-2:1.1 failed with error -5
>   drivers/usb/core/usb.c: registered new driver hci_usb
> 
> Tried adding the device id's to hci_usb.c in vain.
> 
> Any ideas to get this beast working ?

your dongle should work out of the box. Have you tried 2.4.23?

Do you have a /proc/bus/usb/devices for us? It should show you something
like this

	T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
	D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
	P:  Vendor=0a12 ProdID=0001
	C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
	I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
	E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
	E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
	E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
