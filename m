Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS Wireless keyboard scans remapping
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200310282105.53460.cijoml@volny.cz>
References: <200310280847.39317.cijoml@volny.cz>
	<20031028084018.GA1875@smartdata.ch> <1067366086.24043.153.camel@pegasus>
	<200310282105.53460.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1067372050.24043.172.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 28 Oct 2003 21:14:03 +0100

Hi Michal,

> Don't remember support these keys :)
> 
> Stand by
> > ACL data: handle 0x0029 flags 0x02 dlen 7
>     L2CAP(d): cid 0x41 len 3 [psm 0]
>       A1 03 02
> 
> Functionkey F
> > ACL data: handle 0x0029 flags 0x02 dlen 7
>     L2CAP(d): cid 0x41 len 3 [psm 0]
>       A1 05 03
> 
> windows key opens properties
> > ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(d): cid 0x41 len 10 [psm 0]
>       A1 01 00 00 65 00 00 00 00 00
> 
> 
> colona key |
> > ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(d): cid 0x41 len 10 [psm 0]
>       A1 01 00 00 32 00 00 00 00 00
> 
> other key in german version marked like criminal key # 
> > ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(d): cid 0x41 len 10 [psm 0]
>       A1 01 00 00 64 00 00 00 00 00

actually I don't care about these data, because the HID descriptor
defines what the keyboard supports and what not. If we reuse the USB HID
parser this should work out of the box. If not, the HID parser is broken
and we have to fix it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
