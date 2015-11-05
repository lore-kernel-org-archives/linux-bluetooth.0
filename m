Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: BlueZ-5.36 segfault
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <55D4834E.9080705@convergeddevices.net>
 <20150819162319.GA16000@t440s.P-661HNU-F1>
 <55E70CA1.1000308@convergeddevices.net>
 <563A1880.8000608@convergeddevices.net>
 <CABBYNZ+WMvoJxrrt59xx7r0thdLcJgfcBvYWN2_-QzCv+hzaHw@mail.gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: tony <tony.makkiel@convergeddevices.net>
Message-ID: <563B320A.2040300@convergeddevices.net>
Date: Thu, 5 Nov 2015 10:40:10 +0000
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+WMvoJxrrt59xx7r0thdLcJgfcBvYWN2_-QzCv+hzaHw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 05/11/15 09:12, Luiz Augusto von Dentz wrote:
> Hi Tony,
>
> On Wed, Nov 4, 2015 at 4:38 PM, tony <tony.makkiel@convergeddevices.net> wrote:
>> Hello,
>>            I am getting a segfault within BlueZ-5.36.
>>
>> [ 8816.157843] bluetoothd[9264]: segfault at 2000000064 ip 00007fb2da31d216
>> sp 00007ffc65426b48 error 4 in libc-2.19.so[7fb2da1dd000+1bb000].
>>
>> "deviceinfo_init" seems to be the cause of the problem. As 'external' flag
>> is set for "deviceinfo_profile", one of the entry in
>>
>> GSList ext_profiles
>>
>> will be of type 'struct btd_profile'.
>>
>> Unfortunately later when "src/profile.c:register_profile" calls
>> "find_ext_profile", g_strcmp0 tries to access "ext->owner" which does not
>> exist for "deviceinfo" entry.
>
>
> Are you sure it is really crashing in g_strcmp0, it is supposed to
> handle NULL pointers and in fact it was introduced to fix this
> problem. Can you try to provide a backtrace, perhaps something else
> needs fixing.
>
	Yes, that is what I also thought initially. For some reason the pointer 
is not NULL! I made an NULL check for "ext->owner" before it goes to 
'g_strcmp0' and it was not null. I guess it is address of some memory 
not meant for it?

Following is the gdb backtrace.

------------------------------------
(gdb) bt
#0  __strcmp_ssse3 () at ../sysdeps/x86_64/multiarch/../strcmp.S:209
#1  0x00000000004538e8 in find_ext_profile (owner=owner@entry=0x6e16c8 
":1.100",
     path=0x6df154 "/Profile/HSPAGProfile") at src/profile.c:749
#2  0x0000000000455c4e in register_profile (conn=0x6dc930, msg=0x6df060, 
user_data=<optimised out>)
     at src/profile.c:2377
#3  0x0000000000476264 in process_message (connection=0x6dc930, 
message=<optimised out>,
     iface_user_data=<optimised out>, method=<optimised out>, 
method=<optimised out>) at gdbus/object.c:259
#4  0x00007ffff78a8e96 in ?? () from /lib/x86_64-linux-gnu/libdbus-1.so.3
#5  0x00007ffff789ba21 in dbus_connection_dispatch () from 
/lib/x86_64-linux-gnu/libdbus-1.so.3
#6  0x0000000000472ed0 in message_dispatch (data=0x6dc930) at 
gdbus/mainloop.c:72
#7  0x00007ffff7b1ace5 in g_main_context_dispatch () from 
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#8  0x00007ffff7b1b048 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#9  0x00007ffff7b1b30a in g_main_loop_run () from 
/lib/x86_64-linux-gnu/libglib-2.0.so.0
#10 0x000000000040b046 in main (argc=1, argv=0x7fffffffe688) at 
src/main.c:661

---------------------------------------------


Following is the bluetoothd trace


----------------------------------

bluetoothd[6404]: Bluetooth daemon 5.36
bluetoothd[6404]: src/adapter.c:adapter_init() sending read version command
bluetoothd[6404]: Starting SDP server
bluetoothd[6404]: src/sdpd-service.c:register_device_id() Adding device 
id record for 0002:1d6b:0246:0524
bluetoothd[6404]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[6404]: src/plugin.c:add_plugin() Loading hostname plugin
bluetoothd[6404]: src/plugin.c:add_plugin() Loading wiimote plugin
bluetoothd[6404]: src/plugin.c:add_plugin() Loading autopair plugin
bluetoothd[6404]: src/plugin.c:add_plugin() Loading policy plugin
bluetoothd[6404]: src/plugin.c:add_plugin() Loading a2dp plugin
bluetoothd[6404]: src/plugin.c:add_plugin() Loading avrcp plugin
bluetoothd[6404]: src/plugin.c:add_plugin() Loading network plugin
bluetoothd[6404]: src/plugin.c:add_plugin() Loading input plugin
bluetoothd[6404]: src/plugin.c:add_plugin() Loading hog plugin
bluetoothd[6404]: src/plugin.c:add_plugin() Loading gap plugin
bluetoothd[6404]: src/plugin.c:add_plugin() Loading scanparam plugin
bluetoothd[6404]: src/plugin.c:add_plugin() Loading deviceinfo plugin
bluetoothd[6404]: src/plugin.c:plugin_init() Loading plugins 
/usr/lib/bluetooth/plugins
bluetoothd[6404]: profiles/input/suspend-none.c:suspend_init()
bluetoothd[6404]: profiles/network/manager.c:read_config() Config 
options: Security=true
bluetoothd[6404]: plugins/hostname.c:read_dmi_fallback() chassis: laptop
bluetoothd[6404]: plugins/hostname.c:read_dmi_fallback() major: 0x01 
minor: 0x03
bluetoothd[6404]: src/main.c:main() Entering main loop
bluetoothd[6404]: src/rfkill.c:rfkill_event() RFKILL event idx 0 type 2 
op 0 soft 0 hard 0
bluetoothd[6404]: Bluetooth management interface 1.10 initialized
bluetoothd[6404]: src/adapter.c:read_version_complete() sending read 
supported commands command
bluetoothd[6404]: src/adapter.c:read_version_complete() sending read 
index list command
bluetoothd[6404]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type 1 
op 0 soft 0 hard 0
bluetoothd[6404]: src/adapter.c:read_commands_complete() Number of 
commands: 61
bluetoothd[6404]: src/adapter.c:read_commands_complete() Number of 
events: 34
bluetoothd[6404]: src/adapter.c:read_commands_complete() enabling 
kernel-side connection control
bluetoothd[6404]: src/adapter.c:read_index_list_complete() Number of 
controllers: 1
bluetoothd[6404]: src/adapter.c:read_index_list_complete() Found index 0
bluetoothd[6404]: src/adapter.c:index_added() index 0
bluetoothd[6404]: src/adapter.c:btd_adapter_new() System name: BlueZ 5.36
bluetoothd[6404]: src/adapter.c:btd_adapter_new() Major class: 0
bluetoothd[6404]: src/adapter.c:btd_adapter_new() Minor class: 0
bluetoothd[6404]: src/adapter.c:btd_adapter_new() Modalias: 
usb:v1D6Bp0246d0524
bluetoothd[6404]: src/adapter.c:btd_adapter_new() Discoverable timeout: 
180 seconds
bluetoothd[6404]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 
seconds
bluetoothd[6404]: src/adapter.c:index_added() sending read info command 
for index 0
bluetoothd[6404]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[6404]: src/adapter.c:clear_uuids() sending clear uuids 
command for index 0
bluetoothd[6404]: src/adapter.c:clear_devices() sending clear devices 
command for index 0
bluetoothd[6404]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Adding 
record with handle 0x10001
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001800-0000-1000-8000-00805f9
bluetoothd[6404]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[6404]: src/adapter.c:add_uuid() sending add uuid command for 
index 0
bluetoothd[6404]: src/gatt-database.c:gatt_db_service_added() GATT 
Service added to local database
bluetoothd[6404]: Failed to obtain handles for "Service Changed" 
characteristic
bluetoothd[6404]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Adding 
record with handle 0x10002
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001801-0000-1000-8000-00805f9
bluetoothd[6404]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[6404]: src/adapter.c:add_uuid() sending add uuid command for 
index 0
bluetoothd[6404]: src/gatt-database.c:gatt_db_service_added() GATT 
Service added to local database
bluetoothd[6404]: profiles/audio/a2dp.c:media_server_probe() path 
/org/bluez/hci0
bluetoothd[6404]: plugins/hostname.c:hostname_probe()
bluetoothd[6404]: plugins/hostname.c:update_class() major: 0x01 minor: 0x03
bluetoothd[6404]: src/adapter.c:btd_adapter_set_class() class: major 1 
minor 3
bluetoothd[6404]: src/adapter.c:set_dev_class() sending set device class 
command for index 0
bluetoothd[6404]: profiles/network/manager.c:panu_server_probe() path 
/org/bluez/hci0
bluetoothd[6404]: profiles/network/server.c:server_register() Registered 
interface org.bluez.NetworkServer1 on path /org/bluez/hci0
bluetoothd[6404]: profiles/network/manager.c:gn_server_probe() path 
/org/bluez/hci0
bluetoothd[6404]: profiles/network/manager.c:nap_server_probe() path 
/org/bluez/hci0
bluetoothd[6404]: profiles/audio/avrcp.c:avrcp_controller_server_probe() 
path /org/bluez/hci0
bluetoothd[6404]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Adding 
record with handle 0x10003
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110f-0000-1000-8000-00805f9
bluetoothd[6404]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[6404]: src/adapter.c:add_uuid() sending add uuid command for 
index 0
bluetoothd[6404]: profiles/audio/avrcp.c:avrcp_target_server_probe() 
path /org/bluez/hci0
bluetoothd[6404]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Adding 
record with handle 0x10004
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[6404]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[6404]: src/adapter.c:add_uuid() sending add uuid command for 
index 0
bluetoothd[6404]: profiles/audio/a2dp.c:a2dp_sink_server_probe() path 
/org/bluez/hci0
bluetoothd[6404]: profiles/audio/a2dp.c:a2dp_source_server_probe() path 
/org/bluez/hci0
bluetoothd[6404]: src/adapter.c:btd_adapter_unblock_address() hci0 
00:00:00:00:00:00
bluetoothd[6404]: src/adapter.c:get_ltk_info() 00:22:37:20:C2:E7
bluetoothd[6404]: src/device.c:device_create_from_storage() address 
00:22:37:20:C2:E7
bluetoothd[6404]: src/device.c:device_new() address 00:22:37:20:C2:E7
bluetoothd[6404]: src/device.c:device_new() Creating device 
/org/bluez/hci0/dev_00_22_37_20_C2_E7
bluetoothd[6404]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[6404]: src/device.c:device_set_bonded()
bluetoothd[6404]: src/adapter.c:load_link_keys() hci0 keys 1 debug_keys 0
bluetoothd[6404]: src/adapter.c:load_ltks() hci0 keys 0
bluetoothd[6404]: src/adapter.c:load_irks() hci0 irks 0
bluetoothd[6404]: src/adapter.c:load_conn_params() hci0 conn params 0
bluetoothd[6404]: src/device.c:device_probe_profiles() Probing profiles 
for device 00:22:37:20:C2:E7
bluetoothd[6404]: profiles/audio/a2dp.c:a2dp_sink_probe() path 
/org/bluez/hci0/dev_00_22_37_20_C2_E7
bluetoothd[6404]: profiles/audio/sink.c:sink_init() 
/org/bluez/hci0/dev_00_22_37_20_C2_E7
bluetoothd[6404]: src/service.c:btd_service_ref() 0x6e75c0: ref=2
bluetoothd[6404]: src/service.c:change_state() 0x6e75c0: device 
00:22:37:20:C2:E7 profile a2dp-sink state changed: unavailable -> 
disconnected (0)
bluetoothd[6404]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[6404]: src/adapter.c:add_uuid() sending add uuid command for 
index 0
bluetoothd[6404]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b 
product 246 version 524
bluetoothd[6404]: src/adapter.c:adapter_register() Adapter 
/org/bluez/hci0 registered
bluetoothd[6404]: src/adapter.c:set_dev_class() sending set device class 
command for index 0
bluetoothd[6404]: src/adapter.c:set_name() sending set local name 
command for index 0
bluetoothd[6404]: src/adapter.c:add_whitelist_complete() 
00:22:37:20:C2:E7 added to kernel whitelist
bluetoothd[6404]: src/adapter.c:load_link_keys_complete() link keys 
loaded for hci0
bluetoothd[6404]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[6404]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
bluetoothd[6404]: src/adapter.c:load_conn_params_complete() Connection 
Parameters loaded for hci0
bluetoothd[6404]: plugins/hostname.c:property_changed() static hostname: 
Thor
bluetoothd[6404]: plugins/hostname.c:property_changed() pretty hostname:
bluetoothd[6404]: plugins/hostname.c:update_name() name: Thor
bluetoothd[6404]: src/adapter.c:adapter_set_name() name: Thor
bluetoothd[6404]: plugins/hostname.c:property_changed() chassis: laptop
bluetoothd[6404]: plugins/hostname.c:update_class() major: 0x01 minor: 0x03
bluetoothd[6404]: profiles/audio/avdtp.c:avdtp_register_sep() SEP 
0x6e2c00 registered: type:0 codec:0 seid:1
bluetoothd[6404]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Adding 
record with handle 0x10005
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[6404]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[6404]: src/adapter.c:add_uuid() sending add uuid command for 
index 0
bluetoothd[6404]: Endpoint registered: sender=:1.100 
path=/MediaEndpoint/A2DPSource
bluetoothd[6404]: profiles/audio/avdtp.c:avdtp_register_sep() SEP 
0x6e81c0 registered: type:1 codec:0 seid:2
bluetoothd[6404]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Adding 
record with handle 0x10006
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110b-0000-1000-8000-00805f9
bluetoothd[6404]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[6404]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[6404]: src/adapter.c:add_uuid() sending add uuid command for 
index 0
bluetoothd[6404]: Endpoint registered: sender=:1.100 
path=/MediaEndpoint/A2DPSink
bluetoothd[6404]: src/profile.c:register_profile() sender :1.100

-----------------------------------


>>          The problem was gone by removing external flag.
>>
>> --- a/profiles/deviceinfo/deviceinfo.c
>> +++ b/profiles/deviceinfo/deviceinfo.c
>> @@ -142,7 +142,6 @@ static int deviceinfo_driver_accept(struct btd_service
>> *service)
>>   static struct btd_profile deviceinfo_profile = {
>>          .name           = "deviceinfo",
>>          .remote_uuid    = DEVICE_INFORMATION_UUID,
>> -       .external       = true,
>>          .device_probe   = deviceinfo_driver_probe,
>>          .device_remove  = deviceinfo_driver_remove,
>>          .accept         = deviceinfo_driver_accept,
>>
>> Many Thanks,
>> Tony
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
