Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI forwarding
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A7074C00364239@resmta03.ono.com> (added by postmaster@resmta03.ono.com)
References: <41A7074C00364239@resmta03.ono.com>
	 (added by postmaster@resmta03.ono.com)
Content-Type: text/plain
Message-Id: <1104698732.8894.32.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 02 Jan 2005 21:45:32 +0100

Hi,

> I'm a little lost in other implementation point:
> If we have the A peer and B peer connected trough tcp, Imagine that the A
> phone wants to connect B one, then it inquires and finds the hci device of
> the A PC and sends the connection requests and all other stuff, these data
> is sniffed with the A raw socket and forwarded to the B PC by TCP where is
> sent over B's hci device again, but... hci frames from A phone may be sent
> to the A PC's hci device's bluetooth address, not to B phone's Bluetooth
> address, may this be a problem? Would I need to parse the frames to change
> the destination address or change the A hci device address to B phone's
> address and B one to A phone address?

maybe you need to map the ACL connection handle.

> Can I change the local chip BT address?

If you now the specific vendor address and if it is not a ROM chip then
you can. Ask the manufacturer for details.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
