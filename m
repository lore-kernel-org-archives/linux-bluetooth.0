Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Some BT problems connecting between Ipaq and USB
	dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200408050214.25654.wim.delvaux@adaptiveplanet.com>
References: <200408050214.25654.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1091669135.16182.93.camel@pegasus>
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
Date: Thu, 05 Aug 2004 03:25:35 +0200

Hi Wim,

> Am I having problems setting up a bluetooth connection between my Ipaq 3870 
> Fam 0.7.2 and my debian sid desktop.
> 
> I tried 
> 
> clean reboot.
> 
> 	Server runs pand --listen --role NAP
> 
> client
> 	
> 	pand --search --cache --persist
> 
> RESULT
> 
> 	I do see a bluepin dialog on my desktop, I see the PIN code being sent
> 	but then I get as result 
> 
> > HCI Event: PIN Code Request(0x16) plen 6
>   . . . . . .
> > HCI Event: Connect Complete(0x03) plen 11
>   . ) . . . . . . . . .
> < HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
>   . . . . . . . 1 2 3 4 . . . . . . . . .
>   . . .
> > HCI Event: Command Complete(0x0e) plen 10
>   . . . . . . . . . .
> > HCI Event: Connect Request(0x04) plen 10
>   . . . . . . . . . .
> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
>   . . . . . . .
> > HCI Event: Command Status(0x0f) plen 4
>   . . . .
> 
> 	the PIN code is correct.
> 	Normally should also get a dialog box on the Ipaq for the same PIN code
> 
> I tried also running sdptool
> 
> 	Then I also get the PIN code dialog box but with following sequence
> 	and output of command
> 
> OUTPUT
> Inquiring ...
> Failed to connect to SDP server on 00:60:57:35:81:B6: Permission denied
> Failed to connect to SDP server on 00:60:57:02:71:A2: Permission denied
> 
> DUMP
> > HCI Event: Connect Request(0x04) plen 10
>   . . . . . . . . . .
> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
>   . . . . . . .
> > HCI Event: Command Status(0x0f) plen 4
>   . . . .
> > HCI Event: Link Key Request(0x17) plen 6
>   . . . . . .
> < HCI Command: Link Key Request Negative Reply(0x01|0x000c) plen 6
>   . . . . . .
> > HCI Event: Role Change(0x12) plen 8
>   . . . . . . . .
> > HCI Event: Command Complete(0x0e) plen 10
>   . . . . . . . . . .
> > HCI Event: PIN Code Request(0x16) plen 6
>   . . . . . .
> > HCI Event: Connect Complete(0x03) plen 11
>   . ( . . . . . . . . .
> < HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
>   . . . . . . . 1 2 3 4 . . . . . . . . .
>   . . .
> > HCI Event: Command Complete(0x0e) plen 10
>   . . . . . . . . . .
> 
> or RAW
> 
> > 04 04 0A 96 85 0D C7 02 00 12 01 12 01
> < 01 09 04 07 96 85 0D C7 02 00 00
> > 04 0F 04 00 01 09 04
> > 04 17 06 96 85 0D C7 02 00
> < 01 0C 04 06 96 85 0D C7 02 00
> > 04 12 08 00 96 85 0D C7 02 00 00
> > 04 0E 0A 01 0C 04 00 96 85 0D C7 02 00
> > 04 16 06 96 85 0D C7 02 00
> > 04 03 0B 18 28 00 96 85 0D C7 02 00 01 00
> < 01 0D 04 17 96 85 0D C7 02 00 04 31 32 33 34 00 00 00 00 00
>   00 00 00 00 00 00 00
> > 04 0E 0A 01 0D 04 02 96 85 0D C7 02 00
> 
> hcitool properly scans the devices.
> 
> pinging yiels (with dialog )
> 
> ~ # l2ping 00:60:57:02:71:A2
> Can't connect.: Permission denied

looks like one of your devices is in security mode 3. It is not a good
idea to use this security mode.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
