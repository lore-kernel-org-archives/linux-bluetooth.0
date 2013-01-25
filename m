Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK7nK6LPq1rYv40fq_Ko_MB2f-ANG08ozHhSLyg_BUAMg@mail.gmail.com>
References: <1358878703-8100-1-git-send-email-jprvita@openbossa.org>
 <1358878703-8100-2-git-send-email-jprvita@openbossa.org> <CABBYNZK7nK6LPq1rYv40fq_Ko_MB2f-ANG08ozHhSLyg_BUAMg@mail.gmail.com>
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Date: Fri, 25 Jan 2013 14:05:59 -0300
Message-ID: <CAAngNMbCc9UzZBx_pD6hEYqQrhs_C+KoUCbLToQu8+ydyE1mrg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] avctp: Create ignore quirk
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 25, 2013 at 10:35 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Joao,
>
> On Tue, Jan 22, 2013 at 8:18 PM, João Paulo Rechi Vita
> <jprvita@openbossa.org> wrote:
>> Create a quirk to be able to accept and trow away certain keys.
>> ---
>>  profiles/audio/avctp.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
>> index 61890cc..f7e607e 100644
>> --- a/profiles/audio/avctp.c
>> +++ b/profiles/audio/avctp.c
>> @@ -58,7 +58,8 @@
>>  #include "avctp.h"
>>  #include "avrcp.h"
>>
>> -#define QUIRK_NO_RELEASE 1 << 0
>> +#define QUIRK_NO_RELEASE       1 << 0
>> +#define QUIRK_IGNORE           1 << 1
>>
>>  /* Message types */
>>  #define AVCTP_COMMAND          0
>> @@ -287,6 +288,11 @@ static size_t handle_panel_passthrough(struct avctp *session,
>>
>>                 key_quirks = session->key_quirks[key_map[i].avc];
>>
>> +               if (key_quirks & QUIRK_IGNORE) {
>> +                       DBG("AV/C: ignoring %s %s", key_map[i].name, status);
>> +                       break;
>> +               }
>> +
>>                 if (key_quirks & QUIRK_NO_RELEASE) {
>>                         if (!pressed) {
>>                                 DBG("AV/C: Ignoring release");
>> --
>> 1.7.11.7
>
> In the end I think we should just accept the commands normally, let me
> quote the recommendations (RD=Rendering Device MP=Media Player):
>
>   "Recommendation 16:
>
>   If volume is changed on the RD, the RD should not send an AVRCP
> volume command to the MP device.
>
>   Motivation 16:
>
>   Sending an AVRCP volume command to the MP may cause the MP to send
> again an AVRCP volume
>   command to the RD device which could lead to an endless loop of
> AVRCP volume commands.
>
>   Recommendation 17:
>
>   If a device receives an AVRCP volume command, it shall not send back
> an AVRCP volume command.
>
>   Motivation 17:
>
>   This will also ensure that endless loop does not happen with
> existing devices which do not comply with the
>   recommendation."
>
> So there is nothing against the RD accepting the Volume Up/Down it
> should just no send it back.
>

All right, so I'll update the patches to forward the Volume Up and
Down to uinput.


--
João Paulo Rechi Vita
Openbossa Labs - INdT
