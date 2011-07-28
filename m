Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukz+g-994zKLK1aPkBusEhv=ti850KhMSjGZQjJOdL9kdcw@mail.gmail.com>
References: <1311803586-5405-1-git-send-email-claudio.takahasi@openbossa.org>
	<1311803586-5405-2-git-send-email-claudio.takahasi@openbossa.org>
	<CACLukz+g-994zKLK1aPkBusEhv=ti850KhMSjGZQjJOdL9kdcw@mail.gmail.com>
Date: Thu, 28 Jul 2011 10:05:16 -0300
Message-ID: <CAKT1EBdLfwYmHQY_i4DV+aS6U_yCsKHhAv+LpojLTRpXtoNKZw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/6] Proximity Monitor: Write Alert Level to Reporter
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago.

Our initial plan was to implement a "queue" to send commands
supporting "offline" mode. The "queue" reference could be "informed"
to the profiles in the probe callback or a reference to it could be
obtained using a function similar to btd_device_add_attio_callback.
The problem is MTU, MTU is negotiated over ATT protocol, meaning that
we can not encode the commands and add it into the queue without a
huge change in our code.

The intermediate solution was to expose GAttrib and add the connection
callback registration to "request" connections.

On Thu, Jul 28, 2011 at 1:36 AM, Santiago Carot <sancane@gmail.com> wrote:
> Hello Claudio,
>
> Some questions below.
>
> 2011/7/27 Claudio Takahasi <claudio.takahasi@openbossa.org>:
>> From: Anderson Lizardo <anderson.lizardo@openbossa.org>
>>
>> When the Proximity Monitor connects to the Reporter, it shall write its
>> current Alert Level (usually defined by the user) into the Alert Level
>> characteristic on the Monitor. So once the link is lost, the Monitor
>> will alert with the appropriate level.
>>
>> Note: Register connection callback to write alert level to the Reporter.
>> ---
>>  proximity/monitor.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 92 insertions(+), 0 deletions(-)
>>
>> diff --git a/proximity/monitor.c b/proximity/monitor.c
>> index 8465f92..f7995aa 100644
>> --- a/proximity/monitor.c
>> +++ b/proximity/monitor.c
>> @@ -35,19 +35,28 @@
>>  #include <sys/stat.h>
<snip>
>> +static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
>> +{
>> +       struct monitor *monitor = user_data;
>> +
>> +       monitor->attrib = attrib;
>
> GAttrib is a referenciable structure. Don't you increment the
> reference counter if you are storing an internal reference in monitor?

References are controlled by the core. The last reference for the
GAttrib will not be release by the core until the last connection
callback is unregistered. This is the reason why reference control
inside the profiles are not needed. If it is more clear to everybody
we can add reference counting in the profiles, but it will be a
duplicated logic. Every btd_device_remove_attio_callback call will be
followed by g_attrib_unref.

>
>> +       write_alert_level(monitor);
>> +}
>> +
>> +static void attio_disconnected_cb(gpointer user_data)
>> +{
>> +       struct monitor *monitor = user_data;
>> +
>> +       monitor->attrib = NULL;
>
> unref above?
>
>> +}
>> +
>>  static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
>>                                                const char *level, void *data)
>>  {
>> @@ -229,6 +318,9 @@ int monitor_register(DBusConnection *conn, struct btd_device *device)
>>
>>        DBG("Registered interface %s on path %s", PROXIMITY_INTERFACE, path);
>>
>> +       btd_device_add_attio_callback(device, attio_connected_cb,
>> +                                       attio_disconnected_cb, monitor);
>
> Could we use a GDestroyNotify function here to avoid possible memory
> leaks or other memory related problems?.
> We could call to GDestroyNotify when btd_device_remove_attio_callback.
> The procedure look me similar to g_dbus_register_interface and
> g_dbus_unregister_interface when destroy function is provided
>

we can add it if necessary. Feel free to send a patch for it.

Regards,
Claudio.

>> +
>>        return 0;
>>  }
>>
>> --
>> 1.7.6
