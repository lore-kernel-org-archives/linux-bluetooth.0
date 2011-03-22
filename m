Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110322211036.GA7180@jh-x301>
References: <1300827396-8043-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110322211036.GA7180@jh-x301>
Date: Tue, 22 Mar 2011 21:36:35 +0000
Message-ID: <AANLkTin6PCLVm5H1o0gBFhX_XipETYCxia4ASdqjPNpL@mail.gmail.com>
Subject: Re: [PATCH] Remove unused fields in btd_driver_data struct
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Mar 22, 2011 at 9:10 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Tue, Mar 22, 2011, Claudio Takahasi wrote:
>> ---
>>  src/device.c |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index e9d9e65..5121064 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -68,9 +68,7 @@
>>  #define GLOBAL_TRUST "[all]"
>>
>>  struct btd_driver_data {
>> -     guint id;
>>       struct btd_device_driver *driver;
>> -     void *priv;
>>  };
>
> Why is btd_driver_data needed at all if btd_device_driver is the only
> thing that it contains (i.e. why can't places pointing to
> btd_driver_data just point to btd_device_driver directly)?
>
> Johan
>

I did a quick look in the code, we can point directly to the
btd_device_driver and remove the btd_driver_data struct.
This structure was added by the commit b76fbc7d in 2008, I don't think
that there is a plan to use it :-)
"*priv" was never used and "guint id;" seems to be added by mistake.

Please ignore this patch, I will send another patch removing
btd_driver_data struct.

Claudio.
