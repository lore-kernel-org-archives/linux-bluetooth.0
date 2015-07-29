Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: Problems with incoming connection request on Nexus 4
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55B83614.8090702@gmail.com>
Date: Wed, 29 Jul 2015 15:51:20 +0200
Cc: Szymon Janc <Szymon.Janc@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <BC4DBE9E-8369-4B20-BBE5-F175DD4C5626@holtmann.org>
References: <55B83614.8090702@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

> I'm currently testing my code on my Nexus 4 device. Multi-Advertising works nicely but I can't get the device to accept incoming connection requests while in peripheral mode. I'm using Nordic's nRF Master Control app on my Samsung S4 in the central role for testing.
> 
> Here some sample debug output. When launching the connection request I get:
> 
> 07-29 03:14:36.816  16843-16843/? I/bluetoothd﹕
> mgmt_if: > 0b 00 00 00 1e 00 05 46 ab c2 01 94 00 00 00 00
> .......F........
> 
> 07-29 03:14:36.816  16843-16843/? I/bluetoothd﹕
> mgmt_if:   00 11 00 0b 09 66 67 2d 73 61 6d 73 75 6e 67 04
> .....fg-samsung.
> 
> 07-29 03:14:36.816  16843-16843/? I/bluetoothd﹕
> mgmt_if:   0d 0c 02 5a
> ...Z
> 
> 07-29 03:14:36.816  16843-16843/? I/bluetoothd﹕
> mgmt_if: [0x0000] event 0x000b
> 
> 07-29 03:14:36.816  16843-16843/? D/bluetoothd﹕
> external/bluetooth/bluez/android/bluetooth.c:mgmt_device_connected_event() 94:01:C2:AB:46:05 type 0
> 
> 07-29 03:14:36.829  16817-16875/com.android.bluetooth D/BlueZ﹕ external/bluetooth/bluez/android/hal-bluetooth.c:handle_acl_state_changed() state 0
> 
> 07-29 03:14:37.100  16843-16843/? D/bluetoothd﹕ external/bluetooth/bluez/android/gatt.c:connect_confirm()
> 
> 07-29 03:14:37.100  16843-16843/? D/bluetoothd﹕ external/bluetooth/bluez/android/gatt.c:device_set_state() gatt: Device 94:01:C2:AB:46:05 state changed DISCONNECTED -> CONNECT READY
> 
> 
> And then after the timeout:
> 
> 07-29 03:15:07.083  16843-16843/? D/bluetoothd﹕ external/bluetooth/bluez/android/gatt.c:connect_cb()
> 
> 07-29 03:15:07.083  16843-16843/? E/bluetoothd﹕ gatt: connection failed HUP or ERR on socket: Connection reset by peer (104)
> 
> 07-29 03:15:07.083  16843-16843/? D/bluetoothd﹕ external/bluetooth/bluez/android/gatt.c:device_set_state() gatt: Device 94:01:C2:AB:46:05 state changed CONNECT READY -> DISCONNECTED
> 
> 
> Symptoms:
> - The connection request times out.
> - bt_io_accept() is being called but the accept_cb (=connect_cb) only gets called when the request times out.
> - the device is stuck in the CONNECT READY state and never reaches the CONNECTED state
> 
> 
> Any ideas how I could analyze/solve that problem? I'm stuck on this for many hours already...

what does btmon actually tell you about what is going on with HCI. Remember that a connection disables advertising in the controller.

Regards

Marcel

