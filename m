Return-Path: <cyrus@holtmann.org>
Message-ID: <50A37AC7.1090009@linux.intel.com>
Date: Wed, 14 Nov 2012 12:04:39 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] adapter: Convert storage aliases
References: <1352888166-7391-1-git-send-email-frederic.danis@linux.intel.com> <20121114104553.GA6519@x220>
In-Reply-To: <20121114104553.GA6519@x220>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Johan,

On 14/11/2012 11:45, Johan Hedberg wrote:
> Hi Frederic,
>
> On Wed, Nov 14, 2012, Frédéric Danis wrote:
>>   #define SETTINGS_PATH STORAGEDIR "/%s/settings"
>>   #define CACHE_PATH STORAGEDIR "/%s/cache/%s"
>> +#define DEVICE_INFO_PATH STORAGEDIR "/%s/%s/info"
>
> Why do you have these separate defines? Do you need them in multiple
> places? The define names are longer than the actual values and you're
> just obfuscating the actual call that uses them (since you need to look
> in two places to figure out of the format parameters are actually
> matching the format string). So please don't use these.
>

CACHE_PATH and DEVICE_INFO_PATH are only used in one place, so they can 
be removed.

SETTINGS_PATH is used in both store_adapter_info() and load_config(), so 
I think it is better to keep it.

Fred


-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

