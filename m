Return-Path: <cyrus@holtmann.org>
Message-ID: <4A64A0B4.6010507@gmail.com>
Date: Mon, 20 Jul 2009 09:52:04 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Mario Limonciello <mario_limonciello@dell.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth works with udev-145 but had some weired issues with
 it
References: <dd18b0c30907192036r477c9637x450562df605294e8@mail.gmail.com> <4A648DDF.7060303@dell.com>
In-Reply-To: <4A648DDF.7060303@dell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mario Limonciello wrote:
> Hi Justin:
>
> Justin Mattock wrote:
>    
>> For some reason in rules.d
>> for the permission setting:
>>
>> #ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd --udev"
>> to
>> RUN+="/usr/sbin/bluetoothd --udev"
>> gets this working for me.
>> prior to this, udev just would not activate
>> bluetoothd
>> Anyways thought it would be good to let people know.
>>
>>
>>      
> I'm wondering if you are seeing something similar that was happening on
> Ubuntu when getting bluez-4.45 added in where the daemon failed to start
> upon bootup but works fine later (eg if you hotplug the device).
>
> It turned out that dbus wasn't up and running at the time udev triggered
> all devices early in the boot.
>
> The easiest solution was to run:
>
>      udevadm trigger --subsystem-match=bluetooth
>
>
> later on, during an init script or similar.
>    
yeah,  the:

ACTION=="add", SUBSYSTEM=="bluetooth", RUN+="/usr/sbin/bluetoothd --udev"
option gave no response after rebooting numerous times, until commenting out
ACTION, and SUBSYSTEM, and just using RUN+=
The init script has /sbin/udevadm trigger and /sbin/udevadm settle
after /sbin/udevd --daemon is called.
And from what I see that might be whats happening,
udevadm needs to be told about the subsystem call.

I'll go ahead and try your solution and see if it reads the susbsystem
option without having to change the *.rules

Justin P. Mattock


