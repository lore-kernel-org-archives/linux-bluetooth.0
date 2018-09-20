Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Sukesh Srikakula <sukeshs@google.com>
Date: Thu, 20 Sep 2018 14:34:51 -0700
Message-ID: <CAE+ULpAgSuUp-TT-cM5vnBw-bh653KB_WkYP+XViesSn_Hhvpg@mail.gmail.com>
Subject: Gatt: Subscriptions are not cleared after disconnection from a
 temporary device
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Yunhan Wang <yunhanw@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

It seems, you added the functionality to clear subscriptions for a
device which is no longer paired with below patch.
This patch is working fine for the devices which are using public addresses.
But, for private/random addressed devices (which are treated as
temporary devices in bluez code), this code is not getting called,
leaving the subscription state to persist even after disconnection.
This is leading to issues with subsequent connections. Can you please
help fix this issue?

Relevant log snippet from private/random addressed central
disconnecting from peripheral running bluez stack

daemon.debug bluetoothd[6284]:
src/adapter.c:adapter_remove_connection() Removing temporary device
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93
daemon.debug bluetoothd[6284]: src/device.c:device_remove() Removing
device /org/bluez/hci0/dev_4A_46_4F_6E_7B_93
daemon.debug bluetoothd[6284]: src/service.c:change_state() 0x87fda0:
device 4A:46:4F:6E:7B:93 profile gap-profile state changed: connected
-> disconnected (-103)
daemon.debug bluetoothd[6284]: src/service.c:change_state() 0x87fda0:
device 4A:46:4F:6E:7B:93 profile gap-profile state changed:
disconnected -> unavailable (0)
daemon.debug bluetoothd[6284]: profiles/gap/gas.c:gap_remove() GAP
profile remove (4A:46:4F:6E:7B:93)
daemon.debug bluetoothd[6284]: src/service.c:btd_service_unref() 0x87fda0: ref=0
daemon.debug bluetoothd[6284]: src/service.c:change_state() 0x880390:
device 4A:46:4F:6E:7B:93 profile deviceinfo state changed: connected
-> disconnected (-103)
daemon.debug bluetoothd[6284]: src/service.c:change_state() 0x880390:
device 4A:46:4F:6E:7B:93 profile deviceinfo state changed:
disconnected -> unavailable (0)
daemon.debug bluetoothd[6284]: src/service.c:btd_service_unref() 0x880390: ref=0
daemon.debug bluetoothd[6284]: src/device.c:btd_device_unref() Freeing
device /org/bluez/hci0/dev_4A_46_4F_6E_7B_93
daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
Removing GATT service:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0006
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0006/char0007
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0006/char0007/desc0009
daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
Removing GATT service:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000a
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000a/char000b
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000a/char000b/desc000d
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000a/char000b/desc000e
daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
Removing GATT service:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000f
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000f/char0010
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000f/char0010/desc0012
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service000f/char0010/desc0013
daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
Removing GATT service:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0014
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0014/char0015
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0014/char0015/desc0017
daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
Removing GATT service:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0018
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0018/char0019
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0018/char0019/desc001b
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0018/char001c
daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
Removing GATT service:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service001e
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service001e/char001f
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service001e/char0021
daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
Removing GATT service:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char0024
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char0024/desc0026
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char0027
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char0027/desc0029
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char002a
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service0023/char002a/desc002c
daemon.debug bluetoothd[6284]: src/gatt-client.c:unregister_service()
Removing GATT service:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char002e
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char002e/desc0030
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char002e/desc0031
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char0032
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char0032/desc0034
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char0032/desc0035
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_characteristic() Removing GATT
characteristic:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char0036
daemon.debug bluetoothd[6284]:
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor:
/org/bluez/hci0/dev_4A_46_4F_6E_7B_93/service002d/char0036/desc0038
daemon.debug bluetoothd[6284]: attrib/gattrib.c:g_attrib_unref()
0x875a88: g_attrib_unref=0
daemon.debug bluetoothd[6284]: src/device.c:device_free() 0x87c5c8
daemon.debug bluetoothd[6284]: plugins/policy.c:disconnect_cb() reason 3
daemon.debug bluetoothd[6284]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr 4A:46:4F:6E:7B:93
type 2 status 0xe
daemon.debug bluetoothd[6284]: src/adapter.c:resume_discovery()




Relevant log snippet from public addressed central disconnecting from
peripheral running bluez stack

daemon.debug bluetoothd[4047]: src/adapter.c:dev_disconnected() Device
98:01:A7:B1:40:2C disconnected, reason 3
daemon.debug bluetoothd[4047]: src/adapter.c:adapter_remove_connection()
daemon.debug bluetoothd[4047]: plugins/policy.c:disconnect_cb() reason 3
daemon.debug bluetoothd[4047]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr 98:01:A7:B1:40:2C
type 1 status 0xe
daemon.debug bluetoothd[4047]: src/device.c:device_bonding_complete()
bonding (nil) status 0x0e
daemon.debug bluetoothd[4047]: src/device.c:device_bonding_failed() status 14
daemon.debug bluetoothd[4047]: src/adapter.c:resume_discovery()
daemon.debug bluetoothd[4047]: src/gatt-database.c:conf_cb() GATT
server received confirmation
daemon.debug bluetoothd[4047]: src/device.c:att_disconnected_cb()
daemon.debug bluetoothd[4047]: src/device.c:att_disconnected_cb()
Connection reset by peer (104)
daemon.debug bluetoothd[4047]: src/service.c:change_state() 0x9e6978:
device 98:01:A7:B1:40:2C profile gap-profile state changed: connected
-> disconnecting (0)
daemon.debug bluetoothd[4047]: src/service.c:change_state() 0x9e6978:
device 98:01:A7:B1:40:2C profile gap-profile state changed:
disconnecting -> disconnected (0)
daemon.debug bluetoothd[4047]: src/service.c:change_state() 0x9e6d10:
device 98:01:A7:B1:40:2C profile deviceinfo state changed: connected
-> disconnecting (0)
daemon.debug bluetoothd[4047]: src/service.c:change_state() 0x9e6d10:
device 98:01:A7:B1:40:2C profile deviceinfo state changed:
disconnecting -> disconnected (0)
daemon.debug bluetoothd[4047]:
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
Cleaning up.
daemon.debug bluetoothd[4047]: src/device.c:att_disconnected_cb()
Automatic connection disabled
daemon.debug bluetoothd[4047]: attrib/gattrib.c:g_attrib_unref()
0x9de000: g_attrib_unref=0
daemon.debug bluetoothd[4047]: src/gatt-database.c:att_disconnected()
daemon.debug bluetoothd[4047]: src/gatt-database.c:clear_ccc_state()
daemon.debug bluetoothd[4047]: src/gatt-database.c:clear_ccc_state()

Regards,
Sukesh.

> Begin forwarded message:
>
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Subject: [PATCH BlueZ] gatt: Clear subscriptions for device not paired
> Date: October 20, 2017 at 5:21:14 AM PDT
> To: linux-bluetooth@vger.kernel.org
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If the device is no longer valid or is not considered bonded anymore
> clear its CCC states before removing otherwise application may continue
> to notify when there are no devices listening.
> ---
> src/gatt-database.c | 22 +++++++++++++++++++++-
> 1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 47304704a..d6d1e4d13 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -891,6 +891,23 @@ static void conf_cb(void *user_data)
> }
> }
>
> +static void clear_ccc_state(void *data, void *user_data)
> +{
> + struct ccc_state *ccc = data;
> + struct btd_gatt_database *db = user_data;
> + struct ccc_cb_data *ccc_cb;
> +
> + if (!ccc->value[0])
> + return;
> +
> + ccc_cb = queue_find(db->ccc_callbacks, ccc_cb_match_handle,
> + UINT_TO_PTR(ccc->handle));
> + if (!ccc_cb)
> + return;
> +
> + ccc_cb->callback(NULL, 0, ccc_cb->user_data);
> +}
> +
> static void send_notification_to_device(void *data, void *user_data)
> {
> struct device_state *device_state = data;
> @@ -940,8 +957,11 @@ static void send_notification_to_device(void *data,
> void *user_data)
>
> remove:
> /* Remove device state if device no longer exists or is not paired */
> - if (queue_remove(notify->database->device_states, device_state))
> + if (queue_remove(notify->database->device_states, device_state)) {
> + queue_foreach(device_state->ccc_states, clear_ccc_state,
> + notify->database);
> device_state_free(device_state);
> + }
> }
>
> static void send_notification_to_devices(struct btd_gatt_database *database,
> --
> 2.13.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
