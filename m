Return-Path: <cyrus@holtmann.org>
Date: Sat, 7 Dec 2013 22:00:29 +0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Missing properties during pairing, refcounting bug?
Message-ID: <20131207180028.GC29280@x220.p-661hnu-f1>
References: <1386420104.32408.9.camel@nuvo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386420104.32408.9.camel@nuvo>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sat, Dec 07, 2013, Bastien Nocera wrote:
> Johan was blaming my "slow" Bluetooth adapter for the missing Class
> property when pairing was remote initiated,

I don't recall blaming your Bluetooth adapter, but simply concluding
that it seems either the local or remote side is slow in doing the name
discovery, based on the HCI log you produced. Your discovery of the
issue going away by adding delay before replying to the PIN request
seemed to support this conclusion.

> but it seems that there is another reason for the trouble. Here's an
> annotated bluetoothd log, with what my (uninformed) analysis.
> 
> I've used an old Sony Ericsson phone, as can be seen from the name in
> the logs, instead of a much harder to control "keyboard". I've also made
> sure that the phone wasn't visible so as to avoid properties being
> gathered from the discovery process.
> 
> # I select my computer for pairing on the phone
> bluetoothd[31569]: src/adapter.c:connected_callback() hci0 device 00:1E:45:AD:F1:96 connected eir_len 5
> bluetoothd[31569]: src/device.c:device_create() dst 00:1E:45:AD:F1:96
> bluetoothd[31569]: src/device.c:device_new() address 00:1E:45:AD:F1:96
> bluetoothd[31569]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_00_1E_45_AD_F1_96
> bluetoothd[31569]: src/device.c:btd_device_set_temporary() temporary 1
> bluetoothd[31569]: src/adapter.c:adapter_connect_list_remove() device /org/bluez/hci0/dev_00_1E_45_AD_F1_96 is not on the list, ignoring
> ** Message: calling device_set_class in connected_callback
> bluetoothd[31569]: src/device.c:device_set_class() /org/bluez/hci0/dev_00_1E_45_AD_F1_96 0x5A0204
> ** Message: calling set_class 0x5A0204 for Bastien's K850i
> 
> # At this point, the device is connected because we're doing a SDP
> search on the connecting device
> bluetoothd[31569]: src/adapter.c:dev_disconnected() Device 00:1E:45:AD:F1:96 disconnected, reason 3
> 
> # We're done with poking at the remote device, so we disconnect
> bluetoothd[31569]: src/adapter.c:adapter_remove_connection() 
> bluetoothd[31569]: src/adapter.c:adapter_remove_connection() Removing temporary device /org/bluez/hci0/dev_00_1E_45_AD_F1_96
> bluetoothd[31569]: src/device.c:device_remove() Removing device /org/bluez/hci0/dev_00_1E_45_AD_F1_96
> bluetoothd[31569]: src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_00_1E_45_AD_F1_96
> 
> # We remove the device we just created?!

Yep. Device which have dev->temporary = TRUE get removed when the
connection to them is lost. The temporary flag in turn gets cleared upon
successful pairing or when we've initiated some procedure through
Device1.Connect() or Device1.Pair().

That said, I think it would make sense to apply the same policy on
remotely initiated connections as we do for devices we've discovered but
not yet connected to. In other words, I think we should have the same 3
minute timer for this kind of device objects and only remove them if
pairing didn't happen by that time. Does it sound like it might solve
the issue?

Johan
