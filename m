Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200412271400.24208.cijoml@volny.cz>
Subject: [Bluez-users] compatible firmwares?
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
Date: Mon, 27 Dec 2004 14:00:24 +0100

Hi Marcel,

are these two firmwares compatible? One I found here:
http://www.dasgenie.com/scrap/archives/000057.html

second I downloaded via btdfu from my dlink dongle (15.3)

notas:/usr/src/btdfu-0.3# src/btdfu verify /usr/src/BTfirmware/dlink.dfu
Filename        dlink.dfu
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

notas:/usr/src/btdfu-0.3# src/btdfu verify /usr/src/BTfirmware/cc_16_4.dfu
Filename        cc_16_4.dfu
Filesize        355054
Checksum        b8efbfbb

DFU suffix      25 05 01 00 12 0a 00 01 55 46 44 10 bb bf ef b8

idVendor        0a12
idProduct       0001
bcdDevice       525

bcdDFU          1.0
ucDfuSignature  DFU
bLength         16
dwCRC           b8efbfbb

Firmware type   CSR-dfu1
Firmware check  valid checksum


Thanks

Michal


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
