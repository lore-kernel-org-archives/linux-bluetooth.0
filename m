Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <011e01c45d24$fbbf2370$640aa8c0@frodo>
From: "Torsten E." <linux-user@gmx.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] Hi there! ... and my first question
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
Date: Mon, 28 Jun 2004 17:30:42 +0200

Hi there,

well, after reading some docs regarding PAN I wasn't able to manage the
problem.
I'd like to attach my iPaq 3970 via BlueTooth to my Linuxbox (SuSE 9.1,
with SuSE kernel 2.6.5-7.75-default).

I configured the Linuxbox so I'm able to l2ping the iPaq, but right when
using DUND I get errors in /var/log/messages like:
Jun 28 17:01:09 gandalf /etc/hotplug/tty.agent[6372]: TTY try 1 while
waiting for /class/tty/rfcomm0's bus_id
Jun 28 17:01:10 gandalf /etc/hotplug/tty.agent[6372]: TTY try 2 while
waiting for /class/tty/rfcomm0's bus_id
Jun 28 17:01:11 gandalf /etc/hotplug/tty.agent[6372]: TTY try 3 while
waiting for /class/tty/rfcomm0's bus_id
Jun 28 17:01:11 gandalf dund[6371]: RFCOMM TTY creation failed. No such
file or directory(2)
Jun 28 17:01:12 gandalf /etc/hotplug/tty.agent[6389]: remove tty device
/class/tty/rfcomm0
Jun 28 17:01:12 gandalf /etc/hotplug/tty.agent[6372]: TTY try 4 while
waiting for /class/tty/rfcomm0's bus_id
Jun 28 17:01:13 gandalf /etc/hotplug/tty.agent[6372]: TTY try 5 while
waiting for /class/tty/rfcomm0's bus_id
Jun 28 17:01:24 gandalf /etc/hotplug/tty.agent[6372]: add tty device
/class/tty/rfcomm0

As there's no directory /class onmy box, but /sys/classm I guess that's
the correct one.
But I'm not able to create any file or directory there ... what does I
have to do?

If you need more information please let me know.
(English isn't my native language, so hopefully you get what I mean ...
german would be better ... ;))

Best regards
Torsten




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
