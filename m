Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <627c376a-9c39-628c-dbe5-e890939cd533@felipetonello.com>
References: <20161118145944.22266-1-eu@felipetonello.com> <f5c20530-bf2e-4cb5-ba1e-bb63114c22f0@felipetonello.com>
 <CABBYNZ+hmPQ3GxP475cGH1=s_U6OdAAutG4NTZBftg56vMG_Tg@mail.gmail.com>
 <3DF5EE56-68DB-4211-B492-3BD6984BA39D@felipetonello.com> <627c376a-9c39-628c-dbe5-e890939cd533@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Nov 2016 14:25:07 +0200
Message-ID: <CABBYNZK4_mQ0nAEbR1he2YK2iUkJHagE68Xej8xNy+3U-Z0rOA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profiles/midi: Added MIDI over BLE profile implementation
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Tue, Nov 29, 2016 at 2:19 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi all,
>
> Ping on this?
>
> I already have a v2 ready but waiting for more comments to send.
>
> More comments below.
>
> On 21/11/16 12:25, Felipe Ferreri Tonello wrote:
>> Hi Luiz,
>>
>> On November 21, 2016 11:47:04 AM GMT+00:00, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>> Hi Felipe,
>>>
>>> On Mon, Nov 21, 2016 at 1:21 PM, Felipe Ferreri Tonello
>>> <eu@felipetonello.com> wrote:
>>>> Hi all,
>>>>
>>>> On 18/11/16 14:59, Felipe F. Tonello wrote:
>>>>> This plugin implements the Central roli of MIDI over Bluetooth
>>>>> Low-Energy (BLE-MIDI) 1.0 specification as published by MMA in
>>>>> November/2015.
>>>>>
>>>>> It was implmemented as a bluez plugin because of latency
>>> requirements
>>>>> of MIDI. There are still room for improvements on this regard.
>>>>>
>>>>> Since all parsing and state-machine code is in libmidi.[hc] it
>>> should be
>>>>> simple to implement Peripheral role as a GATT service as well.
>>>>>
>>>>> I have also implemented several unit-tests that can be easily
>>> extended
>>>>> without adding any code, just use-cases.
>>>>>
>>>>> Files added:
>>>>>  * profiles/midi/midi.c: Actual GATT plugin
>>>>>  * profiles/midi/libmidi.[ch]: MIDI parsers
>>>>>  * unit/test-midi.c: Unit-tests
>>>
>>> Btw, usually we stayed away from alsa/audio dependencies since they
>>> are quite time sensitive which may impact in the responsiveness of
>>> bluetoothd, so I wonder if you document anything in this regard? Also
>>> please keep in mind many parts of bluetoothd are not thread-safe so if
>>> there are other threads involved Im afraid we won't be taking more
>>> than the GATT plugin leaving the remaining code to be done somewhere
>>> else.
>>
>> Yes, this is time sensitive, as it requires low-latency connection intervals, but I didn't notice any problems with it. I have tested with two devices connected at the same time and it works very well. What sort of document are you referring to?
>> As this profile is quite unique in terms of low-latency GATT services it may be interesting to optimise it in future if necessary.
>>
>> On the thread note, I was aware of this and implemented in a way thst doesn't require any extra threads.
>
> This plugin doesn't require any new threads. It relies on notifications
> from a device to parse and render proper events that are queued in the
> kernel, causing no blocks at all. Even if an error occur, it will be
> handled and returned control to bluetoothd.
>
> It also adds a new file descriptor to be read using struct io. That is
> necessary to read events from applications and render raw BLE packets to
> be sent to the device with a write without response command. It doesn't
> block as well.
>
> Even though this adds a new dependency, ALSA, it is not an audio plugin.
> It is rather a MIDI plugin, which is a byte stream protocol with low
> throughput but requires low-latency.

Please add this to the commit message of the v2, I will be checking
for other problems when applying it.

Luiz Augusto von Dentz
