Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20070705155549.GF3175@suse.de>
References: <20070704141123.GA10807@suse.de>
	<1183622728.6351.75.camel@aeonflux.holtmann.net>
	<20070705155549.GF3175@suse.de>
Date: Fri, 06 Jul 2007 07:57:33 +0200
Message-Id: <1183701453.6351.107.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Mouse reconnect problems since version 3.12
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Stefan,

> > > I recently upgraded to bluez-3.12 on my openSUSE Factory machine and now i
> > > have problems with the mouse reconnecting after a timeout.
> > > 
> > > It simply does not reconnect. Nothing in syslog nor in the output of
> > > kbluetooth which is my authorization agent.
> > > 
> > > I do not know exactly how to proceed with debugging - i tried a
> > > hcidump -X -V
> > > when the mouse did not reconnect, and it spat out lots of stuff when i
> > > moved the mouse. But of course, i could not make any sense out of it.
> > 
> > I need to see the hcidump output. Otherwise I can't tell anything.
> 
> HCI sniffer - Bluetooth packet analyzer ver 1.35
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > ACL data: handle 6 flags 0x02 dlen 13
>     L2CAP(d): cid 0x0041 len 9 [psm 0]
>       0000: a1 02 01 00 00 00 00 00  00                       .........
> > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 6 mode 0x00 interval 126
>     Mode: Active
> > HCI Event: Mode Change (0x14) plen 6
>     status 0x00 handle 6 mode 0x02 interval 20
>     Mode: Sniff
> 
> up to here this was a left button press, from here on i was moving the
> mouse around.

are you sure that the authorization agent is working. Maybe you wanna
use adapter.SetTrusted() to make it fully trusted.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
