Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+B_dDGRnoic6xyn4N1kRpOPTGrMJ7xBkmB7M=ZBsZzDQ@mail.gmail.com>
References: <1309790985-32143-1-git-send-email-bulislaw@linux.com>
	<CABBYNZ+B_dDGRnoic6xyn4N1kRpOPTGrMJ7xBkmB7M=ZBsZzDQ@mail.gmail.com>
Date: Tue, 5 Jul 2011 10:55:03 +0200
Message-ID: <CAPGrrxVT-xugggk_CcNn_Zd+ZSJjuVPrMn64XVnNoUqK2sm60Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Add SetRemoteProperty method for OOB mechanism
From: Bartosz Szatkowski <bulislaw@linux.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 5, 2011 at 10:42 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Bartosz,
>
> On Mon, Jul 4, 2011 at 5:49 PM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
>> It might be necessary in use cases when there is OOB pairing and some
>> portion of remote device properties is needed before profiles are
>> connected. For now only class of device is supported.
>> ---
>>  doc/oob-api.txt   |   10 ++++++++++
>>  plugins/dbusoob.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 63 insertions(+), 0 deletions(-)
>>
>> diff --git a/doc/oob-api.txt b/doc/oob-api.txt
>> index d838712..e15fc29 100644
>> --- a/doc/oob-api.txt
>> +++ b/doc/oob-api.txt
>> @@ -36,3 +36,13 @@ Methods              array{byte} hash, array{byte} randomizer ReadLocalData()
>>
>>                        Possible errors: org.bluez.Error.Failed
>>                                         org.bluez.Error.InvalidArguments
>> +
>> +               void SetRemoteProperty(string address, string property,
>> +                                                               variant value)
>> +
>> +                       This method adds new property for device with specified
>> +                       address, to be used when device is created.
>> +                       For now only Class of device is supported.
>> +
>> +                       Possible errors: org.bluez.Error.Failed
>> +                                        org.bluez.Error.InvalidArguments
>> diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
>> index 2c03780..c9ca57a 100644
>> --- a/plugins/dbusoob.c
>> +++ b/plugins/dbusoob.c
>> @@ -43,6 +43,7 @@
>>  #include "event.h"
>>  #include "error.h"
>>  #include "oob.h"
>> +#include "storage.h"
>>
>>  #define OOB_INTERFACE  "org.bluez.OutOfBand"
>>
>> @@ -153,6 +154,57 @@ static DBusMessage *add_remote_data(DBusConnection *conn, DBusMessage *msg,
>>        return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>>  }
>>
>> +static DBusMessage *set_remote_property(DBusConnection *conn, DBusMessage *msg,
>> +                                                               void *data)
>> +{
>> +       struct btd_adapter *adapter = data;
>> +       DBusMessageIter iter, sub;
>> +       char *addr, *property;
>> +       bdaddr_t local, peer;
>> +
>> +       if (!dbus_message_iter_init(msg, &iter))
>> +               return btd_error_invalid_args(msg);
>> +
>> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
>> +               return btd_error_invalid_args(msg);
>> +
>> +       dbus_message_iter_get_basic(&iter, &addr);
>> +       dbus_message_iter_next(&iter);
>> +
>> +       if (bachk(addr))
>> +               return btd_error_invalid_args(msg);
>> +
>> +       adapter_get_address(adapter, &local);
>> +       str2ba(addr, &peer);
>> +
>> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
>> +               return btd_error_invalid_args(msg);
>> +
>> +       dbus_message_iter_get_basic(&iter, &property);
>> +       dbus_message_iter_next(&iter);
>> +
>> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
>> +               return btd_error_invalid_args(msg);
>> +
>> +       dbus_message_iter_recurse(&iter, &sub);
>> +
>> +       if (g_str_equal("Class", property)) {
>> +               uint32_t class;
>> +
>> +               if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT32)
>> +                       return btd_error_invalid_args(msg);
>> +
>> +               dbus_message_iter_get_basic(&sub, &class);
>> +
>> +               if (write_remote_class(&local, &peer, class) < 0)
>> +                       return btd_error_failed(msg, "Request failed");
>> +       } else {
>> +               return btd_error_invalid_args(msg);
>> +       }
>> +
>> +       return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>> +}
>> +
>>  static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
>>                                                                void *data)
>>  {
>> @@ -177,6 +229,7 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
>>
>>  static GDBusMethodTable oob_methods[] = {
>>        {"AddRemoteData",       "sayay",        "",     add_remote_data},
>> +       {"SetRemoteProperty",   "ssv",          "",     set_remote_property},
>>        {"RemoveRemoteData",    "s",            "",     remove_remote_data},
>>        {"ReadLocalData",       "",             "ayay", read_local_data,
>>                                                G_DBUS_METHOD_FLAG_ASYNC},
>> --
>> 1.7.4.1
>
> I don't think this is the right approach for OOB data because this
> information may become private to bluetoothd if the device is not
> created since it is not associated with any device object/path, IMO
> the OOB data needs to be passed in the CreateDevice which should take
> a dictionary containing all the known information of the device, but
> that breaks the API otherwise I would already send a patch proposing
> this.
>
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Right, i'v discussed this approach with Johan and Szymon on freenode
-- i'v changed few things after that (mostly because implementing it
in AddRemoteData would break api, so i moved it to separate method) --
maybe it would be a good idea to have this functionality now in this
form and change it when the api break would be possible (5.0?)?

-- 
Pozdrowienia,
Bartosz Szatkowski
