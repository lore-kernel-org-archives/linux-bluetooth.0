Return-Path: <cyrus@holtmann.org>
Message-id: <8C8BB2F934024A59952659368CC09B46@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1341490285-14932-1-git-send-email-jaganath.k@samsung.com>
 <20120705123731.GA32370@x220.P-661HNU-F1>
In-reply-to: <20120705123731.GA32370@x220.P-661HNU-F1>
Subject: Re: [PATCH] Bluetooth: Override status if local user rejects pairing
Date: Thu, 05 Jul 2012 18:43:34 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

--------------------------------------------------
From: "Johan Hedberg" <johan.hedberg@gmail.com>
Sent: Thursday, July 05, 2012 6:07 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Override status if local user rejects 
pairing

> Hi Jaganath,
>
> On Thu, Jul 05, 2012, Jaganath Kanakkassery wrote:
>> In case if ssp is failed, user cannot differentiate from the status
>> whether failure is caused by local rejection or remote rejection
>> because authentication failure is coming in both the cases.
>>
>> This patch overrides the status from controller with "pin or key missing"
>> in case of local rejection. In legacy pairing already contoller gives
>> this error.
>>
>> This patch will be useful if user can take some action based on local
>> or remote rejection
>>
>> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
>> ---
> --snip--
>> + /* Override status if local device rejected pairing */
>> + if (auth_rejected == true)
>> + ev.status = MGMT_STATUS_NOT_PAIRED;
>> + else
>> + ev.status = mgmt_status(status);
>
> You're not returning "pin or key missing" (which sounds like an HCI
> error) but MGMT_STATUS_NOT_PAIRED. Please be honest about this in your

In mgmt_status_table MGMT_STATUS_NOT_PAIRED is defined as
"pin or key missing" which is an hci error code.  That is why I used that.
In legacy pairing local rejection we are getting this error where as if
remote rejected "pairing not allowed" is coming. So I thought of
reusing this error.

> commit message. However, I don't think this is a very intuitive error
> code for a local rejection. Could you just use MGMT_STATUS_REJECTED for
> it? I think you'll get "pin or key missing" also if the remote side
> rejects so I don't think that's a good HCI error to derive the needed
> mgmt error from.

Sounds good to me to not use existing error since it will be dependent on 
the
controller.  I will do it and raise patch

Thanks
Jaganath 

