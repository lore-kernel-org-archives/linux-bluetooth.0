Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Hi there! ... and my first question
From: Marcel Holtmann <marcel@holtmann.org>
To: "Torsten E." <linux-user@gmx.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <011e01c45d24$fbbf2370$640aa8c0@frodo>
References: <011e01c45d24$fbbf2370$640aa8c0@frodo>
Content-Type: text/plain
Message-Id: <1088465542.6030.230.camel@pegasus>
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
Date: Tue, 29 Jun 2004 01:32:22 +0200

Hi Thorsten,

> well, after reading some docs regarding PAN I wasn't able to manage the
> problem.
> I'd like to attach my iPaq 3970 via BlueTooth to my Linuxbox (SuSE 9.1,
> with SuSE kernel 2.6.5-7.75-default).

right now I don't installed SuSE on any of my machines.

> I configured the Linuxbox so I'm able to l2ping the iPaq, but right when
> using DUND I get errors in /var/log/messages like:
> Jun 28 17:01:09 gandalf /etc/hotplug/tty.agent[6372]: TTY try 1 while
> waiting for /class/tty/rfcomm0's bus_id
> Jun 28 17:01:10 gandalf /etc/hotplug/tty.agent[6372]: TTY try 2 while
> waiting for /class/tty/rfcomm0's bus_id
> Jun 28 17:01:11 gandalf /etc/hotplug/tty.agent[6372]: TTY try 3 while
> waiting for /class/tty/rfcomm0's bus_id
> Jun 28 17:01:11 gandalf dund[6371]: RFCOMM TTY creation failed. No such
> file or directory(2)
> Jun 28 17:01:12 gandalf /etc/hotplug/tty.agent[6389]: remove tty device
> /class/tty/rfcomm0
> Jun 28 17:01:12 gandalf /etc/hotplug/tty.agent[6372]: TTY try 4 while
> waiting for /class/tty/rfcomm0's bus_id
> Jun 28 17:01:13 gandalf /etc/hotplug/tty.agent[6372]: TTY try 5 while
> waiting for /class/tty/rfcomm0's bus_id
> Jun 28 17:01:24 gandalf /etc/hotplug/tty.agent[6372]: add tty device
> /class/tty/rfcomm0

I don't know anything about tty.agent. It is not part of the hotplug
package.

> As there's no directory /class onmy box, but /sys/classm I guess that's
> the correct one.
> But I'm not able to create any file or directory there ... what does I
> have to do?

Nothing. This is sysfs related and is ok.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
