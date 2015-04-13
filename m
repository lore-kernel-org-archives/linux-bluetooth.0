Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] bluetoothd: add option to automatically power on the first adapter found
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <552C1413.1000504@ahsoftware.de>
Date: Mon, 13 Apr 2015 13:22:48 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A619270B-434E-4F83-A3A3-21E25C1DC237@holtmann.org>
References: <1428685062-2911-1-git-send-email-holler@ahsoftware.de> <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org> <55280525.7040902@ahsoftware.de> <55289DD3.1080509@ahsoftware.de> <5528AC01.80804@ahsoftware.de> <55295063.2010106@ahsoftware.de> <72FEAB70-4102-4048-94E0-4AA0B4D67217@holtmann.org> <552A397D.50709@ahsoftware.de> <273C2B2C-FE29-4E28-8B50-7A9BE82C098D@holtmann.org> <552B87EE.5040800@ahsoftware.de> <B8F6B143-DA86-4F06-B4C8-FA2790AA33B3@holtmann.org> <552C1413.1000504@ahsoftware.de>
To: Alexander Holler <holler@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

>>>>> As said, this (currently) needs that dbus is ready and bluetoothctl can communicate with bluetoothd. And on a reasonable fast machine (4 core x86_64 2ghz+) this needs more than 4 seconds after startup here (invoked through /etc/rc.d/rc.local on f21).
>>>> 
>>>> Szymon send an example on how to add wait-for-adapter in bluetoothctl. Together with that and a proper systemd unit, I bet you that this does not take 4 seconds.
>>>> 
>>>> If you insist on doing old fashion rc.local stuff, then I can not help you. You can look into systemd target definitions, but I am pretty sure it ends up being started after something else happened.
>>> 
>>> At least that old fashioned stuff worked. I even still have bt-alsa-devices on systems where I stick to bluez 4.0.
>>> 
>>> And it would make me extremly wonder, if it would be any faster when using a systemd unit. Remember, I did in rc.local:
>>> 
>>> sleep 4
>>> echo "power on" | /bin/bluetoothctl
>>> 
>>> And if that fails, then how could a systemd unit which calls bluetoothctl be faster? There is absolutely nothing in those 2 lines which slows down the necessary prerequisits for bluetoothctl.
>> 
>> except the sleep 4 that you put in. So you are going on for rant this takes 4 seconds and the reason it takes 4 seconds since you put a sleep 4 in there. Szymon gave you a simple solution for removing the sleep and we are still discussing this.
> 
> I've run into the problem, because those 4 second weren't enough after an update of bluez. I then had to use 6 seconds, otherwise that construct failed. And because that ugly sleep was just an extremly ugly workaround for the missing easy-to-use knob to reliable turn on bt on Linux with bluez 5.x, I've now written that patch.
> 
> But it's senseless trying to discuss further. If you think people have to write udev-rules or systemd units in order to use bluetooth on Linux, there is just nothing I could add to such a discussion.

you did read my responses here? I mean there are so many possible options. Szymon provided an addition for bluetoothctl command where you could just have replaced sleep 4 with the new command. And you could have it working perfectly all the time.

> And you might want to decide if you want a configuration less bluez (something I think I've read several times and which is likely the reason that make install doesn't install at least an example for configuration), or if you still want to support some configuration as mentioned in the comment in regard to a [policy] section.

Upstream is not responsible for personal or distribution specific customization. We provide configuration via main.conf and I am repeating myself now for the 3rd time here, I am fine with a policy setting for auto-power on found controllers. The distribution has to do the work to put a proper main.conf in place if they choose to. It is really up to them. This is not something upstream should do in the first place.

bluetoothd has to work properly with default values if the configuration is present or not. Failing because a configuration file is not present and you can not run a proper sane default is plain stupid. That is not how we write software. We are doing proper defaults.

Please respect the upstream decision not to install main.conf in /etc/bluetooth/ and leave this up to the distribution and packagers. In case you wonder this is important for stateless installations and systems that support factory reset.

I am happy to take a patch that implements the auto-power on properly and without race conditions and makes it configurable based on the main.conf policy section. And I said this many times now. The amount of emails exchanged on this topic where I agreed to take a patch if it would be done race free and in sync with how upstream operates is amazing.

So the choice is really yours here. However upstream has been pretty much inviting here to handle your use case. Fun part is just you seem to disagree with upstream's proposal. And that is your right, but I am honestly not spending any more time on this. The direction is crystal clear. And with Szymon's patch for bluetoothctl you would even have a temporary solution that is race free and dead simple to deploy. Then again, you seemed to prefer argumenting for a sleep vs a proper command. And honestly with that dismissal of people trying to help, nobody is going to bother in the end.

Regards

Marcel

