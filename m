Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Kyle Rose <krose+bluez@krose.org>
Message-ID: <khnacuya23u.fsf@hunter-killer.kendall.corp.akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] AMD64 HID pairing
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
Date: Thu, 07 Oct 2004 13:07:33 -0400

On my AMD64 system (Tyan K8W, dual Opteron 244, logitech MX 900 mouse
and bluetooth cradle, linux-2.6.8.1 with patch-2.6.8-mh2), I have to
switch to VT, do "hidd --search", and hit both buttons (on the mouse
and on the cradle) every time I either reboot the machine or let it
sit for a while.  Needless to say, this is pretty irritating.

What really bugs me is that this exact same hardware configuration
works in IA32 mode: when I reboot, I just hit the button on the mouse
and a few seconds later the mouse comes alive; and when I leave it sit
for a while, I just move it or hit a button and a few seconds later
the mouse comes back.

I've confirmed I've got hidd --server running.

Any insight?

Cheers,
Kyle


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
