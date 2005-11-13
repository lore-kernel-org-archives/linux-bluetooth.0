Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm simultaneous connection
In-Reply-To: <1131828732.29461.29.camel@blade>
Message-ID: <Pine.LNX.4.33.0511131501280.1406-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 13 Nov 2005 15:03:00 +0100 (CET)



Hi Marcel,

or we need to change the HCI layer to enable it to queue the commands
correctly ..... but this is not trivial.

Could'nt resist ;-)..

Peter

On Sat, 12 Nov 2005, Marcel Holtmann wrote:

> Hi Artur,
>
> > t01:/# /usr/local/sbin/hcidump -X -V
> > HCI sniffer - Bluetooth packet analyzer ver 1.27
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > < HCI Command: Create Connection (0x01|0x0005) plen 13
> >     bdaddr 00:13:FD:BB:22:3F ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> >     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > > HCI Event: Command Status (0x0f) plen 4
> >     Create Connection (0x01|0x0005) status 0x00 ncmd 1
> > < HCI Command: Create Connection (0x01|0x0005) plen 13
> >     bdaddr 00:14:60:01:23:45 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
> >     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > > HCI Event: Command Status (0x0f) plen 4
> >     Create Connection (0x01|0x0005) status 0x0c ncmd 1
> >     Error: Command Disallowed
>
> you try to create both piconets at the same time. This can't work,
> because the Bluetooth chip can only page one. You must wait at least
> until one piconet is established.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. Download
> it for free - -and be entered to win a 42" plasma tv or your very own
> Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
