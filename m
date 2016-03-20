Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Mar 2016 20:34:33 -0600
Message-ID: <CAASrBQkO4oNjR9j+Yz6CcmjhDChkABwKHR_-hgZoQCcTPnaWPA@mail.gmail.com>
Subject: Crash in src/gatt-client.c (was Re: setting indication on
 GattCharacteristic1 interface)
From: Mark Rages <markrages@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bluetoothd crashes when I attempt to close the connection and
reconnect through d-bus interface.

bluez @ 4d7b1d2b347423a7a79647e51b31744f3e044612

I've put the trace and btmon log here:

https://www.dropbox.com/sh/ddo9kuux9lixj4l/AAB-dWv3aZhfi27KXMMBkoHxa?dl=0

And here is the script that reliably triggers it.  It is an
implementation of the Nordic Semiconductor nRF51 DFU bootloader.
Unfortunately you need appropriate nRF51 hardware to duplicate this.

https://github.com/markrages/ble/blob/master/example_dfu.py

If there's any more information that would be useful, please let me
know, preferably with the exact command-line to gather the
information.

Regards,
Mark
markrages@gmail
