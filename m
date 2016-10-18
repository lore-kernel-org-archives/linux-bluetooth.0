Return-Path: <jiangbo.wu@intel.com>
Date: Tue, 18 Oct 2016 18:23:38 +0800
From: "Wu,Jiangbo" <jiangbo.wu@intel.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: Johan Hedberg <johan.hedberg@intel.com>, marcel@holtmann.org,
	martin.xu@intel.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add conn type to identify addr type with SMP
 over BR/EDR
Message-ID: <20161018102338.GB25770@wujiangbo-ubuntu>
References: <1476448183-8630-1-git-send-email-jiangbo.wu@intel.com>
 <20161014141938.GA16585@x1c.P-661HNU-F1>
 <20161014164313.GA16931@wujiangbo-ubuntu>
 <1880358.RakREcZFtR@ix>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
In-Reply-To: <1880358.RakREcZFtR@ix>
List-ID: <linux-bluetooth.vger.kernel.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Oct 17, 2016 at 11:05:33PM +0200, Szymon Janc wrote:
> Hi,
> 
> On Saturday, 15 October 2016 00:43:13 CEST wujiangbo wrote:
> > On Fri, Oct 14, 2016 at 05:19:38PM +0300, Johan Hedberg wrote:
> > > Hi Jiangbo,
> > > 
> > > Please don't top-post on this list.
> > > 
> > > On Fri, Oct 14, 2016, Wu, Jiangbo wrote:
> > > > If pair a device that unpair firstly that remove encryption key,
> > > > encryption key event will be emitted. kernel will receive
> > > > 'L2CAP_CID_SMP_BREDR' frame, and then it will use SMP to distribute
> > > > key.  SMP would like to use LTK, IRK and CRSK to notify user. If it
> > > > don't identify device by which conn type they are, only marks LE as
> > > > the device type,
> > > 
> > > Why would that happen? Before SMP over BR/EDR happens pairing would have
> > > happened over BR/EDR, so bluetoothd should know that BR/EDR is supported
> > > as well (it would even be aware of an existing BR/EDR connection). Are
> > > you perhaps trying to work around some bluetoothd bug with all this?
> > 
> > I use upstream bluez source code without change.
> > 
> > Yes, bluetoothd scan will find device type is BR/EDR or LE. As my case,
> > device is BR/EDR. But if kernel report CRSK notify, bluetoothd will change
> > the device type to LE. The code you can see:
> > 	new_csrk_callback -> btd_adapter_get_device -> btd_adapter_find_device
> > 		if (bdaddr_type == BDADDR_BREDR)
> > 			device_set_bredr_support(device);
> > 		else
> > 			device_set_le_support(device, bdaddr_type);
> > As Marcel mentioned before, LTK, IRK and CRSK are only valid for LE link.
> > So the rootcause is why remote start to pair a BR/EDR device, the kernel
> > will receive CRSK event.
> > 
> > This is the first pair, and it will pair success even if receive CRSK
> > notify. And the second and the next all pair will be failed with remote
> > device unpair and then pair again.
> > 
> > > > while Bluetoothd will use this 'addr' and 'addr type' to reply the
> > > > comfirm to kernel.
> > > 
> > > What reply are you talking about? There's no user interaction involved
> > > with SMP over BR/EDR - that would already have occurred when SSP over
> > > BR/EDR happened.
> > 
> > Sorry to confuse the case, the pairing failed coming with next pair
> > procedure. Because at the last pair with CRSK notify, device type will be
> > changed to LE, following is the failed scenario after last success with
> > CRSK notify. Remote unpair and pair again.
> > 
> > This reply is SPP, user confirm passkey reply. When pairing proceduce, User
> > confirm the pairing request through bluetoothd, that will send mgmt op
> > 'MGMT_OP_USER_CONFIRM_REPLY' with device address and device type in
> > mgmt_cp_user_confirm_reply. Kernel use the device address and type to lookup
> > hci conn. Unfortunately, it will lookup hci_conn from LE hashtable, that
> > don't include hci conn. So spp reply couldn't send to remote, caused pair
> > failed.
> > > > At the same time kernel always uses them to lookup hci_conn in LE
> > > > hashtable firstly, because addr type always marks as LE. Obviously it
> > > > will failed with SMP over BR/EDR.
> > > 
> > > I don't follow this either since there shouldn't have been any "reply"
> > > from user space for SMP over BR/EDR. All there should be are events from
> > > the kernel for the generated LE keys.
> > > 
> > > > Actually, SPM is only for LE in SPEC,
> > > 
> > > That's not true. SMP is specified both for LE-U and ACL-U.
> > > 
> > > > but kernel already support and use SMP over BR/EDR. if BR/EDR
> > > > exchanges key with SMP, it will never reply pairing response to
> > > > remote, in other words it will be never paired, that is happened in
> > > > our products.
> > > 
> > > Szymon recently implemented SMP over BR/EDR for Zephyr and used
> > > Linux/BlueZ as a reference for testing. He didn't report any issues like
> > > this. It might help if you could provide some logs (particularly
> > > HCI/btmon but also from bluetoothd) to understand what's the actual
> > > issue you're seeing.
> > > 
> > > Johan
> > 
> > Sorry to confuse this issue, the log is not in my hand right now,
> > so it maybe later.
> 
> So I was able to reproduce this issue. This is bluetoothd bug and not kernel 
> one. This bug is no specific to cross-transport pairing. It can happen with 
> any dual-mode device that is doing BR/EDR pairing while being known as dual 
> mode by bluetoothd when agent replies with passkey or confirmation.
> 
> To fix this we probably need to hold extra information in
> 'struct authentication_req' in device.c about type of pairing (LE or BR/EDR). 
> This is not a one-liner-fix so I don't have a patch ready yet.
>

Totally agree with you about dual-mode device pairing known as dual mode. But i
want to known is that reasonable about device is to do BR/EDR pairing will
generate CRSK notify? I'm very intersting about this fixing, this bug is hight
priority in our product. In my opinion hold extra informatin in
'struct authentication_req' may not fix this bug. Because if CRSK event is still
report, then bluetoothd will change the device type to LE even if we pair device
that is scaned with BR/EDR. So i think the rootcase is find does CRSK event make
sense in BR/EDR pairing, and how to handle CRSK events in BR/EDR pairing if it
make sense. I'm confuse with those.

I noticed that if quikly reply the passkey confirm, this bug always be reproduced,
but if wait for 2~3s to reply the passkey confirm, it works well every time.
In terms of code, wait for 2~3s will cause l2cap chan timeout for info timer that
created by HCI_EV_REMOTE_EXT_FEATURES event, and timeout will change l2cap chan
to BT_CONNECTED. So next SMP resume/ready don't distribute key also CRSK events.

It can't reproduce with btmgmt, because it reply passkey confirm always only use
BR/EDR in 'struct mgmt_cp_user_confirm_reply' not use device relation type.

bluetoothd.log and btmon.log are attached. It records two pair request sequence,
one is pair success that have CRSK event, another is next pair reqeust don't
success any, hope those maybe help you to annlyze this bug.

Thanks
Jiangbo

> -- 
> pozdrawiam
> Szymon Janc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bluetoothd.log"

bluetoothd[3713]: Bluetooth daemon 5.41
bluetoothd[3713]: src/main.c:parse_config() parsing main.conf
bluetoothd[3713]: src/main.c:parse_config() Key file does not have key 'DiscoverableTimeout'
bluetoothd[3713]: src/main.c:parse_config() Key file does not have key 'PairableTimeout'
bluetoothd[3713]: src/main.c:parse_config() Key file does not have key 'AutoConnectTimeout'
bluetoothd[3713]: src/main.c:parse_config() Key file does not have key 'Name'
bluetoothd[3713]: src/main.c:parse_config() Key file does not have key 'Class'
bluetoothd[3713]: src/main.c:parse_config() Key file does not have key 'DeviceID'
bluetoothd[3713]: src/main.c:parse_config() Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[3713]: src/adapter.c:adapter_init() sending read version command
bluetoothd[3713]: Starting SDP server
bluetoothd[3713]: src/sdpd-service.c:register_device_id() Adding device id record for 0002:1d6b:0246:0529
bluetoothd[3713]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[3713]: src/plugin.c:add_plugin() Loading hostname plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading wiimote plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading autopair plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading policy plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading gatt_example plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading neard plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading sap plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading a2dp plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading avrcp plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading network plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading input plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading hog plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading health plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading gap plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading scanparam plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading deviceinfo plugin
bluetoothd[3713]: src/plugin.c:add_plugin() Loading service plugin
bluetoothd[3713]: src/plugin.c:plugin_init() Loading plugins /usr/lib/bluez/plugins
bluetoothd[3713]: plugins/service.c:service_init() 
bluetoothd[3713]: profiles/health/hdp.c:hdp_manager_start() Starting Health manager
bluetoothd[3713]: profiles/input/suspend-none.c:suspend_init() 
bluetoothd[3713]: profiles/network/manager.c:read_config() Config options: Security=true
bluetoothd[3713]: plugins/neard.c:neard_init() Setup neard plugin
bluetoothd[3713]: plugins/hostname.c:read_dmi_fallback() chassis: laptop
bluetoothd[3713]: plugins/hostname.c:read_dmi_fallback() major: 0x01 minor: 0x03
bluetoothd[3713]: src/main.c:main() Entering main loop
bluetoothd[3713]: src/rfkill.c:rfkill_event() RFKILL event idx 0 type 2 op 0 soft 0 hard 0
bluetoothd[3713]: Bluetooth management interface 1.10 initialized
bluetoothd[3713]: src/adapter.c:read_version_complete() sending read supported commands command
bluetoothd[3713]: src/adapter.c:read_version_complete() sending read index list command
bluetoothd[3713]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type 1 op 0 soft 0 hard 0
bluetoothd[3713]: src/adapter.c:read_commands_complete() Number of commands: 61
bluetoothd[3713]: src/adapter.c:read_commands_complete() Number of events: 34
bluetoothd[3713]: src/adapter.c:read_commands_complete() enabling kernel-side connection control
bluetoothd[3713]: src/adapter.c:read_index_list_complete() Number of controllers: 1
bluetoothd[3713]: src/adapter.c:read_index_list_complete() Found index 0
bluetoothd[3713]: src/adapter.c:index_added() index 0
bluetoothd[3713]: src/adapter.c:btd_adapter_new() System name: Peacock
bluetoothd[3713]: src/adapter.c:btd_adapter_new() Major class: 0
bluetoothd[3713]: src/adapter.c:btd_adapter_new() Minor class: 0
bluetoothd[3713]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d0529
bluetoothd[3713]: src/adapter.c:btd_adapter_new() Discoverable timeout: 180 seconds
bluetoothd[3713]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 seconds
bluetoothd[3713]: src/adapter.c:index_added() sending read info command for index 0
bluetoothd[3713]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[3713]: src/adapter.c:clear_uuids() sending clear uuids command for index 0
bluetoothd[3713]: src/adapter.c:clear_devices() sending clear devices command for index 0
bluetoothd[3713]: src/gatt-database.c:btd_gatt_database_new() GATT Manager registered for adapter: /org/bluez/hci0
bluetoothd[3713]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001800-0000-1000-8000-00805f9
bluetoothd[3713]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[3713]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[3713]: src/gatt-database.c:gatt_db_service_added() GATT Service added to local database
bluetoothd[3713]: Failed to obtain handles for "Service Changed" characteristic
bluetoothd[3713]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001801-0000-1000-8000-00805f9
bluetoothd[3713]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[3713]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[3713]: src/gatt-database.c:gatt_db_service_added() GATT Service added to local database
bluetoothd[3713]: profiles/audio/a2dp.c:media_server_probe() path /org/bluez/hci0
bluetoothd[3713]: plugins/hostname.c:hostname_probe() 
bluetoothd[3713]: plugins/hostname.c:update_class() major: 0x01 minor: 0x03
bluetoothd[3713]: src/adapter.c:btd_adapter_set_class() class: major 1 minor 3
bluetoothd[3713]: src/adapter.c:set_dev_class() sending set device class command for index 0
bluetoothd[3713]: Not enough free handles to register service
bluetoothd[3713]: plugins/gatt-example.c:gatt_example_adapter_probe() Battery service could not be registered
bluetoothd[3713]: gatt-example-adapter-driver: Input/output error (5)
bluetoothd[3713]: profiles/network/manager.c:panu_server_probe() path /org/bluez/hci0
bluetoothd[3713]: profiles/network/server.c:server_register() Registered interface org.bluez.NetworkServer1 on path /org/bluez/hci0
bluetoothd[3713]: profiles/network/manager.c:gn_server_probe() path /org/bluez/hci0
bluetoothd[3713]: profiles/network/manager.c:nap_server_probe() path /org/bluez/hci0
bluetoothd[3713]: profiles/audio/avrcp.c:avrcp_controller_server_probe() path /org/bluez/hci0
bluetoothd[3713]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10003
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110f-0000-1000-8000-00805f9
bluetoothd[3713]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[3713]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[3713]: profiles/audio/avrcp.c:avrcp_target_server_probe() path /org/bluez/hci0
bluetoothd[3713]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[3713]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3713]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[3713]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[3713]: profiles/audio/a2dp.c:a2dp_sink_server_probe() path /org/bluez/hci0
bluetoothd[3713]: profiles/audio/a2dp.c:a2dp_source_server_probe() path /org/bluez/hci0
bluetoothd[3713]: profiles/sap/manager.c:sap_server_probe() path /org/bluez/hci0
bluetoothd[3713]: Sap driver initialization failed.
bluetoothd[3713]: sap-server: Operation not permitted (1)
bluetoothd[3713]: src/adapter.c:btd_adapter_unblock_address() hci0 00:00:00:00:00:00
bluetoothd[3713]: src/adapter.c:get_ltk_info() A0:C5:89:04:C2:29
bluetoothd[3713]: src/device.c:device_create_from_storage() address A0:C5:89:04:C2:29
bluetoothd[3713]: src/device.c:device_new() address A0:C5:89:04:C2:29
bluetoothd[3713]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_A0_C5_89_04_C2_29
bluetoothd[3713]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[3713]: src/device.c:device_set_bonded() 
bluetoothd[3713]: src/adapter.c:get_ltk_info() 30:F3:1D:37:0B:69
bluetoothd[3713]: src/device.c:device_create_from_storage() address 30:F3:1D:37:0B:69
bluetoothd[3713]: src/device.c:device_new() address 30:F3:1D:37:0B:69
bluetoothd[3713]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_30_F3_1D_37_0B_69
bluetoothd[3713]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[3713]: src/device.c:device_set_bonded() 
bluetoothd[3713]: src/adapter.c:get_ltk_info() A0:C5:89:04:C7:51
bluetoothd[3713]: src/device.c:device_create_from_storage() address A0:C5:89:04:C7:51
bluetoothd[3713]: src/device.c:device_new() address A0:C5:89:04:C7:51
bluetoothd[3713]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_A0_C5_89_04_C7_51
bluetoothd[3713]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[3713]: src/device.c:device_set_bonded() 
bluetoothd[3713]: src/device.c:device_set_bonded() 
bluetoothd[3713]: src/adapter.c:load_link_keys() hci0 keys 3 debug_keys 0
bluetoothd[3713]: src/adapter.c:load_ltks() hci0 keys 1
bluetoothd[3713]: src/adapter.c:load_irks() hci0 irks 0
bluetoothd[3713]: src/adapter.c:load_conn_params() hci0 conn params 0
bluetoothd[3713]: src/device.c:device_probe_profiles() Probing profiles for device A0:C5:89:04:C2:29
bluetoothd[3713]: src/device.c:device_probe_profiles() Probing profiles for device 30:F3:1D:37:0B:69
bluetoothd[3713]: profiles/gap/gas.c:gap_driver_probe() GAP profile probe (30:F3:1D:37:0B:69)
bluetoothd[3713]: src/service.c:change_state() 0x83ffd88: device 30:F3:1D:37:0B:69 profile gap-profile state changed: unavailable -> disconnected (0)
bluetoothd[3713]: plugins/service.c:service_get_data() /org/bluez/hci0/dev_30_F3_1D_37_0B_69/00001800_0000_1000_8000_00805f9b34fb
bluetoothd[3713]: profiles/network/connection.c:connection_register() /org/bluez/hci0/dev_30_F3_1D_37_0B_69 id 4373
bluetoothd[3713]: profiles/network/connection.c:create_peer() Registered interface org.bluez.Network1 on path /org/bluez/hci0/dev_30_F3_1D_37_0B_69
bluetoothd[3713]: src/service.c:btd_service_ref() 0x83fff48: ref=2
bluetoothd[3713]: profiles/network/connection.c:connection_register() id 4373 registered
bluetoothd[3713]: src/service.c:change_state() 0x83fff48: device 30:F3:1D:37:0B:69 profile network-panu state changed: unavailable -> disconnected (0)
bluetoothd[3713]: plugins/service.c:service_get_data() /org/bluez/hci0/dev_30_F3_1D_37_0B_69/00001115_0000_1000_8000_00805f9b34fb
bluetoothd[3713]: profiles/network/connection.c:connection_register() /org/bluez/hci0/dev_30_F3_1D_37_0B_69 id 4374
bluetoothd[3713]: src/service.c:btd_service_ref() 0x83fdcb8: ref=2
bluetoothd[3713]: profiles/network/connection.c:connection_register() id 4374 registered
bluetoothd[3713]: src/service.c:change_state() 0x83fdcb8: device 30:F3:1D:37:0B:69 profile network-nap state changed: unavailable -> disconnected (0)
bluetoothd[3713]: plugins/service.c:service_get_data() /org/bluez/hci0/dev_30_F3_1D_37_0B_69/00001116_0000_1000_8000_00805f9b34fb
bluetoothd[3713]: profiles/audio/avrcp.c:avrcp_target_probe() path /org/bluez/hci0/dev_30_F3_1D_37_0B_69
bluetoothd[3713]: profiles/audio/control.c:control_init() Registered interface org.bluez.MediaControl1 on path /org/bluez/hci0/dev_30_F3_1D_37_0B_69
bluetoothd[3713]: src/service.c:btd_service_ref() 0x83ff5b0: ref=2
bluetoothd[3713]: src/service.c:change_state() 0x83ff5b0: device 30:F3:1D:37:0B:69 profile audio-avrcp-target state changed: unavailable -> disconnected (0)
bluetoothd[3713]: plugins/service.c:service_get_data() /org/bluez/hci0/dev_30_F3_1D_37_0B_69/0000110c_0000_1000_8000_00805f9b34fb
bluetoothd[3713]: profiles/audio/a2dp.c:a2dp_source_probe() path /org/bluez/hci0/dev_30_F3_1D_37_0B_69
bluetoothd[3713]: profiles/audio/source.c:source_init() /org/bluez/hci0/dev_30_F3_1D_37_0B_69
bluetoothd[3713]: src/service.c:btd_service_ref() 0x83f6000: ref=2
bluetoothd[3713]: src/service.c:change_state() 0x83f6000: device 30:F3:1D:37:0B:69 profile a2dp-source state changed: unavailable -> disconnected (0)
bluetoothd[3713]: plugins/service.c:service_get_data() /org/bluez/hci0/dev_30_F3_1D_37_0B_69/0000110a_0000_1000_8000_00805f9b34fb
bluetoothd[3713]: src/device.c:device_probe_profiles() Probing profiles for device A0:C5:89:04:C7:51
bluetoothd[3713]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[3713]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[3713]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b product 246 version 529
bluetoothd[3713]: src/adapter.c:adapter_register() Adapter /org/bluez/hci0 registered
bluetoothd[3713]: src/adapter.c:set_dev_class() sending set device class command for index 0
bluetoothd[3713]: src/adapter.c:set_name() sending set local name command for index 0
bluetoothd[3713]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[3713]: src/adapter.c:set_discoverable() sending set mode command for index 0
bluetoothd[3713]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[3713]: src/adapter.c:add_whitelist_complete() A0:C5:89:04:C2:29 added to kernel whitelist
bluetoothd[3713]: src/adapter.c:add_whitelist_complete() 30:F3:1D:37:0B:69 added to kernel whitelist
bluetoothd[3713]: src/adapter.c:add_whitelist_complete() A0:C5:89:04:C7:51 added to kernel whitelist
bluetoothd[3713]: src/adapter.c:load_link_keys_complete() link keys loaded for hci0
bluetoothd[3713]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[3713]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
bluetoothd[3713]: src/adapter.c:load_conn_params_complete() Connection Parameters loaded for hci0
bluetoothd[3713]: src/adapter.c:new_settings_callback() Settings: 0x00000ad0
bluetoothd[3713]: src/adapter.c:settings_changed() Changed settings: 0x0000000a
bluetoothd[3713]: src/adapter.c:new_settings_callback() Settings: 0x00000ad2
bluetoothd[3713]: src/adapter.c:settings_changed() Changed settings: 0x00000002
bluetoothd[3713]: src/adapter.c:new_settings_callback() Settings: 0x00000ada
bluetoothd[3713]: src/adapter.c:settings_changed() Changed settings: 0x00000008
bluetoothd[3713]: src/agent.c:agent_ref() 0x83d03b8: ref=1
bluetoothd[3713]: src/agent.c:register_agent() agent :1.484
bluetoothd[3713]: src/agent.c:add_default_agent() Default agent set to :1.484 /org/bluez/agent
bluetoothd[3713]: src/agent.c:agent_disconnect() Agent :1.484 disconnected
bluetoothd[3713]: src/agent.c:remove_default_agent() Default agent cleared
bluetoothd[3713]: src/agent.c:agent_destroy() agent :1.484
bluetoothd[3713]: src/agent.c:agent_unref() 0x83d03b8: ref=0
bluetoothd[3713]: src/agent.c:agent_ref() 0x83f3c50: ref=1
bluetoothd[3713]: src/agent.c:register_agent() agent :1.2949
bluetoothd[3713]: src/agent.c:add_default_agent() Default agent set to :1.2949 /org/bluez/agent
bluetoothd[3713]: src/adapter.c:property_set_mode() sending Set Powered command for index 0
bluetoothd[3713]: src/adapter.c:dev_class_changed_callback() Class: 0x00010c
bluetoothd[3713]: src/adapter.c:property_set_mode_complete() Success (0x00)
bluetoothd[3713]: src/adapter.c:new_settings_callback() Settings: 0x00000adb
bluetoothd[3713]: src/adapter.c:settings_changed() Changed settings: 0x00000001
bluetoothd[3713]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
bluetoothd[3713]: src/adapter.c:trigger_passive_scanning() 
bluetoothd[3713]: src/adapter.c:set_discovery_filter() sender :1.2949
bluetoothd[3713]: src/adapter.c:parse_discovery_filter_dict() filtered discovery params: transport: 1 rssi: 32767 pathloss: 32767
bluetoothd[3713]: src/adapter.c:set_discovery_filter() successfully pre-set filter
bluetoothd[3713]: src/adapter.c:start_discovery() sender :1.2949
bluetoothd[3713]: src/adapter.c:update_discovery_filter() 
bluetoothd[3713]: src/adapter.c:discovery_filter_to_mgmt_cp() 
bluetoothd[3713]: src/adapter.c:trigger_start_discovery() 
bluetoothd[3713]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[3713]: src/adapter.c:start_discovery_timeout() 
bluetoothd[3713]: src/adapter.c:start_discovery_timeout() adapter->current_discovery_filter == 1
bluetoothd[3713]: src/adapter.c:start_discovery_timeout() sending MGMT_OP_START_SERVICE_DISCOVERY 127, 1, 0
bluetoothd[3713]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[3713]: src/adapter.c:discovering_callback() hci0 type 1 discovering 1 method 1
bluetoothd[3713]: src/adapter.c:device_found_callback() hci0 addr 00:1A:7D:DA:71:13, rssi -42 flags 0x0000 eir_len 46
bluetoothd[3713]: src/device.c:device_create() dst 00:1A:7D:DA:71:13
bluetoothd[3713]: src/device.c:device_new() address 00:1A:7D:DA:71:13
bluetoothd[3713]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_00_1A_7D_DA_71_13
bluetoothd[3713]: src/device.c:device_set_legacy() legacy 0
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi -42
bluetoothd[3713]: src/device.c:device_set_tx_power() tx_power 4
bluetoothd[3713]: src/device.c:device_set_class() /org/bluez/hci0/dev_00_1A_7D_DA_71_13 0x000100
bluetoothd[3713]: src/adapter.c:device_found_callback() hci0 addr E8:2A:EA:7F:71:18, rssi -86 flags 0x0001 eir_len 5
bluetoothd[3713]: src/device.c:device_create() dst E8:2A:EA:7F:71:18
bluetoothd[3713]: src/device.c:device_new() address E8:2A:EA:7F:71:18
bluetoothd[3713]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_E8_2A_EA_7F_71_18
bluetoothd[3713]: src/device.c:device_set_legacy() legacy 0
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi -86
bluetoothd[3713]: src/device.c:device_set_class() /org/bluez/hci0/dev_E8_2A_EA_7F_71_18 0x3A010C
bluetoothd[3713]: src/adapter.c:confirm_name() hci0 bdaddr E8:2A:EA:7F:71:18 name_known 1
bluetoothd[3713]: src/adapter.c:confirm_name_complete() Confirm name complete for hci0
bluetoothd[3713]: src/adapter.c:device_found_callback() hci0 addr 44:85:00:61:A1:3D, rssi -94 flags 0x0000 eir_len 24
bluetoothd[3713]: src/device.c:device_create() dst 44:85:00:61:A1:3D
bluetoothd[3713]: src/device.c:device_new() address 44:85:00:61:A1:3D
bluetoothd[3713]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_44_85_00_61_A1_3D
bluetoothd[3713]: src/device.c:device_set_legacy() legacy 0
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi -94
bluetoothd[3713]: src/device.c:device_set_tx_power() tx_power 7
bluetoothd[3713]: src/device.c:device_set_class() /org/bluez/hci0/dev_44_85_00_61_A1_3D 0x02010C
bluetoothd[3713]: src/adapter.c:device_found_callback() hci0 addr E8:2A:EA:7F:71:18, rssi -85 flags 0x0000 eir_len 20
bluetoothd[3713]: src/device.c:device_set_legacy() legacy 0
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi -85 delta 1
bluetoothd[3713]: src/device.c:device_set_tx_power() tx_power 10
bluetoothd[3713]: src/adapter.c:device_found_callback() hci0 addr 7C:7A:91:88:A6:25, rssi -74 flags 0x0000 eir_len 23
bluetoothd[3713]: src/device.c:device_create() dst 7C:7A:91:88:A6:25
bluetoothd[3713]: src/device.c:device_new() address 7C:7A:91:88:A6:25
bluetoothd[3713]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_7C_7A_91_88_A6_25
bluetoothd[3713]: src/device.c:device_set_legacy() legacy 0
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi -74
bluetoothd[3713]: src/device.c:device_set_tx_power() tx_power 10
bluetoothd[3713]: src/device.c:device_set_class() /org/bluez/hci0/dev_7C_7A_91_88_A6_25 0x12010C
bluetoothd[3713]: src/adapter.c:device_found_callback() hci0 addr 68:3E:34:6A:83:4B, rssi -81 flags 0x0000 eir_len 61
bluetoothd[3713]: src/device.c:device_create() dst 68:3E:34:6A:83:4B
bluetoothd[3713]: src/device.c:device_new() address 68:3E:34:6A:83:4B
bluetoothd[3713]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_68_3E_34_6A_83_4B
bluetoothd[3713]: src/device.c:device_set_legacy() legacy 0
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi -81
bluetoothd[3713]: src/device.c:device_set_class() /org/bluez/hci0/dev_68_3E_34_6A_83_4B 0x5A020C
bluetoothd[3713]: src/adapter.c:device_found_callback() hci0 addr 68:3E:34:6D:F7:B6, rssi -94 flags 0x0000 eir_len 43
bluetoothd[3713]: src/device.c:device_create() dst 68:3E:34:6D:F7:B6
bluetoothd[3713]: src/device.c:device_new() address 68:3E:34:6D:F7:B6
bluetoothd[3713]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_68_3E_34_6D_F7_B6
bluetoothd[3713]: src/device.c:device_set_legacy() legacy 0
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi -94
bluetoothd[3713]: src/device.c:device_set_class() /org/bluez/hci0/dev_68_3E_34_6D_F7_B6 0x5A020C
bluetoothd[3713]: src/adapter.c:stop_discovery() sender :1.2949
bluetoothd[3713]: src/adapter.c:discovery_destroy() owner :1.2949
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[3713]: src/device.c:device_set_tx_power() tx_power 127
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[3713]: src/device.c:device_set_tx_power() tx_power 127
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[3713]: src/device.c:device_set_tx_power() tx_power 127
bluetoothd[3713]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[3713]: src/device.c:device_set_tx_power() tx_power 127
bluetoothd[3713]: src/adapter.c:discovering_callback() hci0 type 1 discovering 0 method 1
bluetoothd[3713]: src/adapter.c:trigger_passive_scanning() 
bluetoothd[3713]: src/adapter.c:stop_discovery_complete() status 0x00
bluetoothd[3713]: src/adapter.c:trigger_passive_scanning() 
bluetoothd[3713]: src/adapter.c:connected_callback() hci0 device A0:C5:89:04:C2:29 connected eir_len 14
bluetoothd[3713]: src/adapter.c:user_confirm_request_callback() hci0 A0:C5:89:04:C2:29 confirm_hint 0
bluetoothd[3713]: src/device.c:new_auth() Requesting agent authentication for A0:C5:89:04:C2:29
bluetoothd[3713]: src/agent.c:agent_ref() 0x83f3c50: ref=2
bluetoothd[3713]: src/agent.c:agent_request_confirmation() Calling Agent.RequestConfirmation: name=:1.2949, path=/org/bluez/agent, passkey=861964
bluetoothd[3713]: src/agent.c:agent_ref() 0x83f3c50: ref=3
bluetoothd[3713]: src/adapter.c:btd_adapter_confirm_reply() hci0 addr A0:C5:89:04:C2:29 success 1
bluetoothd[3713]: src/agent.c:agent_unref() 0x83f3c50: ref=2
bluetoothd[3713]: src/agent.c:agent_unref() 0x83f3c50: ref=1
bluetoothd[3713]: src/adapter.c:new_link_key_callback() hci0 new key for A0:C5:89:04:C2:29 type 8 pin_len 0 store_hint 1
bluetoothd[3713]: src/device.c:device_set_bonded() 
bluetoothd[3713]: src/device.c:device_bonding_complete() bonding (nil) status 0x00
bluetoothd[3713]: src/adapter.c:resume_discovery() 
bluetoothd[3713]: src/adapter.c:new_csrk_callback() hci0 new CSRK for A0:C5:89:04:C2:29 type 3
bluetoothd[3713]: src/adapter.c:new_csrk_callback() hci0 new CSRK for A0:C5:89:04:C2:29 type 2
bluetoothd[3713]: src/adapter.c:new_long_term_key_callback() hci0 new LTK for A0:C5:89:04:C2:29 type 3 enc_size 16
bluetoothd[3713]: src/device.c:device_set_bonded() 
bluetoothd[3713]: src/device.c:device_bonding_complete() bonding (nil) status 0x00
bluetoothd[3713]: src/device.c:device_bonding_complete() setting timer for reverse service discovery
bluetoothd[3713]: src/adapter.c:resume_discovery() 
bluetoothd[3713]: A0:C5:89:04:C2:29: error updating services: Connection refused (111)
bluetoothd[3713]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_A0_C5_89_04_C2_29 err -111
bluetoothd[3713]: src/adapter.c:dev_disconnected() Device A0:C5:89:04:C2:29 disconnected, reason 3
bluetoothd[3713]: src/adapter.c:adapter_remove_connection() 
bluetoothd[3713]: plugins/policy.c:disconnect_cb() reason 3
bluetoothd[3713]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr A0:C5:89:04:C2:29 type 0 status 0xe
bluetoothd[3713]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[3713]: src/device.c:device_bonding_failed() status 14
bluetoothd[3713]: src/adapter.c:resume_discovery() 
bluetoothd[3713]: src/adapter.c:connected_callback() hci0 device A0:C5:89:04:C2:29 connected eir_len 14
bluetoothd[3713]: src/adapter.c:user_confirm_request_callback() hci0 A0:C5:89:04:C2:29 confirm_hint 0
bluetoothd[3713]: src/device.c:new_auth() Requesting agent authentication for A0:C5:89:04:C2:29
bluetoothd[3713]: src/agent.c:agent_ref() 0x83f3c50: ref=2
bluetoothd[3713]: src/agent.c:agent_request_confirmation() Calling Agent.RequestConfirmation: name=:1.2949, path=/org/bluez/agent, passkey=482281
bluetoothd[3713]: src/agent.c:agent_ref() 0x83f3c50: ref=3
bluetoothd[3713]: src/adapter.c:btd_adapter_confirm_reply() hci0 addr A0:C5:89:04:C2:29 success 1
bluetoothd[3713]: src/agent.c:agent_unref() 0x83f3c50: ref=2
bluetoothd[3713]: src/agent.c:agent_unref() 0x83f3c50: ref=1
bluetoothd[3713]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr A0:C5:89:04:C2:29 type 0 status 0x5
bluetoothd[3713]: src/device.c:device_bonding_complete() bonding (nil) status 0x05
bluetoothd[3713]: src/device.c:device_cancel_authentication() Canceling authentication request for A0:C5:89:04:C2:29
bluetoothd[3713]: src/device.c:device_bonding_failed() status 5
bluetoothd[3713]: src/adapter.c:resume_discovery() 
bluetoothd[3713]: src/adapter.c:dev_disconnected() Device A0:C5:89:04:C2:29 disconnected, reason 3
bluetoothd[3713]: src/adapter.c:adapter_remove_connection() 
bluetoothd[3713]: plugins/policy.c:disconnect_cb() reason 3
bluetoothd[3713]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr A0:C5:89:04:C2:29 type 0 status 0xe
bluetoothd[3713]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[3713]: src/device.c:device_bonding_failed() status 14
bluetoothd[3713]: src/adapter.c:resume_discovery() 

--oyUTqETQ0mS9luUI
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="btmon.log"
Content-Transfer-Encoding: base64

YnRzbm9vcAAAAAABAAAH0QAAABAAAAAQAAAAAAAAAAAA4ewYdwO8zgAD4M4EicWgaGNpMAAA
AAAAAAAAAAAAAAAAAAgAAAAAAOHsGHcDvNEAAAAIAAAACAAAAAoAAAAAAOHsGHcDvNLgzgSJ
xaACAAAAAAgAAAAIAAAAAgAAAAAA4ewYeBwKWgEEBTOLnggAAAAABgAAAAYAAAADAAAAAADh
7Bh4HCUiDwQAAgEEAAABAQAAAQEAAAADAAAAAADh7Bh4HuK4L/8BE3HafRoAAQAAAQBaDtYR
CXd1amlhbmdiby11YnVudHUCCgQJEAIAax1GAioFCQMAGAEYDhEMEQAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAAABAQAAAAMAAAAAAOHsGHgfL6wv/wEYcX/q
KugBAAwBOsMZqgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEAAAEBAAAAAwAAAAAA4ewY
eCNsOC//AT2hYQCFRAEADAEC9k6iDwlZSUhFTkdXQS1NT0JMMQIKBwAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQAAAQEA
AAADAAAAAADh7Bh4JjGSL/8BGHF/6iroAQAMATrDGasLCVhYVTQyLU1PQkwCCgoAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAEBAAABAQAAAAMAAAAAAOHsGHgrrEgv/wElpoiRenwBAAwBEvkftg4JUEVOR0NIRTEt
TU9CTAIKCgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAQEAAAEBAAAAAwAAAAAA4ewYeC9gTi//AUuDajQ+aAEADAJaEHWv
DQnprYXok50gbWV0YWwXAxIRAxIfERYRFREMEQ8RChEyES8RBRERB2eaDCAACJmK3hGsr9DA
iPoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
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
AAAABgAAAAMAAAAAAOHsGHyjjmgFBAAAARM=

--oyUTqETQ0mS9luUI--
