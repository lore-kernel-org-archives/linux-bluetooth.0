Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BECBD8C9-C49D-410C-BE11-CA1A52839EED@holtmann.org>
References: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com>
	<CABBYNZ+iR-LXvMDkGiOkh8+X_=PWjrbGs3kveYFMo1UdhHVaNA@mail.gmail.com>
	<CAGrhNMwpx9Q4Usb75jWofWpLpUxJOd6FsckRT=O4Uj8KBtqayA@mail.gmail.com>
	<BECBD8C9-C49D-410C-BE11-CA1A52839EED@holtmann.org>
Date: Thu, 1 Oct 2015 12:29:02 +0100
Message-ID: <CAGrhNMwv+gNpWJv2pXut8S4L2DLZa-AeS1q4qVyQz4fi1oW8xA@mail.gmail.com>
Subject: Re: [RFC] MIDI over Bluetooth Low Energy
From: Felipe Tonello <eu@felipetonello.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, alsa-devel@alsa-project.org,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 1, 2015 at 12:16 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Felipe,
>
>>>> I am planning to start the support of MIDI BLE profile[1]. This
>>>> profile is not officially supported yet, but it will most likely be
>>>> very similar, so development efforts are still valid.
>>>>
>>>> I suggest two main goals:
>>>> * To be transparent to applications, i.e., use rawmidi and sequencer
>>>> ALSA interfaces to interact.
>>>> * To support peripheral and central BLE roles.
>>>>
>>>> My question is: what is the best way possible of doing it?
>>>>
>>>> My initial though is to write a GATT BlueZ profile plugin that will
>>>> load snd-virtmidi module with id and midi_devs parameters, then read
>>>> and write seq events from/to it. I am not sure if this is really
>>>> possible.
>>>
>>> If that doesn't involve creating new threads that would be the
>>> direction I would suggest.
>>
>> I don't think it will be necessary. Does bluetoothd run plugins as threa=
ds?
>>
>>>
>>>> Another way of implementing is as a rawmidi and a seq plugin using the
>>>> BlueZ GATT D-Bus interface. IMO this is not ideal because it requires
>>>> a lot more work (rawmidi and seq plugins, maybe even a library to
>>>> avoid code duplication) and has an overhead of using dbus.
>>>
>>> D-Bus is not meant for data, in fact GATT is not meant for byte stream
>>> either since the channel is shared with all other profiles it can
>>> cause delay.
>>
>> GATT can handle MIDI throughput very easily. Usually messages are 1 to
>> 10 Hz, 3 or 4 bytes each. Even SysEx messages tend to be 250 bytes at
>> maximum.
>>
>>>
>>>> It is also possible to write a kernel module to handle ALSA
>>>> card/device setup and reads and writes from the bluez plugin (perhaps
>>>> this simplifies things because it has less dependencies).
>>>
>>> Well if it uses the profile uses ATT/GATT then this is not possible
>>> since that is implemented in userspace, I guess creating virtual cards
>>> would be better (we do that for HoG using uhid), but I guess that is
>>> not currently possible otherwise we would have done that for A2DP/HFP
>>> already.
>>
>> The kernel module would act as a virtual card as well. The reads and
>> writes would come from user-space (because as you said, ATT/GATT is
>> implemented there). The good point is that it would be dedicated for
>> midi. It is like loading a usb midi gadget.
>
> I would prefer if you implement this completely in userspace. I do not th=
ink any extra new kernel module is needed. ALSA should easily support users=
pace MIDI cards.

AFAIK there is no way to create ALSA cards in userspace, unless you
load a kernel module that does it.

>
> Also I would think that first attempt should be implement this as D-Bus c=
lient utilizing our GATT API. That way it would be not introducing complex =
dependencies in BlueZ. Only if the timing is a problem, I would consider do=
ing this as a plugin for bluetoothd.

Fair enough. The only limitation I see is no peripheral support via
D-Bus API, which is one of the requirements I see.

Felipe
