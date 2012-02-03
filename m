Return-Path: <cyrus@holtmann.org>
Message-id: <F077852F86D84892A3B10767242C50BC@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1328182441-14892-1-git-send-email-jaganath.k@samsung.com>
 <CABBYNZJYyqtD+0c6YYALx8bON3A_S3bXH29K07OFJcq=ZrJCOw@mail.gmail.com>
In-reply-to: <CABBYNZJYyqtD+0c6YYALx8bON3A_S3bXH29K07OFJcq=ZrJCOw@mail.gmail.com>
Subject: Re: [PATCH obexd 3/4] irmc: Fix length parameter of strncpy
Date: Fri, 03 Feb 2012 17:52:46 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

--------------------------------------------------
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Sent: Thursday, February 02, 2012 10:59 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH obexd 3/4] irmc: Fix length parameter of strncpy

> Hi Jaganath,
>
> On Thu, Feb 2, 2012 at 3:34 AM, Jaganath Kanakkassery
> <jaganath.k@samsung.com> wrote:
>> ---
>>  plugins/irmc.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/plugins/irmc.c b/plugins/irmc.c
>> index 6f28e51..8344a47 100644
>> --- a/plugins/irmc.c
>> +++ b/plugins/irmc.c
>> @@ -215,9 +215,9 @@ static void *irmc_connect(struct obex_session *os, 
>> int *err)
>>         * For now lets used hostname and some 'random' value
>>         */
>>        gethostname(irmc->did, DID_LEN);
>> -       strncpy(irmc->sn, "12345", DID_LEN);
>> -       strncpy(irmc->manu, "obex", DID_LEN);
>> -       strncpy(irmc->model, "mymodel", DID_LEN);
>> +       strncpy(irmc->sn, "12345", sizeof(irmc->sn) - 1);
>> +       strncpy(irmc->manu, "obex", sizeof(irmc->manu) - 1);
>> +       strncpy(irmc->model, "mymodel", sizeof(irmc->model) - 1);
>
> Not sure what is the point to use a fixed size array here? Does the
> spec require it to be 18 bytes long?

I checked IRMC spec and could not find any length restriction.
For "sn" spec says "The format of the field is manufacturer dependent."
and for "manu" and "model" the acceptable value is string.

>
> -- 
> Luiz Augusto von Dentz

Regards
Jaganath 

