Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170914114402.qbfwd3ceosrrgzqp@earth>
References: <20170914114402.qbfwd3ceosrrgzqp@earth>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Sep 2017 17:00:16 +0300
Message-ID: <CABBYNZKT6-8VjGPMyJ87jBPnGWQ=LtfODT3JMyVfZ8Nzp=tiMw@mail.gmail.com>
Subject: Re: Bose QC35 HFP/HSP MTU size
To: Sebastian Reichel <sre@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Thu, Sep 14, 2017 at 2:44 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> Bose QC35 are affected by the attached upgrade notice
> from Pulseaudio 11. The workaround fixes the problem.

This doesn't make much sense when the problem below refer to the local
adapter not the remote device, so I suspect just about any device
would have similar problem when using an MTU not compatible with the
adapter. Or perhaps this does depend on the packet type the controller
end up negotiating since the spec say:


6.5.2.1 HV1 Packet
The HV1 packet has 10 information bytes. The bytes are protected with a rate
1/3 FEC. No MIC is present. No CRC is present. The payload length is fixed at
240 bits. There is no payload header present.
6.5.2.2 HV2 Packet
The HV2 packet has 20 information bytes. The bytes are protected with a rate
2/3 FEC. No MIC is present. No CRC is present. The payload length is fixed at
240 bits. There is no payload header present.
 can 6.5.2.3 HV3 Packet
The HV3 packet has 30 information bytes. The bytes are not protected by FEC.
No MIC is present. No CRC is present. The payload length is fixed at 240 bits.
There is no payload header present.

So HV1, HV2, HV3 packet size is 240bit = 48 bytes, but for EV and eSCO
the payload is not fixed. So far we had assumed the controller would
do the flow control so we just push data to its buffer but if it does
expect the exact payload depending on the packet type that would
explain why this doesn't work all the time. I have never seem a SCO
buffer over 96 bytes and since packets but packets such as 3-EV5 can
take up to 540 bytes of payload, well I guess we will need to ask the
controller folks how they are handling SCO over HCI because the spec
is not very clear about it.

> -- Sebastian
>
>> https://www.freedesktop.org/wiki/Software/PulseAudio/Notes/11.0/
>>
>> Improved bluetooth MTU configuration
>>
>> The packet size (a.k.a. MTU, "maximum transmission unit") that
>> PulseAudio uses with the bluetooth HSP profile was previously
>> always configured to be 48 bytes. That worked with most hardware,
>> but some adapters require a different packet size. Now PulseAudio
>> asks the kernel what packet size should be used, which fixes the
>> problem.
>>
>> However, a new problem appeared: some adapters that used to work
>> with 48 byte packet size don't any more work with the size that
>> the kernel tells PulseAudio to use. If you find that HSP audio
>> stopped working when upgrading to PulseAudio 11.0, you can revert
>> to the old behaviour by passing option "autodetect_mtu=no" to
>> module-bluetooth-discover in /etc/pulse/default.pa. If that fixes
>> the problem, then please report the problem to the BlueZ and/or
>> PulseAudio developers, so that the kernel can be fixed.



-- 
Luiz Augusto von Dentz
