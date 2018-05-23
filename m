Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: KORG nanoKONTROL Studio ... again
From: Robert Schneider <Robert.Schneider@aramar.de>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <4f787a1b-848b-be07-bdd0-198892c56120@aramar.de>
 <CABBYNZ+HQ2CeuHLrx1w5k6BK-AV8SYbdE_-TOej522cwf-BtUg@mail.gmail.com>
 <f557429f-e61b-1ac6-c894-bc84db45c65c@aramar.de>
 <CABBYNZKS+xNeiW6p+_aLp=K8Fu8DoSX+7xTt5x7-SOHkhXX=fw@mail.gmail.com>
 <9dac26c6-72ee-7368-cb2b-62747e0e9707@aramar.de>
Message-ID: <4650be8c-54dc-ba8e-ff91-e9a4cb9402f6@aramar.de>
Date: Wed, 23 May 2018 19:23:38 +0200
MIME-Version: 1.0
In-Reply-To: <9dac26c6-72ee-7368-cb2b-62747e0e9707@aramar.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I did some more testing today, after compiling a bluetoothd that has MIDI 
support, the device now shows up in the alsa MIDI devices list, however, 
communication fails. As I am not savvy enough to interpret this, could someone 
more technically involved shed some light on this for me?

I see that "bonding" fails with status 5. But that doesn't tell me anything. 
Especially, I would be interested in how I could solve that issue.

Thanks in advance and regards,

Robert

bluetoothd[890]: src/device.c:device_probe_profiles() Probing profiles for 
device 60:F1:89:28:DA:1F
bluetoothd[890]: profiles/midi/midi.c:midi_device_probe() MIDI GATT Driver 
profile probe (60:F1:89:28:DA:1F)
bluetoothd[890]: src/service.c:change_state() 0x5649f05dc240: device 
60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: unavailable -> 
disconnected (0)
bluetoothd[890]: src/device.c:device_set_auto_connect() 60:F1:89:28:DA:1F auto 
connect: 1
bluetoothd[890]: src/device.c:device_set_auto_connect() Already connected
bluetoothd[890]: profiles/midi/midi.c:midi_accept() MIDI GATT Driver profile 
accept (60:F1:89:28:DA:1F)
bluetoothd[890]: profiles/midi/midi.c:handle_midi_io() MIDI I/O handle: 0x001b
bluetoothd[890]: src/service.c:change_state() 0x5649f05dc240: device 
60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnected -> 
connected (0)
bluetoothd[890]: src/service.c:btd_service_ref() 0x5649f05dc240: ref=2
bluetoothd[890]: plugins/policy.c:service_cb() Added MIDI GATT Driver reconnect 0
bluetoothd[890]: src/gatt-client.c:btd_gatt_client_ready() GATT client ready
bluetoothd[890]: src/gatt-client.c:create_services() Exporting objects for GATT 
services: 60:F1:89:28:DA:1F
bluetoothd[890]: src/gatt-client.c:service_create() Exported GATT service: 
/org/bluez/hci0/dev_60_F1_89_28_DA_1F/service000c
bluetoothd[890]: src/gatt-client.c:characteristic_create() Exported GATT 
characteristic: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service000c/char000d
bluetoothd[890]: src/gatt-client.c:descriptor_create() Exported GATT 
characteristic descriptor: 
/org/bluez/hci0/dev_60_F1_89_28_DA_1F/service000c/char000d/desc000f
bluetoothd[890]: src/gatt-client.c:service_create() Exported GATT service: 
/org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0010
bluetoothd[890]: src/gatt-client.c:characteristic_create() Exported GATT 
characteristic: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0010/char0011
bluetoothd[890]: src/gatt-client.c:characteristic_create() Exported GATT 
characteristic: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0010/char0013
bluetoothd[890]: src/gatt-client.c:service_create() Exported GATT service: 
/org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0015
bluetoothd[890]: src/gatt-client.c:characteristic_create() Exported GATT 
characteristic: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0015/char0016
bluetoothd[890]: src/gatt-client.c:descriptor_create() Exported GATT 
characteristic descriptor: 
/org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0015/char0016/desc0018
bluetoothd[890]: src/device.c:device_svc_resolved() 
/org/bluez/hci0/dev_60_F1_89_28_DA_1F err 0
bluetoothd[890]: src/adapter.c:add_device_complete() 60:F1:89:28:DA:1F (1) added 
to kernel connect list
bluetoothd[890]: src/device.c:gatt_debug() Registered handler for "Service 
Changed": 1
bluetoothd[890]: profiles/gap/gas.c:read_device_name_cb() GAP Device Name: 
nanoKONTROL Studio
bluetoothd[890]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0080
bluetoothd[890]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 
60:F1:89:28:DA:1F type 1 status 0x5
bluetoothd[890]: src/device.c:device_bonding_complete() bonding (nil) status 0x05
bluetoothd[890]: src/device.c:device_bonding_failed() status 5
bluetoothd[890]: src/adapter.c:resume_discovery()
bluetoothd[890]: src/adapter.c:dev_disconnected() Device 60:F1:89:28:DA:1F 
disconnected, reason 2
bluetoothd[890]: src/adapter.c:adapter_remove_connection()
bluetoothd[890]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[890]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 
60:F1:89:28:DA:1F type 1 status 0xe
bluetoothd[890]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[890]: src/device.c:device_bonding_failed() status 14
bluetoothd[890]: src/adapter.c:resume_discovery()
bluetoothd[890]: MIDI I/O: Failed to read initial request
bluetoothd[890]: src/device.c:att_disconnected_cb()
bluetoothd[890]: src/device.c:att_disconnected_cb() Software caused connection 
abort (103)
bluetoothd[890]: src/service.c:change_state() 0x5649f05ce090: device 
60:F1:89:28:DA:1F profile gap-profile state changed: connected -> disconnecting (0)
bluetoothd[890]: src/service.c:change_state() 0x5649f05ce090: device 
60:F1:89:28:DA:1F profile gap-profile state changed: disconnecting -> 
disconnected (0)
bluetoothd[890]: src/service.c:change_state() 0x5649f05dbe30: device 
60:F1:89:28:DA:1F profile deviceinfo state changed: connected -> disconnecting (0)
bluetoothd[890]: src/service.c:change_state() 0x5649f05dbe30: device 
60:F1:89:28:DA:1F profile deviceinfo state changed: disconnecting -> 
disconnected (0)
bluetoothd[890]: src/service.c:change_state() 0x5649f05dc240: device 
60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: connected -> 
disconnecting (0)
bluetoothd[890]: profiles/midi/midi.c:midi_disconnect() MIDI GATT Driver profile 
disconnect (60:F1:89:28:DA:1F)
bluetoothd[890]: src/service.c:change_state() 0x5649f05dc240: device 
60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnecting -> 
disconnected (0)
bluetoothd[890]: src/gatt-client.c:btd_gatt_client_disconnected() Device 
disconnected. Cleaning up.
