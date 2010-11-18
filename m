Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101118124320.GA4918@jh-x301>
References: <1290009593-13658-1-git-send-email-bruna.moreira@openbossa.org>
	<1290009593-13658-2-git-send-email-bruna.moreira@openbossa.org>
	<20101118124320.GA4918@jh-x301>
Date: Thu, 18 Nov 2010 10:03:30 -0400
Message-ID: <AANLkTi=xBthrmGDV0pUK_Tbw-Lob4gT9RmTgPrPAYj7M@mail.gmail.com>
Subject: Re: [PATCH 2/3] Extract service UUIDs from advertising data
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Bruna Moreira <bruna.moreira@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Nov 18, 2010 at 8:43 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Bruna,
>
> On Wed, Nov 17, 2010, Bruna Moreira wrote:
>> +     /* Extract UUIDs from extended inquiry response if any */
>> +     dev->services = get_eir_uuids(eir_data, eir_length, dev->services);
>> +     uuid_count = g_slist_length(dev->services);
>> +
>> +     if (dev->services) {
>> +             uuids = strlist2array(dev->services);
>> +             g_slist_foreach(dev->services, (GFunc) g_free, NULL);
>> +             g_slist_free(dev->services);
>> +             dev->services = NULL;
>> +     }
>
> What's the reason that the get_eir_uuids API is designed so that it can
> handle a list which already contains elements before calling the
> function? Since you free the list right after creating the uuids array
> it seems like this shouldn't happen. Or am I missing something?

The list is destroyed here just to keep the old semantics for BR/EDR,
which ignores service UUIDs from previous EIR data.

For LE devices (as you can see on the following 3/3 patch) we do not
destroy the previous list when new advertising data is parsed.
Instead, we "merge" the UUIDs list.

Do you think we can unify semantics of BR/EDR and LE and always merge
the service UUIDs for both EIR and advertising data?

> Btw, is there something that could be optimized here since it seems like
> you're regenerating the uuids array before every signal even though the
> set of service might not have changed since the previous one. Maybe you
> should track this and only regenerate the array if there has been a
> changed from the previous signal. What do you think?

On the current code, the UUIDs array is always created on each EIR
data (inside get_eir_uuids()) and destroyed right after the
DeviceFound signal is emitted. For simplicity, we kept this same
behavior.

I agree we can make some optimization here and avoid heap
allocations/deallocations when UUIDs do not change. One idea might be
to keep the uuids char* array as well as the GSList on the
remote_dev_info struct, and only recreate this array if any new UUIDs
were added to the GSList (this can be identified if the uuidcount has
changed, because we never delete UUIDs). What do you think?

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
