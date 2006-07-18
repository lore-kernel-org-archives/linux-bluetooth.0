Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060718142827.GP10190@suse.de>
References: <20060707094252.GA26792@suse.de>
	<1152617098.15028.16.camel@localhost> <20060711133956.GD13809@suse.de>
	<1152625591.15028.35.camel@localhost> <20060711154501.GE13809@suse.de>
	<1152885278.25660.27.camel@localhost> <20060718142827.GP10190@suse.de>
Date: Tue, 18 Jul 2006 18:03:05 +0200
Message-Id: <1153238585.21024.2.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] kernel: hci_scodata_packet:
	hci1	SCO	packet	for	unknown connection handle 0
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Stefan,

> > > > actually with isco=1 the SCO transfers are still on, but limited to
> > > > 8-bit instead of 16-bit with isoc=2. So if you have isoc=2 it fills up
> > > > your syslog. Can you extract some of these SCO packets with hcidump for
> > > > me.
>  
> > > root@strolchi:~# hcidump -i hci1
> > > HCI sniffer - Bluetooth packet analyzer ver 1.29
> > > device: hci1 snap_len: 1028 filter: 0xffffffff
> > > > SCO data: handle 0 dlen 0
> > > > SCO data: handle 0 dlen 0
> 
> > > This happens immediately after plugging the thing in, there is no pairing
> > > or any application involved that might trigger this AFAICT.
> > 
> > Another RTX based dongle with RTX chip (0400:0807) has already been
> > blacklisted by me. I have no idea, why they can't get this right.
>  
> > It would be interesting if this will work with isoc=1 and a 16-bit PCM
> > stream. You should really try some stuff from the btsco package.
> 
> I did this and could not get it to work at all, means it did not play any sound
> with btsco and aplay to a Belkin F8T060xHDST headset. I got some "pops" on the
> earpiece when opening the device, but it did not play back anything.
> 
> The headset worked with a Belkin F8T013 after applying the SCO MTU patch and
> with a Gigabyte GN-BTD02 out of the box. The SCO MTU patch did not help for
> the Abe dongle.
> 
> I guess this piece of silicon is just plain crap :-)

it is the same as the Vivanco one, which I also have a bug report for:

lsusb: Bus 003 Device 004: ID 0400:080a National Semiconductor Corp.

And yes, they are a piece of crap when it comes to ISOC transfers. We
can only mark the SCO support as broken.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
