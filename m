Return-Path: <cyrus@holtmann.org>
Message-ID: <552CD0F2.7080605@ahsoftware.de>
Date: Tue, 14 Apr 2015 10:33:54 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetoothd: add option to automatically power on the
 first adapter found
References: <1428685062-2911-1-git-send-email-holler@ahsoftware.de> <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org> <55280525.7040902@ahsoftware.de> <55289DD3.1080509@ahsoftware.de> <5528AC01.80804@ahsoftware.de> <55295063.2010106@ahsoftware.de> <72FEAB70-4102-4048-94E0-4AA0B4D67217@holtmann.org> <552A397D.50709@ahsoftware.de> <273C2B2C-FE29-4E28-8B50-7A9BE82C098D@holtmann.org> <552B87EE.5040800@ahsoftware.de> <B8F6B143-DA86-4F06-B4C8-FA2790AA33B3@holtmann.org> <552C1413.1000504@ahsoftware.de> <A619270B-434E-4F83-A3A3-21E25C1DC237@holtmann.org>
In-Reply-To: <A619270B-434E-4F83-A3A3-21E25C1DC237@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 13.04.2015 um 22:22 schrieb Marcel Holtmann:
> Hi Alexander,
>
>>>>>> As said, this (currently) needs that dbus is ready and bluetoothctl can communicate with bluetoothd. And on a reasonable fast machine (4 core x86_64 2ghz+) this needs more than 4 seconds after startup here (invoked through /etc/rc.d/rc.local on f21).
>>>>>
>>>>> Szymon send an example on how to add wait-for-adapter in bluetoothctl. Together with that and a proper systemd unit, I bet you that this does not take 4 seconds.
>>>>>
>>>>> If you insist on doing old fashion rc.local stuff, then I can not help you. You can look into systemd target definitions, but I am pretty sure it ends up being started after something else happened.
>>>>
>>>> At least that old fashioned stuff worked. I even still have bt-alsa-devices on systems where I stick to bluez 4.0.
>>>>
>>>> And it would make me extremly wonder, if it would be any faster when using a systemd unit. Remember, I did in rc.local:
>>>>
>>>> sleep 4
>>>> echo "power on" | /bin/bluetoothctl
>>>>
>>>> And if that fails, then how could a systemd unit which calls bluetoothctl be faster? There is absolutely nothing in those 2 lines which slows down the necessary prerequisits for bluetoothctl.
>>>
>>> except the sleep 4 that you put in. So you are going on for rant this takes 4 seconds and the reason it takes 4 seconds since you put a sleep 4 in there. Szymon gave you a simple solution for removing the sleep and we are still discussing this.
>>
>> I've run into the problem, because those 4 second weren't enough after an update of bluez. I then had to use 6 seconds, otherwise that construct failed. And because that ugly sleep was just an extremly ugly workaround for the missing easy-to-use knob to reliable turn on bt on Linux with bluez 5.x, I've now written that patch.
>>
>> But it's senseless trying to discuss further. If you think people have to write udev-rules or systemd units in order to use bluetooth on Linux, there is just nothing I could add to such a discussion.
>
> you did read my responses here? I mean there are so many possible options. Szymon provided an addition for bluetoothctl command where you could just have replaced sleep 4 with the new command. And you could have it working perfectly all the time.
>
>> And you might want to decide if you want a configuration less bluez (something I think I've read several times and which is likely the reason that make install doesn't install at least an example for configuration), or if you still want to support some configuration as mentioned in the comment in regard to a [policy] section.
>
> Upstream is not responsible for personal or distribution specific customization. We provide configuration via main.conf and I am repeating myself now for the 3rd time here, I am fine with a policy setting for auto-power on found controllers. The distribution has to do the work to put a proper main.conf in place if they choose to. It is really up to them. This is not something upstream should do in the first place.
>
> bluetoothd has to work properly with default values if the configuration is present or not. Failing because a configuration file is not present and you can not run a proper sane default is plain stupid. That is not how we write software. We are doing proper defaults.

Sorry, I'm sick of having to teach others about the usability problems 
of bluez.

E.g. since the configuration knob for hid2hci disappeared (I think that
happened with bluez 4.x), it's still done wrong by many people and
distributions. E.g. on Ubuntu the udev-rule for hid2hci is still wrong 
because nobody explained them that the udev-rule is not the problem but 
the non-existing knob to turn off hid2hci if it is installed. Not to 
mention that it should be turned off by default (until the user turned 
it on, hoping he is aware of the implications).

Just the same problem which happened on Fedora and Gentoo too (until 
I've explained the problem to the maintainers and now hid2hci isnt 
installed by default there). It's just to hard to understand (and to 
explain) that installing a command-line utility (by default) might 
render a system unusable. And users aren't the problem here, if even 
maintainers get it wrong.

And almost anyone runs into the problem that bt-adapters are now powered
off by default and people have not idea how to change that policy or 
even how to manually turn on the adapter. And that now happens since 5.x 
was thrown at users, which is already 30 releases old.

>
> Please respect the upstream decision not to install main.conf in /etc/bluetooth/ and leave this up to the distribution and packagers. In case you wonder this is important for stateless installations and systems that support factory reset.
>
> I am happy to take a patch that implements the auto-power on properly and without race conditions and makes it configurable based on the main.conf policy section. And I said this many times now. The amount of emails exchanged on this topic where I agreed to take a patch if it would be done race free and in sync with how upstream operates is amazing.
>

Sorry, but I've no idea about which races you are talking. Of course, I 
haven't fixed the already existing race(s) in bluetoothd with the 
missing lock for the adapter list (at least I haven't seen or found any 
lock for that list, otherwise I would have used it). But that still 
might be my problem, as I'm not very familiar with bluetoothd and 
especially it's locking strategy (if there is any, which I hope).

I also have noticed that bluetoothd and bluetoothctl seem to have a 
different idea about the default adapter (at least that is_default 
variable in bluetoothd doesn't seem to be in sync with what bluetoothctl 
displayed as default adapter when I've tried the stuff with two 
adapters). Or I just have missed how that is_default was changed during 
my few tests. Otherwise I would have named that option I've added 
different ("default adapter" instead of "first adapter").

Regards,

Alexander Holler
