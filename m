Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5515641A.4020907@ontarget-group.com>
References: <5515641A.4020907@ontarget-group.com>
Date: Fri, 27 Mar 2015 16:52:04 +0200
Message-ID: <CABBYNZ++ZaDAhfsptONiQ15n3+yvbdYQUwY1CdZ-O723QoJeoQ@mail.gmail.com>
Subject: Re: Bluez 5.29 BLE connection issue
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alexey Pavlyuk <alexey.pavlyuk@ontarget-group.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexey,

On Fri, Mar 27, 2015 at 4:07 PM, Alexey Pavlyuk
<alexey.pavlyuk@ontarget-group.com> wrote:
> Hi, can you help me with bluetooth connection issue?
> I'm developing server which should work on BeagleBone Black device and
> connected with Android application by bluetooth LE or Classic. The server
> use Bluez library and set LE advertisement data, parameters and enable
> advertising. Than it create L2CAP socket and waits for connection.
> Debian 7.5 system ("wheezy") is installed on BeagleBone. I removed old bluez
> version than installed bluez-5.29 from source and run "bluetoothd --compat
> -d -n".

If you want to use GATT APIs you will need -E to enable experimental
interfaces, then you should use them to register the GATT services if
you have any, we are still working on the advertising API but it will
also be possible to advertise via D-Bus interface.

> After that I cannot connect from Android to the server using BLE protocol.
> Here is debug log:
>
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/adapter.c:connected_callback() hci0 device X:X:X:X:X:X connected eir_len
> 0
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/gatt-database.c:connect_cb() New incoming LE ATT connection
> Mar 27 12:27:22 beaglebone bluetoothd[601]:
> src/adapter.c:connected_callback() hci0 device X:X:X:X:X:X connected eir_len
> 0
> Mar 27 12:27:22 beaglebone bluetoothd[601]: src/gatt-database.c:connect_cb()
> New incoming LE ATT connection
> Mar 27 12:27:22 beaglebone bluetoothd[601]: attrib/gattrib.c:g_attrib_ref()
> 0x8dd20: g_attrib_ref=1
> Mar 27 12:27:22 beaglebone bluetoothd[601]:
> src/adapter.c:adapter_connect_list_remove() device
> /org/bluez/hci0/dev_X_X_X_X_X_X is not on the list, ignoring
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> attrib/gattrib.c:g_attrib_ref() 0x8dd20: g_attrib_ref=1
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/adapter.c:adapter_connect_list_remove() device
> /org/bluez/hci0/dev_X_X_X_X_X_X is not on the list, ignoring
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/adapter.c:dev_disconnected() Device X:X:X:X:X:X disconnected, reason 3
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/adapter.c:adapter_remove_connection()
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> plugins/policy.c:disconnect_cb() reason 3
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/adapter.c:bonding_attempt_complete() hci0 bdaddr X:X:X:X:X:X type 1
> status 0xe
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/device.c:device_bonding_failed() status 14
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/adapter.c:resume_discovery()
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/device.c:att_disconnected_cb()
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/device.c:att_disconnected_cb() Connection reset by peer (104)
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> src/device.c:att_disconnected_cb() Automatic connection disabled
> Mar 27 12:27:22 beaglebone bluetoothd[601]: bluetoothd[601]:
> attrib/gattrib.c:g_attrib_unref() 0x8dd20: g_attrib_unref=0
> Mar 27 12:27:22 beaglebone bluetoothd[601]: src/adapter.c:dev_disconnected()
> Device X:X:X:X:X:X disconnected, reason 3
> Mar 27 12:27:22 beaglebone bluetoothd[601]:
> src/adapter.c:adapter_remove_connection()
> Mar 27 12:27:22 beaglebone bluetoothd[601]: plugins/policy.c:disconnect_cb()
> reason 3
> Mar 27 12:27:22 beaglebone bluetoothd[601]:
> src/adapter.c:bonding_attempt_complete() hci0 bdaddr X:X:X:X:X:X type 1
> status 0xe
> Mar 27 12:27:22 beaglebone bluetoothd[601]:
> src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> Mar 27 12:27:22 beaglebone bluetoothd[601]:
> src/device.c:device_bonding_failed() status 14
> Mar 27 12:27:22 beaglebone bluetoothd[601]: src/adapter.c:resume_discovery()
> Mar 27 12:27:22 beaglebone bluetoothd[601]:
> src/device.c:att_disconnected_cb()
> Mar 27 12:27:22 beaglebone bluetoothd[601]:
> src/device.c:att_disconnected_cb() Connection reset by peer (104)
> Mar 27 12:27:22 beaglebone bluetoothd[601]:
> src/device.c:att_disconnected_cb() Automatic connection disabled
> Mar 27 12:27:22 beaglebone bluetoothd[601]:
> attrib/gattrib.c:g_attrib_unref() 0x8dd20: g_attrib_unref=0

We might need the HCI traffic to tell you what is happening, from what
I can see the pairing is failing, do you have any agent running? Or
are you trying this with bluetoothctl?

> When I stop bluetoothd, BLE connection is working. But I need SDP server for
> Classic Bluetooth connection.
> Also all is working well with Bluez-4.99 library and the daemon.
>
> Bluetooth dongle on 'Broadcom BCM20702' chipset is used.




-- 
Luiz Augusto von Dentz
