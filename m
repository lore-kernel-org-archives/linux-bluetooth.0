Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLFi2a8j6qjfNqrFTC-ic_6iH=UNwZ_ri_jOvQ01VtCbw@mail.gmail.com>
References: <20170523195650.29695-1-mcchou@chromium.org> <20170525001054.92520-1-mcchou@chromium.org>
 <CACumGO+-WFY9QQWTJJ8NfZzYdeVskY=7fbpC8K+of_Y49fhGHQ@mail.gmail.com>
 <CAHgsZ+hyvPHdD0X0sp-8DkbG=GbY79_J=_ttpCfbPue_WJ5R9g@mail.gmail.com>
 <CACumGOKBCN9VOK+xetL_b8FxaR3cyPraBgg3QTnYJri6_xNPuw@mail.gmail.com>
 <CAHgsZ+icer9T3rMmof4f_v9W4xMp2oVyF2k9X8y0Nn84Gw0mNg@mail.gmail.com>
 <CAMDKGBXesKCZkdXgLzT_ZKQPL3pN-5KSr_pjtDFuiSD3XwH9vg@mail.gmail.com> <CABBYNZLFi2a8j6qjfNqrFTC-ic_6iH=UNwZ_ri_jOvQ01VtCbw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 31 May 2017 15:04:39 +0300
Message-ID: <CABBYNZJTq-BPakOo3jaX_4_CgcMXZdms1siAfNL2QJTQVLadxA@mail.gmail.com>
Subject: Re: [PATCH v3] device: Clear GATT DB after disconnection for unpaired device
To: =?UTF-8?Q?Giovanni_Ortu=C3=B1o?= <ortuno@chromium.org>
Cc: Miao-chen Chou <mcchou@google.com>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        josephsih@chromium.org, sonnysasaka@chromium.org,
        Rahul Chaturvedi <rkc@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

On Sun, May 28, 2017 at 11:39 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Sun, May 28, 2017 at 7:54 AM, Giovanni Ortu=C3=B1o <ortuno@chromium.or=
g> wrote:
>> On Fri, May 26, 2017 at 11:10 AM, Miao-chen Chou <mcchou@google.com> wro=
te:
>>> Hi Luiz,
>>>
>>> The user space apps follow the procedure defined in the spec to
>>> re-register the notification after re-connection for the unpaired
>>> device. Skipping the error doesn't seem to be a good workaround, since
>>> no notification is wanted unless the user space apps explicitly ask
>>> for it, and there can be other implicit notifications even if we skip
>>> one. Also, the Service Changed Characteristic does not matter in the
>>> case of unpaired devices, and there is no such check in BlueZ
>>> currently as well.
>>>
>>
>> +1
>
> BlueZ only re-register if the application had called StartNotify, and
> by _design_ StartNotify persists across reconnection, if the app do
> StopNotify at any point it would not re-register, so what you are
> describing is either a bug or Chrome OS does not call StopNotify thus
> causing bluetoothd still to believe the app want to re-register
> automatically. So the app has all the control here, the only real
> different is that we don't disable the notification on disconnect
> since StartNotify works on top of CCC and we support multiple clients,
> which should be clear by now.
>
> Btw, I did comment earlier that we could a config option to discard
> cache on disconnect.
>
>>> For other system supporting auto-connect, keeping the caches for
>>> unpaired device after disconnection can also be wrong in practice. For
>>> instance, the local device can connect to a different device which has
>>> the exact same address but with totally different GATT services, and
>>> the caching doesn't help in this case.
>
> That is only possible with random addresses, which afaik we don't
> cache since they are considered temporary the whole object is
> destroyed when disconnected:
>
>
> commit ecf2495781f735a7604df7d5d5b2d8ad5330c480
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Fri Jul 1 17:24:15 2016 +0300
>
>     core/device: Don't persist private devices
>
>     Device which address is private should not be allowed to reset the
>     temporary flag since its settings cannot be stored and the address
>     may never be used again after disconnecting.
>
>>> The first workaround that I mentioned is to prevent re-register
>>> subscribed notification clients and clear them, and the second
>>> workaround is to clear the subscribed notification during
>>> disconnection so that there won't be any clients to be re-registered
>>> for notification upon re-connection.
>
> StartNotify don't work like that, we used to remove the services but
> that caused many problems if the connection is not stable which is
> especially problematic if you have to rediscover the attributes over
> and over again.
>
>>> Thanks,
>>> Miao
>>>
>>> On Fri, May 26, 2017 at 1:42 AM, Von Dentz, Luiz
>>> <luiz.von.dentz@intel.com> wrote:
>>>> Hi Miao,
>>>>
>>>> On Fri, May 26, 2017 at 10:20 AM, Miao-chen Chou <mcchou@google.com> w=
rote:
>>>>> Hi,
>>>>>
>>>>> Thanks for your comments. Indeed the auto-connection(reconnection)
>>>>> policy is not enabled in Chrome OS. However, the caching for unpaired
>>>>> device is causing registration failures when users try to register fo=
r
>>>>> the notification after reconnecting to the device which was unpaired
>>>>> in the previous connection, and there is no such failure on Mac and
>>>>> Android afaIk. Please correct me if I was wrong, but I didn't find an=
y
>>>>> logic checking whether the service changed characteristic was
>>>>> presented in the previous connection. The problem we are trying to
>>>>> solve here is that BlueZ returns operation failed error on registerin=
g
>>>>> for notification after reconnecting to an unpaired device. And this i=
s
>>>>> caused by the caching which should be reset according to the spec.
>>>>>
>>>>> [Scenario]
>>>>> connect to the remote device without pairing
>>>>> register for notification
>>>>> disconnect from the remote device
>>>>> reconnect without pairing
>>>>> register for notification  --> operation failure with "Already
>>>>> notifying" error message
>>>>
>>>> Well you could just ignore if already notifying, or that still doesn't
>>>> notify? That error perhaps is misleading as it doesn't change anything
>>>> perhaps we should return no error. Btw, if Im not mistake we do
>>>> re-enable the notifications when reconnecting:
>>>>
>>>> bluetoothd[8777]: src/gatt-client.c:register_notify() Re-register
>>>> subscribed notification client
>>>>
>>>> < ACL Data TX: Handle 3585 flags 0x00 dlen 9
>>>>       ATT: Write Request (0x12) len 4
>>>>         Handle: 0x0011
>>>>           Data: 0100
>>>>
>>>>> Other possible workarounds without clearing GATT DB are
>>>>> 1) Skip re-register notify in btd_gatt_client_connected() and clear
>>>>> chrc->notify_clients and client->all_notify_clients for unpaired
>>>>> devices.
>>>>> 2) Clear chrc->service->client->all_notify_clients in
>>>>> btd_gatt_client_disconnected() for unpaired devices.
>>>>
>>>> See above, I think we can just remove the error of already registered
>>>> since we it should already be registered is just a NOP.
>>>>
>>>>> Any comments are appreciated.
>>>>>
>>>>> Thanks,
>>>>> Miao
>>>>>
>>>>> On Thu, May 25, 2017 at 12:44 AM, Von Dentz, Luiz
>>>>> <luiz.von.dentz@intel.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Thu, May 25, 2017 at 3:10 AM,  <mcchou@chromium.org> wrote:
>>>>>>> From: Miao-chen Chou <mcchou@chromium.org>
>>>>>>>
>>>>>>> This patch adds gatt_db_cleanup() function to clear client-role GAT=
T DB for the
>>>>>>> unpaired device. According to Core Specification v4.2 [1] and v5.0 =
[2], the
>>>>>>> attributes should be cleared between unbonded devices after disconn=
ection, since
>>>>>>> the attributes are no long valid.
>>>>>>>
>>>>>>> [1] Page 525, Section 2.5.2 Attribute Caching, Part G, Volume 3: "F=
or clients
>>>>>>> that do not have a trusted relationship with the server, the attrib=
ute cache is
>>>>>>> valid only during the connection."
>>>>>>> [2] Page 2227, Section 2.5.2 Attribute Caching, Part G, Volume 3: "=
For clients
>>>>>>> that do not have a trusted relationship with the server, the attrib=
ute cache is
>>>>>>> valid only during the connection."
>>>>>>
>>>>>> This ignores the fact that devices which don't implement service
>>>>>> changed characteristic shall not change its database so the discover=
y
>>>>>> may be skipped:
>>>>>>
>>>>>> BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part C
>>>>>> page 2079
>>>>>> "If the client had previously determined that the server did not hav=
e
>>>>>> the =C2=ABService Changed=C2=BB characteristic then service discover=
y may be
>>>>>> skipped."
>>>>>>
>>
>> I think this spec quote is being taken out of context. That paragraph
>> specifically talks about
>> rebonding and as I understand it does not apply to all devices:
>
> I do believe many OSes, including iOS, do cache service discovery
> persistently if Service Changed is no found:
>
> https://github.com/01org/corelibs-arduino101/issues/96
>
>
>>> If a higher layer determines the bond no longer exists on the server, t=
he client must,
>>> after user interaction to confirm the remote device, re-bond, perform s=
ervice discovery
>>> and re-configure the server. If the client had previously determined th=
at the server did
>>> not have the =C2=ABService Changed=C2=BB characteristic then service di=
scovery may be skipped.
>>
>>
>>>>>> Also note that we do persist the cache to be able to persist
>>>>>> configuration such as notifications and indications, perhaps in chro=
me
>>>>>> you don't really have a use for it but in systems where reconnection
>>>>>> is supported, afaik chrome OS doesn't, it is a must have since
>>>>>> notifications and indications would not work during the discovery if
>>>>>> we remove the cache. And please remember that discovery is a very sl=
ow
>>>>>> procedure, in most cases it takes a good 3-5 seconds to rediscover,
>>>>>> depending on db size it may take over 10 seconds and until it is
>>>>>> completed no attribute can be accessed.
>>>>>>
>>
>> We recognize that rediscovery is an expensive procedure and we do have
>> projects that
>> struggle because of this but as Miao-Chen stated not following the
>> spec is not the right
>> solution. Besides, there are other initiatives inside the Bluetooth SIG =
that
>> would allow caching of the database thus solving this problem across
>> all platforms
>> while still following the spec.
>
> The spec don't say cache cannot be persited, or that you must discard
> the cache completely on disconnect, otherwise we would have a
> qualification test testing this, and no new spec will fix this for
> existing devices although we do intend to take advantage of new
> improvements in this area.
>
> For StartNotify please see above, we might add a config option to
> disable caching for non-bonding devices, other systems might still
> want to do more than just recognize this as a problem.
>
>>>>>> We could, however, have a config option to select the behavior of th=
e
>>>>>> cache or have an option for auto-connect so disabling it also disabl=
e
>>>>>> caching.
>>>>>>
>>>>>>> ---
>>>>>>>  src/device.c | 13 +++++++++++++
>>>>>>>  1 file changed, 13 insertions(+)
>>>>>>>
>>>>>>> diff --git a/src/device.c b/src/device.c
>>>>>>> index 1b05561e4..f8cde0b43 100644
>>>>>>> --- a/src/device.c
>>>>>>> +++ b/src/device.c
>>>>>>> @@ -267,6 +267,7 @@ struct pending_sdp_query {
>>>>>>>
>>>>>>>  static int device_browse_gatt(struct btd_device *device, DBusMessa=
ge *msg);
>>>>>>>  static int device_browse_sdp(struct btd_device *device, DBusMessag=
e *msg);
>>>>>>> +static void store_gatt_db(struct btd_device *device);
>>>>>>>
>>>>>>>  static struct pending_sdp_query *pending_sdp_query_new(DBusConnect=
ion *conn,
>>>>>>>                                 DBusMessage *msg, const struct btd_=
device *dev)
>>>>>>> @@ -546,6 +547,15 @@ static void browse_request_free(struct browse_=
req *req)
>>>>>>>         g_free(req);
>>>>>>>  }
>>>>>>>
>>>>>>> +static void gatt_db_cleanup(struct btd_device* device)
>>>>>>> +{
>>>>>>> +       if (!device->db)
>>>>>>> +               return;
>>>>>>> +
>>>>>>> +       gatt_db_clear(device->db);
>>>>>>> +       store_gatt_db(device);
>>>>>>> +}
>>>>>>> +
>>>>>>>  static void gatt_client_cleanup(struct btd_device *device)
>>>>>>>  {
>>>>>>>         if (!device->client)
>>>>>>> @@ -578,6 +588,9 @@ static void attio_cleanup(struct btd_device *de=
vice)
>>>>>>>                 device->att_io =3D NULL;
>>>>>>>         }
>>>>>>>
>>>>>>> +       if (!device->bredr_state.bonded && !device->le_state.bonded=
)
>>>>>>> +               gatt_db_cleanup(device);
>>>>>>> +
>>>>>>>         gatt_client_cleanup(device);
>>>>>>>         gatt_server_cleanup(device);

Please check the patch I just send adding a config option, that should
do what you did but we retain the possibility to keep the cache always
if the system do want to have quick reconnections.
