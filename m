Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKH53pxSahoQL4AJf14F8fMChMC93+2gq5CA_wQCC4Xfg@mail.gmail.com>
References: <1316543496-18575-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1316543496-18575-4-git-send-email-lucas.demarchi@profusion.mobi>
 <CABBYNZLjLTBtd9AeRzkzzRBjxeiq+20hC_bf-KM+_1C6sNXocw@mail.gmail.com>
 <CAMOw1v47ns-m8b66Sb07HOvt354XVb32bHCVpjqo7+wr_k1i-w@mail.gmail.com> <CABBYNZKH53pxSahoQL4AJf14F8fMChMC93+2gq5CA_wQCC4Xfg@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 27 Sep 2011 07:15:49 -0300
Message-ID: <CAMOw1v4FkTcY8+Q=4rube5GR8baLKB1GvMYnch7oEUw=FiXBbA@mail.gmail.com>
Subject: Re: [PATCH 3/3] avrcp: handle volume up/down passthroughs as TG
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Sep 23, 2011 at 4:48 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Thu, Sep 22, 2011 at 9:02 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> Hi Luiz,
>>
>> On Wed, Sep 21, 2011 at 7:33 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Lucas,
>>>
>>> On Tue, Sep 20, 2011 at 9:31 PM, Lucas De Marchi
>>> <lucas.demarchi@profusion.mobi> wrote:
>>>> ---
>>>>  audio/avctp.c |    2 ++
>>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/audio/avctp.c b/audio/avctp.c
>>>> index e9b8e40..59fbed9 100644
>>>> --- a/audio/avctp.c
>>>> +++ b/audio/avctp.c
>>>> @@ -155,6 +155,8 @@ static struct {
>>>>        { "BACKWARD",           BACKWARD_OP,            KEY_PREVIOUSSONG },
>>>>        { "REWIND",             REWIND_OP,              KEY_REWIND },
>>>>        { "FAST FORWARD",       FAST_FORWARD_OP,        KEY_FASTFORWARD },
>>>> +       { "VOLUME UP",          VOL_UP_OP,              KEY_VOLUMEUP },
>>>> +       { "VOLUME DOWN",        VOL_DOWN_OP,            KEY_VOLUMEDOWN },
>>>>        { NULL }
>>>>  };
>>>
>>> Have a look at the SIMULTANEOUS USE OF HFP, A2DP, AND AVRCP PROFILES
>>> white paper:
>>>
>>> Recommendation 16:
>>> If volume is changed on the RD, the RD should not send an AVRCP volume
>>> command to the MP device.
>>> Motivation 16:
>>> Sending an AVRCP volume command to the MP may cause the MP to send
>>> again an AVRCP volume
>>> command to the RD device which could lead to an endless loop of AVRCP
>>> volume commands.
>>
>> So this recommendation says that if we are the rendering device (and therefore
>> the CT) and the volume was changed on the rendering device, we should not send
>> the AVRCP volume command. In BlueZ parlance means we are on CT role and
>> org.bluez.Control.{VolumeUp(), VolumeDown()} should not be called, right?
>
> I don't think MP and RD refer to CT or TG AVRCP roles, so a
> phone/tablet/pc would be consider a MP (source/encoder) and
> headsets/carkits/speakers RD (sink/decoder) and yes we should probably
> deprecate VolumeUp and VolumeDown because they cannot be synchronized
> properly and use absolute volume control if supported by the remote
> device, Im also planning to move volume control per transport so the
> endpoints can do the volume control since they are the ones
> generating/consuming the data.

What I was not convinced of is that if we have two devices running
BlueZ (one as CT and the other as TG), CT would send the volume
up/down commands and TG would always ignore.

It just doesn't seem right CT not being able to talk to TG when both
use BlueZ. However if you are going to deprecate the calls for CT in
favor of something better, go for it.



Lucas De Marchi
