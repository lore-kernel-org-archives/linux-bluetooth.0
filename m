Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110614091405.GC31529@dell.ger.corp.intel.com>
References: <1308034791-3290-1-git-send-email-lkslawek@gmail.com>
	<20110614091405.GC31529@dell.ger.corp.intel.com>
Date: Tue, 14 Jun 2011 11:31:58 +0200
Message-ID: <BANLkTi=ZdNj6jcCuZMYDk=0TD1gOnPpFqg@mail.gmail.com>
Subject: Re: [PATCH] Send new missed calls count once
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jun 14, 2011 at 11:14 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> index 80dfc02..d396203 100644
>> --- a/plugins/phonebook-tracker.c
>> +++ b/plugins/phonebook-tracker.c
>> @@ -1551,6 +1551,8 @@ int phonebook_pull_read(void *request)
>>       if (!data)
>>               return -ENOENT;
>>
>> +     data->newmissedcalls = 0;
>> +
>>       if (g_strcmp0(data->req_name,"/telecom/mch.vcf") == 0 &&
>>                                               data->tracker_index == 0) {
>>               /* new missed calls amount should be counted only once - it
>
> Shouldn't this be added inside the first if-statement branch instead of
> affecting the whole function? It seems to me that only the first branch
> deals with new missed calls.

If the pulled phone book is mch, setting this to zero has to be done
in case of calling the function when data->tracker_index != 0. So it
would have to be added inside second and third branch, or second and
third branch can be nested inside a new branch. 'newmissedcalls' is
used unconditionally in code in pulls from every phone book (not only
mch), and whether or not the header is actually sent depends on
non-zero value of it. Thus always presetting it to zero makes sense.

-- 
Slawomir Bochenski
