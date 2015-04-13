Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] bluetoothd: add option to automatically power on the first adapter found
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <552B87EE.5040800@ahsoftware.de>
Date: Mon, 13 Apr 2015 07:32:56 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B8F6B143-DA86-4F06-B4C8-FA2790AA33B3@holtmann.org>
References: <1428685062-2911-1-git-send-email-holler@ahsoftware.de> <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org> <55280525.7040902@ahsoftware.de> <55289DD3.1080509@ahsoftware.de> <5528AC01.80804@ahsoftware.de> <55295063.2010106@ahsoftware.de> <72FEAB70-4102-4048-94E0-4AA0B4D67217@holtmann.org> <552A397D.50709@ahsoftware.de> <273C2B2C-FE29-4E28-8B50-7A9BE82C098D@holtmann.org> <552B87EE.5040800@ahsoftware.de>
To: Alexander Holler <holler@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

>>>>>>>>> We took the power on policy out of BlueZ 5 on purpose.
>>>>>>>> 
>>>>>>>> Nobody has to use the option which is by default off.
>>>>>>> 
>>>>>>> Sorry, but I just have to ask that in order to keep my reputation as
>>>>>>> troll:
>>>>>>> 
>>>>>>> What's that purpose?
>>>>>>> 
>>>>>>> Defeating usability? ;)
>>>>>> 
>>>>>> Just to clarify my patch. Its purpose is not to reimplement a "power on
>>>>>> by default" policy because I understand that it's a good idea to not
>>>>>> power on bt-adapters by default.
>>>>>> 
>>>>>> The purpose of my patch is to offer users a simple, fast and reliable
>>>>>> way to power on an adapter on startup, without the need to wait until
>>>>>> dbus and udev are ready and without the need for additional tools (or
>>>>>> complications) like udev-rules, hciconfig or bluetootctl.
>>>>> 
>>>>> 
>>>>> And just in case some people don't understand why I'm calling a simple looking udev-rule a complication, here is an incomplete list what all might fail when using such error-prone mechanisms:
>>>>> 
>>>>> As example I use the rule
>>>>> 
>>>>> ACTION=="add", KERNEL=="hci0", RUN+="/usr/bin/hciconfig hci0 up"
>>>>> 
>>>>> which might work as a bad replacement for the patch I've posted.
>>>>> 
>>>>> - There is the devicename (hci0). That might change.
>>>> 
>>>> that is actually not true. The device name stays the same as long as the hardware is plugged in.
>>> 
>>> Yes, but the initial name might change. We just (a year or 2 ago) had such for most network devices and since that change I have e.g. only a 70% chance that a bt-network device is named bnep0 when I'm starting a bnep-connection. The other 30% it's named en* (on one of my systems where I regulary do so). Up to now I still haven't searched where that randomness does come from and I'm using it here just as an example for an existing uncertainty in regard to device names. There's no need to discuss this problem further in this thread.
>> 
>> I you start intermixing network interface names with Bluetooth HCI device names, then there is really nothing much more to add. They are two different things. Plain and simple.
> 
> I've used it as an example that device names might change, in general, to explain one of the many possible failures if there is a need for an udev-rule which calls another executable. Nothing else. Try to abstract.
> 
>>>>> - There is the need for a working hciconfig-executable.
>>>>> - The path to the executable might change (think at /usr/bin -> /bin)
>>>>> - The call to hciconfig (like options) might change without notice
>>>> 
>>>> hciconfig is a deprecated tool and should not be used anymore. That might be your biggest problem that the binary might go away in BlueZ 6.
>>>> 
>>>>> - The partition the unnecessarily needed third executable (besides bluetoothd and dbus) might be mounted to late (maybe through a change in some mount order)
>>>> 
>>>> To be fair, we could just built this into bluetoothctl as a command.
>>> 
>>> As said, this (currently) needs that dbus is ready and bluetoothctl can communicate with bluetoothd. And on a reasonable fast machine (4 core x86_64 2ghz+) this needs more than 4 seconds after startup here (invoked through /etc/rc.d/rc.local on f21).
>> 
>> Szymon send an example on how to add wait-for-adapter in bluetoothctl. Together with that and a proper systemd unit, I bet you that this does not take 4 seconds.
>> 
>> If you insist on doing old fashion rc.local stuff, then I can not help you. You can look into systemd target definitions, but I am pretty sure it ends up being started after something else happened.
> 
> At least that old fashioned stuff worked. I even still have bt-alsa-devices on systems where I stick to bluez 4.0.
> 
> And it would make me extremly wonder, if it would be any faster when using a systemd unit. Remember, I did in rc.local:
> 
> sleep 4
> echo "power on" | /bin/bluetoothctl
> 
> And if that fails, then how could a systemd unit which calls bluetoothctl be faster? There is absolutely nothing in those 2 lines which slows down the necessary prerequisits for bluetoothctl.

except the sleep 4 that you put in. So you are going on for rant this takes 4 seconds and the reason it takes 4 seconds since you put a sleep 4 in there. Szymon gave you a simple solution for removing the sleep and we are still discussing this.

> So, now were there, people are called old fashioned, if they even use systemd but still stick to some easy to use script. Nice new Linux world where nothing works. No wonder Linux on desktops (which aren't Android or Chrome*) is dead ...
> 
> 
>>>>> - the udev-rule syntax might change
>>>> 
>>>> That would be a udev / systemd regression that one should highly object against.
>>>> 
>>>>> - udev might not be available at all (there are still some alternatives)
>>>> 
>>>> And now we are getting into the funny cases where it is a home baked distro. Then someone might also just compile their own version of BlueZ with all sorts of patches. Upstream can not support every corner cases. So this is something I would not entertain at all.
>>>> 
>>>>> - ...
>>>>> 
>>>>> And please don't try to tell me that all of the above possiblities for errors are pure fiction which only might be found inside my brain. I've experienced almost all of them (not in regard to bluez or hciconfig) and most of them not just once or on systems I (mis)configured myself.
>>>> 
>>>> What we can do is add an option AutomaticEnabling=true,false into the [Policy] section that would equally just power on all controllers when they are found.
>>> 
>>> Then people will ask which [Policy] section? E.g. on Fedora the configuration file disappeared completely. There's none in /etc anymore and no example in /usr/share/doc (likely because make install doesn't install such).
>> 
>> That is a documentation problem. Send patches for it.
> 
> 
> Why should I send any further patches if I already fail with such simple ones?

I am not taking patches that are just hacks only because they work for you. It is plain and simple like that. I offered a way for adding this in a generic fashion that will be actually useful for others and would work for you, but it seems nobody cares.

> Anyway. It's ok. I accept that my patch is an unbelievable piece of shit which renders bluetoothd into a big bug and kills almost any Linux system.
> 
> But maybe it could help other victims. That was the only reason I've posted this patch and even tried to explain the motivations to not have the unnecessary need for further complications besides a simple additional command line option for bluetoothd.

Regards

Marcel

