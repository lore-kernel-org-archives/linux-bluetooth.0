Return-Path: <cyrus@holtmann.org>
Message-ID: <4D657852.2090100@sergio.spb.ru>
Date: Thu, 24 Feb 2011 00:12:50 +0300
From: sergio <mailbox@sergio.spb.ru>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: can't pair the phone
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

I can't pair my Ericsson T39 with my linux box.
I can pair any another phone (for example Nokia 6310) with linux.
I can pair Ericsson with any other device (for example with adroid phone, or
with windows). So it's bluez problem.

% bluez-test-discovery
[ 00:01:EC:0C:D2:00 ]
     Name = totoro
     Paired = 0
     LegacyPairing = 1
     Alias = totoro
     Address = 00:01:EC:0C:D2:00
     RSSI = 0
     Class = 0x520204
     Icon = phone
[ 00:01:EC:0C:D2:00 ]
     Name = totoro
     Paired = 0
     LegacyPairing = 1
     Alias = totoro
     Address = 00:01:EC:0C:D2:00
     RSSI = 0
     Class = 0x520204
     Icon = phone

I don't know why it shows it twice.

bluetoothd -n -d shows:
bluetoothd[8071]: plugins/hciops.c:hciops_start_inquiry() hci0 length 8 
periodic 1
bluetoothd[8071]: Discovery session 0xf77741c8 with :1.64 activated
bluetoothd[8071]: src/adapter.c:session_ref() 0xf77741c8: ref=1
bluetoothd[8071]: plugins/hciops.c:hciops_resolve_name() hci0 dba 
00:01:EC:0C:D2:00
bluetoothd[8071]: plugins/hciops.c:remote_name_information() hci0 status 0
bluetoothd[8071]: src/adapter.c:session_remove() Discovery session 
0xf77741c8 with :1.64 deactivated
bluetoothd[8071]: src/adapter.c:session_remove() Stopping discovery
bluetoothd[8071]: plugins/hciops.c:hciops_stop_inquiry() hci0

% bluez-simple-agent hci0 00:01:EC:0C:D2:00
RequestPinCode (/org/bluez/8071/hci0/dev_00_01_EC_0C_D2_00)
Enter PIN Code: 1234
Creating device failed: org.bluez.Error.AuthenticationRejected: 
Authentication Rejected

Phone doesn't ask to enter pin.

bluetoothd -n -d shows:
before pin enter:
bluetoothd[8071]: src/adapter.c:adapter_create_device() 00:01:EC:0C:D2:00
bluetoothd[8071]: src/device.c:device_create() Creating device 
/org/bluez/8071/hci0/dev_00_01_EC_0C_D2_00
bluetoothd[8071]: src/device.c:btd_device_ref() 0xf7786b88: ref=1
bluetoothd[8071]: src/device.c:bonding_request_new() Requesting bonding 
for 00:01:EC:0C:D2:00
bluetoothd[8071]: src/device.c:bonding_request_new() Temporary agent 
registered for 00:01:EC:0C:D2:00 at :1.65:/test/agent
bluetoothd[8071]: src/adapter.c:adapter_get_device() 00:01:EC:0C:D2:00
bluetoothd[8071]: plugins/hciops.c:remote_features_information() hci0 
status 0
bluetoothd[8071]: plugins/hciops.c:link_key_request() hci0 dba 
00:01:EC:0C:D2:00
bluetoothd[8071]: plugins/hciops.c:link_key_request() kernel auth 
requirements = 0x03
bluetoothd[8071]: plugins/hciops.c:link_key_request() Matching key not found
bluetoothd[8071]: plugins/hciops.c:pin_code_request() hci0 PIN request 
for 00:01:EC:0C:D2:00
bluetoothd[8071]: src/adapter.c:adapter_get_device() 00:01:EC:0C:D2:00
bluetoothd[8071]: src/device.c:device_request_authentication() 
Requesting agent authentication for 00:01:EC:0C:D2:00

after pin enter:
bluetoothd[8071]: plugins/hciops.c:hciops_pincode_reply() hci0 dba 
00:01:EC:0C:D2:00
bluetoothd[8071]: plugins/hciops.c:auth_complete() hci0 status 24
bluetoothd[8071]: src/event.c:btd_event_bonding_process_complete() status=18
bluetoothd[8071]: src/device.c:device_cancel_authentication() Canceling 
authentication request for 00:01:EC:0C:D2:00
bluetoothd[8071]: src/device.c:device_cancel_bonding() Canceling bonding 
request for 00:01:EC:0C:D2:00
bluetoothd[8071]: src/agent.c:agent_release() Releasing agent :1.65, 
/test/agent
bluetoothd[8071]: src/adapter.c:adapter_get_device() 00:01:EC:0C:D2:00
bluetoothd[8071]: src/adapter.c:adapter_remove_connection() Removing 
temporary device /org/bluez/8071/hci0/dev_00_01_EC_0C_D2_00
bluetoothd[8071]: src/device.c:device_remove() Removing device 
/org/bluez/8071/hci0/dev_00_01_EC_0C_D2_00
bluetoothd[8071]: src/device.c:btd_device_unref() 0xf7786b88: ref=0
bluetoothd[8071]: src/device.c:device_free() 0xf7786b88


When I try to iniate pairing from phone I get, after enter pin on phone:

bluetoothd[8071]: src/adapter.c:adapter_get_device() 00:01:EC:0C:D2:00
bluetoothd[8071]: src/adapter.c:adapter_create_device() 00:01:EC:0C:D2:00
bluetoothd[8071]: src/device.c:device_create() Creating device 
/org/bluez/8071/hci0/dev_00_01_EC_0C_D2_00
bluetoothd[8071]: src/device.c:btd_device_ref() 0xf7786b88: ref=1
bluetoothd[8071]: src/device.c:device_remove() Removing device 
/org/bluez/8071/hci0/dev_00_01_EC_0C_D2_00
bluetoothd[8071]: src/device.c:btd_device_unref() 0xf7786b88: ref=0
bluetoothd[8071]: src/device.c:device_free() 0xf7786b88

bluez-simple-agent shows nothing.

-- 
sergio.
