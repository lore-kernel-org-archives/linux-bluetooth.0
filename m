Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users]  Again dund
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAT2mvzXDViU6RxBXLMLKoFgEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAT2mvzXDViU6RxBXLMLKoFgEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1099939109.29330.17.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 08 Nov 2004 19:38:29 +0100

Hi Peter,

> I'm not yet able to tell linux, that my bluetooth-connection is a
> ethernet-connection. I have no idea how to manage this with PPP. With YaST I
> tried to define the bt-connection as a networkcard - but it doesn't realy
> work.

I don't get your point. The ppp0 interface can be used and when the
routing information are right then this works. It is not different from
dialin with a modem.

> Linux-Notebook:~ # sdptool search --bdaddr 00:0B:CE:00:01:8F lan
> Searching for lan on 00:0B:CE:00:01:8F ...
> Service Name: Netzwerkzugang
> Service RecHandle: 0x10000
> Service Class ID List:
>   "LAN Access Using PPP" (0x1102)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 1
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
> 
> What can I do - ? - perhaps I have to install SuSE 9.2 ??!

The SuSE 9.2 will improve things, because the kernel, libs and utils are
up to date. However I don't know if that is the problem here. You should
remember that "LAN access using PPP" is deprecated and this stuff is all
PPP related. Look on the internet for more information.

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
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
