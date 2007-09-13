Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Matthias Becker <matthias.becker@beyondsoft.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1189614213.12789.59.camel@aeonflux.holtmann.net>
References: <200709121104.43419.toralf.foerster@gmx.de>
	<1189614213.12789.59.camel@aeonflux.holtmann.net>
Date: Thu, 13 Sep 2007 17:24:11 +0200
Message-Id: <1189697051.4067.19.camel@matthias.BEYONDSOFT.local>
Mime-Version: 1.0
Subject: [Bluez-devel]  What can I do in parallel
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

Hi,

I write an aplication that is intended to push a file to all surrounding
mobilephones. So it performs an inquiry scan and than starts threads for
all recived addresses to push the file.

But I need to know what is allowed to do in parallel. 

(I know that I can't read multiple names via hci_read_remote_name. But I
don't need those names anyway.)

To push the file I need to get the OBEX push channel. Can I do multiple
SDP requests over one bluetooth adapter at the same time?

hcidump shows me that SDP seems to perform a name reuest. Why is this?

(an excerpt from hcidump while a call to "sdptool browse
00:19:63:9D:09:16":
...
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:19:63:9D:09:16 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:19:63:9D:09:16 name 'K800i'
...
)

Than I need to do the OBEX stuff (using OpenOBEX
BtOBEX_TransportConnect, ...).

If I can do things in parallel how many can be performed in parallel per
bluetooth adapter? I read something about bluetooth allows 7 active
connections and 255 passive connections, but I'm not sure what that
meens.



Thanks in advance

-- Matthias


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
