Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] HCI forwarding
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41A7074C0036241B@resmta03.ono.com> (added by postmaster@resmta03.ono.com)
References: <41A7074C0036241B@resmta03.ono.com>
	 (added by postmaster@resmta03.ono.com)
Content-Type: text/plain
Message-Id: <1104693661.8894.25.camel@pegasus>
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
Date: Sun, 02 Jan 2005 20:21:01 +0100

Hi,

> Device detection is not a problem since bluez does it for me (I only have to
> set the local class of device to the correct value (0x500204) in order to
> deceiving mobile phones in both sides). I conform with forwarding L2CAP and
> RFCOMM profile connection data, SDP and the rest of necessary HCI commands
> and events to make possible a long-distance L2CAP / RFCOMM session.

forwarding L2CAP channels or also ACL data packets is very easy. However
the ACL MTU should match. The role switches might be a little tricky.
Forwarding the HCI commands and events is not that easy. You must keep
an eye on the flow control mechanism of HCI, but this is all still
doable and there are more ways for doing it.

> Is this possible in this way?, In other?, Am I wrong?
> (I wrote the app sniffing and forwarding hci frames (it seems that "works")
> but I had no chance for testing it).

It is possible and the best way depends on what you wanna do. Basically
I used L2CAP and RFCOMM forwarding a lot of this to crack protocol stuff
that was going on between some devices. Best example is the Nokia PhoNet
protocol.

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
