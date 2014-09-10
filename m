Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKk=-ZzWSSH=eAtAr-Y+oHmijrPdodZLp4PjU6MxZtSzw@mail.gmail.com>
References: <1410347494-22084-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZKk=-ZzWSSH=eAtAr-Y+oHmijrPdodZLp4PjU6MxZtSzw@mail.gmail.com>
Date: Wed, 10 Sep 2014 15:20:06 +0200
Message-ID: <CAMudyAuxjq3xe_xfpBDfDWfsgSiZkCWb=ozdwZxPkM5xFHNsUw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] android/hf-client: API fixes
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 10 September 2014 13:53, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Wed, Sep 10, 2014 at 2:11 PM, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
>> Couple of fixes to hf-client api.
>>
>> Those patches previously where a part of bigger set
>> [PATCH 00/39] android: HF Client initial implementation
>> but on Luiz request I split it into smaller sets.
>>
>> Lukasz Rymanowski (4):
>>   android/hal-ipc-api: Use 2 bytes for location in dial memory
>>   android/hal-ipc-api: Use Tone instead of Code DTMF
>>   android/hal-ipc-api: Add missing peer features parameter
>>   android/hal-ipc-api: Fix define for HF-Client
>>
>>  android/hal-ipc-api.txt | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> --
>> 1.8.4
>
> First thanks for flooding my inbox, and second congrats for sending
> almost 60 emails to the list in one day.
>
I should probably not reply on that email as this is yet another email
from me :) - However I will take that risk
First of all, I'm not sending patches to annoy you - lets be clear on
it :) You had comments to my patches so I put you into CC.

On IRC you asked me to send smaller patch sets, so once I fixed your
comment, Szymons ones and couple of mine  I've sent v2 in 2 patch
sets. One set is 4 patch long and second one is 16 patch long. (it is
not 60 :) )

As I wrote on the IRC, this HAL is big and we usually have such big
patch sets when doing skeletons for HALs. Also you were sending 35
patches for AVCTP in one set some time ago. Sometimes it is like that.
But those patches are small so it is easy to review. I don't see
reason to be annoyed.

BR
\Lukasz
>
> --
> Luiz Augusto von Dentz
