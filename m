Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinp8bmy9y-GrQsFPDxdJkPK7n5dixaKsVZtJv0h@mail.gmail.com>
References: <1285696155-32766-1-git-send-email-claudio.takahasi@openbossa.org>
	<20100929134908.GB19362@jh-x301>
	<AANLkTi=1hKSL+2-DJ4SJkZJ+TaAzP1BUSh4FbiT=xg4g@mail.gmail.com>
	<AANLkTinp8bmy9y-GrQsFPDxdJkPK7n5dixaKsVZtJv0h@mail.gmail.com>
Date: Thu, 30 Sep 2010 15:48:56 -0300
Message-ID: <AANLkTinprUCsZ8k1Cw6pU0C8_1e50sG4kSD=aPWuitb=@mail.gmail.com>
Subject: Re: [PATCH 1/4] Add the Attribute interface to the API
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Sep 29, 2010 at 5:00 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Wed, Sep 29, 2010 at 5:52 PM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>>>
>>> What's the motivation of moving this into its own D-Bus interface? I
>>> thought the plan was to abstract both traditional SDP and ATT behind the
>>> same API in which case having this in the Device interface makes more
>>> sense imho.
>>>
>>> Johan
>>>
>>
>> Hi Johan,
>>
>> we forgot the SDP integration plan. Forget this patch.
>>
>> From the implementation point of view, implement inside the attrib
>> client plugin was the easiest way, if we keep this property inside the
>> Device interface a new function needs to be created in device.h to
>> register the available primary services object paths.
>
> Well there is a more complicated way, which is to add support for
> user_data per method/property, so a plugin could directly register
> their methods and properties in e.g. Adapter and Device interfaces. Of
> course this has drawbacks since the API could really became a mess
> with plugins doing there thing carelessly, but in the other hand it
> can greatly simplify the interfaces like Device.Disconnect()
> propagation.
>
> Just a crazy idea I had late in the night :D
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>

Please ignore this patch sequence. A proper pull request will be sent
to the ML containing the last 3 patches only.
This patch [PATCH 1/4] will be removed.


Claudio
