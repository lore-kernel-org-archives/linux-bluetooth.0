Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAG=SMqbo6mOOFjEjn_Kh9eFaUYH7f+xYLx3XP35j9Bw5JSCotA@mail.gmail.com>
References: <CAG=SMqZaBR-8HGsYmy3p_02vJhjnhcTu2sUBc5BqyqBEbt2Jag@mail.gmail.com>
	<CAG=SMqbo6mOOFjEjn_Kh9eFaUYH7f+xYLx3XP35j9Bw5JSCotA@mail.gmail.com>
Date: Thu, 24 Dec 2015 15:44:11 -0200
Message-ID: <CABBYNZKN+rjopcfec9UvOQgmGe7ay25KyxwG2=6GX_qY5j8_JA@mail.gmail.com>
Subject: Re: BLE GATT connection problem
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Fabian Bergmark <fabian.bergmark@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabian,

On Wed, Dec 23, 2015 at 8:49 PM, Fabian Bergmark
<fabian.bergmark@gmail.com> wrote:
> I use the glib D-Bus interface to connect to a BLE button. This works
> great some times but I regularly get this connection error:
> GDBus.Error:org.bluez.Error.Failed: Software caused connection abort,
> 36
>
>  The debug output in bluetoothd is:
>
> bluetoothd[17071]: src/device.c:device_set_auto_connect()
> 80:E4:DA:70:07:A7 auto connect: 1
> bluetoothd[17071]: src/device.c:device_connect_le() Connection attempt
> to: 80:E4:DA:70:07:A7
> bluetoothd[17071]: src/adapter.c:add_device_complete()
> 80:E4:DA:70:07:A7 (1) added to kernel connect list
> bluetoothd[17071]: src/adapter.c:connected_callback() hci0 device
> 80:E4:DA:70:07:A7 connected eir_len 0
> bluetoothd[17071]: src/gatt-client.c:notify_client_ref() owner :1.2517
> bluetoothd[17071]: src/gatt-client.c:notify_client_ref() owner :1.2517
> bluetoothd[17071]: src/device.c:att_connect_cb() connect error:
> Function not implemented (38)
> bluetoothd[17071]: src/device.c:att_error_cb() Enabling automatic connections
> bluetoothd[17071]: src/adapter.c:dev_disconnected() Device
> 80:E4:DA:70:07:A7 disconnected, reason 0
> bluetoothd[17071]: src/adapter.c:adapter_remove_connection()
> bluetoothd[17071]: plugins/policy.c:disconnect_cb() reason 0
> bluetoothd[17071]: src/adapter.c:bonding_attempt_complete() hci0
> bdaddr 80:E4:DA:70:07:A7 type 1 status 0xe
> bluetoothd[17071]: src/device.c:device_bonding_complete() bonding
> (nil) status 0x0e
> bluetoothd[17071]: src/device.c:device_bonding_failed() status 14
> bluetoothd[17071]: src/adapter.c:resume_discovery()
>
>
> What worries me is the connect error: Function not implemented (38) line.
>
> I'm on commit 1b9e48f4c2b98ea88e43bd493c098dcca822a1d0
>
> Is this a potential bluez bug?

This is coming from bt_io_connect callback so it is very likely this
is from the kernel, check the HCI trace.

>
> When I manage to connect to a button, the output is as follows:
>
> bluetoothd[17071]: src/device.c:device_connect_le() Connection attempt
> to: 80:E4:DA:70:08:9E

This is a different device, are you sure you are testing this
correctly or perhaps only the device 80:E4:DA:70:08:9E is a BLE
peripheral?
