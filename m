Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth kernel patch for 2.6.1
From: Marcel Holtmann <marcel@holtmann.org>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074626637.1707.103.camel@localhost>
References: <1074193649.2629.23.camel@pegasus>
	 <1074196988.2559.270.camel@localhost>  <1074198649.2629.67.camel@pegasus>
	 <1074288307.2559.434.camel@localhost>  <1074301700.2629.124.camel@pegasus>
	 <1074626637.1707.103.camel@localhost>
Content-Type: text/plain
Message-Id: <1074649003.7088.43.camel@pegasus>
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
Date: Wed, 21 Jan 2004 02:36:43 +0100

Hi Max,

> > Do you have a contact for me, so we can talk about it. I
> > am also interested in a Bluetooth 1.2 firmware if it exists.
> I'm actually subscribed to Broadcomm release notifications. 
> So I'll get and email as soon as the release something. I don't think
> that they have 1.2 support yet. Anyway this subscription and stuff is
> kind of proprietary. One of the reasons I got it is because I'm a
> Qualcommer :).

I tried to contact the guys from Broadcom, but they never answered. This
makes me really unhappy.

> > I came around with this on 21 Dec and I thought about it for over 3
> > weeks before I finally decided to include this patch. I am not happy
> > with it, but doing nothing and keep the ACL link makes me even more sad.
> > The Apple mouse with its Broadcom HID stack is even more worse than I
> > can think about it. At http://www.holtmann.org/linux/bluetooth/hid.html
> > you find some of my notes about Bluetooth HID devices. And the mouse
> > never disconnects the ACL link. I checked this and it stays forever :(
> 
> I see. Well I guess it's ok as long as it doesn't brake anything.

Actually I must say I hope so ;)

The current way of waiting 4 seconds before we kill an incoming and
unused ACL link should be really long enough and in the most cases the
remote device already disconnected it before the timer kicks in. However
I haven't seen any problems in the last three weeks while I tested this
patch on my machines.

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
