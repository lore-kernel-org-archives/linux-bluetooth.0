Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [pulseaudio-discuss] Bose QC35 HFP/HSP MTU size
To: General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Arun Raghavan <arun@arunraghavan.net>,
        Tanu Kaskinen <tanuk@iki.fi>
References: <20170914114402.qbfwd3ceosrrgzqp@earth>
 <CABBYNZKT6-8VjGPMyJ87jBPnGWQ=LtfODT3JMyVfZ8Nzp=tiMw@mail.gmail.com>
From: Georg Chini <georg@chini.tk>
Message-ID: <4e644615-3778-83a8-0976-35a781223485@chini.tk>
Date: Sat, 16 Sep 2017 20:12:43 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZKT6-8VjGPMyJ87jBPnGWQ=LtfODT3JMyVfZ8Nzp=tiMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 14.09.2017 16:00, Luiz Augusto von Dentz wrote:
> Hi Sebastian,
>
> On Thu, Sep 14, 2017 at 2:44 PM, Sebastian Reichel <sre@kernel.org> wrote:
>> Hi,
>>
>> Bose QC35 are affected by the attached upgrade notice
>> from Pulseaudio 11. The workaround fixes the problem.
> This doesn't make much sense when the problem below refer to the local
> adapter not the remote device, so I suspect just about any device
> would have similar problem when using an MTU not compatible with the
> adapter. Or perhaps this does depend on the packet type the controller
> end up negotiating since the spec say:
>
>
> 6.5.2.1 HV1 Packet
> The HV1 packet has 10 information bytes. The bytes are protected with a rate
> 1/3 FEC. No MIC is present. No CRC is present. The payload length is fixed at
> 240 bits. There is no payload header present.
> 6.5.2.2 HV2 Packet
> The HV2 packet has 20 information bytes. The bytes are protected with a rate
> 2/3 FEC. No MIC is present. No CRC is present. The payload length is fixed at
> 240 bits. There is no payload header present.
>   can 6.5.2.3 HV3 Packet
> The HV3 packet has 30 information bytes. The bytes are not protected by FEC.
> No MIC is present. No CRC is present. The payload length is fixed at 240 bits.
> There is no payload header present.
>
> So HV1, HV2, HV3 packet size is 240bit = 48 bytes, but for EV and eSCO
> the payload is not fixed. So far we had assumed the controller would
> do the flow control so we just push data to its buffer but if it does
> expect the exact payload depending on the packet type that would
> explain why this doesn't work all the time. I have never seem a SCO
> buffer over 96 bytes and since packets but packets such as 3-EV5 can
> take up to 540 bytes of payload, well I guess we will need to ask the
> controller folks how they are handling SCO over HCI because the spec
> is not very clear about it.
>
>
Actually, the more I look into this, the less I understand. Taking the 
default
read/write block size of 48, why does it work at all?

According to the specs, HV1/2/3 contain 10/20/30 bytes of audio data. Why
is it then OK if PA writes audio in chunks of 48 bytes? And where does 
the 48
come from in the first place? Again according to the specs, bluetooth 
packets
start with a 72 bit access code followed by a 54 bit header, which gives
approximately 16 bytes. Adding the payload, I arrive at 46 bytes packet size
instead of 48 for HV1/2/3. Because EV3 has two additional bytes CRC, this is
the only case where the total packet size sums up to 48 bytes, but still the
payload is only 30 bytes.

The HV1/2/3 and EV3 packets have a maximum payload length of 30 bytes,
so where does the MTU come into this at all for those packet types? Packets
are always smaller than / equal to the minimum MTU.

For EV4/5, 2-EV3/5 and 3-EV3/5 the payload may be larger but is negotiated
during the LMP eSCO setup. So again, where does the MTU come into it?
Does it just limit the maximum possible packet size in these cases?

More questions: Looking at the kernel code for btusb, I see that some 
devices
are known to report the wrong MTU size. For those devices, the kernel 
returns
64 as MTU. Why is it 64 and not the known working size of 48? Or should PA
subtract the 16 bytes header from the MTU? If yes, I guess for 2-EV and 3-EV
packets, a different value would need to be subtracted because of the
guard/sync/trailer fields. Unfortunately I could not figure out the size of
those fields.

Can somebody provide some insight?

