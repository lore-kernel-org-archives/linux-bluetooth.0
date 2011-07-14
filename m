Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110714144444.GB26341@dell.ger.corp.intel.com>
References: <1309874168-32716-9-git-send-email-claudio.takahasi@openbossa.org>
	<1309987430-10111-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110714144444.GB26341@dell.ger.corp.intel.com>
Date: Thu, 14 Jul 2011 10:52:33 -0400
Message-ID: <CAJdJm_PuzO+vSjLuM=eWnjif64Ki8kcEJSgarBOizELNw-xH0A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 08/12] Drop GAttrib ref if callback list is empty
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Jul 14, 2011 at 10:44 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> @@ -2605,10 +2605,15 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
>>
>>       g_free(attio);
>>
>> +     if (device->attios != NULL)
>> +             return TRUE;
>> +
>>       if (device->attioid) {
>>               g_source_remove(device->attioid);
>>               device->attioid = 0;
>>       }
>>
>> +     g_attrib_unref(device->attrib);
>> +
>>       return TRUE;
>>  }
>
> Looks like you're missing a device->attrib = NULL; after the unref.

I really don't see the point in setting a reference counted variable
to NULL. How would we know whether this is the last usage or not? In
this case we are just removing a callback. What if we registered two
callbacks?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
