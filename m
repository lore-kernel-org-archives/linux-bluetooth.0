Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ISSC USB Dongle does not work with current bluez?
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Krause <Andreas.Krause@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407231230.50970.Andreas.Krause@web.de>
References: <200407222124.44032.Andreas.Krause@web.de>
	 <200407230649.28305.Andreas.Krause@web.de>
	 <1090570478.21828.47.camel@pegasus>
	 <200407231230.50970.Andreas.Krause@web.de>
Content-Type: text/plain
Message-Id: <1090579307.4791.12.camel@pegasus>
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
Date: Fri, 23 Jul 2004 12:41:47 +0200

Hi Andreas,

> > That is the problem here, because the kernel thinks that the dongle is
> > already in inquiry mode and won't start another one. Please stop hcid
> > and sdpd. Unplug your dongle and replug it. Run "hcidump -x" and then
> > call "hciconfig hci0 up".
> 
> OK that worked.
> Here's the dum while doing "hciconfig hci0 up":
> 
> sweethome root # hcidump -x
> HCIDump - HCI packet analyzer ver 1.9
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
> > HCI Event: Command Complete (0x0e) plen 12
>   01 03 10 00 FF FF 0D 00 00 00 00 00
> < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > HCI Event: Command Complete (0x0e) plen 11
>   01 05 10 00 A6 02 30 0C 00 05 00
> < HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> > HCI Event: Command Complete (0x0e) plen 10
>   01 09 10 00 9E 0B 00 67 11 00
> < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> > HCI Event: Command Complete (0x0e) plen 6
>   01 25 0C 00 60 00
> < HCI Command: Set Event Filter (0x03|0x0005) plen 2
>   00 00
> > HCI Event: Command Complete (0x0e) plen 4
>   01 05 0C 00
> < HCI Command: Write Page Timeout (0x03|0x0018) plen 2
>   00 80
> > HCI Event: Command Complete (0x0e) plen 4
>   01 18 0C 00
> < HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
>   00 7D
> > HCI Event: Command Complete (0x0e) plen 4
>   01 16 0C 00
> < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
>   03
> > HCI Event: Command Complete (0x0e) plen 4
>   01 1A 0C 00
> 
> 
> And here's the dump for "hcitool inq":
> 
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>   33 8B 9E 08 64
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 01 04

I miss the inquiry complete event.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
