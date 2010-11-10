Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix segfault in HDP during device re-creation
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <AANLkTim=3tZWao0Kzqq8nr4Z=dOrXL_aK76Ernx=UqQS@mail.gmail.com>
Date: Wed, 10 Nov 2010 10:40:24 -0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BCBAC715-C7A9-415F-BE62-F843DE5A72D1@signove.com>
References: <1289358915-6612-1-git-send-email-epx@signove.com> <1289382461-10510-1-git-send-email-santoscadenas@gmail.com> <AANLkTimoQRAHXJ65xa1-TMKGUfLujw8f9MhzxrxPXHmY@mail.gmail.com> <126814B4-25DA-4BA4-A0B8-0E5D57001EF7@signove.com> <AANLkTim=3tZWao0Kzqq8nr4Z=dOrXL_aK76Ernx=UqQS@mail.gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Elvis,
> 
> 2010/11/10 Elvis Pfützenreuter <epx@signove.com>:
>>>> ---
>>>>  health/hdp.c |    1 +
>>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>> 
>>>> diff --git a/health/hdp.c b/health/hdp.c
>>>> index 1eba8e1..d361b27 100644
>>>> --- a/health/hdp.c
>>>> +++ b/health/hdp.c
>>>> @@ -259,6 +259,7 @@ static void device_unref_mcl(struct hdp_device *hdp_device)
>>>>        if (!hdp_device->mcl)
>>>>                return;
>>>> 
>>>> +       mcap_close_mcl(hdp_device->mcl, FALSE);
>>>>        mcap_mcl_unref(hdp_device->mcl);
>>>>        hdp_device->mcl = NULL;
>>>>        hdp_device->mcl_conn = FALSE;
>>>> --
>>>> 1.7.1
>>>> 
>>>> 
>>> 
>>> Please Elvis, try this solution and tell us if it fix the segfault problem.
>> 
>> Yes, it seems to have fixed the problem. And far cleaner :)
>> 
>> I hadn't proposed a lookalike solution because this seems to disable MCL caching completely. HDP already calls mcap_close_mcl(cache=FALSE) when takes the initiative of closing the MCL; this patch takes care of remaining case.
> 
> This function doesn't disable the caching in general, it just closes
> this MCL without catching it, but caching is still active for all the
> other MCL's. Additionally, nothing happens if mcap_close_mcl is called
> more than once, so this patch takes care of this too.

Indeed, MCL disconnection and hdp_device destruction are different moments. Still fulfilling the caffeine quota for this morning :P

>> 
>> So, perhaps it would be better to get rid of caching code in mcap.c?
> 
> I can't understand this, can you explain this more?. As I see, MCAP
> should do the catching because it holds all the information about the
> channels that are connected and can cache it, HDP could not do this
> without MCAP. More over, if in the future more profiles use MCAP they
> may want to cache too.

I do have the opinion that caching in mcap.c is more complicated than it could be. I'd have used a single list with a CLOSED flag. Also, there is some confusion in nomenclature (mcap_uncache_mcl() recovers from the cache, while mcl_uncached_cb callback means that MCL has been invalidated). This is source of bugs like this one.

At the very least, cached MCLs should have mcl->cb zeroed. if MCAP level caches MCLs, very well, but HDP level should be asked to set callbacks and user data again, as if it were a new MCL. (Actually, mcl_reconnected in hdp.c seems to do that; not sure why it did not avoid the particular bug that is under discussion.)