Return-Path: <cyrus@holtmann.org>
Message-ID: <4E3A7E09.6040503@start.ca>
Date: Thu, 04 Aug 2011 07:10:01 -0400
From: Colin Beckingham <colbec@start.ca>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Permission denied (13) on Samsung WEP475 headset?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'd like to provide some feedback regarding a Samsung WEP475 headset 
which fails to connect to linux specifically.

The USB bluetooth adapter is a Model: Belkin BLUETOOTH USB +EDR ADAPTER 
v2.1 UHE which successfully interconnects with 2 Jabra and 1 Plantronics 
headsets, plus a Nokia E71 phone. Samsung WEP475 successfully connects 
to a Windows XP machine and to the Nokia E71.

Using Opensuse 11.4 with custom kernel 3.0 currently, (also fails with 
2.6.38), bluez 4.96 and bluedevil manager.

Symptoms are that bluedevil sees the headset in pairing mode and 
correctly retrieves the name WEP475, connected button flashes green and 
then returns to grey (not connected). WEP475 led changes to connected 
status but bluedevil shows headset not connected and headset does not work.

With bluetoothd in debug mode, I get the following transactions in 
/var/log/messages:

Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
plugins/hciops.c:conn_complete() status 0x00
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
src/adapter.c:adapter_get_device() 00:---:47
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
plugins/hciops.c:remote_features_information() hci0 status 0
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
plugins/hciops.c:remote_name_information() hci0 status 0
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
audio/headset.c:headset_set_channel() Discovered Handsfree service on 
channel 2
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
audio/headset.c:rfcomm_connect() /org/bluez/13226/hci0/dev_00_---_47: 
Connecting to 00:---:47 channel 2
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
plugins/hciops.c:link_key_request() hci0 dba 00:---:47
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
plugins/hciops.c:get_auth_info() hci0 dba 00:---:47
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
plugins/hciops.c:link_key_request() kernel auth requirements = 0x04
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
plugins/hciops.c:link_key_request() Matching key found
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
plugins/hciops.c:link_key_request() link key type 0x04
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
plugins/hciops.c:auth_complete() hci0 status 0
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
plugins/hciops.c:bonding_complete() status 0x00
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
src/event.c:btd_event_bonding_complete() status 0x00
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
src/adapter.c:adapter_get_device() 00:---:47
Aug  4 06:22:51 linux-xxxx bluetoothd[13227]: 
src/device.c:device_bonding_complete() bonding (nil) status 0x00
Aug  4 06:22:52 linux-xxxx bluetoothd[13227]: Permission denied (13)
Aug  4 06:22:52 linux-xxxx bluetoothd[13227]: 
audio/headset.c:headset_set_state() State changed 
/org/bluez/13226/hci0/dev_00_---_47: HEADSET_STATE_CONNECTING -> 
HEADSET_STATE_DISCONNECTED
Aug  4 06:22:52 linux-xxxx bluetoothd[13227]: 
plugins/hciops.c:disconn_complete() handle 11 status 0x00
Aug  4 06:22:52 linux-xxxx bluetoothd[13227]: 
src/event.c:btd_event_disconn_complete()
Aug  4 06:22:52 linux-xxxx bluetoothd[13227]: 
src/adapter.c:adapter_remove_connection()

I have tried clearing the contents of /var/lib/bluetooth/ forcing the 
system to recreate, but no difference.
-- 
---
Colin Beckingham
