Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ed1a2090-d30c-d2d8-2b15-3e9aa12dfcf9@nokia.com>
References: <a40f6085-e8b2-972a-9df8-cdcc928deb98@nokia.com>
 <79794ec3-94a8-3808-9c6b-fb5d4569c481@nokia.com> <CABBYNZJZQSem+6JbER+zRtwaAynK1UPvknr8YG8hbEK1Ayp8oA@mail.gmail.com>
 <ed1a2090-d30c-d2d8-2b15-3e9aa12dfcf9@nokia.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Jun 2017 11:37:15 +0300
Message-ID: <CABBYNZKQ9p_m4BQBvRZUOwf5szFgQQv_rfPeDoL0YUADHZaRbQ@mail.gmail.com>
Subject: Re: [PATCH] Device API : overload device connect dbus method to allow
 transport arg (manage priority between LE and BR/EDR connect)
To: Eric Khach <eric.khach@nokia.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eric,

On Mon, Jun 19, 2017 at 10:47 AM, Eric Khach <eric.khach@nokia.com> wrote:
> Hi Luiz,
>
> On 17/06/2017 21:49, Luiz Augusto von Dentz wrote:
>>
>> Hi Eric,
>>
>> On Fri, Jun 16, 2017 at 6:21 PM, Eric Khach <eric.khach@nokia.com> wrote:
>>>
>>>
>>> Hello,
>>>
>>> This patch overloads device connect dbus method so that it allows a new
>>> argument : transport. This new argument lets user decide which transport
>>> to
>>> use between LE and BR/EDR.
>>>
>>> The decision tree is the same as before, except for the last criterion
>>> where
>>> timestamps for LE and BR/EDR are equal. In this case, BR/EDR used to
>>> always
>>> take precedence but with this patch, it depends on the optional argument.
>>>
>>> This argument defaults to BR/EDR and so the method works as before when
>>> no
>>> argument is sent.
>>>
>>> This is useful in case a device has to be able to connect to both BR/EDR
>>> and
>>> LE devices but has to force LE in some cases.
>>
>>
>> D-Bus does not support method overloading, we would probably break
>> client with that. That said we do have plans to introduce bearer
>> specific interfaces, which those you would be able to specify which
>> bearer to connect.
>
>
> Alright, thanks for the answer. When do you think the new interfaces will be


> available ?

If I recall this was the last proposal:

http://www.spinics.net/lists/linux-bluetooth/msg66818.html

I guess Szymon did not have time to finished it but we could at least
agree on the API so we can start implementing it.

>
>>> ---
>>>   doc/device-api.txt | 10 ++++++----
>>>   src/device.c       | 31 ++++++++++++++++++++++++-------
>>>   2 files changed, 30 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>>> index 13b2881..375e998 100644
>>> --- a/doc/device-api.txt
>>> +++ b/doc/device-api.txt
>>> @@ -9,7 +9,7 @@ Service         org.bluez
>>>   Interface      org.bluez.Device1
>>>   Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>>>
>>> -Methods                void Connect()
>>> +Methods                void Connect(string transport (optional))
>>>
>>>                          This is a generic method to connect any profiles
>>>                          the remote device supports that can be connected
>>> @@ -31,9 +31,11 @@ Methods              void Connect()
>>>                                  bearers are bonded or both are skip and
>>> check
>>>                                  latest seen bearer.
>>>
>>> -                               3. Connect last seen bearer, in case the
>>> -                               timestamps are the same BR/EDR takes
>>> -                               precedence.
>>> +                               3. Connect last seen bearer. In case the
>>> +                               timestamps are the same, transport type
>>> set
>>> in
>>> +                               optional argument (either "bredr" or
>>> "le")
>>> will
>>> +                               take precedence. In case argument is not
>>> set,
>>> +                               transport defaults to BR/EDR.
>>>
>>>                          Possible errors: org.bluez.Error.NotReady
>>>                                           org.bluez.Error.Failed
>>> diff --git a/src/device.c b/src/device.c
>>> index 43795fa..4eafda5 100644
>>> --- a/src/device.c
>>> +++ b/src/device.c
>>> @@ -1744,7 +1744,7 @@ resolve_services:
>>>   #define NVAL_TIME ((time_t) -1)
>>>   #define SEEN_TRESHHOLD 300
>>>
>>> -static uint8_t select_conn_bearer(struct btd_device *dev)
>>> +static uint8_t select_conn_bearer(struct btd_device *dev, uint8_t
>>> transport_priority)
>>>   {
>>>          time_t bredr_last = NVAL_TIME, le_last = NVAL_TIME;
>>>          time_t current = time(NULL);
>>> @@ -1781,11 +1781,14 @@ static uint8_t select_conn_bearer(struct
>>> btd_device
>>> *dev)
>>>                  return dev->bdaddr_type;
>>>
>>>          /*
>>> -        * Prefer BR/EDR if time is the same since it might be from an
>>> -        * advertisement with BR/EDR flag set.
>>> +        * If time is the same since it might be from an
>>> +        * advertisement with BR/EDR flag set, use priority set
>>> +        * by user (defaults to BR/EDR in case it is not set by user).
>>>           */
>>> -       if (bredr_last <= le_last)
>>> +       if (bredr_last < le_last)
>>>                  return BDADDR_BREDR;
>>> +       else if(bredr_last == le_last)
>>> +               return transport_priority;
>>>
>>>          return dev->bdaddr_type;
>>>   }
>>> @@ -1794,7 +1797,19 @@ static DBusMessage *dev_connect(DBusConnection
>>> *conn,
>>> DBusMessage *msg,
>>>                                                          void *user_data)
>>>   {
>>>          struct btd_device *dev = user_data;
>>> -       uint8_t bdaddr_type;
>>> +       uint8_t bdaddr_type, transport_priority = BDADDR_BREDR;
>>> +
>>> +       if (dbus_message_has_signature(msg, "s")){
>>> +               const char *transport;
>>> +               if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING,
>>> &transport,
>>> +
>>> DBUS_TYPE_INVALID)
>>> != NULL){
>>> +
>>> +                       if (strcmp(transport, "le") == 0)
>>> +                               transport_priority = dev->bdaddr_type;
>>> +                       else if (strcmp(transport, "bredr") != 0)
>>> +                               return btd_error_invalid_args(msg);
>>> +               }
>>> +       }
>>>
>>>          if (dev->bredr_state.connected) {
>>>                  /*
>>> @@ -1810,7 +1825,7 @@ static DBusMessage *dev_connect(DBusConnection
>>> *conn,
>>> DBusMessage *msg,
>>>          } else if (dev->le_state.connected && dev->bredr)
>>>                  bdaddr_type = BDADDR_BREDR;
>>>          else
>>> -               bdaddr_type = select_conn_bearer(dev);
>>> +               bdaddr_type = select_conn_bearer(dev,
>>> transport_priority);
>>>
>>>          if (bdaddr_type != BDADDR_BREDR) {
>>>                  int err;
>>> @@ -2397,7 +2412,7 @@ static DBusMessage *pair_device(DBusConnection
>>> *conn,
>>> DBusMessage *msg,
>>>          else if (device->le_state.bonded)
>>>                  bdaddr_type = BDADDR_BREDR;
>>>          else
>>> -               bdaddr_type = select_conn_bearer(device);
>>> +               bdaddr_type = select_conn_bearer(device, BDADDR_BREDR);
>>>
>>>          state = get_state(device, bdaddr_type);
>>>
>>> @@ -2525,6 +2540,8 @@ static DBusMessage *cancel_pairing(DBusConnection
>>> *conn, DBusMessage *msg,
>>>
>>>   static const GDBusMethodTable device_methods[] = {
>>>          { GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, dev_disconnect)
>>> },
>>> +       { GDBUS_ASYNC_METHOD("Connect", GDBUS_ARGS({ "transport", "s" }),
>>> +                                               NULL, dev_connect) },
>>>          { GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
>>>          { GDBUS_ASYNC_METHOD("ConnectProfile", GDBUS_ARGS({ "UUID", "s"
>>> }),
>>>                                                  NULL, connect_profile)
>>> },
>>> --
>>> 2.7.4
>>>
>>>
>>> Eric KHACH
>>> eric.khach@nokia.com
>>> khacheric@gmail.com
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-bluetooth"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
>



-- 
Luiz Augusto von Dentz
