Return-Path: <cyrus@holtmann.org>
Message-ID: <4E9C27BE.10006@linux.intel.com>
Date: Mon, 17 Oct 2011 15:03:58 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] fix build
References: <1318848980-569-1-git-send-email-frederic.danis@linux.intel.com> <20111017111035.GA19306@fusion.localdomain>
In-Reply-To: <20111017111035.GA19306@fusion.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

Le 17/10/2011 13:10, Johan Hedberg a écrit :
> Hi Frédéric,
>
> On Mon, Oct 17, 2011, Frédéric Danis wrote:
>> src/eir.c: In function ‘eir_parse’:
>> src/eir.c:72: error: ‘name_len’ may be used uninitialized in this function
>>
>> and
>>
>> thermometer/thermometer.c: In function ‘destroy_char’:
>> thermometer/thermometer.c:79: error: implicit declaration of function ‘g_slist_free_full’
>> ---
>>   src/eir.c                 |    2 +-
>>   thermometer/thermometer.c |    5 +++++
>>   2 files changed, 6 insertions(+), 1 deletions(-)
>
> Strange. Current git compiles just fine under Fedora 16 beta (gcc 2.6.1)
> as well as debian unstable (also gcc 2.6.1). Which gcc version do you
> use?

Ubuntu 10.10 32 bits with gcc version 4.4.5 (Ubuntu/Linaro 4.4.4-14ubuntu5)
>
> I'd push the patch upstream but it fails to apply:
>
> 	fatal: cannot convert from UTF-8utf-8 to UTF-8
>
> I suspect that's because of the double Content-Type header in your
> email. Could you try to fix it?

I will send new version removing double Content-Type header

Fred

-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation

