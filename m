Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1098654320.4635.16.camel@localhost>
References: <1098654320.4635.16.camel@localhost>
Content-Type: text/plain
Message-Id: <1098676528.6465.68.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard, keyboard does not
 reconnect on reboot
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
Date: Mon, 25 Oct 2004 05:55:28 +0200

Hi Matthew,

> Running 2.6.8 mh2, bluz-utils 2.10 on Debian Sarge.  Marcel, please
> excuse me for mailing you directly as wellas the list, as I want to send
> you a binary hcidump output so you can get maximum debug info.

don't care about that. If you exceed the mailing list limited I will
accept the post manually and let it through.

> I am having problems with the keyboard not reconnecting on reboot when
> hciattach switches the internal dongle from USB HID emulation to HCI.

It is not hciattach that is switching, it is hid2hci.

> The Lower level layer is definitely connected, but the keyboard events
> are not generating keyboard input at all.  I have to switch the keyboard
> off, and then switch it back on, and it renegotiates, and it all starts
> working.

What does "hidd --show" tell you when the keyboard is connected, but not
working?

> This test is not using security mode 3 yet, though I will be doing this
> to prevent people sniffing passwords.... but the same problem happens
> then.

Actually I thought, that the Apple keyboard is always in security mode
three, but from your dumps it looks like that this is not true when it
reconnects. What does "hcitool con" say about the reconnect ACL link?

> When I boot from OS X back into Linux, the problem does not occur.

This is strange and actually I never had any problems with the Apple HID
stuff, but I used it on a normal Intel machine.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
