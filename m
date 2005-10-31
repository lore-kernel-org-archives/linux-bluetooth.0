Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] dbus.c cleanup
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510310359g33724820y596b244076d08315@mail.gmail.com>
References: <20051029175338.GA26114@localhost.localdomain>
	 <1130609278.5396.48.camel@blade>
	 <20051029184820.GA26657@localhost.localdomain>
	 <1130612847.5396.51.camel@blade>
	 <e1effdeb0510310359g33724820y596b244076d08315@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130760726.17124.17.camel@blade>
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
Date: Mon, 31 Oct 2005 13:12:06 +0100

Hi Claudio,

> I don't have cleanup patches to be sent. A new release can be good to
> receive the users/developers feedback.

I have to do some other small fixes in other parts of bluez-utils, but
the release is actually planned for today.

> Some cleanups/improvements suggestions for the next release:
> - find_conn is a shared function: put in a shared directory. It's used
> by hcitool.c and dbus.c

I know, but this has time. Maybe you wanna move it into lib.c inside the
hcid directory first.

> - Disconnect signal: handle de disconnect signal sent when the
> dbus-daemon exits.

I have no idea what that means.

> - split dbus.c file:
> - use session bus to send the PinRequest message: using the session
> bus it's possible start the dbus pin helper application automatically

This sounds like a good idea. Is anybody working on it? However the
bluez-pin package needs to updated to support the latest D-Bus version,
because we don't support the D-Bus 0.23 anymore.

> I think Eduardo is working on some services device configuration
> services. Maybe it should be better wait his patch. I will ask him and
> confirm soon.

There is plenty of time after the release. I don't consider the current
D-Bus API as stable.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
