Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DBT-120 firmware upgrade
References: <200411261152.29925.pavouk@pavouk.org> <1101489949.6514.33.camel@pegasus>
In-Reply-To: <1101489949.6514.33.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200411271655.27322.pavouk@pavouk.org>
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
Date: Sat, 27 Nov 2004 16:55:27 +0100

Hello,

when I compare original backuped firmware with downloaded, that
there are few differences:
--------------
Filename        backup.dfu
bcdDevice       443
Firmware type   CSR-dfu2
--------------
Filename        GenericCSR.dfu
bcdDevice       ffff
Firmware type   CSR-dfu1
--------------

Can somebody explain me, what does it means and if it is not problem
for flashing?

Downloaded firmware is much longer than backuped. Is it OK?

Thanks,

Pavel Ruzicka

PS. Here is complete btdfu verify output:
-------------------------------------------
[root@home bt]# btdfu verify backup.dfu
Filename        backup.dfu
Filesize        347078
Checksum        be0ea993

DFU suffix      43 04 01 00 12 0a 00 01 55 46 44 10 93 a9 0e be

idVendor        0a12
idProduct       0001
bcdDevice       443

bcdDFU          1.0
ucDfuSignature  DFU
bLength         16
dwCRC           be0ea993

Firmware type   CSR-dfu2
Firmware check  valid checksum
----------------------------------------------
[root@home bt]# btdfu verify GenericCSR.dfu
Filename        GenericCSR.dfu
Filesize        994866
Checksum        65085dde

DFU suffix      ff ff 01 00 12 0a 00 01 55 46 44 10 de 5d 08 65

idVendor        0a12
idProduct       0001
bcdDevice       ffff

bcdDFU          1.0
ucDfuSignature  DFU
bLength         16
dwCRC           65085dde

Firmware type   CSR-dfu1
Firmware check  valid checksum
------------------------------------------


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
