Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <6DC51AD5-E9D5-4874-AAA8-38A4BF7C1668@holtmann.org>
References: <20170920125445.24792-1-hadess@hadess.net> <20170920125445.24792-2-hadess@hadess.net>
 <0268513E-AD33-4E4E-A926-2EC695DC1D86@holtmann.org> <1505925333.9350.7.camel@hadess.net>
 <6DC51AD5-E9D5-4874-AAA8-38A4BF7C1668@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Sep 2017 21:57:54 +0300
Message-ID: <CABBYNZLeNiw_5A_mBbLm6Uq2B-8+KEhuMKAsVerSAKeS3WbE+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] hostname: Fix "BlueZ 5.XX" adapter name on startup
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bastien Nocera <hadess@hadess.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

H Bastien,

On Wed, Sep 20, 2017 at 7:59 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Bastien,
>
>>>> The hostname plugin listens to property changes from systemd-
>>>> hostnamed
>>>> but doesn't fetch initial values. This means that unless the
>>>> PrettyHostname or StaticHostname changes, the default adapter will
>>>> be
>>>> called "BlueZ 5.XX" matching the version number.
>>>>
>>>> This is the case since the hostname plugin replaced the adaptername
>>>> plugin in 2012.
>>>>
>>>> Fetch the initial values for PrettyHostname,StaticHostname and
>>>> Chassis when the plugin is initiated, so as to make the values
>>>> available for adapter setup.
>>>> ---
>>>> plugins/hostname.c | 4 ++++
>>>> 1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/plugins/hostname.c b/plugins/hostname.c
>>>> index f876d0afb..db9187378 100644
>>>> --- a/plugins/hostname.c
>>>> +++ b/plugins/hostname.c
>>>> @@ -307,6 +307,10 @@ static int hostname_init(void)
>>>>             hostname_proxy =3D NULL;
>>>>             g_dbus_client_unref(hostname_client);
>>>>             hostname_client =3D NULL;
>>>> +   } else {
>>>>+           g_dbus_proxy_refresh_property(hostname_proxy,
>>>> "PrettyHostname");
>>>> +           g_dbus_proxy_refresh_property(hostname_proxy,
>>>> "StaticHostname");
>>>> +           g_dbus_proxy_refresh_property(hostname_proxy,
>>>> "Chassis");
>>>>     }
>>>
>>> I am 100% certain that I tested this since this would be a really
>>> dumb plugin otherwise.
>>
>> You don't say ;)
>>
>>> However is it possible that when calling GetManagedObjects the
>>> values are not returned correctly?
>>
>> get_managed_objects() in gdbus/client.c is never called for this
>> GDBusClient.

I guess this can only occur if the bus name does not exist, perhaps it
has not been activated yet, that would explain why calling refresh
would work since that activate the bus name. I wonder if GetNameOwner
is not enough to activate a service? Well perhaps we should use
StartServiceByName then but it doesn't return the bus id so it only
works if the service has activated since we have subscribed to
NameOwnerChanged but in case it is already running we still have to
call GetNameOwner. Btw is this running with dbus-daemon or the new
dbus-broker? Perhaps the later doesn't active things in the same way
dbus-daemon would.


> Hmmm, you should either come via service_connect callback or when setting=
 the proxy handlers. Seems setting the property watch is not triggering the=
 initial GetManagedObjects. And most likely the service_connect is not trig=
gered correctly either. Something is fishy here and it is too long ago that=
 I wrote that code to remember. Maybe we changed something and accidentally=
 broke some expected behavior.
>
> Maybe Luiz and Johan can have a look at this as well, but I have the feel=
ing this should be a fix in the gdbus code.gdbus
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" inlinux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
