Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_NsUGrZdfwBv4CmNNjwFCvvrF02+FRJ+GJQTpCpJzfp9g@mail.gmail.com>
References: <1328203716-24299-1-git-send-email-arik@wizery.com> <CAJdJm_NsUGrZdfwBv4CmNNjwFCvvrF02+FRJ+GJQTpCpJzfp9g@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Thu, 2 Feb 2012 20:44:53 +0200
Message-ID: <CA+XVXff4eFBP91oy=ein1_nP1CacCew-VL=2oNjMTVbTAO1vDQ@mail.gmail.com>
Subject: Re: [PATCH] proximity: make reporter work per-adapter
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Feb 2, 2012 at 20:30, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Arik,
>
> Minor comments below.
>
> On Thu, Feb 2, 2012 at 1:28 PM, Arik Nemtsov <arik@wizery.com> wrote:
>> Register an adapter driver for reporter and add the adapter argument in
>> appropriate places.
>>
>> Signed-off-by: Arik Nemtsov <arik@wizery.com>
>> ---
>>  proximity/manager.c  |   19 ++++++++++++----
>>  proximity/reporter.c |   57 +++++++++++++++++++------------------------------
>>  proximity/reporter.h |    4 +-
>>  3 files changed, 38 insertions(+), 42 deletions(-)
>>
>> diff --git a/proximity/manager.c b/proximity/manager.c
>> index a767554..dfb5d6d 100644
>> --- a/proximity/manager.c
>> +++ b/proximity/manager.c
>> @@ -84,12 +84,17 @@ static void attio_device_remove(struct btd_device *device)
>>  }
>>
>>  static struct btd_device_driver monitor_driver = {
>> -       .name = "Proximity GATT Driver",
>> +       .name = "Proximity GATT Monitor Driver",
>>        .uuids = BTD_UUIDS(IMMEDIATE_ALERT_UUID, LINK_LOSS_UUID, TX_POWER_UUID),
>>        .probe = attio_device_probe,
>>        .remove = attio_device_remove,
>>  };
>>
>> +static struct btd_adapter_driver reporter_server_driver = {
>
> You can drop "_server_" here, because "reporter_driver" is already
> enough to differentiate from the monitor_driver IMHO.

Sure.

>
>> +       .name = "gatt-proximity-reporter",
>
> Either use "Proximity GATT Reporter Driver" here or
> "gatt-proximity-monitor" for the monitor driver. Either is fine , just
> keep consistency :)

Will do.

>
>> +       .probe = reporter_init,
>> +       .remove = reporter_exit,
>> +};
>>  static void load_config_file(GKeyFile *config)
>>  {
>>        char **list;
>> @@ -118,19 +123,23 @@ int proximity_manager_init(DBusConnection *conn, GKeyFile *config)
>>
>>        load_config_file(config);
>>
>> -       /* TODO: Register Proximity Monitor/Reporter drivers */
>>        ret = btd_register_device_driver(&monitor_driver);
>>        if (ret < 0)
>>                return ret;
>>
>> -       connection = dbus_connection_ref(conn);
>> +       ret = btd_register_adapter_driver(&reporter_server_driver);
>> +       if (ret < 0) {
>> +               btd_unregister_device_driver(&monitor_driver);
>> +               return ret;
>> +       }
>>
>> -       return reporter_init();
>> +       connection = dbus_connection_ref(conn);
>
> I think it is better to initialize "connection" before registering the
> drivers, given the connection is used on the probe() function.

Good catch. I didn't create the bug, but no reason not to squash it here.

I'll send a v2.

Arik
