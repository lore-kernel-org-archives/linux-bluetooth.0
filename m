Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Hi there! ... and my first question
From: Marcel Holtmann <marcel@holtmann.org>
To: "Torsten E." <linux-user@gmx.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <007001c45dba$19c61a50$640aa8c0@frodo>
References: <011e01c45d24$fbbf2370$640aa8c0@frodo>
	 <1088465542.6030.230.camel@pegasus>  <007001c45dba$19c61a50$640aa8c0@frodo>
Content-Type: text/plain
Message-Id: <1088531266.6030.316.camel@pegasus>
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
Date: Tue, 29 Jun 2004 19:47:46 +0200

Hi Torsten,

> > right now I don't installed SuSE on any of my machines.
> 
> ... might be better not to have any ... ;)

all the kernel related problems are fixed in the SuSE kernel. So no
problem on that side.

> >> I configured the Linuxbox so I'm able to l2ping the iPaq, but right
> >> when using DUND I get errors in /var/log/messages like:
> >> Jun 28 17:01:09 gandalf /etc/hotplug/tty.agent[6372]: TTY try 1 while
> >> waiting for /class/tty/rfcomm0's bus_id
> >> Jun 28 17:01:10 gandalf /etc/hotplug/tty.agent[6372]: TTY try 2 while
> >> waiting for /class/tty/rfcomm0's bus_id
> >> Jun 28 17:01:11 gandalf /etc/hotplug/tty.agent[6372]: TTY try 3 while
> >> waiting for /class/tty/rfcomm0's bus_id
> >> Jun 28 17:01:11 gandalf dund[6371]: RFCOMM TTY creation failed. No
> >> such file or directory(2)
> >> Jun 28 17:01:12 gandalf /etc/hotplug/tty.agent[6389]: remove tty
> >> device /class/tty/rfcomm0
> >> Jun 28 17:01:12 gandalf /etc/hotplug/tty.agent[6372]: TTY try 4 while
> >> waiting for /class/tty/rfcomm0's bus_id
> >> Jun 28 17:01:13 gandalf /etc/hotplug/tty.agent[6372]: TTY try 5 while
> >> waiting for /class/tty/rfcomm0's bus_id
> >> Jun 28 17:01:24 gandalf /etc/hotplug/tty.agent[6372]: add tty device
> >> /class/tty/rfcomm0
> >
> > I don't know anything about tty.agent. It is not part of the hotplug
> > package.
> 
> It seems to be an SuSE script.

Please make a backup copy and remove it. I don't what it is good for.

> >> As there's no directory /class onmy box, but /sys/classm I guess
> >> that's the correct one.
> >> But I'm not able to create any file or directory there ... what does
> >> I have to do?
> >
> > Nothing. This is sysfs related and is ok.
> 
> Yes & No ...
> I was able to create /dev/rfcomm0 by using:
>     mknod /dev/rfcomm0 c 216 0

Why don't you use udev?

> But then it becomes strange:
> Running dund --master --listen starts just fine (it seems
> dund --mster --sdp --listen doen not work (anymore?)).
> Trying to establish an connection shows in /var/log/messages:
> Jun 29 10:06:21 gandalf /etc/hotplug/tty.agent[5401]: add tty device
> /class/tty/rfcomm0
> Jun 29 10:07:20 gandalf dund[5448]: New connection from
> 00:02:C7:11:FE:D6
> Jun 29 10:07:20 gandalf pppd[5460]: pppd 2.4.2 started by root, uid 0
> Jun 29 10:07:20 gandalf pppd[5460]: Using interface ppp1
> Jun 29 10:07:20 gandalf pppd[5460]: Connect: ppp1 <--> /dev/rfcomm0
> Jun 29 10:07:20 gandalf /etc/hotplug/tty.agent[5449]: TTY try 1 while
> waiting for /class/tty/rfcomm0's bus_id
> Jun 29 10:07:21 gandalf /etc/hotplug/tty.agent[5449]: TTY try 2 while
> waiting for /class/tty/rfcomm0's bus_id
> Jun 29 10:07:22 gandalf /etc/hotplug/tty.agent[5449]: TTY try 3 while
> waiting for /class/tty/rfcomm0's bus_id
> Jun 29 10:07:23 gandalf /etc/hotplug/tty.agent[5449]: TTY try 4 while
> waiting for /class/tty/rfcomm0's bus_id
> Jun 29 10:07:24 gandalf /etc/hotplug/tty.agent[5449]: TTY try 5 while
> waiting for /class/tty/rfcomm0's bus_id
> Jun 29 10:07:25 gandalf /etc/hotplug/tty.agent[5449]: add tty device
> /class/tty/rfcomm0
> Jun 29 10:07:28 gandalf pppd[5460]: Hangup (SIGHUP)
> Jun 29 10:07:28 gandalf pppd[5460]: Modem hangup
> Jun 29 10:07:28 gandalf pppd[5460]: Connection terminated.
> Jun 29 10:07:29 gandalf pppd[5460]: Exit.
> Jun 29 10:07:29 gandalf /etc/hotplug/tty.agent[5503]: remove tty device
> /class/tty/rfcomm0
> 
> Ok, now /sys/class/tty/rfcomm0 is created automatically (maybe just some
> seconds too late ...).

The tools from bluez-utils-2.7 should wait three seconds or so.

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
