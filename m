Return-Path: <cyrus@holtmann.org>
Message-ID: <552C1413.1000504@ahsoftware.de>
Date: Mon, 13 Apr 2015 21:08:03 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetoothd: add option to automatically power on the
 first adapter found
References: <1428685062-2911-1-git-send-email-holler@ahsoftware.de> <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org> <55280525.7040902@ahsoftware.de> <55289DD3.1080509@ahsoftware.de> <5528AC01.80804@ahsoftware.de> <55295063.2010106@ahsoftware.de> <72FEAB70-4102-4048-94E0-4AA0B4D67217@holtmann.org> <552A397D.50709@ahsoftware.de> <273C2B2C-FE29-4E28-8B50-7A9BE82C098D@holtmann.org> <552B87EE.5040800@ahsoftware.de> <B8F6B143-DA86-4F06-B4C8-FA2790AA33B3@holtmann.org>
In-Reply-To: <B8F6B143-DA86-4F06-B4C8-FA2790AA33B3@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 13.04.2015 um 16:32 schrieb Marcel Holtmann:

>>>> As said, this (currently) needs that dbus is ready and bluetoothctl can communicate with bluetoothd. And on a reasonable fast machine (4 core x86_64 2ghz+) this needs more than 4 seconds after startup here (invoked through /etc/rc.d/rc.local on f21).
>>>
>>> Szymon send an example on how to add wait-for-adapter in bluetoothctl. Together with that and a proper systemd unit, I bet you that this does not take 4 seconds.
>>>
>>> If you insist on doing old fashion rc.local stuff, then I can not help you. You can look into systemd target definitions, but I am pretty sure it ends up being started after something else happened.
>>
>> At least that old fashioned stuff worked. I even still have bt-alsa-devices on systems where I stick to bluez 4.0.
>>
>> And it would make me extremly wonder, if it would be any faster when using a systemd unit. Remember, I did in rc.local:
>>
>> sleep 4
>> echo "power on" | /bin/bluetoothctl
>>
>> And if that fails, then how could a systemd unit which calls bluetoothctl be faster? There is absolutely nothing in those 2 lines which slows down the necessary prerequisits for bluetoothctl.
>
> except the sleep 4 that you put in. So you are going on for rant this takes 4 seconds and the reason it takes 4 seconds since you put a sleep 4 in there. Szymon gave you a simple solution for removing the sleep and we are still discussing this.

I've run into the problem, because those 4 second weren't enough after 
an update of bluez. I then had to use 6 seconds, otherwise that 
construct failed. And because that ugly sleep was just an extremly ugly 
workaround for the missing easy-to-use knob to reliable turn on bt on 
Linux with bluez 5.x, I've now written that patch.

But it's senseless trying to discuss further. If you think people have 
to write udev-rules or systemd units in order to use bluetooth on Linux, 
there is just nothing I could add to such a discussion.

And you might want to decide if you want a configuration less bluez 
(something I think I've read several times and which is likely the 
reason that make install doesn't install at least an example for 
configuration), or if you still want to support some configuration as 
mentioned in the comment in regard to a [policy] section.

Alexander Holler
