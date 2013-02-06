Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1360136399.15783.1.camel@aeonflux>
References: <1360076455-32716-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1360136399.15783.1.camel@aeonflux>
Date: Wed, 6 Feb 2013 10:08:56 +0200
Message-ID: <CABBYNZKZugN7Tfm2rqKn2v5qh1WTtXYr4NO80kesG6Xe2Y4hrw@mail.gmail.com>
Subject: Re: [PATCH v0] core: Fix racy D-Bus service name request
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Mikel,

On Wed, Feb 6, 2013 at 9:39 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mikel,
>
>> The ObjectManager interface should already be ready by the time the
>> D-Bus service name is owned. Hence, use g_dbus_request_name() explicitly
>> once g_dbus_attach_object_manager() has finished.
>>
>> Without this patch, clients relying on the presence of the ObjectManager
>> could potentially face a race condition.
>
> I almost expected that someone sooner or later will run into this issue.
>
>> ---
>>  src/main.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/main.c b/src/main.c
>> index 1e40ebc..12ae3d9 100644
>> --- a/src/main.c
>> +++ b/src/main.c
>> @@ -424,7 +424,7 @@ static int connect_dbus(void)
>>
>>       dbus_error_init(&err);
>>
>> -     conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, BLUEZ_NAME, &err);
>> +     conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &err);
>>       if (!conn) {
>>               if (dbus_error_is_set(&err)) {
>>                       g_printerr("D-Bus setup failed: %s\n", err.message);
>> @@ -439,6 +439,12 @@ static int connect_dbus(void)
>>       g_dbus_set_disconnect_function(conn, disconnected_dbus, NULL, NULL);
>>       g_dbus_attach_object_manager(conn);
>>
>> +     if (!g_dbus_request_name(conn, BLUEZ_NAME, &err)) {
>> +             g_printerr("D-Bus service name request failed: %s\n",
>> +                                                             err.message);
>> +             return -EIO;
>> +     }
>> +
>
> The only thing that I do not really like here is that the request name
> is actually a blocking call. If we are trying to fix this, then we might
> actually really do this async.

But still the problem seems to be that we should attach object manager
before requesting the name, so perhaps what we should do is to change
g_dbus_setup_bus or create another function that does take into
account object manager e.g. g_dbus_setup_bus_with_object_manager. I
agree with the async name request though and that would cause
g_dbus_setup_bus to change anyway because we probably need a callback
to tell when it is complete.

--
Luiz Augusto von Dentz
