Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Trouble sending from device (K700i)
From: Marcel Holtmann <marcel@holtmann.org>
To: niklas adolfsson <niklas.adolfsson@home.se>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40FAB231.1020400@home.se>
References: <40FA3DBD.5010401@home.se> <1090142232.4558.60.camel@pegasus>
	 <40FA48B4.1010101@home.se> <1090144899.4558.65.camel@pegasus>
	 <40FAB231.1020400@home.se>
Content-Type: text/plain
Message-Id: <1090173546.4400.21.camel@pegasus>
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
Date: Sun, 18 Jul 2004 19:59:06 +0200

Hi Niklas,

> < ACL data: handle 0x0029 flags 0x02 dlen 11
>     L2CAP(d): cid 0x46 len 7 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 8 pf 0 ilen 3 fcs 0x80
>       A0 00 03
> < ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x46 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 0 dlci 8 pf 1 ilen 0 fcs 0x49
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 1 dlci 8 pf 1 ilen 0 fcs 0x28
> < ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x46 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 8 pf 1 ilen 0 fcs 0x2
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00
> > ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): UA: cr 0 dlci 8 pf 1 ilen 0 fcs 0x63
> < ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x46 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 8 pf 1 ilen 0 fcs 0xe3
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00

so the trouble is that the DLCI 0 will never gets closed and so the
L2CAP PSM 3 will never be close and so on the ACL link can't be closed.
Right now I am not sure what device is buggy here. The BlueZ or your
phone. Please install a 2.6.8-rc2 vanilla kernel and try again and I
need a binary dump of the full communication from your phone to BlueZ.
Do this with "hcidump -w <file>" as root.

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
