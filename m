Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Make a local network using two Bluetooth USB
	Dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: PC32 YPXin <YPXin@Winbond.com.tw>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E36E0C5C92D97049B4855B5498A9454790E93B@weshml02.winbond.com.tw>
References: <E36E0C5C92D97049B4855B5498A9454790E93B@weshml02.winbond.com.tw>
Content-Type: text/plain
Message-Id: <1084100698.9269.19.camel@pegasus>
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
Date: Sun, 09 May 2004 13:04:58 +0200

Hi,

> 	I have made a File Transfer using two Bluetooth USB Dongle(which is Bigabyte supporting Bluetooth Spec v1.1) between a linux box and windows machine.
> 	In windows, I can find the BlueDevice in linux and its service(such as Audio Gateway, include File Transfer), but I cannot transfer to linux, because timeout.
> 	
> 	I do that as the document from bluez.org:
> 		Get the kernel 2.4.20, and patch it.
> 		then compile with support Bluetooth:
> 				<M> L2CAP
> 				<M> SCO links
> 				<M>RFCOMM
> 				<M>BNEP
> 			Bluetooth device drivers:
> 				<M>HCI USB driver
> 				<M>HCI UART driver
> 				<M>HCI BlueFRITZ! USB driver
> 				<M>HCI VHCI driver
> 
> 	make, make install,make modules,make modules_install
> 	then reboot
> 	install the bluetools from bluez.org
> 	and ln /usr/sbin/hcid /sbin/hcid
> 	/etc/init.d/bluetooth start
> 	and get [OK];
> 	Then let windows to search the device, and found it, got its service, it was ok. Then transfer file, but failed.
> 	This is log from hcidump:
> 	
> 		> HCI Event: Connect Request(0x04) plen 10
> 		< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> 		> HCI Event: Command Status(0x0f) plen 4
> 		> HCI Event: Connect Complete(0x03) plen 11
> 		< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> 		> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> 		> HCI Event: Command Complete(0x0e) plen 6
> 		< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> 		> HCI Event: Max Slots Change(0x1b) plen 3
> 		> HCI Event: Command Status(0x0f) plen 4
> 		> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> 		> ACL data: handle 0x0028 flags 0x02 dlen 12
> 		    L2CAP(s): Connect req: psm 1 scid 0x0049
> 		> HCI Event: Disconn Complete(0x05) plen 4                                               
>                                     
> 
> 	I don't know why the L2Cap(s): Connect req broken?

to let others find your service information you need to run a SDP
server. Try starting sdpd.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
