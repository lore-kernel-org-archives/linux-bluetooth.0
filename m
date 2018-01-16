Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2951607.rb9Mzus4Iv@ix>
References: <20180111110423.14498-1-szymon.janc@codecoup.pl> <2951607.rb9Mzus4Iv@ix>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Tue, 16 Jan 2018 17:42:51 +0100
Message-ID: <CALevQMbaizjkEOfKGP+aEPNXgh1EPYpZes=itE_mUTMeU=T7Zw@mail.gmail.com>
Subject: Re: [RFC] adapter: Add CreateDevice method
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

2018-01-16 15:15 GMT+01:00 Szymon Janc <szymon.janc@codecoup.pl>:
> Hi,
>
> On Thursday, 11 January 2018 12:04:23 CET Szymon Janc wrote:
>> This allows to create Device1 object without discovery. This is needed f=
or
>> some of qualification tests where there is no general discovery upfront
>> and we need to do connection to device with provided address.
>>
>> Another usecase is for scenario where scanning happen on one controller =
but
>> connection handling on another.
>>
>> Implementation wide this results in new temporary device object being
>> created that if unused will be cleanup just like it would be if found
>> during discovery session.
>>
>> This patch implements bare minimum properties needed for connection -
>> address and address type. If needed eg. for non-NFC based OOB it could b=
e
>> extended with more options.
>> ---
>>  doc/adapter-api.txt | 29 ++++++++++++++++
>>  src/adapter.c       | 96
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 1=
25
>> insertions(+)
>>
>> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
>> index 0533b674a..c8f3ce26e 100644
>> --- a/doc/adapter-api.txt
>> +++ b/doc/adapter-api.txt
>> @@ -145,6 +145,35 @@ Methods          void StartDiscovery()
>>
>>                       Possible errors: None
>>
>> +             void CreateDevice(dict properties) [experimental]
>> +
>> +                     Creates new temporary device with defined properti=
es.
>> +
>> +                     Parameters that may be set in the filter dictionar=
y
>> +                     include the following:
>> +
>> +                     string Address
>> +
>> +                             The Bluetooth device address of the remote
>> +                             device. This parameter is mandatory.
>> +
>> +                     string AddressType
>> +
>> +                             The Bluetooth device Address Type. This is
>> +                             address type that should be used for initi=
al
>> +                             connection. If this parameter is not prese=
nt
>> +                             BR/EDR device is created.
>> +
>> +                             Possible values:
>> +                                     "public" - Public address
>> +                                     "random" - Random address
>> +
>> +                     Possible errors: org.bluez.Error.InvalidArguments
>> +                                      org.bluez.Error.AlreadyExists
>> +                                      org.bluez.Error.NotSupported
>> +                                      org.bluez.Error.NotReady
>> +                                      org.bluez.Error.Failed
>> +
>>  Properties   string Address [readonly]
>>
>>                       The Bluetooth device address.
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 0a25ae27e..0d18b58aa 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -3080,6 +3080,99 @@ static DBusMessage
>> *get_discovery_filters(DBusConnection *conn, return reply;
>>  }
>>
>> +static DBusMessage *create_device(DBusConnection *conn,
>> +                                     DBusMessage *msg, void *user_data)
>> +{
>> +     struct btd_adapter *adapter =3D user_data;
>> +     DBusMessageIter iter, subiter, dictiter, value;
>> +     uint8_t addr_type =3D BDADDR_BREDR;
>> +     bdaddr_t addr =3D *BDADDR_ANY;
>> +     struct btd_device *device;
>> +
>> +     DBG("sender %s", dbus_message_get_sender(msg));
>> +
>> +     if (!(adapter->current_settings & MGMT_SETTING_POWERED))
>> +             return btd_error_not_ready(msg);
>> +
>> +     dbus_message_iter_init(msg, &iter);
>> +     if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_ARRAY ||
>> +         dbus_message_iter_get_element_type(&iter) !=3D DBUS_TYPE_DICT_=
ENTRY)
>> +             return btd_error_invalid_args(msg);
>> +
>> +     dbus_message_iter_recurse(&iter, &subiter);
>> +     do {
>> +             int type =3D dbus_message_iter_get_arg_type(&subiter);
>> +             char *key;
>> +             char *str;
>> +
>> +             if (type =3D=3D DBUS_TYPE_INVALID)
>> +                     break;
>> +
>> +             dbus_message_iter_recurse(&subiter, &dictiter);
>> +
>> +             dbus_message_iter_get_basic(&dictiter, &key);
>> +             if (!dbus_message_iter_next(&dictiter))
>> +                     return btd_error_invalid_args(msg);
>> +
>> +             if (dbus_message_iter_get_arg_type(&dictiter) !=3D
>> +                                                     DBUS_TYPE_VARIANT)
>> +                     return btd_error_invalid_args(msg);
>> +
>> +             dbus_message_iter_recurse(&dictiter, &value);
>> +
>> +             if (!strcmp(key, "Address")) {
>> +                     if (dbus_message_iter_get_arg_type(&value) !=3D
>> +                                                     DBUS_TYPE_STRING)
>> +                             return btd_error_invalid_args(msg);
>> +
>> +                     dbus_message_iter_get_basic(&value, &str);
>> +
>> +                     if (str2ba(str, &addr) < 0 )
>> +                             return btd_error_invalid_args(msg);
>> +             } else if (!strcmp(key, "AddressType")) {
>> +                     if (dbus_message_iter_get_arg_type(&value) !=3D
>> +                                                     DBUS_TYPE_STRING)
>> +                             return btd_error_invalid_args(msg);
>> +
>> +                     dbus_message_iter_get_basic(&value, &str);
>> +
>> +
>> +                     if (!strcmp(str, "public"))
>> +                             addr_type =3D BDADDR_LE_PUBLIC;
>> +                     else if (!strcmp(str, "random"))
>> +                             addr_type =3D BDADDR_LE_RANDOM;
>> +                     else
>> +                             return btd_error_invalid_args(msg);
>> +             } else {
>> +                     return btd_error_invalid_args(msg);
>> +             }
>> +
>> +             dbus_message_iter_next(&subiter);
>> +     } while (true);
>> +
>> +     if (!bacmp(&addr, BDADDR_ANY))
>> +             return btd_error_invalid_args(msg);
>> +
>> +     device =3D btd_adapter_find_device(adapter, &addr, addr_type);
>> +     if (device)
>> +             return btd_error_already_exists(msg);
>> +
>> +
>> +     device =3D adapter_create_device(adapter, &addr, addr_type);
>> +     if (!device)
>> +             return btd_error_failed(msg, "Failed to create device");
>> +
>> +     device_update_last_seen(device, addr_type);
>> +     btd_device_set_temporary(device, true);
>> +
>> +     if (!adapter->temp_devices_timeout)
>> +             adapter->temp_devices_timeout =3D g_timeout_add_seconds(
>> +                                             TEMP_DEV_TIMEOUT,
>> +                                             remove_temp_devices, adapt=
er);
>> +
>> +     return dbus_message_new_method_return(msg);
>> +}
>> +
>>  static const GDBusMethodTable adapter_methods[] =3D {
>>       { GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery=
) },
>>       { GDBUS_METHOD("SetDiscoveryFilter",
>> @@ -3091,6 +3184,9 @@ static const GDBusMethodTable adapter_methods[] =
=3D {
>>       { GDBUS_METHOD("GetDiscoveryFilters", NULL,
>>                       GDBUS_ARGS({ "filters", "as" }),
>>                       get_discovery_filters) },
>> +     { GDBUS_EXPERIMENTAL_METHOD("CreateDevice",
>> +                             GDBUS_ARGS({ "properties", "a{sv}" }), NUL=
L,
>> +                             create_device) },
>>       { }
>>  };
>
> Any feedback on this?
I've used it internally in btpclient and it works well. +1 from me.
>
>
> --
> pozdrawiam
> Szymon Janc
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

pozdrawiam,
Grzegorz Ko=C5=82odziejczyk
