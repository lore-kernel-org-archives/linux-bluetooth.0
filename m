Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Feb 2013 10:11:22 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Damjan Cvetko <Damjan.Cvetko@monotek.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Add heartrate monitoring LE device to auto connect list.
Message-ID: <20130201161122.GB22624@x220>
References: <1359408442-8002-1-git-send-email-damjan.cvetko@monotek.net>
 <20130129233606.GA16365@x220>
 <CEE0DF8E7B2727428D202DA3F3FBC4DD8C756889@PULWAR.mtk.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CEE0DF8E7B2727428D202DA3F3FBC4DD8C756889@PULWAR.mtk.lan>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Damjan,

On Fri, Feb 01, 2013, Damjan Cvetko wrote:
> Generally the latest code works, but not always. Every so often the
> reconnect would not happen. Here a snip from output when the
> reconnection does not happen (or fails somehow):
> 
> bluetoothd[4628]: src/attrib-server.c:channel_handler() op 0x1b
> bluetoothd[4628]: src/adapter.c:dev_disconnected() Device 00:22:D0:00:00:64 disconnected, reason 0
> bluetoothd[4628]: src/adapter.c:adapter_remove_connection()
> bluetoothd[4628]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> bluetoothd[4628]: src/device.c:device_bonding_failed() status 14
> bluetoothd[4628]: src/adapter.c:resume_discovery()
> bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1f9eda8: ref=4
> bluetoothd[4628]: profiles/heartrate/heartrate.c:attio_disconnected_cb()
> bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1f9eda8: ref=3
> bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1f9eda8: ref=2
> bluetoothd[4628]: g_attrib_unregister: invalid id
> bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1f9eda8: ref=1
> bluetoothd[4628]: src/adapter.c:adapter_connect_list_add() /org/bluez/hci0/dev_00_22_D0_00_00_64 added to BlueZ 5.1's connect_list
> bluetoothd[4628]: src/adapter.c:trigger_passive_scanning()
> bluetoothd[4628]: attrib/gattrib.c:g_attrib_unref() 0x1f9eda8: ref=0
> bluetoothd[4628]: src/adapter.c:passive_scanning_complete() status 0x00
> bluetoothd[4628]: src/adapter.c:discovering_callback() hci0 type 6 discovering 1
> bluetoothd[4628]: src/adapter.c:device_found_callback() hci0 addr 00:22:D0:00:00:64, rssi -91 flags 0x0000 eir_len 17
> bluetoothd[4628]: src/device.c:device_set_legacy() legacy 0
> bluetoothd[4628]: src/adapter.c:stop_passive_scanning()
> bluetoothd[4628]: src/device.c:device_connect_le() Connection attempt to: 00:22:D0:00:00:64
> bluetoothd[4628]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0
> bluetoothd[4628]: src/adapter.c:connected_callback() hci0 device 00:22:D0:00:00:64 connected eir_len 0
> bluetoothd[4628]: src/adapter.c:dev_disconnected() Device 00:22:D0:00:00:64 disconnected, reason 0
> bluetoothd[4628]: src/adapter.c:adapter_remove_connection()
> bluetoothd[4628]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> bluetoothd[4628]: src/device.c:device_bonding_failed() status 14
> bluetoothd[4628]: src/adapter.c:resume_discovery()
> bluetoothd[4628]: src/device.c:att_connect_cb() connect error: Function not implemented (38)

It's hard to say exactly why the connection is failing here without the
HCI logs. Could you run btmon simultaneously and let me know the output.
Also please update to latest bluez.git since there might be some fixes
that you have missed.

Johan
