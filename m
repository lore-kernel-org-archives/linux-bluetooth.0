Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BCBAC715-C7A9-415F-BE62-F843DE5A72D1@signove.com>
References: <1289358915-6612-1-git-send-email-epx@signove.com>
 <1289382461-10510-1-git-send-email-santoscadenas@gmail.com>
 <AANLkTimoQRAHXJ65xa1-TMKGUfLujw8f9MhzxrxPXHmY@mail.gmail.com>
 <126814B4-25DA-4BA4-A0B8-0E5D57001EF7@signove.com> <AANLkTim=3tZWao0Kzqq8nr4Z=dOrXL_aK76Ernx=UqQS@mail.gmail.com>
 <BCBAC715-C7A9-415F-BE62-F843DE5A72D1@signove.com>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Wed, 10 Nov 2010 14:02:12 +0100
Message-ID: <AANLkTi=5yNRrLgVroj6_82JYC73mOoq_mYf5svwsH_6F@mail.gmail.com>
Subject: Re: [PATCH] Fix segfault in HDP during device re-creation
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

2010/11/10 Elvis Pfützenreuter <epx@signove.com>:
>> Hi Elvis,
>>
>> 2010/11/10 Elvis Pfützenreuter <epx@signove.com>:
>>>>> ---
>>>>>  health/hdp.c |    1 +
>>>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/health/hdp.c b/health/hdp.c
>>>>> index 1eba8e1..d361b27 100644
>>>>> --- a/health/hdp.c
>>>>> +++ b/health/hdp.c
>>>>> @@ -259,6 +259,7 @@ static void device_unref_mcl(struct hdp_device *hdp_device)
>>>>>        if (!hdp_device->mcl)
>>>>>                return;
>>>>>
>>>>> +       mcap_close_mcl(hdp_device->mcl, FALSE);
>>>>>        mcap_mcl_unref(hdp_device->mcl);
>>>>>        hdp_device->mcl = NULL;
>>>>>        hdp_device->mcl_conn = FALSE;
>>>>> --
>>>>> 1.7.1
>>>>>
>>>>>
>>>>
>>>> Please Elvis, try this solution and tell us if it fix the segfault problem.
>>>
>>> Yes, it seems to have fixed the problem. And far cleaner :)
>>>
>>> I hadn't proposed a lookalike solution because this seems to disable MCL caching completely. HDP already calls mcap_close_mcl(cache=FALSE) when takes the initiative of closing the MCL; this patch takes care of remaining case.
>>
>> This function doesn't disable the caching in general, it just closes
>> this MCL without catching it, but caching is still active for all the
>> other MCL's. Additionally, nothing happens if mcap_close_mcl is called
>> more than once, so this patch takes care of this too.
>
> Indeed, MCL disconnection and hdp_device destruction are different moments. Still fulfilling the caffeine quota for this morning :P

Of course they are, but when a device is removed, is completely normal
that you (HDP) would like to delete the MCAP cache because you (HDP)
are forgetting this device so you won't have any structures for the
data channels nor other structs in HDP needed to manage the
reconnections of the data channels that could be cached. The way to
uncache an mcl in MCAP is to close it indicating that you don't want
to cache it. This is just what this patch to.

>
>>>
>>> So, perhaps it would be better to get rid of caching code in mcap.c?
>>
>> I can't understand this, can you explain this more?. As I see, MCAP
>> should do the catching because it holds all the information about the
>> channels that are connected and can cache it, HDP could not do this
>> without MCAP. More over, if in the future more profiles use MCAP they
>> may want to cache too.
>
> I do have the opinion that caching in mcap.c is more complicated than it could be.

My opinion is that caching in MCAP is the correct way because MCAP is
dealing with sending and receiving commands and need to retain certain
structures that are necessary for it, this structures do not concern
to HDP, only concerns to MCAP and should be MCAP who stores (caches)
them.

> I'd have used a single list with a CLOSED flag. Also, there is some confusion in nomenclature (mcap_uncache_mcl() recovers from the cache, while mcl_uncached_cb callback means that MCL has been invalidated). This is source of bugs like this one.

This is a different issue. Probably the nomenclature is not as clear
as it should be but I think that this is not the point here,
nevertheless we can change it too.

>
> At the very least, cached MCLs should have mcl->cb zeroed. if MCAP level caches MCLs, very well, but HDP level should be asked to set callbacks and user data again, as if it were a new MCL. (Actually, mcl_reconnected in hdp.c seems to do that; not sure why it did not avoid the particular bug that is under discussion.)

It is supposed that if HDP (or any other profile using MCAP) wants to
use cache, it should keep its variables all the time that it is
interested in caching them. If the profile using MCAP don't want to
keep its state should tell MCAP that it is not interested in caching
(as the patch in this thread does) because it is deleting its own
state.


Regards.

Jose
