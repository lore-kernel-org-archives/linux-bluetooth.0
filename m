Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLjLTBtd9AeRzkzzRBjxeiq+20hC_bf-KM+_1C6sNXocw@mail.gmail.com>
References: <1316543496-18575-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1316543496-18575-4-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZLjLTBtd9AeRzkzzRBjxeiq+20hC_bf-KM+_1C6sNXocw@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 22 Sep 2011 15:02:08 -0300
Message-ID: <CAMOw1v47ns-m8b66Sb07HOvt354XVb32bHCVpjqo7+wr_k1i-w@mail.gmail.com>
Subject: Re: [PATCH 3/3] avrcp: handle volume up/down passthroughs as TG
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Sep 21, 2011 at 7:33 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Tue, Sep 20, 2011 at 9:31 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> ---
>>  audio/avctp.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/audio/avctp.c b/audio/avctp.c
>> index e9b8e40..59fbed9 100644
>> --- a/audio/avctp.c
>> +++ b/audio/avctp.c
>> @@ -155,6 +155,8 @@ static struct {
>>        { "BACKWARD",           BACKWARD_OP,            KEY_PREVIOUSSONG },
>>        { "REWIND",             REWIND_OP,              KEY_REWIND },
>>        { "FAST FORWARD",       FAST_FORWARD_OP,        KEY_FASTFORWARD },
>> +       { "VOLUME UP",          VOL_UP_OP,              KEY_VOLUMEUP },
>> +       { "VOLUME DOWN",        VOL_DOWN_OP,            KEY_VOLUMEDOWN },
>>        { NULL }
>>  };
>
> Have a look at the SIMULTANEOUS USE OF HFP, A2DP, AND AVRCP PROFILES
> white paper:
>
> Recommendation 16:
> If volume is changed on the RD, the RD should not send an AVRCP volume
> command to the MP device.
> Motivation 16:
> Sending an AVRCP volume command to the MP may cause the MP to send
> again an AVRCP volume
> command to the RD device which could lead to an endless loop of AVRCP
> volume commands.

So this recommendation says that if we are the rendering device (and therefore
the CT) and the volume was changed on the rendering device, we should not send
the AVRCP volume command. In BlueZ parlance means we are on CT role and
org.bluez.Control.{VolumeUp(), VolumeDown()} should not be called, right?

Since handle_passthrough_command() is called when we *receive* a command, I
think looking at recommendation 17 makes more sense, doesn't it?

Recomentation 17: If a device receives an AVRCP volume command, it shall not
send back an AVRCP volume command.
Motivation 17: This will also ensure that endless loop does not happen with
existing devices which do not comply with the recommendation.

So, we should not send back (through AVRCP) the volume command. However BlueZ
*should* forward this command to the application to the application, otherwise
the application will just not respond to the command.


Currently, the following scenario doesn't work (WARNING: I'm not good at ASCII
art :-) )


Media Player
============
    PC
  running  <---------------------------> Bluetooth speaker
   BlueZ
     ^ ↑
     | ↑
     | ↑ AVRCP_volume_up
     | ↑
     v ↑
   Remote
 Controller


What do you think?


Lucas De Marchi
