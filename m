Return-Path: <cyrus@holtmann.org>
Message-ID: <55295063.2010106@ahsoftware.de>
Date: Sat, 11 Apr 2015 18:48:35 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetoothd: add option to automatically power on the
 first adapter found
References: <1428685062-2911-1-git-send-email-holler@ahsoftware.de> <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org> <55280525.7040902@ahsoftware.de> <55289DD3.1080509@ahsoftware.de> <5528AC01.80804@ahsoftware.de>
In-Reply-To: <5528AC01.80804@ahsoftware.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 11.04.2015 um 07:07 schrieb Alexander Holler:
> Am 11.04.2015 um 06:06 schrieb Alexander Holler:
>> Am 10.04.2015 um 19:15 schrieb Alexander Holler:
>>> Am 10.04.2015 um 19:10 schrieb Marcel Holtmann:
>>
>>>> We took the power on policy out of BlueZ 5 on purpose.
>>>
>>> Nobody has to use the option which is by default off.
>>
>> Sorry, but I just have to ask that in order to keep my reputation as
>> troll:
>>
>> What's that purpose?
>>
>> Defeating usability? ;)
>
> Just to clarify my patch. Its purpose is not to reimplement a "power on
> by default" policy because I understand that it's a good idea to not
> power on bt-adapters by default.
>
> The purpose of my patch is to offer users a simple, fast and reliable
> way to power on an adapter on startup, without the need to wait until
> dbus and udev are ready and without the need for additional tools (or
> complications) like udev-rules, hciconfig or bluetootctl.


And just in case some people don't understand why I'm calling a simple 
looking udev-rule a complication, here is an incomplete list what all 
might fail when using such error-prone mechanisms:

As example I use the rule

ACTION=="add", KERNEL=="hci0", RUN+="/usr/bin/hciconfig hci0 up"

which might work as a bad replacement for the patch I've posted.

- There is the devicename (hci0). That might change.
- There is the need for a working hciconfig-executable.
- The path to the executable might change (think at /usr/bin -> /bin)
- The call to hciconfig (like options) might change without notice
- The partition the unnecessarily needed third executable (besides 
bluetoothd and dbus) might be mounted to late (maybe through a change in 
some mount order)
- the udev-rule syntax might change
- udev might not be available at all (there are still some alternatives)
- ...

And please don't try to tell me that all of the above possiblities for 
errors are pure fiction which only might be found inside my brain. I've 
experienced almost all of them (not in regard to bluez or hciconfig) and 
most of them not just once or on systems I (mis)configured myself.


> E.g. one of my use-cases is to be able to use a bt-keyboard right after
> the system shows me a login. Without that patch waiting 4 seconds
> haven't been enough, and with the patch the keyboard is now usable
> almost immediately.
>
> And there are many other use cases where people do want that an adapter
> is turned on after it's found. E.g. I assume on most systems which don't
> have a fixed bt-adapter but rely on usb-dongles, people might prefer
> that their dongle will be automatically turned on when it's plugged in
> (otherwise they likely wouldn't plug it in). And the patch offers just a
> very simple, clean and easy to use way to reach that goal and is not a
> try to change the default policy.
>
> Regards,
>
> Alexander Holler
