Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: bluez: A2DP backchannel
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180730182532.abvthspuafhdbdl5@pali>
Date: Mon, 30 Jul 2018 21:39:09 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E042522B-87CF-4885-86A6-ADC9EF349991@holtmann.org>
References: <20180711110406.hkcqfjkmxsqq5xqk@pali>
 <CABBYNZJQPJOz75cZ4M8WZO0ZL29ePnsi1V1Y1Rc6S-=DT0ox+w@mail.gmail.com>
 <20180711143747.lg6ve2lxkfphkftt@pali> <20180728192649.7aryivyczpr2ek47@pali>
 <4BA0F4BA-1CA9-46F1-8A86-212321742D4B@holtmann.org>
 <20180730171001.gehfsvgcnlf4jzzi@pali>
 <1449F90F-E5EE-43E3-8E3F-77DC50B1A722@holtmann.org>
 <20180730182532.abvthspuafhdbdl5@pali>
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pali,

>>>>>>>> Some vendor A2DP bluetooth codecs like FastStream or aptX Low Latency
>>>>>>>> supports backchannel. Which means that they are bi-directional and in
>>>>>>>> A2DP they supports not only (music) playback, but also receiving
>>>>>>>> backchannel (microphone) voice.
>>>>>>>> 
>>>>>>>> How to establish this bi-directional A2DP transfer with backchannel via
>>>>>>>> bluez daemon?
>>>>>>> 
>>>>>>> There is no such thing as bi-directional in AVDTP, which is a screw up
>>>>>>> from the spec authors,
>>>>>> 
>>>>>> So it means that those vendor A2DP codecs somehow extends AVDTP, right?
>>>>>> I would need to figure out how A2DP devices send voice data... At least
>>>>>> backchannel activation for FastStream is via one bit in codec parameters
>>>>>> like other codec parameters.
>>>>>> 
>>>>>>> luckily we don't have to stick to it since our
>>>>>>> sockets are bi-directional so you can send and receive data at same
>>>>>>> time, though the configuration must be the same in either direction
>>>>>>> otherwise we would have to support transport multiplexing to have
>>>>>>> multiple configuration done using the same channel.
>>>>>> 
>>>>>> So does it mean that I can read from file descriptor received from dbus
>>>>>> which is used for sending encoded A2DP audio samples? And if other side
>>>>>> (e.g device with FastStream or aptX LL vendor codec) send voice via A2DP
>>>>>> then I receive them on that file descriptor?
>>>>> 
>>>>> Now I established A2DP connection with FastStream codec and in btmon I
>>>>> see that my headset started sending some data to channel 65 in this A2DP
>>>>> mode.
>>>>> 
>>>>> So definitely it is possible to send data from headset to computer (that
>>>>> backchannel) in A2DP mode despite what A2DP specification says.
>>>>> 
>>>>> I managed to modify pulseaudio code to start encoding and streaming
>>>>> FastStream data to headset and it is working.
>>>>> 
>>>>> Now the challenge would be how to get those data which headset send to
>>>>> channel 65? Is bluez really sending them via file descriptor which is
>>>>> used for writing from host to headset?
>>>>> 
>>>>> Via btmon I was able to dump data from this channel 65 and via some
>>>>> sed/perl magic I converted received voice data and played it:
>>>>> 
>>>>> $ btmon > /tmp/dump
>>>>> CTRL+C
>>>>> $ grep 'Channel: 65' -A 14 /tmp/dump | grep '^        ' | sed 's/^        //;s/  .*//' | tr ' ' '\n' | perl -ne 'print chr(hex($_))' > /tmp/voice.sbc
>>>>> $ sbcdec -f /tmp/voice.snd /tmp/voice.sbc
>>>>> $ play /tmp/voice.snd
>>>>> 
>>>>> And I heard clear voice. So FastStream is really just rebranded SBC
>>>>> codec (with fixed parameters; without RTP) and in A2DP bluetooth profile
>>>>> provides nice bi-directional channels.
>>>> 
>>>> can you show us at least a few of these channel 65 frames from btmon decoding. If it is via L2CAP fixed PSM, then in theory there needs to be some sort of channel establishment. Or if this via L2CAP fixed CID, then it is essentially unicast connectionless data. Both can be handled via L2CAP sockets, but you need to create sockets for these to receive the data.
>>>> 
>>>> On a side note, fixed CID 65 and fixed PSM 65 are both Bluetooth SIG reserved values, so seems like this codec is still violating the standard.
>>> 
>>> Hi! In attachment is btmon dump with codec negotiation, connect, both
>>> sink and source data and disconnect. Interesting is that now channel 65
>>> is used for both sink and source. Yesterday when I was doing tests I
>>> remember that different channel was used for microphone input and audio
>>> playback.
>> 
>> so the Channel: 65 is a CID and is assigned dynamically. They can be different in each direction and by chance you get Source CID: 65 and Destination CID: 65. What I am seeing is that you get TX and RX on that PSM 25 which seems to be the established media channel. This means the file descriptor you already have for sending audio, just read from it and you should be getting the back channel receiving audio. L2CAP channels are always bi-directional.
> 
> Interesting. Now I repeated my tests again and channels 77 and 64 are
> used (64 for voice microphone). Just in case, btmon output is attached.

that is fine. As I said, different CID numbers are assigned for each direction. They are negotiated when the L2CAP channel is created. That they are the same rarely happens, but it can. Anyhow, the L2CAP socket from the kernel will map CID 64 into recv and CID 77 into send.

> I would try to read directly from file descriptor used for sending data
> and see if I can easily decode it in pulseaudio. As sbcdec was able to
> decode it I hope that there would not be problem with libsbc in
> pulseaudio.

No idea why it would be SBC encoded, but sure. I don’t know enough detail about Fast Stream codec.

Regards

Marcel

