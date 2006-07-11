Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 11 Jul 2006 17:45:01 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060711154501.GE13809@suse.de>
References: <20060707094252.GA26792@suse.de>
	<1152617098.15028.16.camel@localhost>
	<20060711133956.GD13809@suse.de>
	<1152625591.15028.35.camel@localhost>
Mime-Version: 1.0
In-Reply-To: <1152625591.15028.35.camel@localhost>
Subject: Re: [Bluez-devel] kernel: hci_scodata_packet: hci1 SCO
	packet	for	unknown connection handle 0
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

On Tue, Jul 11, 2006 at 03:46:31PM +0200, Marcel Holtmann wrote:
> Hi Stefan,
 =

> actually with isco=3D1 the SCO transfers are still on, but limited to
> 8-bit instead of 16-bit with isoc=3D2. So if you have isoc=3D2 it fills up
> your syslog. Can you extract some of these SCO packets with hcidump for
> me.

ok, it looks like this (hoping that i invoked hcidump correctly, i am still
learning this bluetooth thingy :-):

root@strolchi:~# hcidump -i hci1
HCI sniffer - Bluetooth packet analyzer ver 1.29
device: hci1 snap_len: 1028 filter: 0xffffffff
> SCO data: handle 0 dlen 0
> SCO data: handle 0 dlen 0
> SCO data: handle 0 dlen 0
> SCO data: handle 0 dlen 0
> SCO data: handle 0 dlen 0
> SCO data: handle 0 dlen 0
> SCO data: handle 0 dlen 0
> SCO data: handle 0 dlen 0
> SCO data: handle 0 dlen 0
> SCO data: handle 0 dlen 0

This happens immediately after plugging the thing in, there is no pairing
or any application involved that might trigger this AFAICT.

> My problem is now that I can only fully blacklist the SCO support for
> this dongle. I can't force the Bluetooth core into using 8-bit only.

Maybe i should try if SCO works at all with this thing :-)
 =

> Any chance of a name or identification of this dongle?

It is an Abe UB20S, http://www.abe-hk.com/english/products/ub12-22/ub12-22.=
htm
The FCC ID is NV6-CS8024.
It is sold e.g. by conrad.com in germany and pretty cheap (around 10 Euro),
and it is pretty small (this is why i bought it, i can leave it plugged in
when putting the notebook into the bag :-)
-- =

Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohen


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
