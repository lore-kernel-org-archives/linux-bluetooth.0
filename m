Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: KORG nanoKONTROL Studio ... again
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <4f787a1b-848b-be07-bdd0-198892c56120@aramar.de>
 <CABBYNZ+HQ2CeuHLrx1w5k6BK-AV8SYbdE_-TOej522cwf-BtUg@mail.gmail.com>
 <f557429f-e61b-1ac6-c894-bc84db45c65c@aramar.de>
 <CABBYNZKS+xNeiW6p+_aLp=K8Fu8DoSX+7xTt5x7-SOHkhXX=fw@mail.gmail.com>
From: Robert Schneider <Robert.Schneider@aramar.de>
Message-ID: <9dac26c6-72ee-7368-cb2b-62747e0e9707@aramar.de>
Date: Sun, 20 May 2018 16:35:45 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZKS+xNeiW6p+_aLp=K8Fu8DoSX+7xTt5x7-SOHkhXX=fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 20.05.2018 16:29, Luiz Augusto von Dentz wrote:

I just figured, that the Ubuntu bluez seems to be build without midi support. 
Its bluetoothd does not list libasound as a library. Isn't that an indicator 
that midi was not compiled into it?

So I guess I need to create a build env first in order to build a bluez with 
midi support.

> Hi Robert,
> On Sun, May 20, 2018 at 4:46 PM Robert Schneider
> <Robert.Schneider@aramar.de>
> wrote:
>
>> On 20.05.2018 14:14, Luiz Augusto von Dentz wrote:
>> [...]
>>> The info says:
>>>> [bluetooth]# info 60:F1:89:28:DA:1F
>>>> Device 60:F1:89:28:DA:1F (public)
>>>>         Name: nanoKONTROL Studio
>>>>         Alias: nanoKONTROL Studio
>>>>         Appearance: 0x0080
>>>>         Icon: computer
>>>>         Paired: no
>>>>         Trusted: yes
>>>>         Blocked: no
>>>>         Connected: no
>>>>         LegacyPairing: no
>>>>         UUID: Generic Access Profile
> (00001800-0000-1000-8000-00805f9b34fb)
>>>>         UUID: Generic Attribute Profile
> (00001801-0000-1000-8000-00805f9b34fb)
>>>>         UUID: Device Information (0000180a-0000-1000-8000-00805f9b34fb)
>>>>         UUID: Vendor specific (03b80e5a-ede8-4b33-a751-6ce34ec4c700)
>>>>         UUID: Vendor specific (d0611e78-bbb4-4591-a5f8-487910ae4366)
>>>    From the looks of it seems the device is not using the standard MIDI
>>> service but vendor specific ones which don't have support.
>> Hm, 03b80e5a-ede8-4b33-a751-6ce34ec4c700 seems to be the MIDI service,
> doesn't
>> it? It is listed up there, as a Vendor specific code, though.
> You are right:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/profiles/midi/libmidi.h#n32
>
> Perhaps it is the MIDI_IO_UUID that is missing, we should probably add
> decoders for these so they are not shown as Vendor specific.
>
>
>> [...]
>
>

