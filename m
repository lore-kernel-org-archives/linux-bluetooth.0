Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <003001c77fdc$5fcf6af0$9b01a8c0@LiYong>
References: <003001c77fdc$5fcf6af0$9b01a8c0@LiYong>
Date: Mon, 16 Apr 2007 15:41:30 +0200
Message-Id: <1176730891.30165.20.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] ISSC Bluetooth dongle + GPS receiver problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

> I am testing the ISSC Bluetooth dongle on my ARM platform. I am using Linux 2.6.16 kernel and bluez-utils 3.9. I can connect to a Bluetooth headphone. However, if I connect the USB dongle to a Bluetooth GPS receiver, the connection is broken sometimes. I performed the below steps:
> 
> 1. Insert the ISSC USB dongle to USB port
> 2. run command "hciconfig hci0 up"
> 3. run command "hcitool scan"
> 4. the dongle find the GPS receiver and output the below message: 
> Scanning ...
>         00:0B:0D:76:14:FE       BT-GPS
> 5. run command "rfcomm bind rfcomm0 00:0B:0D:76:14:FE"
> 6. run command "cat /dev/rfcomm0"
> 
> I can get the gps information like that: 
> $GPGSA,A,1,,,,,,,,,,,,,,,*1E
> 
> $GPRMC,034415.781,V,,,,,,,160407,,,N*40
> 
> $GPGGA,034416.769,,,,,0,00,,,M,0.0,M,,0000*5A
> 
> $GPGSA,A,1,,,,,,,,,,,,,,,*1E
> 
> However, the connection is broken after a random time. If I run the hcidump -x command on another terminal, the error message is:
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 01 00 01 00 
> > ACL data: handle 1 flags 0x02 dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40 
>       47 50 47 47 41 2C 30 33 34 
> < ACL data: handle 1 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
>       47 
> > ACL data: handle 1 flags 0x02 dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40 
>       34 33 36 2E 37 38 31 2C 2C 
> < ACL data: handle 1 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
>       50 
> < ACL data: handle 1 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
>       47 
> < ACL data: handle 1 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
>       47 
> < ACL data: handle 1 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
>       41 
> < ACL data: handle 1 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
>       2C 
> < ACL data: handle 1 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
>       30 
> < ACL data: handle 1 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0040 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
>       33 
> < HCI Command: Reset (0x03|0x0003) plen 0
> Receive failed: Broken pipe
> 
> It seems that the ISSC BT dongle is incompatible with BlueZ, anyone encounters the same issue?

actually the ISSC dongle is broken and from my experience a really badly
implemented Bluetooth chip. You are really better of if you get yourself
a CSR BlueCore4 based dongle.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
