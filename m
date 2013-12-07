Return-Path: <cyrus@holtmann.org>
Message-ID: <1386420104.32408.9.camel@nuvo>
Subject: Missing properties during pairing, refcounting bug?
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 07 Dec 2013 13:41:44 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

Johan was blaming my "slow" Bluetooth adapter for the missing Class
property when pairing was remote initiated, but it seems that there is
another reason for the trouble. Here's an annotated bluetoothd log, with
what my (uninformed) analysis.

I've used an old Sony Ericsson phone, as can be seen from the name in
the logs, instead of a much harder to control "keyboard". I've also made
sure that the phone wasn't visible so as to avoid properties being
gathered from the discovery process.

# I select my computer for pairing on the phone
bluetoothd[31569]: src/adapter.c:connected_callback() hci0 device 00:1E:45:AD:F1:96 connected eir_len 5
bluetoothd[31569]: src/device.c:device_create() dst 00:1E:45:AD:F1:96
bluetoothd[31569]: src/device.c:device_new() address 00:1E:45:AD:F1:96
bluetoothd[31569]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_00_1E_45_AD_F1_96
bluetoothd[31569]: src/device.c:btd_device_set_temporary() temporary 1
bluetoothd[31569]: src/adapter.c:adapter_connect_list_remove() device /org/bluez/hci0/dev_00_1E_45_AD_F1_96 is not on the list, ignoring
** Message: calling device_set_class in connected_callback
bluetoothd[31569]: src/device.c:device_set_class() /org/bluez/hci0/dev_00_1E_45_AD_F1_96 0x5A0204
** Message: calling set_class 0x5A0204 for Bastien's K850i

# At this point, the device is connected because we're doing a SDP search on the connecting device
bluetoothd[31569]: src/adapter.c:dev_disconnected() Device 00:1E:45:AD:F1:96 disconnected, reason 3

# We're done with poking at the remote device, so we disconnect
bluetoothd[31569]: src/adapter.c:adapter_remove_connection() 
bluetoothd[31569]: src/adapter.c:adapter_remove_connection() Removing temporary device /org/bluez/hci0/dev_00_1E_45_AD_F1_96
bluetoothd[31569]: src/device.c:device_remove() Removing device /org/bluez/hci0/dev_00_1E_45_AD_F1_96
bluetoothd[31569]: src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_00_1E_45_AD_F1_96

# We remove the device we just created?!
** Message: Actually sending process_properties_from_interface for data 0x2095d70
bluetoothd[31569]: src/device.c:device_free() 0x20967b0
bluetoothd[31569]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:1E:45:AD:F1:96 type 0 status 0xe
bluetoothd[31569]: src/adapter.c:resume_discovery() 
bluetoothd[31569]: src/adapter.c:trigger_start_discovery() 
bluetoothd[31569]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[31569]: src/adapter.c:start_discovery_timeout() 
bluetoothd[31569]: src/adapter.c:start_discovery_complete() status 0x00

# Now I've actually entered the PIN on the phone, for me to enter on the computer
# The data we got from the EIR above has been lost because we freed the device
bluetoothd[31569]: src/adapter.c:discovering_callback() hci0 type 7 discovering 1
bluetoothd[31569]: src/adapter.c:pin_code_request_callback() hci0 00:1E:45:AD:F1:96
bluetoothd[31569]: src/device.c:device_create() dst 00:1E:45:AD:F1:96
bluetoothd[31569]: src/device.c:device_new() address 00:1E:45:AD:F1:96
bluetoothd[31569]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_00_1E_45_AD_F1_96
bluetoothd[31569]: src/device.c:btd_device_set_temporary() temporary 1
bluetoothd[31569]: src/adapter.c:adapter_connect_list_remove() device /org/bluez/hci0/dev_00_1E_45_AD_F1_96 is not on the list, ignoring
bluetoothd[31569]: src/device.c:new_auth() Requesting agent authentication for 00:1E:45:AD:F1:96
bluetoothd[31569]: src/agent.c:agent_ref() 0x2081e80: ref=2
** Message: sending message in pincode_request_new()

Does that sound correct? That would certainly explain why I get nothing
from the remote device apart from the name and address.

Ideas?

Cheers

