Return-Path: <cyrus@holtmann.org>
Message-ID: <50BC6C46.2020607@tieto.com>
Date: Mon, 3 Dec 2012 10:09:26 +0100
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH v2 01/20] cyclingspeed: Add CSC profile plugin skeleton
References: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com> <1352105705-13988-2-git-send-email-andrzej.kaczmarek@tieto.com> <20121115093126.GA4414@x220>
In-Reply-To: <20121115093126.GA4414@x220>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/15/2012 10:31 AM, Johan Hedberg wrote:
> Hi Andrzej,
>
> On Mon, Nov 05, 2012, Andrzej Kaczmarek wrote:
>> This patch adds stub profile driver plugin for CSC profile.
>> ---
>>   Makefile.am                          |   9 +-
>>   lib/uuid.h                           |   2 +
>>   profiles/cyclingspeed/cyclingspeed.c | 163 +++++++++++++++++++++++++++++++++++
>>   profiles/cyclingspeed/cyclingspeed.h |  26 ++++++
>>   profiles/cyclingspeed/main.c         |  53 ++++++++++++
>>   profiles/cyclingspeed/manager.c      |  79 +++++++++++++++++
>>   profiles/cyclingspeed/manager.h      |  24 ++++++
>>   7 files changed, 354 insertions(+), 2 deletions(-)
>>   create mode 100644 profiles/cyclingspeed/cyclingspeed.c
>>   create mode 100644 profiles/cyclingspeed/cyclingspeed.h
>>   create mode 100644 profiles/cyclingspeed/main.c
>>   create mode 100644 profiles/cyclingspeed/manager.c
>>   create mode 100644 profiles/cyclingspeed/manager.h
>
> You'll need to rebase these against latest git since this one doesn't
> apply cleanly (due to Makefile.am) and doesn't compile either (due to
> main_opts.gatt_enabled having been removed).

Sure, will do.

>> +struct csc_adapter {
>> +	struct btd_adapter	*adapter;
>> +	GSList			*devices;	/* list of registered devices */
>> +};
>> +
>> +struct csc {
>> +	struct btd_device	*dev;
>> +	struct csc_adapter	*cadapter;
>> +};
>
> I'm a bit worried that we've failed to create proper internal GATT APIs
> if they require this kind of per-profile tracking of devices and
> adapters. You can already get a list of btd_device from btd_adapter and
> the btd_adapter from a btd_device. Profiles should only need to track a
> very minimal amount of context.

Probably would be good to have some kind of API to attach profile 
specific data for particular device and/or adapter so we can get rid of 
duplicated code across plugins and just use one already existing list. 
Not sure how this could look like at the moment though.

>> +++ b/profiles/cyclingspeed/main.c
>> @@ -0,0 +1,53 @@

<snip>

>> +static int cyclingspeed_init(void)
>> +{
>> +	if (!main_opts.gatt_enabled) {
>> +		DBG("GATT is disabled");
>> +		return -ENOTSUP;
>> +	}
>> +
>> +	return cyclingspeed_manager_init();
>> +}
>> +
>> +static void cyclingspeed_exit(void)
>> +{
>> +	cyclingspeed_manager_exit();
>> +}
>> +
>> +BLUETOOTH_PLUGIN_DEFINE(cyclingspeed, VERSION,
>> +					BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
>> +					cyclingspeed_init, cyclingspeed_exit)
>
> If this is all the main.c file does seems like it should be merged into
> manager.c or even cyclingspeed.c.
>
>> +++ b/profiles/cyclingspeed/manager.c
>> @@ -0,0 +1,79 @@

<snip>

>> +
>> +static struct btd_profile cscp_profile = {
>> +	.name		= "Cycling Speed and Cadence GATT Driver",
>> +	.remote_uuids	= BTD_UUIDS(CYCLING_SC_UUID),
>> +
>> +	.adapter_probe	= csc_adapter_probe,
>> +	.adapter_remove	= csc_adapter_remove,
>> +
>> +	.device_probe	= csc_device_probe,
>> +	.device_remove	= csc_device_remove,
>> +};
>> +
>> +int cyclingspeed_manager_init(void)
>> +{
>> +	return btd_profile_register(&cscp_profile);
>> +}
>> +
>> +void cyclingspeed_manager_exit(void)
>> +{
>> +	btd_profile_unregister(&cscp_profile);
>> +}
>
> Are these functions ever going to do anything else than make single
> Vcalls into cyclingspeed.c? If not it seems to me like all this should
> be merged into that file.
>
> Btw, I do realize that other profiles might have similar brain dead
> design but that's not a good enough excuse to keep replicating the bad
> design. Instead the other profiles should be fixed.

Probably I'll just merge all this code into single cyclingspeed.c since 
all code in main.c and manager.c are just dumb calls and I don't see any 
need to extend them in future.

I'll try to send new patchset later today.

BR,
Andrzej
