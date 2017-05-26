Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHgsZ+hyvPHdD0X0sp-8DkbG=GbY79_J=_ttpCfbPue_WJ5R9g@mail.gmail.com>
References: <20170523195650.29695-1-mcchou@chromium.org> <20170525001054.92520-1-mcchou@chromium.org>
 <CACumGO+-WFY9QQWTJJ8NfZzYdeVskY=7fbpC8K+of_Y49fhGHQ@mail.gmail.com> <CAHgsZ+hyvPHdD0X0sp-8DkbG=GbY79_J=_ttpCfbPue_WJ5R9g@mail.gmail.com>
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date: Fri, 26 May 2017 11:42:09 +0300
Message-ID: <CACumGOKBCN9VOK+xetL_b8FxaR3cyPraBgg3QTnYJri6_xNPuw@mail.gmail.com>
Subject: Re: [PATCH v3] device: Clear GATT DB after disconnection for unpaired device
To: Miao-chen Chou <mcchou@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        josephsih@chromium.org, sonnysasaka@chromium.org,
        Rahul Chaturvedi <rkc@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Miao,

On Fri, May 26, 2017 at 10:20 AM, Miao-chen Chou <mcchou@google.com> wrote:
> Hi,
>
> Thanks for your comments. Indeed the auto-connection(reconnection)
> policy is not enabled in Chrome OS. However, the caching for unpaired
> device is causing registration failures when users try to register for
> the notification after reconnecting to the device which was unpaired
> in the previous connection, and there is no such failure on Mac and
> Android afaIk. Please correct me if I was wrong, but I didn't find any
> logic checking whether the service changed characteristic was
> presented in the previous connection. The problem we are trying to
> solve here is that BlueZ returns operation failed error on registering
> for notification after reconnecting to an unpaired device. And this is
> caused by the caching which should be reset according to the spec.
>
> [Scenario]
> connect to the remote device without pairing
> register for notification
> disconnect from the remote device
> reconnect without pairing
> register for notification  --> operation failure with "Already
> notifying" error message

Well you could just ignore if already notifying, or that still doesn't
notify? That error perhaps is misleading as it doesn't change anything
perhaps we should return no error. Btw, if Im not mistake we do
re-enable the notifications when reconnecting:

bluetoothd[8777]: src/gatt-client.c:register_notify() Re-register
subscribed notification client

< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Write Request (0x12) len 4
        Handle: 0x0011
          Data: 0100

> Other possible workarounds without clearing GATT DB are
> 1) Skip re-register notify in btd_gatt_client_connected() and clear
> chrc->notify_clients and client->all_notify_clients for unpaired
> devices.
> 2) Clear chrc->service->client->all_notify_clients in
> btd_gatt_client_disconnected() for unpaired devices.

See above, I think we can just remove the error of already registered
since we it should already be registered is just a NOP.

> Any comments are appreciated.
>
> Thanks,
> Miao
>
> On Thu, May 25, 2017 at 12:44 AM, Von Dentz, Luiz
> <luiz.von.dentz@intel.com> wrote:
>> Hi,
>>
>> On Thu, May 25, 2017 at 3:10 AM,  <mcchou@chromium.org> wrote:
>>> From: Miao-chen Chou <mcchou@chromium.org>
>>>
>>> This patch adds gatt_db_cleanup() function to clear client-role GATT DB=
 for the
>>> unpaired device. According to Core Specification v4.2 [1] and v5.0 [2],=
 the
>>> attributes should be cleared between unbonded devices after disconnecti=
on, since
>>> the attributes are no long valid.
>>>
>>> [1] Page 525, Section 2.5.2 Attribute Caching, Part G, Volume 3: "For c=
lients
>>> that do not have a trusted relationship with the server, the attribute =
cache is
>>> valid only during the connection."
>>> [2] Page 2227, Section 2.5.2 Attribute Caching, Part G, Volume 3: "For =
clients
>>> that do not have a trusted relationship with the server, the attribute =
cache is
>>> valid only during the connection."
>>
>> This ignores the fact that devices which don't implement service
>> changed characteristic shall not change its database so the discovery
>> may be skipped:
>>
>> BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part C
>> page 2079
>> "If the client had previously determined that the server did not have
>> the =C2=ABService Changed=C2=BB characteristic then service discovery ma=
y be
>> skipped."
>>
>> Also note that we do persist the cache to be able to persist
>> configuration such as notifications and indications, perhaps in chrome
>> you don't really have a use for it but in systems where reconnection
>> is supported, afaik chrome OS doesn't, it is a must have since
>> notifications and indications would not work during the discovery if
>> we remove the cache. And please remember that discovery is a very slow
>> procedure, in most cases it takes a good 3-5 seconds to rediscover,
>> depending on db size it may take over 10 seconds and until it is
>> completed no attribute can be accessed.
>>
>> We could, however, have a config option to select the behavior of the
>> cache or have an option for auto-connect so disabling it also disable
>> caching.
>>
>>> ---
>>>  src/device.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/src/device.c b/src/device.c
>>> index 1b05561e4..f8cde0b43 100644
>>> --- a/src/device.c
>>> +++ b/src/device.c
>>> @@ -267,6 +267,7 @@ struct pending_sdp_query {
>>>
>>>  static int device_browse_gatt(struct btd_device *device, DBusMessage *=
msg);
>>>  static int device_browse_sdp(struct btd_device *device, DBusMessage *m=
sg);
>>> +static void store_gatt_db(struct btd_device *device);
>>>
>>>  static struct pending_sdp_query *pending_sdp_query_new(DBusConnection =
*conn,
>>>                                 DBusMessage *msg, const struct btd_devi=
ce *dev)
>>> @@ -546,6 +547,15 @@ static void browse_request_free(struct browse_req =
*req)
>>>         g_free(req);
>>>  }
>>>
>>> +static void gatt_db_cleanup(struct btd_device* device)
>>> +{
>>> +       if (!device->db)
>>> +               return;
>>> +
>>> +       gatt_db_clear(device->db);
>>> +       store_gatt_db(device);
>>> +}
>>> +
>>>  static void gatt_client_cleanup(struct btd_device *device)
>>>  {
>>>         if (!device->client)
>>> @@ -578,6 +588,9 @@ static void attio_cleanup(struct btd_device *device=
)
>>>                 device->att_io =3D NULL;
>>>         }
>>>
>>> +       if (!device->bredr_state.bonded && !device->le_state.bonded)
>>> +               gatt_db_cleanup(device);
>>> +
>>>         gatt_client_cleanup(device);
>>>         gatt_server_cleanup(device);
>>>
>>> --
>>> 2.13.0.219.gdb65acc882-goog
>>>
