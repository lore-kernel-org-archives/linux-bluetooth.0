Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGXr9JEs_SUNBJhRqDoy90HqAkKs4NyamB4_q=qSNcLzyk8WsA@mail.gmail.com>
References: <CAGXr9JFjURuq0brgMGYYU+r_5XedXm4WgS_B-vKLZiWS4WKbrA@mail.gmail.com>
 <CABBYNZ+yMwgGN4+pv7dyog0P8LyME5zVz=RuD=sqXs6csYQBAQ@mail.gmail.com>
 <CAGXr9JHSmQs-wZenHAVCPqpe+jL8b5awywBQ-XtZtqYSVtmcpQ@mail.gmail.com>
 <CABBYNZ+cGzQcspVM0B3wbimsE5sjZS6t9Kk-TZ_qc324aO1Q2Q@mail.gmail.com>
 <CAGXr9JET_-mB1qtOryXpUMhQPTe_ecw84f4kFH+Wv9_WYp3iog@mail.gmail.com>
 <CAGXr9JGBGVy5P0BiGCer=RO4i9D_8qMabaSP0DufaTk3gx6Ryw@mail.gmail.com>
 <CABBYNZ+v7B6gkUZ-a=3maBUmFu-boOduiSDxvcyaJ=Y-HcktCQ@mail.gmail.com>
 <CABBYNZ+jYduJM-5j0tK7-TN0axQA_qdOfdrM+hZvm4_6raKK1g@mail.gmail.com> <CAGXr9JEs_SUNBJhRqDoy90HqAkKs4NyamB4_q=qSNcLzyk8WsA@mail.gmail.com>
From: Petri Gynther <pgynther@google.com>
Date: Wed, 30 Nov 2016 14:55:03 -0800
Message-ID: <CAGXr9JFiYAo4kgp6WxJ2qyJuhMo-_8hQM4pFQ7xcDwDK0U2CYg@mail.gmail.com>
Subject: Re: BlueZ 5.43: HoG peripheral services re-discovered again and again
 on every reconnect
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Nov 30, 2016 at 2:15 PM, Petri Gynther <pgynther@google.com> wrote:
> Hi Luiz,
>
> On Wed, Nov 30, 2016 at 1:37 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Petri,
>>
>> On Wed, Nov 30, 2016 at 10:36 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Petri,
>>>>
>>>> This primary services re-discovery on every reconnect is actually now
>>>> causing a problem for us.
>>>>
>>>> Basically, this is what happens:
>>>> 1. HoG remote control reconnects to BlueZ host for firmware update check.
>>>> 2. BlueZ starts re-discovering the services of the remote, but doesn't
>>>> yet complete it.
>>>> 3. The remote disconnects after being connected for 2 seconds (no
>>>> firmware update was available, so quickly disconnect to save battery).
>>>> 4. BlueZ declares the HoG remote "bad" since it couldn't complete step
>>>> (2). And then, BlueZ ends up removing the HoG remote services from its
>>>> GATT database completely.
>>>> 5. On the next reconnect attempt, the remote does not work. Re-pairing
>>>> is required.
>>>>
>>>> Obviously, this is bad for user experience. Therefore, I'm asking:
>>>> 1. Is there a way to avoid services re-discovery on every reconnect?
>>>> 2. If the remote control is successfully bonded previously, and BlueZ
>>>> experiences a problem during reconnect (services re-discovery), can we
>>>> avoid destroying the bonding and GATT info on BlueZ side? A failed
>>>> reconnect should not be a reason to remove a bonded device.
>>>
>>> The second point should definitely be fixed, but I wonder how the
>>> firmware update check does actually detects if the host is not doing
>>> something important before it decides it has to save power. Also if I
>>> recall this correctly dfu was exactly why some devices needed the
>>> database check, they boot in dfu mode which has a different database
>>> but they completely lost the state of service changed subscriptions so
>>> basically nothing works since all handles are invalid and even if
>>> service changed would work it would cause a rediscover anyway.
>>
>> Checking the code I did not find anything that could have break the
>> remote services, or perhaps it is the passive scanning/reconnection
>> logic that gets broken if we failed to discover the services?
>>
>> --
>> Luiz Augusto von Dentz
>
> Here is a sample BlueZ log that shows HoG remote reconnect, quick
> disconnect, primary services re-discovery failure, and subsequent
> removal of all GATT services of the remote:
>
> 11/12,060338.676  bluez: bluetoothd[3980]:
> src/gatt-database.c:connect_cb() New incoming LE ATT connection
> 11/12,060338.677  bluez: bluetoothd[3980]:
> src/device.c:device_attach_att() Elevating security level since LTK is
> available
> 11/12,060338.700  bluez: bluetoothd[3980]:
> attrib/gattrib.c:g_attrib_ref() 0x50b138: g_attrib_ref=1
> 11/12,060338.700  bluez: bluetoothd[3980]: src/device.c:attio_connected()
> 11/12,060338.701  bluez: bluetoothd[3980]:
> profiles/input/hog.c:attio_connected_cb() HoG connected
> 11/12,060338.701  bluez: bluetoothd[3980]: src/device.c:attio_connected()
> 11/12,060338.702  bluez: bluetoothd[3980]: src/device.c:attio_connected()
> 11/12,060338.702  bluez: bluetoothd[3980]:
> profiles/battery/battery.c:attio_connected_cb() BATT connected
> 11/12,060338.703  bluez: bluetoothd[3980]: src/device.c:attio_connected()
> 11/12,060338.703  bluez: bluetoothd[3980]:
> profiles/oad/oad.c:oad_attio_connected_cb() OAD connected
> 11/12,060338.704  bluez: bluetoothd[3980]:
> profiles/oad/oad.c:oad_is_time_for_upgrade_check() OAD not time for
> upgrade check yet (15164 seconds left)
> 11/12,060338.704  bluez: bluetoothd[3980]:
> src/gatt-client.c:btd_gatt_client_connected() Device connected.
> 11/12,060343.426  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
> MTU exchange complete, with MTU: 23
> 11/12,060343.476  bluez: bluetoothd[3980]:
> profiles/battery/battery.c:level_read_char_cb() BATT level=78
>
> ==== HoG remote disconnects below; primary services re-discovery was
> still in progress ====
> 11/12,060343.691  bluez: bluetoothd[3980]:
> src/adapter.c:dev_disconnected() Device LEFQAU disconnected, reason 3
> 11/12,060343.692  bluez: bluetoothd[3980]:
> src/adapter.c:dev_disconnected() device 0x522c18 paired 1 bonded 1
> bonding 0
> 11/12,060343.694  bluez: bluetoothd[3980]:
> src/adapter.c:adapter_remove_connection()
> 11/12,060343.694  bluez: bluetoothd[3980]:
> plugins/policy.c:disconnect_cb() reason 3
> 11/12,060343.695  bluez: bluetoothd[3980]:
> src/adapter.c:bonding_attempt_complete() hci0 bdaddr LEFQAU type 1
> status 0xe
> 11/12,060343.695  bluez: bluetoothd[3980]:
> src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> 11/12,060343.696  bluez: bluetoothd[3980]:
> src/device.c:device_bonding_failed() status 14
> 11/12,060343.696  bluez: bluetoothd[3980]: src/adapter.c:resume_discovery()
>
> ==== primary services discovery failure noted below; all GATT services
> of the remote are then removed and become unavailable ====
> 11/12,060343.698  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
> Primary service discovery failed. ATT ECODE: 0x00
> 11/12,060343.698  bluez: bluetoothd[3980]:
> src/device.c:gatt_service_removed() start: 0x0001, end: 0x000b
> 11/12,060343.702  bluez: bluetoothd[3980]:
> src/service.c:change_state() 0x53dd48: device LEFQAU profile
> gap-profile state changed: connecting -> disconnected (-130)
> 11/12,060343.707  bluez: bluetoothd[3980]:
> src/device.c:device_profile_connected() gap-profile Software caused
> connection abort (130)
> 11/12,060343.707  bluez: bluetoothd[3980]:
> src/service.c:change_state() 0x53dd48: device LEFQAU profile
> gap-profile state changed: disconnected -> unavailable (0)
> 11/12,060343.711  bluez: bluetoothd[3980]:
> profiles/gap/gas.c:gap_driver_remove() GAP profile remove (LEFQAU)
> 11/12,060343.712  bluez: bluetoothd[3980]:
> src/service.c:btd_service_unref() 0x53dd48: ref=0
> 11/12,060343.723  bluez: bluetoothd[3980]:
> src/gatt-client.c:btd_gatt_client_service_removed() GATT Services
> Removed - start: 0x0001, end: 0x000b
> 11/12,060343.837  bluez: bluetoothd[3980]:
> src/device.c:gatt_service_removed() start: 0x000c, end: 0x000f
> 11/12,060343.838  bluez: bluetoothd[3980]:
> src/gatt-client.c:btd_gatt_client_service_removed() GATT Services
> Removed - start: 0x000c, end: 0x000f
> 11/12,060343.838  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_service() Removing GATT service:
> /org/bluez/hci0/dev_LEFQAU/service000c
> 11/12,060343.839  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_characteristic() Removing GATT
> characteristic: /org/bluez/hci0/dev_LEFQAU/service000c/char000d
> 11/12,060343.840  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
> /org/bluez/hci0/dev_LEFQAU/service000c/char000d/desc000f
> 11/12,060343.893  bluez: bluetoothd[3980]:
> src/device.c:gatt_service_removed() start: 0x0010, end: 0x0022
> 11/12,060343.894  bluez: bluetoothd[3980]:
> src/service.c:change_state() 0x53dce8: device LEFQAU profile
> deviceinfo state changed: connecting -> disconnected (-130)
> 11/12,060343.895  bluez: bluetoothd[3980]:
> src/device.c:device_profile_connected() deviceinfo Software caused
> connection abort (130)
> 11/12,060343.898  bluez: bluetoothd[3980]:
> src/service.c:change_state() 0x53dce8: device LEFQAU profile
> deviceinfo state changed: disconnected -> unavailable (0)
> 11/12,060343.898  bluez: bluetoothd[3980]:
> src/service.c:btd_service_unref() 0x53dce8: ref=0
> 11/12,060343.902  bluez: bluetoothd[3980]:
> src/gatt-client.c:btd_gatt_client_service_removed() GATT Services
> Removed - start: 0x0010, end: 0x0022
> 11/12,060343.905  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_service() Removing GATT service:
> /org/bluez/hci0/dev_LEFQAU/service0010
> 11/12,060343.906  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_characteristic() Removing GATT
> characteristic: /org/bluez/hci0/dev_LEFQAU/service0010/char0011
> 11/12,060343.910  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_characteristic() Removing GATT
> characteristic: /org/bluez/hci0/dev_LEFQAU/service0010/char0013
> 11/12,060343.914  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_characteristic() Removing GATT
> characteristic: /org/bluez/hci0/dev_LEFQAU/service0010/char0015
> 11/12,060343.920  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_characteristic() Removing GATT
> characteristic: /org/bluez/hci0/dev_LEFQAU/service0010/char0017
> 11/12,060343.922  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_characteristic() Removing GATT
> characteristic: /org/bluez/hci0/dev_LEFQAU/service0010/char0019
> 11/12,060343.926  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_characteristic() Removing GATT
> characteristic: /org/bluez/hci0/dev_LEFQAU/service0010/char001b
> 11/12,060343.940  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_characteristic() Removing GATT
> characteristic: /org/bluez/hci0/dev_LEFQAU/service0010/char001d
> 11/12,060343.941  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_characteris
>
> 11/12,061849.049  bluez: bluetoothd[3980]:
> src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
> Cleaning up.
> 11/12,061849.056  bluez: bluetoothd[3980]:
> attrib/gattrib.c:g_attrib_unref() 0x51c360: g_attrib_unref=0tic()
> Removing GATT characteristic:
> /org/bluez/hci0/dev_LEFQAU/service0010/char001f
> 11/12,060343.942  bluez: bluetoothd[3980]:
> src/gatt-client.c:unregister_characteristic() Removing GATT
> characteristic: /org/bluez/hci0/dev_LEFQAU/service0010/char0021
> 11/12,060344.021  bluez: bluetoothd[3980]:
> src/device.c:gatt_service_removed() start: 0x0023, end: 0x0028
> 11/12,060344.022  bluez: bluetoothd[3980]:
> src/service.c:change_state() 0x53dd80: device LEFQAU profile Battery
> state changed: connecting -> disconnected (-130)
> 11/12,060344.023  bluez: bluetoothd[3980]:
> src/device.c:device_profile_connected() Battery Software caused
> connection abort (130)
> 11/12,060344.025  bluez: bluetoothd[3980]:
> src/service.c:change_state() 0x53dd80: device LEFQAU profile Battery
> state changed: disconnected -> unavailable (0)
> 11/12,060344.033  bluez: bluetoothd[3980]:
> profiles/battery/battery.c:batt_remove() BATT path
> /org/bluez/hci0/dev_LEFQAU
> 11/12,060344.036  bluez: bluetoothd[3980]:
> src/service.c:btd_service_unref() 0x53dd80: ref=0
> 11/12,060344.037  bluez: bluetoothd[3980]:
> src/gatt-client.c:btd_gatt_client_service_removed() GATT Services
> Removed - start: 0x0023, end: 0x0028
> 11/12,060344.046  bluez: bluetoothd[3980]: Error storing included
> service - can't find it
> 11/12,060344.128  bluez: bluetoothd[3980]:
> src/device.c:gatt_service_removed() start: 0x0029, end: 0x002e
> 11/12,060344.129  bluez: bluetoothd[3980]:
> src/service.c:change_state() 0x53dd08: device LEFQAU profile Scan
> Parameters Client Driver state changed: connecting -> disconnected
> (-130)
> 11/12,060344.129  bluez: bluetoothd[3980]:
> src/device.c:device_profile_connected() Scan Parameters Client Driver
> Software caused connection abort (130)
> 11/12,060344.133  bluez: bluetoothd[3980]:
> src/service.c:change_state() 0x53dd08: device LEFQAU profile Scan
> Parameters Client Driver state changed: disconnected -> unavailable
> (0)
> 11/12,060344.141  bluez: bluetoothd[3980]:
> profiles/scanparam/scan.c:scan_param_remove() GAP profile remove
> (LEFQAU)
> 11/12,060344.145  bluez: bluetoothd[3980]:
> src/service.c:btd_service_unref() 0x53dd08: ref=0
> 11/12,060344.226  bluez: bluetoothd[3980]:
> src/service.c:btd_service_unref() 0x53dc38: ref=0
> 11/12,060344.239  bluez: bluetoothd[3980]:
> src/gatt-client.c:btd_gatt_client_service_removed() GATT Services
> Removed - start: 0x002f, end: 0x0037
> 11/12,060344.247  bluez: bluetoothd[3980]: Error storing included
> service - can't find it
> 11/12,060344.291  bluez: bluetoothd[3980]:
> src/device.c:gatt_service_removed() start: 0x0038, end: 0x005c
> 11/12,060344.292  bluez: bluetoothd[3980]:
> src/service.c:change_state() 0x53d3a0: device LEFQAU profile input-hog
> state changed: connecting -> disconnected (-130)
> 11/12,060344.293  bluez: bluetoothd[3980]:
> src/device.c:device_profile_connected() input-hog Software caused
> connection abort (130)
> 11/12,060344.293  bluez: bluetoothd[3980]:
> src/service.c:change_state() 0x53d3a0: device LEFQAU profile input-hog
> state changed: disconnected -> unavailable (0)
> 11/12,060344.296  bluez: bluetoothd[3980]:
> profiles/input/hog.c:hog_remove() path /org/bluez/hci0/dev_LEFQAU
> 11/12,060344.313  bluez: bluetoothd[3980]:
> src/service.c:btd_service_unref() 0x53d3a0: ref=0
> 11/12,060344.313  bluez: bluetoothd[3980]:
> src/gatt-client.c:btd_gatt_client_service_removed() GATT Services
> Removed - start: 0x0038, end: 0x005c
> 11/12,060344.382  bluez: bluetoothd[3980]:
> src/device.c:gatt_service_removed() start: 0x005d, end: 0x0070
> 11/12,060344.383  bluez: bluetoothd[3980]:
> src/gatt-client.c:btd_gatt_client_service_removed() GATT Services
> Removed - start: 0x005d, end: 0x0070
> 11/12,060344.575  bluez: bluetoothd[3980]:
> src/device.c:device_svc_resolved() /org/bluez/hci0/dev_LEFQAU err 0
> 11/12,060344.584  bluez: bluetoothd[3980]: src/device.c:att_disconnected_cb()
> 11/12,060344.591  bluez: bluetoothd[3980]:
> src/device.c:att_disconnected_cb() Connection reset by peer (131)
>
> So, if we can somehow avoid removing the GATT services of the remote
> in this scenario, it would be a big usability win. Next reconnect
> attempt would just work, since the services would be left in
> disconnected state.
>
> -- Petri

Just found a bug in src/shared/gatt-client.c: discover_primary_cb()

        if (!success) {
                util_debug(client->debug_callback, client->debug_data,
                                        "Primary service discovery failed."
                                        " ATT ECODE: 0x%02x", att_ecode);
                /* Reset error in case of not found */
                if (BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
                        success = true;
                        att_ecode = 0;
                }
                goto secondary;
        }

The second if-statement:
if (BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND)

should be:
if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND)

Furthermore, looking at my own failure log:
bluez: bluetoothd[3980]: src/device.c:gatt_debug() Primary service
discovery failed. ATT ECODE: 0x00

Perhaps the if-statement should be:
if (att_ecode == 0 || att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
    success = true;
    att_ecode = 0;
    goto secondary;
} else {
    goto done;
}

Similar adjustment for att_ecode == 0 might be needed for
discover_secondary_cb().
