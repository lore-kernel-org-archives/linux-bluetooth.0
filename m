Return-Path: <cyrus@holtmann.org>
Message-ID: <94b1ecb27a99150d2cc0cae8fe6607af.squirrel@www.codeaurora.org>
In-Reply-To: <AANLkTi=nW-E8S3ccyutn_LYafmhSXiGY62PVZJ6L2QnX@mail.gmail.com>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
    <1279814780-29673-3-git-send-email-ingas@codeaurora.org>
    <AANLkTi=nW-E8S3ccyutn_LYafmhSXiGY62PVZJ6L2QnX@mail.gmail.com>
Date: Tue, 27 Jul 2010 13:08:02 -0700 (PDT)
Subject: Re: [PATCH 2/5] Support for adding UUID128 to extended inquiry  
     response
From: ingas@codeaurora.org
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "Inga Stotland" <ingas@codeaurora.org>,
 linux-bluetooth@vger.kernel.org,
 rshaffer@codeaurora.org,
 marcel@holtmann.org,
 johan.hedberg@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Hi,
>
> On Thu, Jul 22, 2010 at 7:06 PM, Inga Stotland <ingas@codeaurora.org>
> wrote:
>> ---
>>  src/sdpd-service.c |  108
>> ++++++++++++++++++++++++++++++++++++++++++++--------
>>  1 files changed, 92 insertions(+), 16 deletions(-)
>>
>> diff --git a/src/sdpd-service.c b/src/sdpd-service.c
>> index cdbb4f4..1314ada 100644
>> --- a/src/sdpd-service.c
>> +++ b/src/sdpd-service.c
>> @@ -49,6 +49,8 @@
>>  #include "manager.h"
>>  #include "adapter.h"
>
>> +
>
> I think you should probably split this in two parts, first update with
> the cleanups and then add the code to handle uuid 128.
>

Sure, I can split this in more patches.

>>  void create_ext_inquiry_response(const char *name,
>>                                        int8_t tx_power, sdp_list_t
>> *services,
>>                                        uint8_t *data)
>>
>> +               /* Check for duplicates */
>>                for (i = 0; i < index; i++)
>> -                       if (uuid[i] == rec->svclass.value.uuid16)
>> +                       if (uuid16[i] == rec->svclass.value.uuid16)
>>                                break;
>>
>> -               if (i == index - 1)
>> +               if (i < index)
>>                        continue;
>>

>
> Also this checks for duplicates looks suspicious, does it really need
> to check that in place and every time, I think it might be more
> efficient if we do that before generating the EIR data avoiding
> comparing data with different endianess or maybe it just make more
> sense to not allow duplicates in the database then we don't have to do
> this at all.
>

This check for duplicates was in place prior to my modifications. I merely
added a comment and fixed an existing problem.

If you examine the patch closely, you might notice that the previous
"check for duplicates" implementation was doing the following:
- cycling through the list of so far accumulated UUIDs in EIR and
comparing them to the current one. If duplicate is found, break out of
this cycling loop. Notice, that in the case of a duplicate, (i <
index)condition will be true, where index is the number of accumulated
UUIDs.
- the current implementation performs check for (i == index -1). Well, we
did not need to cycle through the whole array to cmpare to the last item
:) But if my reading of the original intent is correct, we don't want to
put a duplicate UUID in EIR, and, therefore, should go to next iteration
if a duplicate is found. Hence, the check should be (i < index).

Maybe it's a better idea to submit this fix separately.

I do not disagree that it would be better to check for duplicate records
elsewhere, but this  is outside the scope of this patch.

Regards,

Inga
