Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+pfaxs8=0eO6w7e3DRmCGyA2wLJpANscCMpLgXOAo_7A@mail.gmail.com>
References: <1389435216-29040-1-git-send-email-luiz.dentz@gmail.com>
	<1389435216-29040-3-git-send-email-luiz.dentz@gmail.com>
	<CAN_7+YbqjZ7=hRjED10mDJuGnhy8pD45iuf9SWFqGM_3N=hVDg@mail.gmail.com>
	<CABBYNZ+pfaxs8=0eO6w7e3DRmCGyA2wLJpANscCMpLgXOAo_7A@mail.gmail.com>
Date: Mon, 13 Jan 2014 10:38:22 +0100
Message-ID: <CAN_7+YahMeLPSME3kaA_nquB5N1B1WYGAuYY7ACaKQT1edUVyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/6] audio/A2DP: Add implemention of audio Open
 Stream command
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jan 13, 2014 at 8:55 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Mon, Jan 13, 2014 at 2:10 AM, Lukasz Rymanowski
> <lukasz.rymanowski@gmail.com> wrote:
>> Hi Luiz,
>>
>> On Sat, Jan 11, 2014 at 11:13 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> ---
>>>  android/a2dp.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 197 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/android/a2dp.c b/android/a2dp.c
>>> index 8649cf3..479cb71 100644
>>> --- a/android/a2dp.c
>>> +++ b/android/a2dp.c
>>> @@ -37,6 +37,7 @@
>>>  #include "lib/bluetooth.h"
>>>  #include "lib/sdp.h"
>>>  #include "lib/sdp_lib.h"
>>> +#include "profiles/audio/a2dp-codecs.h"
>>
>> We need to discuss how we gonna use structs from this file in
>> hal-audio (eg. a2dp_sbc_t). Maybe we should have some special file
>> with audio structs/defines for IPC only? Then you could copy data to
>> structs you need.
>
> Not sure what you mean about this header, its LGPL already so I see no
> problem of including it in hal-audio.

You are right, it is LGPL so no problem.

\Lukasz
