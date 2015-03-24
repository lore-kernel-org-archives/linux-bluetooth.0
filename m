Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJC1u3buiOPTxcfiBuS0t+6FvZ6dF+rHO0eegnm+YAe4Q@mail.gmail.com>
References: <1427139103-26441-1-git-send-email-jpawlowski@google.com>
	<1427139103-26441-4-git-send-email-jpawlowski@google.com>
	<CAHrH25Qo_yNOXa-MSMUGtBkK1J=gBBNMMkvep-H-Uhhr2chOgw@mail.gmail.com>
	<CAD0=r8wYKCbkh0Ve1XK1iMK3eaB-ZLTF=w+e3mdYsfyD6X_U7Q@mail.gmail.com>
	<CABBYNZJC1u3buiOPTxcfiBuS0t+6FvZ6dF+rHO0eegnm+YAe4Q@mail.gmail.com>
Date: Tue, 24 Mar 2015 12:53:47 -0700
Message-ID: <CAD0=r8x6yvEFMEXRfa+u9R2FeJrhMuod=jmKAQ6+qyiennGKPg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] core: adapter: Add parameter parsing to SetDiscoveryFilter
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 24, 2015 at 2:16 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jakub,
>
> On Tue, Mar 24, 2015 at 10:01 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> On Mon, Mar 23, 2015 at 5:22 PM, Arman Uguray <armansito@chromium.org> wrote:
>>> Hi Jakub,
>>>
>>>> On Mon, Mar 23, 2015 at 12:31 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>>>> This patch adds parameter parsing, and basic internal logic checks to
>>>> SetDiscoveryFilter method.
>>>> ---
>>>>  src/adapter.c | 172 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 172 insertions(+)
>>>>
>>>> diff --git a/src/adapter.c b/src/adapter.c
>>>> index 7c51399..f57b58c 100644
>>>> --- a/src/adapter.c
>>>> +++ b/src/adapter.c
>>>> @@ -92,6 +92,8 @@
>>>>  #define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
>>>>  #define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE)
>>>>
>>>> +#define        DISTNACE_VAL_INVALID    0x7FFF
>>>
>>> s/DISTNACE/DISTANCE/
>> fixed
>>>
>>> Also, where does the 0x7FFF come from? Why not just 0xFFFF?
>>>> +
>>>>  static DBusConnection *dbus_conn = NULL;
>>>>
>>>>  static bool kernel_conn_control = false;
>>>> @@ -145,6 +147,13 @@ struct conn_param {
>>>>         uint16_t timeout;
>>>>  };
>>>>
>>>> +struct discovery_filter {
>>>> +       uint8_t type;
>>>> +       uint16_t pathloss;
>>>> +       int16_t rssi;
>>>> +       GSList *uuids;
>>>> +};
>>>> +
>>>>  struct watch_client {
>>>>         struct btd_adapter *adapter;
>>>>         char *owner;
>>>> @@ -1760,9 +1769,172 @@ static DBusMessage *start_discovery(DBusConnection *conn,
>>>>         return dbus_message_new_method_return(msg);
>>>>  }
>>>>
>>>> +static bool parse_discovery_filter_entry(char *key, DBusMessageIter *value,
>>>> +                                     GSList **uuids, int16_t *rssi,
>>>> +                                     uint16_t *pathloss, uint8_t *transport)
>>>> +{
>>>> +       uint8_t type;
>>>> +
>>>> +       if (strcmp("UUIDs", key) == 0) {
>>>
>>> Use "if (!strcmp("UUIDs"..." instead of "== 0".
>>>
>> fixed
>>>> +               DBusMessageIter arriter;
>>>> +
>>>> +               if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_ARRAY)
>>>> +                       return false;
>>>
>>> New line after return.
>>>
>> fixed
>>>> +               dbus_message_iter_recurse(value, &arriter);
>>>> +               while ((type = dbus_message_iter_get_arg_type(&arriter)) !=
>>>> +                                                       DBUS_TYPE_INVALID) {
>>>> +                       char *uuid_str;
>>>> +                       char *result_uuid;
>>>> +                       uuid_t uuid_tmp;
>>>
>>> I'd use bt_uuid_t here instead of uuid_t, since the latter is defined
>>> for sdp specific usage. Though I'd check with the others here still.
>> still discussing
>>>
>>>> +
>>>> +                       if (dbus_message_iter_get_arg_type(&arriter) !=
>>>> +                                                       DBUS_TYPE_STRING)
>>>> +                               return false;
>>>> +
>>>> +                       dbus_message_iter_get_basic(&arriter, &uuid_str);
>>>> +                       if (bt_string2uuid(&uuid_tmp, uuid_str) < 0)
>>>> +                               return false;
>>>> +
>>>> +                       result_uuid = bt_uuid2string(&uuid_tmp);
>>>> +
>>>> +                       *uuids = g_slist_prepend(*uuids, result_uuid);
>>>> +
>>>> +               dbus_message_iter_next(&arriter);
>>>
>>> Indentation looks off here. You should probably run checkpatch on
>>> these for general formatting.
>> fixed
>>>
>>>> +               }
>>>> +       } else if (strcmp("RSSI", key) == 0) {
>>>> +               if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_INT16)
>>>> +                       return false;
>>>
>>> It makes code more readable if you add a new line after returns within a block.
>>>
>> fixed
>>>> +               dbus_message_iter_get_basic(value, rssi);
>>>> +               if (*rssi > 0 || *rssi < -127)
>>>
>>> Why are positive RSSI values not allowed? doc/adapter.txt doesn't
>>> provide the unit of measurement for RSSI but I assume it's dBm, which
>>> can be positive, no? Eitherway, add a comment here explaining these
>>> checks.
>>>
>> I checked that in spec, added proper comment
>>>> +                       return false;
>>>> +       } else if (strcmp("Pathloss", key) == 0) {
>>>> +               if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
>>>> +                       return false;
>>>> +               dbus_message_iter_get_basic(value, pathloss);
>>>> +               if (*pathloss > 127)
>>>
>>> Add a comment here explaining why this is. Also it probably makes
>>> sense to define a macro constant for 127.
>> actually after looking at spec, max pathloss might be 137, RSSI =
>> -127, TX_POWER=10
>>>
>>>> +                       return false;
>>>> +       } else if (strcmp("Transport", key) == 0) {
>>>> +               char *transport_str;
>>>> +
>>>> +               if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING)
>>>> +                       return false;
>>>> +               dbus_message_iter_get_basic(value, &transport_str);
>>>> +
>>>> +               if (strcmp(transport_str, "bredr") == 0)
>>>> +                       *transport = SCAN_TYPE_BREDR;
>>>> +               else if (strcmp(transport_str, "le") == 0)
>>>> +                       *transport = SCAN_TYPE_LE;
>>>> +               else if (strcmp(transport_str, "auto") == 0)
>>>> +                       *transport = SCAN_TYPE_DUAL;
>>>> +               else
>>>> +                       return false;
>>>> +       } else {
>>>> +               DBG("Unknown key parameter: %s!\n", key);
>>>> +               return false;
>>>> +       }
>>>> +
>>>> +       return true;
>
> You could perhaps split these into e.g. parse_pathloss, parse_transport, etc.
>
Done. Looks better, thanks!
>>>> +}
>>>> +
>>>> +/* This method is responsible for parsing parameters to SetDiscoveryFilter. If
>>>> + * filter in msg was empty, sets *filter to NULL. If whole parsing was
>>>> + * successful, sets *filter to proper value.
>>>> + * Returns false on any error, and true on success.
>>>> + */
>>>> +static bool parse_discovery_filter_dict(struct discovery_filter **filter,
>>>> +                                       DBusMessage *msg)
>
> Why don't you return the struct discovery_filter * instead of bool?

Returned value means that parsing was successful/unsuccessful.
When it was successfull, the filter parameter will be either NULL
(filter was cleared), or point to the filter.
I think it's according to convention (returning status). How would you
like that modified?

>
>
> --
> Luiz Augusto von Dentz
