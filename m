Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth kernel patch for 2.6.1
From: Marcel Holtmann <marcel@holtmann.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074288307.2559.434.camel@localhost>
References: <1074193649.2629.23.camel@pegasus>
	 <1074196988.2559.270.camel@localhost>  <1074198649.2629.67.camel@pegasus>
	 <1074288307.2559.434.camel@localhost>
Content-Type: text/plain
Message-Id: <1074301700.2629.124.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 17 Jan 2004 02:08:20 +0100

Hi Max,

> No. I have several email with Broadcomm engineer who explained how
> protocol works. That's pretty much it. He didn't mention any additional
> stuff.

I have a nice USB dump from the Windows driver. Of course it uses an
older firmware and mini driver, but it also issues another status
command before selecting the memory. I decided not to include it,
because I can't decode the extra information and it makes the driver
more complex. Do you have a contact for me, so we can talk about it. I
am also interested in a Bluetooth 1.2 firmware if it exists.

> I'm trying to remember scenario where it was a problem (ie us killing
> incoming connection) but it simply vanished from my memory :).

I talked a little bit with Steven and Chris from CSR about it (look at
the archive) and of course there can be a problem with some link manager
implementation if both sides issue HCI_Disconnect at the same time. This
is why I choose the double time if we disconnect an incoming connection
to be safe for BlueZ <-> BlueZ connections.

> But I still think it's not right, even though spec does not say who must
> close the connection (are you sure it doesn't btw ?). That Bluetooth
> mouse must have its reasons for keeping connection and if you kill it
> most likely they just reconnect immediately.

I came around with this on 21 Dec and I thought about it for over 3
weeks before I finally decided to include this patch. I am not happy
with it, but doing nothing and keep the ACL link makes me even more sad.
The Apple mouse with its Broadcom HID stack is even more worse than I
can think about it. At http://www.holtmann.org/linux/bluetooth/hid.html
you find some of my notes about Bluetooth HID devices. And the mouse
never disconnects the ACL link. I checked this and it stays forever :(

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
