Return-Path: <cyrus@holtmann.org>
Message-ID: <4A641F9A.7000408@gmail.com>
Date: Mon, 20 Jul 2009 00:41:14 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: bluetooth works with udev-145 but had some weired issues with
 it
References: <dd18b0c30907192036r477c9637x450562df605294e8@mail.gmail.com> <1248074063.4549.88.camel@violet>
In-Reply-To: <1248074063.4549.88.camel@violet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
> Hi Justin,
>
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
>
> this is pretty much strange. What kernel version are you using?
>
> Kay, do you have any idea why such a simple rule would not work?
>
> Regards
>
> Marcel
>
>
>
>    
kernel is the latest git from linus pulled a day ago.
The system itself is a home brewed LFS.

As for the simple rule, this one has me confused as well.
unless I did something wrong while compiling bluez/udev
(missed a switch) or something is missing in the system itself
to not read ADD or SUBSYSTEM.
Looking at the init script for udev I cant see how it could cause
udev to not read that specific rule unless:

  cat /etc/rc.d/init.d/udev
(this is taken towards the bottom)

                /sbin/udevd --daemon

                 # Now traverse /sys in order to "coldplug" devices that 
have
                 # already been discovered
                 /sbin/udevadm trigger

                 # Now wait for udevd to process the uevents we triggered
                 /sbin/udevadm settle
                 evaluate_retval


  udevadm might have created confusion.
Also keep in mind the system is not running hal.
(not sure how depended bluez/udev is with hal)
This one has me stumped.

but besides that confusion  everything seems to be handling pretty good
(nice work on the bluetooth bluez!!)
I like how the scrollball for the mouse survives suspend.

Justin P. Mattock
