Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] AMD64 HID pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: Kyle Rose <krose+bluez@krose.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <khnacuya23u.fsf@hunter-killer.kendall.corp.akamai.com>
References: <khnacuya23u.fsf@hunter-killer.kendall.corp.akamai.com>
Content-Type: text/plain
Message-Id: <1097185188.7325.75.camel@pegasus>
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
Date: Thu, 07 Oct 2004 23:39:48 +0200

Hi Kyle,

> On my AMD64 system (Tyan K8W, dual Opteron 244, logitech MX 900 mouse
> and bluetooth cradle, linux-2.6.8.1 with patch-2.6.8-mh2), I have to
> switch to VT, do "hidd --search", and hit both buttons (on the mouse
> and on the cradle) every time I either reboot the machine or let it
> sit for a while.  Needless to say, this is pretty irritating.
> 
> What really bugs me is that this exact same hardware configuration
> works in IA32 mode: when I reboot, I just hit the button on the mouse
> and a few seconds later the mouse comes alive; and when I leave it sit
> for a while, I just move it or hit a button and a few seconds later
> the mouse comes back.

this looks very weird. Especially the switching to the VT. Please try to
reproduce it with a 2.6.9-rc3-bk7 kernel.

Is the cradle in HID or in HCI mode? Do you see any other errors on
AMD64. I fixed some 64 bit bugs, but I can't remember that any of them
where in the HID stuff.

Run "hcidump -X" as root whenever possible so we can see if there are
wrong things.

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
