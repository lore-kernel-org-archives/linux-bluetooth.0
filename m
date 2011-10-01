Return-Path: <cyrus@holtmann.org>
Message-ID: <97EE5E556FD3483EAA57E6174F6254C0@freqoneremote>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "Lucas De Marchi" <lucas.demarchi@profusion.mobi>,
	"Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1316543496-18575-1-git-send-email-lucas.demarchi@profusion.mobi> <1316543496-18575-4-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZLjLTBtd9AeRzkzzRBjxeiq+20hC_bf-KM+_1C6sNXocw@mail.gmail.com> <CAMOw1v47ns-m8b66Sb07HOvt354XVb32bHCVpjqo7+wr_k1i-w@mail.gmail.com> <CABBYNZKH53pxSahoQL4AJf14F8fMChMC93+2gq5CA_wQCC4Xfg@mail.gmail.com> <CAMOw1v4FkTcY8+Q=4rube5GR8baLKB1GvMYnch7oEUw=FiXBbA@mail.gmail.com>
In-Reply-To: <CAMOw1v4FkTcY8+Q=4rube5GR8baLKB1GvMYnch7oEUw=FiXBbA@mail.gmail.com>
Subject: Re: [PATCH 3/3] avrcp: handle volume up/down passthroughs as TG
Date: Fri, 30 Sep 2011 19:36:04 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys...

-----Original Message----- 
From: Lucas De Marchi
Sent: Tuesday, September 27, 2011 5:15 AM
To: Luiz Augusto von Dentz
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] avrcp: handle volume up/down passthroughs as TG

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
>>>>  audio/avctp.c |    2 ++
>>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/audio/avctp.c b/audio/avctp.c
>>>> index e9b8e40..59fbed9 100644
>>>> --- a/audio/avctp.c
>>>> +++ b/audio/avctp.c
>>>> @@ -155,6 +155,8 @@ static struct {
>>>>        { "BACKWARD",           BACKWARD_OP, 
>>>>            KEY_PREVIOUSSONG },
>>>>        { "REWIND",             REWIND_OP,              KEY_REWIND },
>>>>        { "FAST FORWARD",       FAST_FORWARD_OP, 
>>>>        KEY_FASTFORWARD },
>>>> +       { "VOLUME UP",          VOL_UP_OP,              KEY_VOLUMEUP },
>>>> +       { "VOLUME DOWN",        VOL_DOWN_OP, 
>>>>            KEY_VOLUMEDOWN },
>>>>        { NULL }
>>>>  };
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
>> So this recommendation says that if we are the rendering device (and 
>> therefore
>> the CT) and the volume was changed on the rendering device, we should not 
>> send
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

+++++
I was out of town on business, and too busy to check this list.  Notice that 
even my apology is in-posted...so no flames this time, please ;-)

I think it is a bad idea to just deprecate this function.

Not every system uses Bluetooth speakers, and in any event, the CT talks to 
the TG and not directly to the speakers.  So, the TG should accept the CT 
command and do whatever it needs to to change the volume as the CT 
commanded.

If the TG is playing through BT speakers, it could pass the command through 
(maybe as CT to TG/RD).  However, that would be an application function, a 
layer above what we should be doing in BlueZ, IMO.  It would be a mistake to 
get too clever and over-encapsulate everything into BlueZ, locking down its 
uses to a severely limited set of use-cases.
+++++

Lucas De Marchi
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html 

