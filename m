Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_M=19tbUqYFztW8EJM5qCOdy00ddZ6rRMtgtQ0hcN55YA@mail.gmail.com>
References: <1316422359-16167-1-git-send-email-sancane@gmail.com>
	<1316422359-16167-2-git-send-email-sancane@gmail.com>
	<CAJdJm_M=19tbUqYFztW8EJM5qCOdy00ddZ6rRMtgtQ0hcN55YA@mail.gmail.com>
Date: Mon, 19 Sep 2011 14:57:48 +0200
Message-ID: <CACLukzKE_5c--JS+FbWS23w_hs_MG9kYkGF_U_5isPM1WF_AFQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] Load device driver if thermometer service attribute
 appears in GATT
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

See comment below.

2011/9/19 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi Santiago,
>
> On Mon, Sep 19, 2011 at 4:52 AM, Santiago Carot-Nemesio
> <sancane@gmail.com> wrote:
>> ---
>>  thermometer/manager.c     |   25 ++++++++++++++++++++++++-
>>  thermometer/thermometer.c |    5 ++++-
>>  thermometer/thermometer.h |    3 ++-
>>  3 files changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/thermometer/manager.c b/thermometer/manager.c
>> index 08f0e0a..0062ea1 100644
>> --- a/thermometer/manager.c
>> +++ b/thermometer/manager.c
>> @@ -21,19 +21,42 @@
>>  */
>>
>>  #include <gdbus.h>
>> +#include <bluetooth/uuid.h>
>>
>>  #include "adapter.h"
>>  #include "device.h"
>> +#include "att.h"
>>  #include "thermometer.h"
>>  #include "manager.h"
>>
>> +#define HEALTH_THERMOMETER_SVC_UUID    "1809"
>>  #define HEALTH_THERMOMETER_UUID                "00001809-0000-1000-8000-00805f9b34fb"
>>
>>  static DBusConnection *connection = NULL;
>>
>> +static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
>> +{
>> +       const struct att_primary *prim = a;
>> +       const char *uuid = b;
>> +
>> +       return g_strcmp0(prim->uuid, uuid);
>> +}
>> +
>>  static int thermometer_driver_probe(struct btd_device *device, GSList *uuids)
>>  {
>> -       return thermometer_register(connection, device);
>> +       struct att_primary *tattr;
>> +       GSList *l, *primaries;
>> +
>> +       primaries = btd_device_get_primaries(device);
>> +
>> +       l = g_slist_find_custom(primaries, HEALTH_THERMOMETER_SVC_UUID,
>> +                                                       primary_uuid_cmp);
>
> I think this is incorrect. You should compare against the 128-bit
> UUID, not the 16-bit one. I.e. use HEALTH_THERMOMETER_UUID here.

Are you sure?. In my tests, the function btd_device_get_primaries only
gives me 16-bit UUIDs. If I try the 128-bit ones it doesn't work. That
the reason wich I did this. Do you have any idea for this?

Regards.
