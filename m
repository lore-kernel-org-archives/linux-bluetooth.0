Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <007001c45dba$19c61a50$640aa8c0@frodo>
From: "Torsten E." <linux-user@gmx.com>
To: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
References: <011e01c45d24$fbbf2370$640aa8c0@frodo> <1088465542.6030.230.camel@pegasus>
Subject: Re: [Bluez-users] Hi there! ... and my first question
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Tue, 29 Jun 2004 11:18:54 +0200

Marcel Holtmann schrieb am Dienstag, 29. Juni 2004 01:32:

> Hi Thorsten,

Hi Marcel,

>> well, after reading some docs regarding PAN I wasn't able to manage
>> the problem.
>> I'd like to attach my iPaq 3970 via BlueTooth to my Linuxbox (SuSE
>> 9.1, with SuSE kernel 2.6.5-7.75-default).
>
> right now I don't installed SuSE on any of my machines.

... might be better not to have any ... ;)

>> I configured the Linuxbox so I'm able to l2ping the iPaq, but right
>> when using DUND I get errors in /var/log/messages like:
>> Jun 28 17:01:09 gandalf /etc/hotplug/tty.agent[6372]: TTY try 1 while
>> waiting for /class/tty/rfcomm0's bus_id
>> Jun 28 17:01:10 gandalf /etc/hotplug/tty.agent[6372]: TTY try 2 while
>> waiting for /class/tty/rfcomm0's bus_id
>> Jun 28 17:01:11 gandalf /etc/hotplug/tty.agent[6372]: TTY try 3 while
>> waiting for /class/tty/rfcomm0's bus_id
>> Jun 28 17:01:11 gandalf dund[6371]: RFCOMM TTY creation failed. No
>> such file or directory(2)
>> Jun 28 17:01:12 gandalf /etc/hotplug/tty.agent[6389]: remove tty
>> device /class/tty/rfcomm0
>> Jun 28 17:01:12 gandalf /etc/hotplug/tty.agent[6372]: TTY try 4 while
>> waiting for /class/tty/rfcomm0's bus_id
>> Jun 28 17:01:13 gandalf /etc/hotplug/tty.agent[6372]: TTY try 5 while
>> waiting for /class/tty/rfcomm0's bus_id
>> Jun 28 17:01:24 gandalf /etc/hotplug/tty.agent[6372]: add tty device
>> /class/tty/rfcomm0
>
> I don't know anything about tty.agent. It is not part of the hotplug
> package.

It seems to be an SuSE script.

>> As there's no directory /class onmy box, but /sys/classm I guess
>> that's the correct one.
>> But I'm not able to create any file or directory there ... what does
>> I have to do?
>
> Nothing. This is sysfs related and is ok.

Yes & No ...
I was able to create /dev/rfcomm0 by using:
    mknod /dev/rfcomm0 c 216 0

But then it becomes strange:
Running dund --master --listen starts just fine (it seems
dund --mster --sdp --listen doen not work (anymore?)).
Trying to establish an connection shows in /var/log/messages:
Jun 29 10:06:21 gandalf /etc/hotplug/tty.agent[5401]: add tty device
/class/tty/rfcomm0
Jun 29 10:07:20 gandalf dund[5448]: New connection from
00:02:C7:11:FE:D6
Jun 29 10:07:20 gandalf pppd[5460]: pppd 2.4.2 started by root, uid 0
Jun 29 10:07:20 gandalf pppd[5460]: Using interface ppp1
Jun 29 10:07:20 gandalf pppd[5460]: Connect: ppp1 <--> /dev/rfcomm0
Jun 29 10:07:20 gandalf /etc/hotplug/tty.agent[5449]: TTY try 1 while
waiting for /class/tty/rfcomm0's bus_id
Jun 29 10:07:21 gandalf /etc/hotplug/tty.agent[5449]: TTY try 2 while
waiting for /class/tty/rfcomm0's bus_id
Jun 29 10:07:22 gandalf /etc/hotplug/tty.agent[5449]: TTY try 3 while
waiting for /class/tty/rfcomm0's bus_id
Jun 29 10:07:23 gandalf /etc/hotplug/tty.agent[5449]: TTY try 4 while
waiting for /class/tty/rfcomm0's bus_id
Jun 29 10:07:24 gandalf /etc/hotplug/tty.agent[5449]: TTY try 5 while
waiting for /class/tty/rfcomm0's bus_id
Jun 29 10:07:25 gandalf /etc/hotplug/tty.agent[5449]: add tty device
/class/tty/rfcomm0
Jun 29 10:07:28 gandalf pppd[5460]: Hangup (SIGHUP)
Jun 29 10:07:28 gandalf pppd[5460]: Modem hangup
Jun 29 10:07:28 gandalf pppd[5460]: Connection terminated.
Jun 29 10:07:29 gandalf pppd[5460]: Exit.
Jun 29 10:07:29 gandalf /etc/hotplug/tty.agent[5503]: remove tty device
/class/tty/rfcomm0

Ok, now /sys/class/tty/rfcomm0 is created automatically (maybe just some
seconds too late ...).
So for me it seems the SuSE scripts aren't working proper right now -
what does I have to do to start an BT connection manually?
Which commands are neccessary? Could somebody give me a hand?

I'm using:
RFCOMM configuration utility ver 2.7
hcitool - HCI Tool ver 2.7
hciconfig - ??? hciconfig version (or "hciconfig hci0 version") does not
work
pppd version 2.4.2

> Regards
>
> Marcel

c y
Torsten (without an h ;))




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
