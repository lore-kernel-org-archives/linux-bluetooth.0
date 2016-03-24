Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Austin Riffle <ARiffle@efji.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: sdptool issue with TI Bluetooth chip
Date: Thu, 24 Mar 2016 13:58:33 +0000
Message-ID: <4C851F03BEE04A418B7A2D283DDCAB5D01E69712@EFJDFWMB01.EFJDFW.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all

I'm attempting to add BlueZ support to a custom linux kernel. Because of some design decisions I have no control over, I am currently locked into using mainline 3.3 kernel code, and buildroot 2013.08.1, leaving me with BlueZ-4.101.

I'm uncertain if anyone will be willing to answer my question because of the dated software, but I would appreciate it if possible, as I've spent a large amount of time trying to solve this on my own. Even a point in the right direction would be helpful.

Also, does BlueZ 5 have kernel dependencies past linux3.3? Modifying buildroot 'may' be a possibility if upgrading BlueZ would solve my issue, but I would prefer not to do so if possible.

My apologies if this message made it to the wrong list. Please point me in the right direction (or a document where I can read where to send) if this is the case.

On to the problem.

I am unable to use sdptool to modify any local sdp records. Running the sdptool command creates this output:

# sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Search failed: Connection timed out

There is no dmesg output to accompany this.

I mentioned the TI chip because it uses the TI shared transport and wilink drivers (CONFIG_TI_ST and CONFIG_BT_WILINK), and I'm not that they are as stable as something like the generic Bluetooth UART.

These issues seem to be causing timeouts when using the rfcomm command as well.

I can always provide more information if needed.

Here is some other basic information from various commands

# hciconfig
hci0:   Type: BR/EDR  Bus: UART
        BD Address: C8:3E:99:E6:2D:51  ACL MTU: 1021:4  SCO MTU: 180:4
        UP RUNNING
        RX bytes:473 acl:0 sco:0 events:19 errors:0
        TX bytes:101 acl:0 sco:0 commands:19 errors:0


# bluetoothd -d -n
bluetoothd[667]: Bluetooth daemon 4.101
bluetoothd[667]: src/main.c:parse_config() parsing main.conf
bluetoothd[667]: src/main.c:parse_config() discovto=0
bluetoothd[667]: src/main.c:parse_config() pairto=0
bluetoothd[667]: src/main.c:parse_config() pageto=8192
bluetoothd[667]: src/main.c:parse_config() auto_to=60
bluetoothd[667]: src/main.c:parse_config() name=%h-%d
bluetoothd[667]: src/main.c:parse_config() class=0x680410
bluetoothd[667]: src/main.c:parse_config() Key file does not have key 'DeviceID'
bluetoothd[667]: Starting SDP server
bluetoothd[667]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[667]: src/plugin.c:add_plugin() Loading input plugin
bluetoothd[667]: src/plugin.c:add_plugin() Loading serial plugin
bluetoothd[667]: src/plugin.c:add_plugin() Loading network plugin
bluetoothd[667]: src/plugin.c:add_plugin() Loading service plugin
bluetoothd[667]: src/plugin.c:add_plugin() Loading hciops plugin
bluetoothd[667]: src/plugin.c:add_plugin() Loading mgmtops plugin
bluetoothd[667]: src/plugin.c:add_plugin() Loading formfactor plugin
bluetoothd[667]: src/plugin.c:add_plugin() Loading storage plugin
bluetoothd[667]: src/plugin.c:add_plugin() Loading adaptername plugin
bluetoothd[667]: src/plugin.c:plugin_init() Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[667]: plugins/service.c:register_interface() path /org/bluez/667/any
bluetoothd[667]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/667/any
bluetoothd[667]: network/manager.c:read_config() Config options: Security=true
bluetoothd[667]: Failed to open control socket: Protocol not supported (93)
bluetoothd[667]: Can't init bnep module
bluetoothd[667]: Failed to init network plugin
bluetoothd[667]: Parsing /etc/bluetooth/input.conf failed: No such file or directory
bluetoothd[667]: plugins/hciops.c:hciops_init()
bluetoothd[667]: plugins/hciops.c:hciops_setup()
bluetoothd[667]: Failed to open RFKILL control device
bluetoothd[667]: src/main.c:main() Entering main loop
bluetoothd[667]: plugins/hciops.c:init_known_adapters()
bluetoothd[667]: plugins/hciops.c:init_device() hci0
bluetoothd[667]: Listening for HCI events on hci0
bluetoothd[667]: plugins/hciops.c:init_conn_list() hci0
bluetoothd[667]: HCI dev 0 up
bluetoothd[667]: plugins/hciops.c:device_devup_setup() hci0
bluetoothd[667]: plugins/hciops.c:read_local_version_complete() Got version for hci0
bluetoothd[667]: src/adapter.c:btd_adapter_ref() 0xb6f1eee8: ref=1
bluetoothd[667]: plugins/hciops.c:hciops_read_bdaddr() hci0
bluetoothd[667]: src/sdpd-database.c:sdp_init_services_list()
bluetoothd[667]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[667]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[667]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[667]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[667]: plugins/service.c:register_interface() path /org/bluez/667/hci0
bluetoothd[667]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/667/hci0
bluetoothd[667]: serial/manager.c:proxy_probe() path /org/bluez/667/hci0
bluetoothd[667]: src/adapter.c:btd_adapter_ref() 0xb6f1eee8: ref=2
bluetoothd[667]: serial/proxy.c:proxy_register() Registered interface org.bluez.SerialProxyManager on path /org/bluez/667/hci0
bluetoothd[667]: Parsing /etc/bluetooth/serial.conf failed: No such file or directory
bluetoothd[667]: src/adapter.c:btd_adapter_ref() 0xb6f1eee8: ref=3
bluetoothd[667]: plugins/adaptername.c:adaptername_probe() Setting name '(none)-0' for device 'hci0'
bluetoothd[667]: plugins/hciops.c:hciops_set_name() hci0, name (none)-0
bluetoothd[667]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[667]: Could not get the contents of DMI chassis type
bluetoothd[667]: plugins/hciops.c:hciops_unblock_device() hci0 dba 00:00:00:00:00:00
bluetoothd[667]: plugins/hciops.c:hciops_load_keys() hci0 keys 0 debug_keys 0
bluetoothd[667]: Unable to load keys to adapter_ops: Function not implemented (38)
bluetoothd[667]: plugins/hciops.c:hciops_get_conn_list() hci0
bluetoothd[667]: src/manager.c:btd_manager_register_adapter() Adapter /org/bluez/667/hci0 registered
bluetoothd[667]: src/adapter.c:btd_adapter_ref() 0xb6f1eee8: ref=4
bluetoothd[667]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 0
bluetoothd[667]: plugins/hciops.c:hciops_disable_cod_cache() hci0 cache_enable 1
bluetoothd[667]: plugins/hciops.c:hciops_disable_cod_cache() hci0 current_cod 0x000000 wanted_cod 0x000100
bluetoothd[667]: plugins/hciops.c:write_class() hci0 class 0x000100
bluetoothd[667]: Adapter /org/bluez/667/hci0 has been enabled
bluetoothd[667]: plugins/hciops.c:hciops_set_discoverable() hci0 discoverable 0
bluetoothd[667]: plugins/hciops.c:hciops_set_pairable() hci0 pairable 1
bluetoothd[667]: plugins/hciops.c:hciops_stop_inquiry() hci0
bluetoothd[667]: src/adapter.c:btd_adapter_unref() 0xb6f1eee8: ref=3
bluetoothd[667]: plugins/hciops.c:read_local_ext_features_complete() hci0 status 0
bluetoothd[667]: plugins/hciops.c:read_tx_power_complete() hci0 status 0
bluetoothd[667]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[667]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[667]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[667]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[667]: plugins/hciops.c:read_simple_pairing_mode_complete() hci0 status 0
bluetoothd[667]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[667]: plugins/hciops.c:read_scan_complete() hci0 status 0
bluetoothd[667]: plugins/hciops.c:hciops_set_limited_discoverable() hci0 limited 0
bluetoothd[667]: src/adapter.c:adapter_mode_changed() old 0x00 new 0x02
bluetoothd[667]: src/adapter.c:set_mode_complete()

-
This e-mail transmission, and any documents, files or previous e-mail messages attached to it, may contain confidential information. If you are not the intended recipient, or a person responsible for delivering it to the intended recipient, you are hereby notified that any disclosure, distribution, review, copy or use of any of the information contained in or attached to this message is STRICTLY PROHIBITED. If you have received this transmission in error, please immediately notify us by reply e-mail, and destroy the original transmission and its attachments without reading them or saving them to disk. Thank you.

