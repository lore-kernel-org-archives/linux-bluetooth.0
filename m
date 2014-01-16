Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F4C3DE28-E297-42B1-9FA2-B3335DF0F080@holtmann.org>
References: <CAGXr9JHw-S5XdXEcp3APN9OKadt7LuoPQmJ2RZkAsRZ8dDJB-w@mail.gmail.com>
	<F4C3DE28-E297-42B1-9FA2-B3335DF0F080@holtmann.org>
Date: Thu, 16 Jan 2014 15:03:15 -0800
Message-ID: <CAGXr9JHi5UuDd01POdua1UZ2kY+n=0wGcxaWx4Ta=55fHvZxyw@mail.gmail.com>
Subject: Re: Questions on BlueZ 5.13: device creation API + persistent
 hid/input pipeline
From: Petri Gynther <pgynther@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for your reply. Please see inline.

On Thu, Jan 16, 2014 at 2:30 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Petri,
>
>> I'm running BlueZ 5.13 userland + backported BlueZ kernel modules on
>> an embedded system that I'm working on. The kernel on the system is
>> 2.6.37-based. I ported uhid driver manually from 3.12.
>>
>> I'm successfully using Bluetooth classic HID remote control and
>> Bluetooth LE HoG remote control on this system. However, I have two
>> questions:
>>
>> 1) The Bluetooth classic remote that I'm using is not discoverable. It
>> is only connectable. When the remote is not paired, it sends its
>> Bluetooth MAC address to the host via IR, and the host needs to add
>> this device to BlueZ's discovered devices database. But, how can I do
>> that via D-Bus API? BlueZ 5 porting guide specifically mentions that "
>> ... we decided to simply get rid of explicit CreateDevice /
>> CreatePairedDevice methods and instead dynamically create device
>> objects as they are discovered during device discovery."
>>
>> So, is there no API available to add non-discoverable devices in BlueZ 5=
?
>>
>> I have worked around this issue by manually adding this remote to
>> <storage path>, so that bluetoothd creates the device on reboot via
>> device_create_from_storage(). But, I would prefer not to restart
>> bluetoothd every time a non-discoverable device needs to be added.
>
> I have never heard of a remote that uses IR to setup the pairing. A creat=
ive way of doing out-of-band pairing.
>
> What I think you are looking for is what the PS3 controllers do when the =
share their details over USB and then after that connect over Bluetooth HID=
. Have a look at plugins/sixaxis.c to see how they do it. BlueZ has a plugi=
n API for doing exactly these kind of automated setup/pairing type of cases=
.
>
> So you want to write a plugin for this remote.
>
> The other plugin you might want to look at is plugins/autopair.c if it ac=
tually requires to also create an encrypted link.
>

Thank you for this info. I will look into plugins/sixaxis.c and
plugins/autopair.c.

>> 2) There is a difference in HID vs HoG hid/input pipeline persistence.
>> When the Bluetooth classic HID remote disconnects, the corresponding
>> hid and input kernel devices are destroyed. And when it reconnects,
>> hid and input devices are created again. This adds a lot of
>> unnecessary delay at reconnect. And, the first keypress is always lost
>> on reconnect.
>>
>> In contrast, for the Bluetooth LE HoG remote, the hid/input pipeline
>> is persistent. When HoG remote disconnects, hid and input devices
>> remain in the system and are reused when the HoG remote reconnects.
>>
>> Is there a way to make Bluetooth classic HID behave the same as HoG,
>> i.e. retain the hid and input kernel devices on disconnect and reuse
>> them on reconnect?
>
> HID and HoG work a little bit different. HID uses a kernel transport driv=
er while HoG uses /dev/uhid to do the work. Porting HID over to use /dev/uh=
id is certainly a possibility. We have considered that, but nobody has done=
 that work yet.
>
> Please remember that HID (with HIDP) is finding its right place in /sys d=
evice tree. While all HoG using /dev/uhid are considered virtual devices. T=
here is a semi proposal that we agreed on New Orleans during the PlumbersCo=
nf, but I have no idea if David actually implemented it.
>
> Another option is to make the HIDP transport smarter and persistent by in=
tegrating it into BlueZ 5=E2=80=99s kernel mgmt support. That however means=
 you will need a much more recent Bluetooth subsystem. So 2.6.37 is not get=
ting you anywhere near that even if we change HIDP support.
>
> Regards
>
> Marcel
>

I'm using BlueZ kernel modules (bluetooth, hidp) from Linux
backports-3.13-rc2-1, so that is pretty recent code. Works fine on top
of 2.6.37. However, my HID and input drivers come from 2.6.37, as they
are not available in backports-3.13-rc2-1.

I understand the difference between HID and HoG. Both hidp and uhid
are hid_ll_drivers. HID input reports stay entirely in kernel, whereas
HoG is handled in bluetoothd and input reports are passed back to
kernel via /dev/uhid.

Assuming the latest HIDP code, what kind of effort would it be to make
the hid/input pipeline persistent when HID remote disconnects and
reconnects?

-- Petri
