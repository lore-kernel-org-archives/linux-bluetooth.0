Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Austin Riffle <ARiffle@efji.com>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: GAP and GATT always added to sdp records
Date: Tue, 13 Feb 2018 20:22:25 +0000
Message-ID: <4C851F03BEE04A418B7A2D283DDCAB5D47F28210@EFJDFWMB01.EFJDFW.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

I'm developing a Bluetooth solution using BlueZ 5.46 on kernel 4.12.0, and =
I'm using a TI Wilink chip for both BR/EDR and BLE. My plan is to initially=
 release software with support for only BR/EDR, and then at a later point r=
elease software which supports BLE.

I have not yet enabled BLE (knowingly), however, during testing I noticed t=
hat other devices are seeing my device advertise both GAP and GATT UUID's t=
hrough SDP. I am starting bluetoothd as follows:

/usr/libexec/bluetooth/bluetoothd --noplugin=3D*

I also do have bredr only marked in main.conf.

Tracing through the bluetoothd source, this is what I see:

...
adapter_register
btd_gatt_database_new
register_core_services
populate_gap_service/populate_gatt_service  **These add GAP_UUID and GATT_U=
UID to the SDP records

If any of these steps fail, the adapter fails to register, and these steps =
are required to be called. I realize that not marking the flag "G_DBUS_FLAG=
_ENABLE_EXPERIMENTAL" prevents any advertising, but I would really like to =
avoid putting GATT/GAP into my SDP records as they are not supported in any=
 meaningful way on my device.

Does BlueZ really force all adapters to advertise these services? Or is the=
re a "nice" way to stop these from being added?

I'm guessing I could go around bluetoothd's back and use sdp_lib to remove =
them, but I'm not sure what unintended consequences that may have.
This e-mail transmission, and any documents, files or previous e-mail messa=
ges attached to it, may contain confidential information. If you are not th=
e intended recipient, or a person responsible for delivering it to the inte=
nded recipient, you are hereby notified that any disclosure, distribution, =
review, copy or use of any of the information contained in or attached to t=
his message is STRICTLY PROHIBITED. If you have received this transmission =
in error, please immediately notify us by reply e-mail, and destroy the ori=
ginal transmission and its attachments without reading them or saving them =
to disk. Thank you.

