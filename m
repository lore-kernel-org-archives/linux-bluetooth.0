Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <126814B4-25DA-4BA4-A0B8-0E5D57001EF7@signove.com>
References: <1289358915-6612-1-git-send-email-epx@signove.com>
 <1289382461-10510-1-git-send-email-santoscadenas@gmail.com>
 <AANLkTimoQRAHXJ65xa1-TMKGUfLujw8f9MhzxrxPXHmY@mail.gmail.com> <126814B4-25DA-4BA4-A0B8-0E5D57001EF7@signove.com>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Wed, 10 Nov 2010 12:49:56 +0100
Message-ID: <AANLkTim=3tZWao0Kzqq8nr4Z=dOrXL_aK76Ernx=UqQS@mail.gmail.com>
Subject: Re: [PATCH] Fix segfault in HDP during device re-creation
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

2010/11/10 Elvis Pfützenreuter <epx@signove.com>:
>>> ---
>>>  health/hdp.c |    1 +
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/health/hdp.c b/health/hdp.c
>>> index 1eba8e1..d361b27 100644
>>> --- a/health/hdp.c
>>> +++ b/health/hdp.c
>>> @@ -259,6 +259,7 @@ static void device_unref_mcl(struct hdp_device *hdp_device)
>>>        if (!hdp_device->mcl)
>>>                return;
>>>
>>> +       mcap_close_mcl(hdp_device->mcl, FALSE);
>>>        mcap_mcl_unref(hdp_device->mcl);
>>>        hdp_device->mcl = NULL;
>>>        hdp_device->mcl_conn = FALSE;
>>> --
>>> 1.7.1
>>>
>>>
>>
>> Please Elvis, try this solution and tell us if it fix the segfault problem.
>
> Yes, it seems to have fixed the problem. And far cleaner :)
>
> I hadn't proposed a lookalike solution because this seems to disable MCL caching completely. HDP already calls mcap_close_mcl(cache=FALSE) when takes the initiative of closing the MCL; this patch takes care of remaining case.

This function doesn't disable the caching in general, it just closes
this MCL without catching it, but caching is still active for all the
other MCL's. Additionally, nothing happens if mcap_close_mcl is called
more than once, so this patch takes care of this too.

>
> The only place hdp.c calls mcap_close_mcl(cache=TRUE) is when mcap_mcl_set_cb() fails, which seems "impossible", because it only depends on valid parameters to succeed.

This is because HDP wants to cache as long as possible.

>
> So, perhaps it would be better to get rid of caching code in mcap.c?

I can't understand this, can you explain this more?. As I see, MCAP
should do the catching because it holds all the information about the
channels that are connected and can cache it, HDP could not do this
without MCAP. More over, if in the future more profiles use MCAP they
may want to cache too.


Regards
