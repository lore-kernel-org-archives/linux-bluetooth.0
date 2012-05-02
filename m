Return-Path: <cyrus@holtmann.org>
Message-id: <EB00DDEFE1E246A6B934FC44FE3E16E1@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1335953480-8902-1-git-send-email-jaganath.k@samsung.com>
 <20120502104301.GA17664@x220.ger.corp.intel.com>
In-reply-to: <20120502104301.GA17664@x220.ger.corp.intel.com>
Subject: Re: [PATCH BlueZ] audio: Reset hfp and hs handle before connection
Date: Wed, 02 May 2012 16:26:01 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

--------------------------------------------------
From: "Johan Hedberg" <johan.hedberg@gmail.com>
Sent: Wednesday, May 02, 2012 4:13 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] audio: Reset hfp and hs handle before connection

> Hi Jaganath,
>
> On Wed, May 02, 2012, Jaganath Kanakkassery wrote:
>> When bluez initiates headset connection  hfp and hs handle is saved
>> each time when initiating connection. So at some point if hf service
>> is removed in remote headset then bluez connects to hs service. But
>> because of previously stored hfp handle bluez thinks that connection
>> made to hs service is hfp connection and waits for at commands.
>> Eventually bluez connection state will be incorrectly set.
>> ---
>>  audio/headset.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/audio/headset.c b/audio/headset.c
>> index 04b26a9..27367d7 100644
>> --- a/audio/headset.c
>> +++ b/audio/headset.c
>> @@ -1462,6 +1462,8 @@ static int headset_set_channel(struct headset 
>> *headset,
>>  }
>>
>>  headset->rfcomm_ch = ch;
>> + headset->hfp_handle = 0;
>> + headset->hsp_handle = 0;
>>
>>  if (svc == HANDSFREE_SVCLASS_ID) {
>>  headset->hfp_handle = record->handle;
>
> I'd instead prefer something like the following:
>
>        if (svc == HANDSFREE_SVCLASS_ID) {
>                headset->hfp_handle = record->handle;
> +               headset->hsp_handle = 0;
>                DBG("Discovered Handsfree service on channel %d", ch);
>        } else {
>                headset->hsp_handle = record->handle;
> +               headset->hfp_handle = 0;
>                DBG("Discovered Headset service on channel %d", ch);
>        }
>
> Would that be ok?

Yes that is Ok. I will raise the new patch.

Thanks,
Jaganath 

