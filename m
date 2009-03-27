Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Mar 2009 20:23:09 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Newbie, can't find device
In-Reply-To: <200903261157.28413.gene.heskett@verizon.net>
Message-ID: <alpine.LNX.2.00.0903262001290.27577@nge2.ngu.pk>
References: <200903252037.03024.gene.heskett@verizon.net> <alpine.LNX.2.00.0903260643010.22668@nge2.ngu.pk> <200903261157.28413.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Thu, 26 Mar 2009, Gene Heskett wrote:

>> I don't use udev, but maybe you can adapt this to your setup. I think you
>> need an rfcomm device. udev may create the devices when they are actually
>> opened. They list in /proc/devices on my system, major number 216, minors 0
>> and 1.
>>
>> crw-rw-rw- 1 root root 216, 0 2009-02-22 23:01 /dev/rfcomm0
>> crw-rw-rw- 1 root root 216, 1 2007-12-16 07:29 /dev/rfcomm1
>
> /proc/devices is a file, not a dir on this F10 system.
>
> I have only:
> 216 rfcomm

It's supposed to be a file. Can you use mknod to make a rfcomm device? Is that 
allowed in udev? I've never worked with it; I find that making the devices by 
hand works well for me. If you can, the command would be like:

mknod -m 666 /dev/rfcomm0 c 216 0
mknod -m 666 /dev/rfcomm0 c 216 1

However, if the bluetooth adapter isn't working for some reason, then udev is 
right not to make devices for it since to it, it doesn't yet exist.

>> # hcitool scan
>
> 20 secs quiet, empty return.  There is a twin to it plugged into a kubuntu box
> about 10 feet away, but its hciconfig says hci0 is down.  and
> 'hciconfig hci0 up' returns no such device.

The dongle on the kubuntu box isn't ready/supported/working. You should see it 
by scanning, and I've never had to do a manual 'hciconfig hci0 up' at any 
time. If it's a USB congle, does it show with 'lsusb'? When you plug it in, 
what kernel messages do you get? Are the bluez/dbus/usb systems all complete 
on that box?



>> # passkey-agent --default (PIN) (address of your device) &
>> # auth-agent &
>>
>> Find the channel the thing you want is on -
>>
>> # sdptool browse 00:1C:62:19:B1:6A
>
> Is a repeat of the null return above.
>
> From a terminal screen:
> [root@coyote src]# hcitool scan
> Scanning ...
> [root@coyote src]# hciconfig -a hci0
> hci0:   Type: USB
>        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
>        UP RUNNING PSCAN ISCAN
>        RX bytes:1390 acl:0 sco:0 events:50 errors:0
>        TX bytes:462 acl:0 sco:0 commands:49 errors:0
>        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy: RSWITCH HOLD SNIFF PARK
>        Link mode: SLAVE ACCEPT
>        Name: 'coyote.coyote.den-0'
>        Class: 0x4a2100
>        Service Classes: Networking, Capturing, Telephony
>        Device Class: Computer, Uncategorized
>        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver: 0x1f4
>        Manufacturer: CONWISE Technology Corporation Ltd (66)
>
> [root@coyote src]# sdptool browse 11:11:11:11:11:11
> Failed to connect to SDP server on 11:11:11:11:11:11: No route to host
> [root@coyote src]#

That's expected. This will always fail until the kubuntu dongle is working.

> [root@coyote src]# rfcomm bind 0 11:11:11:11:11:11 8
> [root@coyote src]# hcitool dev
> Devices:
>        hci0    11:11:11:11:11:11
> [root@coyote src]# rfcomm bind 0 11:11:11:11:11:11 8
> Can't create device: Address already in use
> [root@coyote src]# rfcomm release 0 11:11:11:11:11:11
> [root@coyote src]# rfcomm bind 0 11:11:11:11:11:11 8
> [root@coyote src]#
>
> So that appears to work since I can't do it a 2nd time w/o a release in
> between.  But there is still no device being created.

This one is the same as above, it won't work until the partner dongle is 
working correctly. It must be contactable and in working order before you can 
make an rfcomm connection to it and transfer data.

Try taking your working adapter and putting it into the kubuntu box. If it 
works, it was the other dongle, if it doesn't, it's the other system itself at 
fault.


  > I followed the thread just in front of this message and made my
> /etc/dbus-1/system.d/bluetooth.conf match the final version there, but I don't
> believe it made any diff>  At what point in the down/up sequence (which gives
> a null return, even for repeats BTW, and hciconfig continues to say its up
> even if I have sent several downs.  And on the kubuntu box, it says its always
> down)

The previous post I made about dbus was to fix permission problems when bluez 
interacts with dbus after dbus is updated to the currect release, which is 
much more strick with permissions. I don't think that is causing the issue 
here. From here, I'd focus on getting 'hciconfig -a' to return the correct 
information on the kubuntu box. Once that works, all the other errors should 
clear up.





