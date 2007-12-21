Return-Path: <cyrus@holtmann.org>
Message-ID: <000e01c843de$cabd8d80$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <009b01c8432a$f2b9a800$0200a8c0@jester>
	<Pine.LNX.4.63.0712201911380.5733@redbean.intranet.gw-instruments.de>
	<000801c84343$f6efce40$0200a8c0@jester>
	<003101c843ba$5d611280$0200a8c0@jester>
	<1198244391.8050.285.camel@aeonflux>
	<Pine.LNX.4.63.0712211442560.8893@redbean.intranet.gw-instruments.de>
Date: Fri, 21 Dec 2007 15:35:53 +0100
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Creating a connection : Error: Command Disallowed
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Peter, Hi Marcel,

> You only have one radio in the chip. Once that is busy
> with a connection attempt, then everything else has to wait. So if the
> host stack queues these connection attempts or the link manager inside
> the Bluetooth chip makes no real difference.

Thanks a lot for your explanations guys everything is clearer now.
However, I can't understand the following behaviour : instead of starting 4 
connections from the same hci device, I put 4 dongles and start 4 
connections at the same time one per dongle.
Here is what I get -dump below- (basically 2 "quick" connections, and 2 page 
timeout). It can vary depending on attempts, but at least 1 page timeout.

> The only way to speed up the process may be to do an inquiry
> first, so you know the clock offsets for the different devices. Knowing
> the clock offset usualy makes connection setup a lot faster. If I remember
> right BlueZ caches the clock offsets and uses them in a connection request
> if available

Do you think running the inquiry on hci0 (for example) would "save" the 
clock offsets for connections on other dongles ? (I mean inquiry on hci0 
then "connect" to the found device on hci1 to N) ?
Do you thing there is there another way to speed this up (e.g. doing a 
request name to the remote device on the dongle where the connection will be 
done) ?

Thanks again & best regards,
Oli
-----------
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
2007-12-21 15:11:41.662180 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:19:2D:15:FF:0E ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 15:11:41.665286 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 15:11:41.758270 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:19:2D:15:FF:0E type ACL encrypt 0x00
...
-----------
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci1 snap_len: 1028 filter: 0xffffffff
2007-12-21 15:11:41.663603 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:17:B0:1E:54:FD ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 15:11:41.666283 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 15:11:42.779225 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:17:B0:1E:54:FD type ACL encrypt 0x00
...
-----------
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci2 snap_len: 1028 filter: 0xffffffff
2007-12-21 15:11:41.664980 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:12:D1:65:27:7F ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 15:11:41.668350 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 15:12:02.148460 > HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:12:D1:65:27:7F type ACL encrypt 0x00
    Error: Page Timeout

-----------
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci3 snap_len: 1028 filter: 0xffffffff
2007-12-21 15:11:41.666608 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:12:D1:6E:4C:96 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 15:11:41.669339 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 15:12:02.149466 > HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 00:12:D1:6E:4C:96 type ACL encrypt 0x00
    Error: Page Timeout

-----------


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
