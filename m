Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] bluetoothd: add option to automatically power on the first adapter found
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55295063.2010106@ahsoftware.de>
Date: Sat, 11 Apr 2015 10:55:09 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <72FEAB70-4102-4048-94E0-4AA0B4D67217@holtmann.org>
References: <1428685062-2911-1-git-send-email-holler@ahsoftware.de> <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org> <55280525.7040902@ahsoftware.de> <55289DD3.1080509@ahsoftware.de> <5528AC01.80804@ahsoftware.de> <55295063.2010106@ahsoftware.de>
To: Alexander Holler <holler@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

>>>>> We took the power on policy out of BlueZ 5 on purpose.
>>>> 
>>>> Nobody has to use the option which is by default off.
>>> 
>>> Sorry, but I just have to ask that in order to keep my reputation as
>>> troll:
>>> 
>>> What's that purpose?
>>> 
>>> Defeating usability? ;)
>> 
>> Just to clarify my patch. Its purpose is not to reimplement a "power on
>> by default" policy because I understand that it's a good idea to not
>> power on bt-adapters by default.
>> 
>> The purpose of my patch is to offer users a simple, fast and reliable
>> way to power on an adapter on startup, without the need to wait until
>> dbus and udev are ready and without the need for additional tools (or
>> complications) like udev-rules, hciconfig or bluetootctl.
> 
> 
> And just in case some people don't understand why I'm calling a simple looking udev-rule a complication, here is an incomplete list what all might fail when using such error-prone mechanisms:
> 
> As example I use the rule
> 
> ACTION=="add", KERNEL=="hci0", RUN+="/usr/bin/hciconfig hci0 up"
> 
> which might work as a bad replacement for the patch I've posted.
> 
> - There is the devicename (hci0). That might change.

that is actually not true. The device name stays the same as long as the hardware is plugged in.

> - There is the need for a working hciconfig-executable.
> - The path to the executable might change (think at /usr/bin -> /bin)
> - The call to hciconfig (like options) might change without notice

hciconfig is a deprecated tool and should not be used anymore. That might be your biggest problem that the binary might go away in BlueZ 6.

> - The partition the unnecessarily needed third executable (besides bluetoothd and dbus) might be mounted to late (maybe through a change in some mount order)

To be fair, we could just built this into bluetoothctl as a command.

> - the udev-rule syntax might change

That would be a udev / systemd regression that one should highly object against.

> - udev might not be available at all (there are still some alternatives)

And now we are getting into the funny cases where it is a home baked distro. Then someone might also just compile their own version of BlueZ with all sorts of patches. Upstream can not support every corner cases. So this is something I would not entertain at all.

> - ...
> 
> And please don't try to tell me that all of the above possiblities for errors are pure fiction which only might be found inside my brain. I've experienced almost all of them (not in regard to bluez or hciconfig) and most of them not just once or on systems I (mis)configured myself.

What we can do is add an option AutomaticEnabling=true,false into the [Policy] section that would equally just power on all controllers when they are found.

This needs to be clearly marked as policy since that is what it is. And it also needs to be implemented correctly. Since you need to program all the keys before you power on. Otherwise you might have tons of race conditions when it comes to re-connection of the mouse/keyboard and the key is missing.

One more complicated option would to do the Apple way in the sense, when there is not keyboard attached, they start the HID pairing UI to let you pair one. However that should be better done in the UI.

Regards

Marcel

