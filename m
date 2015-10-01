Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [RFC] MIDI over Bluetooth Low Energy
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGrhNMwpx9Q4Usb75jWofWpLpUxJOd6FsckRT=O4Uj8KBtqayA@mail.gmail.com>
Date: Thu, 1 Oct 2015 13:16:33 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	alsa-devel@alsa-project.org,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <BECBD8C9-C49D-410C-BE11-CA1A52839EED@holtmann.org>
References: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com> <CABBYNZ+iR-LXvMDkGiOkh8+X_=PWjrbGs3kveYFMo1UdhHVaNA@mail.gmail.com> <CAGrhNMwpx9Q4Usb75jWofWpLpUxJOd6FsckRT=O4Uj8KBtqayA@mail.gmail.com>
To: Felipe Tonello <eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

>>> I am planning to start the support of MIDI BLE profile[1]. This
>>> profile is not officially supported yet, but it will most likely be
>>> very similar, so development efforts are still valid.
>>> 
>>> I suggest two main goals:
>>> * To be transparent to applications, i.e., use rawmidi and sequencer
>>> ALSA interfaces to interact.
>>> * To support peripheral and central BLE roles.
>>> 
>>> My question is: what is the best way possible of doing it?
>>> 
>>> My initial though is to write a GATT BlueZ profile plugin that will
>>> load snd-virtmidi module with id and midi_devs parameters, then read
>>> and write seq events from/to it. I am not sure if this is really
>>> possible.
>> 
>> If that doesn't involve creating new threads that would be the
>> direction I would suggest.
> 
> I don't think it will be necessary. Does bluetoothd run plugins as threads?
> 
>> 
>>> Another way of implementing is as a rawmidi and a seq plugin using the
>>> BlueZ GATT D-Bus interface. IMO this is not ideal because it requires
>>> a lot more work (rawmidi and seq plugins, maybe even a library to
>>> avoid code duplication) and has an overhead of using dbus.
>> 
>> D-Bus is not meant for data, in fact GATT is not meant for byte stream
>> either since the channel is shared with all other profiles it can
>> cause delay.
> 
> GATT can handle MIDI throughput very easily. Usually messages are 1 to
> 10 Hz, 3 or 4 bytes each. Even SysEx messages tend to be 250 bytes at
> maximum.
> 
>> 
>>> It is also possible to write a kernel module to handle ALSA
>>> card/device setup and reads and writes from the bluez plugin (perhaps
>>> this simplifies things because it has less dependencies).
>> 
>> Well if it uses the profile uses ATT/GATT then this is not possible
>> since that is implemented in userspace, I guess creating virtual cards
>> would be better (we do that for HoG using uhid), but I guess that is
>> not currently possible otherwise we would have done that for A2DP/HFP
>> already.
> 
> The kernel module would act as a virtual card as well. The reads and
> writes would come from user-space (because as you said, ATT/GATT is
> implemented there). The good point is that it would be dedicated for
> midi. It is like loading a usb midi gadget.

I would prefer if you implement this completely in userspace. I do not think any extra new kernel module is needed. ALSA should easily support userspace MIDI cards.

Also I would think that first attempt should be implement this as D-Bus client utilizing our GATT API. That way it would be not introducing complex dependencies in BlueZ. Only if the timing is a problem, I would consider doing this as a plugin for bluetoothd.

Regards

Marcel

