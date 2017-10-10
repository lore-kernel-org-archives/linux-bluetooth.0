Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvjcs8ERh1xD6cZQCW2vHUmzJjcBUkzfHwy4+4o3mCKsB5Kcg@mail.gmail.com>
References: <CALvjcs8EHZWsNd+wwcQ_XgdstpgLCpVa-Je-Xuo0PYq=anrtuw@mail.gmail.com>
 <CALvjcs-RSrdJVpqNhU8tcGxO0CPL4OG83L=Mkjb_nFv2EgvBZQ@mail.gmail.com>
 <CABBYNZKiLm5x10Ax37eyP_DYVCtxaTS=4fnOuh8hmEN2=skknQ@mail.gmail.com> <CALvjcs8ERh1xD6cZQCW2vHUmzJjcBUkzfHwy4+4o3mCKsB5Kcg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Oct 2017 13:07:39 +0300
Message-ID: <CABBYNZ+EB6O9xQtjh-Um=Lvkf+M9dciAj0Sn=nMxF+obQsH2_w@mail.gmail.com>
Subject: Re: notification has not yet been cleaned in server side when ble is disconnected.
To: Yunhan Wang <yunhanw@nestlabs.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Tue, Oct 10, 2017 at 11:48 AM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
> Hi=EF=BC=8C Luiz
>
> Here there is no pair operation in our end. Our rough idea is the below.
> 1. ble scan
> 2. ble connect from central to peripheral.
> 3. central app writes data in characteristic A offered by peripheral
> 4. central app subscribes characteristic B offered by peripheral app,
> which is used to receive indication data from peripheral.
>
> I am using 2 btvirt, one is 00:AA:01:00:00:23(peripheral), another is
> 00:AA:01:01:00:24 (central)
>
> For previous reproduced step:
> 1. Assume server has one characteristic A that is subscribed by client
> and sending indication,
> 2. Then ble connection is disconnected by client directly or
> connection disappear without unsubscribing A.
> 3. Client tries to connect to ble successfully
> 4. Client fails to subscribe that characteristic A although ble
> connection is ok.
> 5. Another retry to make Ble connection and subscribe to A can work.
>
> The below logs in bluetoothd are from step 2: ble disconnect seems not
> clean anything related to gatt notification.
>
> src/gatt-database.c:send_notification_to_device() GATT server sending ind=
ication
> src/gatt-database.c:conf_cb() GATT server received confirmation
> src/device.c:gatt_debug() Write Req - handle: 0x003f
> src/gatt-database.c:send_notification_to_device() GATT server sending ind=
ication
> src/gatt-database.c:conf_cb() GATT server received confirmation
> src/service.c:change_state() 0x925b20: device 00:AA:01:00:00:23
> profile gap-profile state changed: connected -> disconnecting (0)
> src/service.c:change_state() 0x925b20: device 00:AA:01:00:00:23
> profile gap-profile state changed: disconnecting -> disconnected (0)
> src/adapter.c:dev_disconnected() Device 00:AA:01:00:00:23 disconnected, r=
eason 2
> src/adapter.c:adapter_remove_connection()
> plugins/policy.c:disconnect_cb() reason 2
> src/adapter.c:bonding_attempt_complete() hci1 bdaddr 00:AA:01:00:00:23
> type 1 status 0xe
> src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> src/device.c:device_bonding_failed() status 14
> src/adapter.c:resume_discovery()
> src/device.c:att_disconnected_cb()
> src/device.c:att_disconnected_cb() Connection reset by peer (104)
> src/service.c:change_state() 0x9103e0: device 00:AA:01:01:00:24
> profile gap-profile state changed: connected -> disconnecting (0)
> src/service.c:change_state() 0x9103e0: device 00:AA:01:01:00:24
> profile gap-profile state changed: disconnecting -> disconnected (0)
> src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
> Cleaning up.
> src/device.c:att_disconnected_cb() Automatic connection disabled
> attrib/gattrib.c:g_attrib_unref() 0x91d190: g_attrib_unref=3D0
> src/adapter.c:dev_disconnected() Device 00:AA:01:01:00:24 disconnected, r=
eason 3
> src/adapter.c:adapter_remove_connection()
> plugins/policy.c:disconnect_cb() reason 3
> src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:AA:01:01:00:24
> type 1 status 0xe
> src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> src/device.c:device_bonding_failed() status 14
> src/device.c:att_disconnected_cb()
> src/device.c:att_disconnected_cb() Connection reset by peer (104)
> src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
> Cleaning up.
> src/device.c:att_disconnected_cb() Automatic connection disabled
> attrib/gattrib.c:g_attrib_unref() 0x925000: g_attrib_unref=3D0
>
> The below logs in bluetoothd are from step 4: Client fails to
> subscribe that characteristic A although ble connection is ok. from
> the log, it seems it is cleaning gatt notification in
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database=
.c#n2005

Looks like we are no cleanup up the subscription no matter if paired
or not which partially explain the problem here.

> src/device.c:gatt_debug() start: 0x0001, end: 0x0005, uuid:
> 00001800-0000-1000-8000-00805f9b34fb
> src/device.c:gatt_debug() start: 0x0006, end: 0x0009, uuid:
> 00001801-0000-1000-8000-00805f9b34fb
> src/device.c:gatt_client_ready_cb() status: success, error: 10
> src/gatt-client.c:create_services() Exporting objects for GATT
> services: 00:AA:01:01:00:24
> src/device.c:device_svc_resolved() /org/bluez/hci0/dev_00_AA_01_01_00_24 =
err 0
> src/device.c:gatt_debug() Read Req - handle: 0x0003
> src/gatt-database.c:gap_device_name_read_cb() GAP Device Name read reques=
t
> profiles/gap/gas.c:read_device_name_cb() GAP Device Name: N0002
> src/device.c:btd_device_device_set_name()
> /org/bluez/hci1/dev_00_AA_01_00_00_23 N0002
> src/device.c:gatt_debug() Write Req - handle: 0x0009
> src/gatt-database.c:gatt_ccc_write_cb() CCC write called for handle: 0x00=
09
> src/device.c:gatt_debug() Registered handler for "Service Changed": 1
> src/device.c:gatt_debug() Read Req - handle: 0x0005
> src/gatt-database.c:gap_appearance_read_cb() GAP Appearance read request
> profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0000
>
> src/device.c:gatt_debug() Write Req - handle: 0x0039
> src/gatt-client.c:notify_client_ref() owner :1.122201
> src/device.c:gatt_debug() Write Req - handle: 0x0037
> src/gatt-database.c:gatt_ccc_write_cb() CCC write called for handle: 0x00=
37
> src/gatt-client.c:notify_client_unref() owner :1.122201
> src/gatt-client.c:notify_client_free() owner :1.122201
> src/device.c:gatt_debug() Write Req - handle: 0x0037
> src/gatt-database.c:gatt_ccc_write_cb() CCC write called for handle: 0x00=
37
> src/gatt-database.c:ccc_write_cb() External CCC write received with
> value: 0x0000

Well this is an unsubscribe value:0x0000 so by itself this is no
wrong, please check with btmon if the remote is not unsubscribing
before subscribing again.

> src/gatt-database.c:pipe_hup() 0x921290 closed
> src/gatt-database.c:proxy_removed_cb() Proxy removed - removing
> service: /org/bluez/xxxx/xxx
> src/gatt-database.c:gatt_db_service_removed() Local GATT service removed
> src/gatt-database.c:send_notification_to_device() GATT server sending ind=
ication
> src/gatt-database.c:client_disconnect_cb() Client disconnected
> src/advertising.c:client_disconnect_cb() Client disconnected
> src/device.c:gatt_debug() Service Changed received - start: 0x0034 end: 0=
x0039
> src/gatt-database.c:conf_cb() GATT server received confirmation
> src/device.c:gatt_debug() Read By Grp Type - start: 0x0034 end: 0x0039
> src/device.c:gatt_debug() Primary service discovery failed. ATT ECODE: 0x=
0a
> src/device.c:gatt_debug() Read By Grp Type - start: 0x0034 end: 0x0039
> src/device.c:gatt_debug() Secondary service discovery failed. ATT ECODE: =
0x0a
> src/device.c:gatt_debug() Read By Type - start: 0x0000 end: 0x0000
> src/device.c:gatt_debug() service disappeared: start 0x0034 end 0x0039
> src/device.c:gatt_service_removed() start: 0x0034, end: 0x0039
>
> Any idea?
>
> Thanks
> Best wishes
> Yunhan
>
> On Tue, Oct 10, 2017 at 1:19 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Yunhan,
>>
>> On Tue, Oct 10, 2017 at 11:02 AM, Yunhan Wang <yunhanw@nestlabs.com> wro=
te:
>>> Hi, Luiz
>>>
>>> Please ignore the previous email.
>>>
>>> I am seeing a bluez gatt notification problem in gatt-database.c
>>>
>>> Here is scenario:
>>>
>>> 1. Assume server has one characteristic A that is subscribed by client
>>> and sending notification,
>>> 2. Then ble connection is disconnected by client directly or
>>> connection disappear without unsubscribing A.
>>> 3. Client tries to connect to ble successfully
>>> 4. Client fails to subscribe that characteristic A although ble
>>> connection is ok.
>>> 5. Another retry to make Ble connection and subscribe to A can work.
>>>
>>> It seems ble disconnect at step 2 only disconnect ble connection and
>>> does not cleanup notify_io and stop
>>> notification in step 3 at code,
>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-databa=
se.c
>>>
>>> It seems retry in step 4 would trigger ccc_write_cb and release
>>> notify_io and stop notification so that step 5 would succeed.
>>> partial log from step 4:
>>> ccc_write_cb() External CCC write received with value: 0x0000
>>> pipe_hup() 0x921290 closed
>>>
>>> Any idea?
>>
>> Do you have the full logs, this might be a bug since perhaps we
>> cleanup the notification itself though if the device is paired the
>> subscription should be persisted.
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
