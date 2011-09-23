Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v47ns-m8b66Sb07HOvt354XVb32bHCVpjqo7+wr_k1i-w@mail.gmail.com>
References: <1316543496-18575-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1316543496-18575-4-git-send-email-lucas.demarchi@profusion.mobi>
	<CABBYNZLjLTBtd9AeRzkzzRBjxeiq+20hC_bf-KM+_1C6sNXocw@mail.gmail.com>
	<CAMOw1v47ns-m8b66Sb07HOvt354XVb32bHCVpjqo7+wr_k1i-w@mail.gmail.com>
Date: Fri, 23 Sep 2011 10:48:54 +0300
Message-ID: <CABBYNZKH53pxSahoQL4AJf14F8fMChMC93+2gq5CA_wQCC4Xfg@mail.gmail.com>
Subject: Re: [PATCH 3/3] avrcp: handle volume up/down passthroughs as TG
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Sep 22, 2011 at 9:02 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Hi Luiz,
>
> On Wed, Sep 21, 2011 at 7:33 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Lucas,
>>
>> On Tue, Sep 20, 2011 at 9:31 PM, Lucas De Marchi
>> <lucas.demarchi@profusion.mobi> wrote:
>>> ---
>>>  audio/avctp.c |    2 ++
>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/audio/avctp.c b/audio/avctp.c
>>> index e9b8e40..59fbed9 100644
>>> --- a/audio/avctp.c
>>> +++ b/audio/avctp.c
>>> @@ -155,6 +155,8 @@ static struct {
>>>        { "BACKWARD",           BACKWARD_OP,            KEY_PREVIOUSSONG },
>>>        { "REWIND",             REWIND_OP,              KEY_REWIND },
>>>        { "FAST FORWARD",       FAST_FORWARD_OP,        KEY_FASTFORWARD },
>>> +       { "VOLUME UP",          VOL_UP_OP,              KEY_VOLUMEUP },
>>> +       { "VOLUME DOWN",        VOL_DOWN_OP,            KEY_VOLUMEDOWN },
>>>        { NULL }
>>>  };
>>
>> Have a look at the SIMULTANEOUS USE OF HFP, A2DP, AND AVRCP PROFILES
>> white paper:
>>
>> Recommendation 16:
>> If volume is changed on the RD, the RD should not send an AVRCP volume
>> command to the MP device.
>> Motivation 16:
>> Sending an AVRCP volume command to the MP may cause the MP to send
>> again an AVRCP volume
>> command to the RD device which could lead to an endless loop of AVRCP
>> volume commands.
>
> So this recommendation says that if we are the rendering device (and therefore
> the CT) and the volume was changed on the rendering device, we should not send
> the AVRCP volume command. In BlueZ parlance means we are on CT role and
> org.bluez.Control.{VolumeUp(), VolumeDown()} should not be called, right?

I don't think MP and RD refer to CT or TG AVRCP roles, so a
phone/tablet/pc would be consider a MP (source/encoder) and
headsets/carkits/speakers RD (sink/decoder) and yes we should probably
deprecate VolumeUp and VolumeDown because they cannot be synchronized
properly and use absolute volume control if supported by the remote
device, Im also planning to move volume control per transport so the
endpoints can do the volume control since they are the ones
generating/consuming the data.

> Since handle_passthrough_command() is called when we *receive* a command, I
> think looking at recommendation 17 makes more sense, doesn't it?
>
> Recomentation 17: If a device receives an AVRCP volume command, it shall not
> send back an AVRCP volume command.
> Motivation 17: This will also ensure that endless loop does not happen with
> existing devices which do not comply with the recommendation.

Yep, with panel volume commands it impossible to synchronize the
volumes, so with AVRCP 1.0 the only thing that really works is to
increase/decrease volume of the stream itself, but that is also not
recommended see recommendation 27.

> So, we should not send back (through AVRCP) the volume command. However BlueZ
> *should* forward this command to the application to the application, otherwise
> the application will just not respond to the command.

Actually the solution that creates less problems is to just ignore the
volume commands all together, if we receive we cannot indicate to
applications because we don't what level the remote side is so it is
very likely it will be out of sync and we cannot send anything back
either.

>
> Currently, the following scenario doesn't work (WARNING: I'm not good at ASCII
> art :-) )
>
>
> Media Player
> ============
>    PC
>  running  <---------------------------> Bluetooth speaker
>   BlueZ
>     ^ ↑
>     | ↑
>     | ↑ AVRCP_volume_up
>     | ↑
>     v ↑
>   Remote
>  Controller
>

Well this separate the speaker for the controller, but the normal case
is that they sit together so when the user presses volume up it
changes its speaker gain and there is nothing we can do about it, in
fact if we change the stream volume it will actually cause a double
volume change.

To summarize:

1. Local volume changes: stream volume level is changed without
sending any command
2. Remote volume changes: volume commands are ignored

> What do you think?

We need absolute volume control to make this work properly.

-- 
Luiz Augusto von Dentz
