Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+D5KbW7b2_F0fw9C=YvMNyVdaN=sLuNj5v0O-Zs6XSVg@mail.gmail.com>
References: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com>
	<CABBYNZ+iR-LXvMDkGiOkh8+X_=PWjrbGs3kveYFMo1UdhHVaNA@mail.gmail.com>
	<CAGrhNMwpx9Q4Usb75jWofWpLpUxJOd6FsckRT=O4Uj8KBtqayA@mail.gmail.com>
	<CABBYNZ+D5KbW7b2_F0fw9C=YvMNyVdaN=sLuNj5v0O-Zs6XSVg@mail.gmail.com>
Date: Thu, 1 Oct 2015 12:26:17 +0100
Message-ID: <CAGrhNMymYEDbL9P5d17GGFSPb96MexpB+mb-ZeOqesukEdbtjQ@mail.gmail.com>
Subject: Re: [RFC] MIDI over Bluetooth Low Energy
From: Felipe Tonello <eu@felipetonello.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: alsa-devel@alsa-project.org,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 1, 2015 at 12:05 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Felipe,
>
> On Thu, Oct 1, 2015 at 1:17 PM, Felipe Tonello <eu@felipetonello.com> wrote:
>> Hi Luiz,
>>
>> On Thu, Oct 1, 2015 at 10:34 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Felipe,
>>>
>>> On Thu, Oct 1, 2015 at 11:41 AM, Felipe Tonello <eu@felipetonello.com> wrote:
>>>> Hi guys,
>>>>
>>>> I am planning to start the support of MIDI BLE profile[1]. This
>>>> profile is not officially supported yet, but it will most likely be
>>>> very similar, so development efforts are still valid.
>>>>
>>>> I suggest two main goals:
>>>>  * To be transparent to applications, i.e., use rawmidi and sequencer
>>>> ALSA interfaces to interact.
>>>>  * To support peripheral and central BLE roles.
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
>> I don't think it will be necessary. Does bluetoothd run plugins as threads?
>
> Nope, and most of the code in the daemon is no thread safe.
>
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
>
> But the transport is shared between all services, you may have several
> command in the queue and those can block the queue for up to 30
> seconds before they timeout.

Hmm. I see. That can really be an issue. Is that BlueZ specific? Can
be worked out?

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
> Well if you are proposing some module that would accept registering
> virtual cards from userspace that probably would probably make sense,
> this make it much simpler to be detected by the system as a regular
> ALSA device so application can use.

Yes. As I see, this is the best option to have correct ALSA rawmidi
and seq interfaces support.

>
>>>
>>>> They all have the problem of context switching between bluez plugin
>>>> and alsa midi driver. I would prefer to use a shared ring buffer
>>>> between ALSA e BlueZ.
>>>
>>> You can use anything you want but don't expose bluetoothd to attacks,
>>> so probably no shmem, actually if your concern is latency then as I
>>> said you shouldn't be using ATT/GATT, instead L2CAP CoC should be used
>>> but I don't think Apple has implemented it yet.
>>
>> What is L2CAP CoC? I am not aware of it.
>
> Connection oriented channel, I think it was introduced in Bluetooth
> 4.1, with that you can have a dedicated channel for your profile. This
> is implemented in the kernel as a regular L2CAP socket btw.
>
>>>
>>>> Any ideas and comments?
>>>>
>>>> [1] https://developer.apple.com/bluetooth/Apple-Bluetooth-Low-Energy-MIDI-Specification.pdf
>>>
>>> It seems the specs is pretty old, from 2012, that probably explain why
>>> L2CAP CoC was not used.
>>
>> I think that might be first draft, because it was released end of
>> 2014. Also there are only two or three products out there implementing
>> this protocol as it is new. I think will be a great thing if these and
>> many other products runs as first class citizen in Linux too.
>>
>> BTW, is peripheral role fully supported on BlueZ? I did look into this
>> beginning of 2014 and it was incomplete.
>
> We do have advertising, GATT server and L2CAP CoC implemented, there
> maybe a few details left though since some APIs are still
> experimental.
>

Felipe
