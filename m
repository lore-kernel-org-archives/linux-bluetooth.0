Return-Path: <cyrus@holtmann.org>
From: Justinas Vilimas <justinas@tableair.com>
Content-Type: text/plain; charset=utf-8
Subject: Cannot retrieve GATT services to Android >=5.0
Date: Thu, 9 Jul 2015 11:12:54 +0300
References: <C48F2B83-538D-4437-857A-0180CCF1A630@tableair.com>
To: linux-bluetooth@vger.kernel.org
Message-Id: <DE009F0F-05F3-494C-89B6-B6F8689CEE90@tableair.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3059\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

I am having trouble on retrieving GATT services with Android >=5.0 devices. GATT services are hosted on a RaspberryPi B+ (with a Bluetooth 4.0 dongle ASUS BT-400). 

I have tested with numerous configurations using different BlueZ versions, kernels and phone models with no success. Android <5.0 and iOS devices work perfectly fine.

Current latest setup I use is 4.1.1+ kernel and 5.32 BlueZ build with experimental enabled.

The whole procedure is as follows:
1. I start the hci0 device and then launch the 5.32 bluetoothd with -nEd params.

2. I initially set the advertising data with this command:
sudo hcitool -i hci0 cmd 0x08 0x0008 14 02 01 02 02 0A A0 0D 09 54 61 62 6C 65 41 69 72 54 56 53 57 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

3. And enable advertising with the command: sudo ./hciconfig hci0 leadv 0

4. Also I start the sample ‘example-gatt-server’ from the test folder in the BlueZ repository.

The bluetoothd seems to accept the sample gatt services and add it to the gatt-database.

When trying to connect to the RPi, Android device successfully discovers the peripheral and successfully connects to it. The device also retrieves initial 1800 and 1801 services, but no additional services from the ‘example-gatt-server'. Whereas Android <5.0 and all tested iOS devices successfully retrieves all GATT services and is able to read or write the discovered characteristics.

I noticed in the bluetoothd log that Android 5.0 fails to perform the MTU exchange:
bluetoothd[11618]: src/adapter.c:connected_callback() hci0 device 48:59:29:61:F0:54 connected eir_len 14
bluetoothd[11618]: src/adapter.c:new_link_key_callback() hci0 new key for 48:59:29:61:F0:54 type 4 pin_len 0 store_hint 0
bluetoothd[11618]: src/device.c:device_bonding_complete() bonding (nil) status 0x00
bluetoothd[11618]: src/adapter.c:resume_discovery() 
bluetoothd[11618]: src/gatt-database.c:connect_cb() New incoming LE ATT connection
bluetoothd[11618]: attrib/gattrib.c:g_attrib_ref() 0x16233d8: g_attrib_ref=1 
bluetoothd[11618]: src/device.c:gatt_debug() MTU Exchange failed. ATT ECODE: 0x06
bluetoothd[11618]: src/device.c:gatt_client_ready_cb() status: failed, error: 6

How is Android >=5.0 different from older versions and iOS when talking with GATT server? Is there any way to solve this?

Help is greatly appreciated, thanks!

Best wishes,
Justinas Vilimas

