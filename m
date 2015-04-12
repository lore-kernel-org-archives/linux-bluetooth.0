Return-Path: <cyrus@holtmann.org>
Message-ID: <552A397D.50709@ahsoftware.de>
Date: Sun, 12 Apr 2015 11:23:09 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetoothd: add option to automatically power on the
 first adapter found
References: <1428685062-2911-1-git-send-email-holler@ahsoftware.de> <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org> <55280525.7040902@ahsoftware.de> <55289DD3.1080509@ahsoftware.de> <5528AC01.80804@ahsoftware.de> <55295063.2010106@ahsoftware.de> <72FEAB70-4102-4048-94E0-4AA0B4D67217@holtmann.org>
In-Reply-To: <72FEAB70-4102-4048-94E0-4AA0B4D67217@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 11.04.2015 um 19:55 schrieb Marcel Holtmann:
> Hi Alexander,
>
>>>>>> We took the power on policy out of BlueZ 5 on purpose.
>>>>>
>>>>> Nobody has to use the option which is by default off.
>>>>
>>>> Sorry, but I just have to ask that in order to keep my reputation as
>>>> troll:
>>>>
>>>> What's that purpose?
>>>>
>>>> Defeating usability? ;)
>>>
>>> Just to clarify my patch. Its purpose is not to reimplement a "power on
>>> by default" policy because I understand that it's a good idea to not
>>> power on bt-adapters by default.
>>>
>>> The purpose of my patch is to offer users a simple, fast and reliable
>>> way to power on an adapter on startup, without the need to wait until
>>> dbus and udev are ready and without the need for additional tools (or
>>> complications) like udev-rules, hciconfig or bluetootctl.
>>
>>
>> And just in case some people don't understand why I'm calling a simple looking udev-rule a complication, here is an incomplete list what all might fail when using such error-prone mechanisms:
>>
>> As example I use the rule
>>
>> ACTION=="add", KERNEL=="hci0", RUN+="/usr/bin/hciconfig hci0 up"
>>
>> which might work as a bad replacement for the patch I've posted.
>>
>> - There is the devicename (hci0). That might change.
>
> that is actually not true. The device name stays the same as long as the hardware is plugged in.

Yes, but the initial name might change. We just (a year or 2 ago) had 
such for most network devices and since that change I have e.g. only a 
70% chance that a bt-network device is named bnep0 when I'm starting a 
bnep-connection. The other 30% it's named en* (on one of my systems 
where I regulary do so). Up to now I still haven't searched where that 
randomness does come from and I'm using it here just as an example for 
an existing uncertainty in regard to device names. There's no need to 
discuss this problem further in this thread.

>> - There is the need for a working hciconfig-executable.
>> - The path to the executable might change (think at /usr/bin -> /bin)
>> - The call to hciconfig (like options) might change without notice
>
> hciconfig is a deprecated tool and should not be used anymore. That might be your biggest problem that the binary might go away in BlueZ 6.
>
>> - The partition the unnecessarily needed third executable (besides bluetoothd and dbus) might be mounted to late (maybe through a change in some mount order)
>
> To be fair, we could just built this into bluetoothctl as a command.

As said, this (currently) needs that dbus is ready and bluetoothctl can 
communicate with bluetoothd. And on a reasonable fast machine (4 core 
x86_64 2ghz+) this needs more than 4 seconds after startup here (invoked 
through /etc/rc.d/rc.local on f21).

>
>> - the udev-rule syntax might change
>
> That would be a udev / systemd regression that one should highly object against.
>
>> - udev might not be available at all (there are still some alternatives)
>
> And now we are getting into the funny cases where it is a home baked distro. Then someone might also just compile their own version of BlueZ with all sorts of patches. Upstream can not support every corner cases. So this is something I would not entertain at all.
>
>> - ...
>>
>> And please don't try to tell me that all of the above possiblities for errors are pure fiction which only might be found inside my brain. I've experienced almost all of them (not in regard to bluez or hciconfig) and most of them not just once or on systems I (mis)configured myself.
>
> What we can do is add an option AutomaticEnabling=true,false into the [Policy] section that would equally just power on all controllers when they are found.

Then people will ask which [Policy] section? E.g. on Fedora the 
configuration file disappeared completely. There's none in /etc anymore 
and no example in /usr/share/doc (likely because make install doesn't 
install such).

>
> This needs to be clearly marked as policy since that is what it is. And it also needs to be implemented correctly. Since you need to program all the keys before you power on. Otherwise you might have tons of race conditions when it comes to re-connection of the mouse/keyboard and the key is missing.
>
> One more complicated option would to do the Apple way in the sense, when there is not keyboard attached, they start the HID pairing UI to let you pair one. However that should be better done in the UI.

I'm not just talking about BT HID devices, also these are likely the 
main use cases. It's about automatically turning on a bt-adapter I 
either plug in or which is fixed, if the user wants such a behaviour.

And I don't want to end up in a discussion about the necessary initial 
pairing processs for bt-keyboards. On Linux, since ever, you need either 
a second keyboard or an ssh connection to do so. That's a complete 
different problem and isn't easy to solve without some special sw in 
order to do this without the need for a different input device (or 
network login or similiar).

What I just don't understand is, what's wrong with that simple command 
line option done with a simple patch (3 files changed, 15 insertions(+), 
4 deletions(-))?

Why should there be a need to use bluetoothctl for that purpose? I don't 
care if it's my patch with names I've choosen for the option and would 
be happy with any patch from any author which would let me do this with 
a simple command line option for bluetoothd.

Regards,

Alexander Holler
