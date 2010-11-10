Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix segfault in HDP during device re-creation
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <AANLkTimoQRAHXJ65xa1-TMKGUfLujw8f9MhzxrxPXHmY@mail.gmail.com>
Date: Wed, 10 Nov 2010 09:36:11 -0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <126814B4-25DA-4BA4-A0B8-0E5D57001EF7@signove.com>
References: <1289358915-6612-1-git-send-email-epx@signove.com> <1289382461-10510-1-git-send-email-santoscadenas@gmail.com> <AANLkTimoQRAHXJ65xa1-TMKGUfLujw8f9MhzxrxPXHmY@mail.gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> ---
>>  health/hdp.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>> 
>> diff --git a/health/hdp.c b/health/hdp.c
>> index 1eba8e1..d361b27 100644
>> --- a/health/hdp.c
>> +++ b/health/hdp.c
>> @@ -259,6 +259,7 @@ static void device_unref_mcl(struct hdp_device *hdp_device)
>>        if (!hdp_device->mcl)
>>                return;
>> 
>> +       mcap_close_mcl(hdp_device->mcl, FALSE);
>>        mcap_mcl_unref(hdp_device->mcl);
>>        hdp_device->mcl = NULL;
>>        hdp_device->mcl_conn = FALSE;
>> --
>> 1.7.1
>> 
>> 
> 
> Please Elvis, try this solution and tell us if it fix the segfault problem.

Yes, it seems to have fixed the problem. And far cleaner :)

I hadn't proposed a lookalike solution because this seems to disable MCL caching completely. HDP already calls mcap_close_mcl(cache=FALSE) when takes the initiative of closing the MCL; this patch takes care of remaining case.

The only place hdp.c calls mcap_close_mcl(cache=TRUE) is when mcap_mcl_set_cb() fails, which seems "impossible", because it only depends on valid parameters to succeed.

So, perhaps it would be better to get rid of caching code in mcap.c?