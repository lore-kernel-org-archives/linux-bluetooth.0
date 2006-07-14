Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060711154501.GE13809@suse.de>
References: <20060707094252.GA26792@suse.de>
	<1152617098.15028.16.camel@localhost> <20060711133956.GD13809@suse.de>
	<1152625591.15028.35.camel@localhost> <20060711154501.GE13809@suse.de>
Date: Fri, 14 Jul 2006 15:54:38 +0200
Message-Id: <1152885278.25660.27.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] kernel: hci_scodata_packet: hci1
	SCO	packet	for	unknown connection handle 0
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

> > actually with isco=1 the SCO transfers are still on, but limited to
> > 8-bit instead of 16-bit with isoc=2. So if you have isoc=2 it fills up
> > your syslog. Can you extract some of these SCO packets with hcidump for
> > me.
> 
> ok, it looks like this (hoping that i invoked hcidump correctly, i am still
> learning this bluetooth thingy :-):

the preferred way would be "hcidump -i hci1 -X -V" to have full decoding
support, but for SCO this doesn't really matter.

> root@strolchi:~# hcidump -i hci1
> HCI sniffer - Bluetooth packet analyzer ver 1.29
> device: hci1 snap_len: 1028 filter: 0xffffffff
> > SCO data: handle 0 dlen 0
> > SCO data: handle 0 dlen 0
> > SCO data: handle 0 dlen 0
> > SCO data: handle 0 dlen 0
> > SCO data: handle 0 dlen 0
> > SCO data: handle 0 dlen 0
> > SCO data: handle 0 dlen 0
> > SCO data: handle 0 dlen 0
> > SCO data: handle 0 dlen 0
> > SCO data: handle 0 dlen 0
> 
> This happens immediately after plugging the thing in, there is no pairing
> or any application involved that might trigger this AFAICT.

Another RTX based dongle with RTX chip (0400:0807) has already been
blacklisted by me. I have no idea, why they can't get this right.
 
> > Any chance of a name or identification of this dongle?
> 
> It is an Abe UB20S, http://www.abe-hk.com/english/products/ub12-22/ub12-22.htm
> The FCC ID is NV6-CS8024.
> It is sold e.g. by conrad.com in germany and pretty cheap (around 10 Euro),
> and it is pretty small (this is why i bought it, i can leave it plugged in
> when putting the notebook into the bag :-)

It would be interesting if this will work with isoc=1 and a 16-bit PCM
stream. You should really try some stuff from the btsco package.

Regards

Marcel




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
