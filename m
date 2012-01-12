Return-Path: <cyrus@holtmann.org>
Message-id: <50132BD1E22B4798B94245E102FCB10F@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1326297791-8533-1-git-send-email-s.syam@samsung.com>
 <20120111164246.GA10746@fusion.localdomain>
Subject: Re: [PATCH] Send the Extended Error result code,
 if requested in the failure cases
Date: Thu, 12 Jan 2012 21:05:50 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

----- Original Message ----- 
From: "Johan Hedberg" <johan.hedberg@gmail.com>
To: "Syam Sidhardhan" <s.syam@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Sent: Wednesday, January 11, 2012 10:12 PM
Subject: Re: [PATCH] Send the Extended Error result code, if requested in 
the failure cases


> Hi Syam,
>
> On Wed, Jan 11, 2012, Syam Sidhardhan wrote:
>> If HF has already requested for the Extended Error result code reporting,
>> then send the same in certain failure cases. Earlier in this case we were
>> sending normal Error.
>> ---
>>  audio/headset.c |    8 +++++++-
>>  1 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/audio/headset.c b/audio/headset.c
>> index 6aef6a8..5455340 100644
>> --- a/audio/headset.c
>> +++ b/audio/headset.c
>> @@ -1331,7 +1331,13 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, 
>> GIOCondition cond,
>>  if (err == -EINVAL) {
>>  error("Badly formated or unrecognized command: %s",
>>  &slc->buf[slc->data_start]);
>> - err = headset_send(hs, "\r\nERROR\r\n");
>> +
>> + if (slc->cme_enabled)
>> + err = headset_send(hs, "\r\n+CME ERROR: %d\r\n",
>> + CME_ERROR_NOT_SUPPORTED);
>> + else
>> + err = headset_send(hs, "\r\nERROR\r\n");
>> +
>>  if (err < 0)
>>  goto failed;
>>  } else if (err < 0)
>
> In this case it'd be easier to just do this:
>
> err = telephony_generic_rsp(device, CME_ERROR_NOT_SUPPORTED);
>
> It'll do the cme_enabled check for you and send the right response
> string.
>
> Johan

I'll correct it and send a new patch.

-Syam
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 

