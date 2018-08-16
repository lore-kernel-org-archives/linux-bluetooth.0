Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [Question] Bluetooth SBC codec bitpool/bitrate limitations
From: ValdikSS <iam@valdikss.org.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <a7c1bf51-751c-880a-56b9-c730d2f0ca7f@valdikss.org.ru>
 <CABBYNZKFSZz-iWE6wrph=DtJM=N+Y2vFF3uP7eZwZkwu2NJQSA@mail.gmail.com>
 <f1a6bf56-ca2c-350e-56d0-a32c6bad2fa7@valdikss.org.ru>
Message-ID: <6bb49e82-f136-7075-ee12-9fac8c7dcc07@valdikss.org.ru>
Date: Thu, 16 Aug 2018 23:25:55 +0300
MIME-Version: 1.0
In-Reply-To: <f1a6bf56-ca2c-350e-56d0-a32c6bad2fa7@valdikss.org.ru>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 16.08.2018 23:23, ValdikSS wrote:
> On 16.08.2018 22:53, Luiz Augusto von Dentz wrote:
>> The reason of 53 bitpool is probably due to the spec. suggesting it as
>> high quality, which as you said is not quite right, so BlueZ never
>> really imposed any limitation on what you can configure, even going
>> above 512 kbit/s. As for not using dual channel that is known to
>> consume more bandwidth which may have an impact on airtime and
>> coexisting with wifi which is why joint stereo is preferred, the real
>> problem I would say is limiting to just 53 especially because the
>> bitpool can be adjusted on the fly so this is on the headset
>> manufacturers, perhaps because they actually want SBC to be perceived
>> as a bad codec so user would favor their proprietary codec? Or perhaps
>> because SBC has a quite bad compression rate and latency compared to
>> other codecs, still there is no reason to limit the bitpool.
>>
> I see the problem in the specification. Imagine you're a headphones manufacturer and your chip limitation is 512 kbit/s. There's no way to properly indicate this constraint. If you return bitpool max 53 in GetConfiguration/GetAllConfiguration

GetCapabilities/GetAllCapabilities*

>  for the connecting device, everything would be fine with joint stereo/stereo/mono, 8 subbands and 16 blocks, but the connecting device can use DUAL_CHANNEL with bitpool 53, which will produce 617 kbit/s SBC audio for 44.1 kHz, or even just use 4 subbands with joint stereo, which will produce 633 kbit/s and is higher than a bitrate constraint.
>
> The decoder should support all channel types, all block sizes and all subbands. The headphone manufacturer can't restrict connection only to joint stereo/stereo as it wouldn't be compatible with the specification.
>
> As far as I know, only source can decrease the bitpool, the headphones have no way to notify the source that high bitrate audio can't be decoded and played properly.
>
> To circumvent max bitpool 53 found on most headphones, bluetooth stacks could use either DUAL_CHANNEL, or joint stereo with 4 subbands. I prefer the former.
>
