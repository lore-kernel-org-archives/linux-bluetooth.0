Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 23 May 2011 16:45:53 -0500
Message-ID: <BANLkTimaJSHEx0GoR1659tOWnYRBWV9Z0Q@mail.gmail.com>
Subject: audio/manager.c:hf_io_cb() Refusing new connection since one already exists
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am having a problem where I can not connect my phone using HFP after
it has been once disconnected from bluetoothd.

Linux 2.6.38-8-generic #42-Ubuntu SMP Mon Apr 11 03:31:50 UTC 2011
i686 i686 i386 GNU/Linux
Bluez 4.93

Here is the initial connection:

bluetoothd[12077]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[12077]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[12077]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[12077]: plugins/hciops.c:remote_name_information() hci0 status 0
bluetoothd[12077]: plugins/hciops.c:link_key_request() hci0 dba
00:17:E3:3B:4F:DD
bluetoothd[12077]: plugins/hciops.c:get_auth_info() hci0 dba 00:17:E3:3B:4F:DD
bluetoothd[12077]: plugins/hciops.c:link_key_request() kernel auth
requirements = 0x04
bluetoothd[12077]: plugins/hciops.c:link_key_request() Matching key found
bluetoothd[12077]: plugins/hciops.c:link_key_request() link key type 0x00
bluetoothd[12077]: plugins/hciops.c:auth_complete() hci0 status 0
bluetoothd[12077]: plugins/hciops.c:bonding_complete() status 0x00
bluetoothd[12077]: src/event.c:btd_event_bonding_complete() status 0x00
bluetoothd[12077]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[12077]: src/device.c:device_bonding_complete() bonding
(nil) status 0x00
bluetoothd[12077]: audio/manager.c:gateway_auth_cb() Accepted AG
connection from 00:17:E3:3B:4F:DD for
/org/bluez/12077/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[12077]: audio/gateway.c:newconnection_reply() Agent reply:
file descriptor passed successfully

Which then I click disconnect on my phone, yielding:

bluetoothd[12077]: plugins/hciops.c:disconn_complete() handle 42 status 0x00
bluetoothd[12077]: src/event.c:btd_event_disconn_complete()
bluetoothd[12077]: src/adapter.c:adapter_remove_connection()

After that, I press connect again on my phone, which gives the following:

bluetoothd[12077]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[12077]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[12077]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[12077]: plugins/hciops.c:remote_name_information() hci0 status 0
bluetoothd[12077]: plugins/hciops.c:link_key_request() hci0 dba
00:17:E3:3B:4F:DD
bluetoothd[12077]: plugins/hciops.c:get_auth_info() hci0 dba 00:17:E3:3B:4F:DD
bluetoothd[12077]: plugins/hciops.c:link_key_request() kernel auth
requirements = 0x04
bluetoothd[12077]: plugins/hciops.c:link_key_request() Matching key found
bluetoothd[12077]: plugins/hciops.c:link_key_request() link key type 0x00
bluetoothd[12077]: plugins/hciops.c:auth_complete() hci0 status 0
bluetoothd[12077]: plugins/hciops.c:bonding_complete() status 0x00
bluetoothd[12077]: src/event.c:btd_event_bonding_complete() status 0x00
bluetoothd[12077]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[12077]: src/device.c:device_bonding_complete() bonding
(nil) status 0x00
bluetoothd[12077]: audio/manager.c:hf_io_cb() Refusing new connection
since one already exists
bluetoothd[12077]: plugins/hciops.c:disconn_complete() handle 43 status 0x00
bluetoothd[12077]: src/event.c:btd_event_disconn_complete()
bluetoothd[12077]: src/adapter.c:adapter_remove_connection()


It seems like there is a missing link between the disconnect event and
setting the gateway to the proper state?

Thanks,

Mike
