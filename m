Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Krause <Andreas.Krause@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] ISSC USB Dongle does not work with current bluez?
References: <200407222124.44032.Andreas.Krause@web.de> <1090529272.21828.41.camel@pegasus>
In-Reply-To: <1090529272.21828.41.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200407230649.28305.Andreas.Krause@web.de>
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
Date: Fri, 23 Jul 2004 06:49:28 +0200

> > I've got a Bluetooth USB Dongle, Vendor ID 0x1131 (ISSC, Integrated
> > System Solution Corp.), Product ID 0x1001, Revision 3.115. 
> where do you got these dongle?

http://cgi.ebay.de/ws/eBayISAPI.dll?ViewItem&item=5709740304


> you only need bluez-libs-2.8, bluez-utils-2.8 and bluez-hcidump-1.9. The
> rest of the BlueZ packages are deprecated and you will run into trouble
> installing them.

OK, unmerged all ebuilds and just installed these three from tarball.

hciconfig -a says the same as in my original posting.

> Run "hcidump -x" and show it to us while executing these commands.

The following dump is the output of 'hcidump -x' while running 'hciconfig -a'. 
Running 'hcitool inq' or 'hcitool scan' does not trigger any output from 
'hcidump -x'!

sweethome root # hcidump -x
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
  01 14 0C 00 42 6C 75 65 5A 20 28 30 29 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 7
  01 23 0C 00 00 01 00
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
  01 01 10 00 01 72 01 01 39 00 72 01


CU - nak


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
