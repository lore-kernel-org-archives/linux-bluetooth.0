Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT mouse disconnect
From: Marcel Holtmann <marcel@holtmann.org>
To: sandro.weiser@gmx.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406201934.30037.sandro.weiser@gmx.de>
References: <200406201934.30037.sandro.weiser@gmx.de>
Content-Type: text/plain
Message-Id: <1087756769.4781.44.camel@pegasus>
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
Date: Sun, 20 Jun 2004 20:39:29 +0200

Hi Sandro,

> When I don't use my BT Mouse, the mouse disconnects after a certain period
> when I use the hidp Module. After that the mouse isn't detectable anymore!
> No reboot, no Linux or Windoof can detect the mouse anymore. Only removing
> the batterys helps and after that the mouse works like before.
> Note: the mouse is an Epox and switches completely of when it's not used.
> I've to press one or more buttons to reenable the mouse. But when using the
> hid-proxy of the adapter, that's no problem.

this is the stupid CSR bug when terminating the L2CAP connections. I
really thought that I found a workaround, but it seems not :(

My EPoX mouse has an earlier build id (0x020a), but I can't remember
that I tested it with the hidp module before. Will do this as soon as
possible.

In HID proxy mode the boot mode is used and I don't know if the device
still uses an idle timeout. Will check this, too.

> > HCI Event: Mode Change(0x14) plen 6
>   00 2D 00 02 78 00
> > ACL data: handle 0x002d flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0044
> < ACL data: handle 0x002d flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0044
> < ACL data: handle 0x002d flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0043 scid 0x0040

This is the problematic command that the CSR firmware don't like. The
mouse disconnects the control channel. We ack that and then we terminate
the interrupt channel and this is what these devices make going mad.

After a little bit more thinking it maybe that the firmware terminates
the interrupt channel first. I can't tell you that from your hcidump,
because it misses the L2CAP connection setup calls. From looking at the
dcid and scid values this can be the problem here. My workaround assumes
that the control channel is always closed first. I must check that.

May you wanna try to start hidd with the --timeout option and set your
own value that is shorter than the timeout value of the mouse. My list
says that it uses a timeout of 11 minutes. Maybe you wanna try eight
minutes. In the case we terminate the connection everything should work
fine.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
