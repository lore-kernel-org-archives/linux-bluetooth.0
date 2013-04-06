Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <515EC86C.1020809@start.ca>
References: <515EBB91.1020006@start.ca>
	<CANT-zCVRwyR9de4gHp5+ur3_oDcMnL4RttQFayBmUKYUrgJODA@mail.gmail.com>
	<515EC86C.1020809@start.ca>
Date: Sat, 6 Apr 2013 10:05:14 +0200
Message-ID: <CANT-zCW7+n0Jh84T1RSUnP47bf_t5rMQXBByKtegV0E+eM-w9g@mail.gmail.com>
Subject: Re: Bluetooth pulseaudio multiple device entries
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Colin Beckingham <colbec@start.ca>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

On Fri, Apr 5, 2013 at 2:49 PM, Colin Beckingham <colbec@start.ca> wrote:
>
>
> On 04/05/2013 08:16 AM, Mikel Astiz wrote:
>>
>> Hi Colin,
>>
>> On Fri, Apr 5, 2013 at 1:54 PM, Colin Beckingham <colbec@start.ca> wrote:
>>>
>>> Good day: using Opensuse 12.3 with standard desktop kernel from repo,
>>> pulseaudio under Gnome.
>>>
>>> Steps to reproduce:
>>> 1. clean boot of machine.
>>> 2. USB Bluetooth adapter Belkin which works reliably
>>> 3. Issue command as root "hciconfig 0 sspmode 0" - this is essential
>>> otherwise bluetooth device not recognized.
>>> 4. Open gnome sound settings from user menu; onboard sound device is
>>> present, only one entry
>>> 5. switch on bluetooth device Samsung WEP 475
>>> 6. device is recognized and paired, an entry appears in PA list
>>> 7. about 10 sec later a second entry for the same BT device appears in
>>> the
>>> list
>>> 8. after playing with the windows sometimes the second entry will go away
>>> 9. at least one of the entries will work and PA shows amplitude changes
>>> registering for the input device
>>> 10. sometimes clicking the wrong one will cause Gnome settings window to
>>> crash, but BT and PA are still running and device is working and gnome
>>> window can be opened again.
>>>
>>> Clearly the multiple entries thing is not normal behaviour.
>>> Might be a BT issue, or a PA issue, or a Gnome issue or other.
>>> It's a tossup where where to start, can I rule out the BT side?
>>
>>
>> Can you specify which versions of BlueZ and PulseAudio you're using?
>>
>> Also, please check:
>> a. which modules are loaded during the issue by doing "pactl list
>> modules" or similar.
>> b. which bluetooth devices BlueZ registers on D-Bus: "test-device
>> list"/"bluez-test-device list" or similar. You can alternatively use a
>> tool such as d-feet.
>>
>> Cheers,
>> Mikel
>
>
> Mikel -
>
> -----------------
>
> $ pulseaudio --version
> pulseaudio 3.0
>
> -------------------
>
> # bluetoothd --version
> 4.101
>
> -------------------
>
> # test-device list
> 00:0D:E6:6E:51:47 WEP475
>
> -------------------
>
> # pactl list modules
>
> ### this module is added after starting the Samsung device
>
> Module #28
>     Name: module-bluetooth-device
>     Argument: address="00:0D:E6:6E:51:47"
> path="/org/bluez/455/hci0/dev_00_0D_E6_6E_51_47"
>     Usage counter: 0
>     Properties:
>         module.author = "Joao Paulo Rechi Vita"
>         module.description = "Bluetooth audio sink and source"
>         module.version = "3.0"
>
> -------------------
>
> A small point to add to steps to reproduce:
>
> 11. with two entries showing in PA, shut down of BT device removes the
> latest added entry from the PA list leaving one entry for the device even
> though it is not active.

As you probably guessed, the traces you provide look good, no
duplicated devices there. I would thus assume it's a UI issue, you
might confirm this by using pavucontrol and checking whether the card
(representing the device) is listed twice or not.

Besides, when you say "7. about 10 sec later a second entry for the
same BT device...", is this happening only after you pair the device?
Or does the issue also reproduce every time the device gets connected
(without unpair + pair)?

Cheers,
Mikel
