Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alan Kennedy <kennedya@3dgames.com.ar>
Date: Mon, 4 Jun 2018 13:55:21 -0300
Message-ID: <CANu8v=5T4eVp5S20P4a4GqHZq+dLcRsJSUYjktS8J=+e2=14hg@mail.gmail.com>
Subject: How to avoid discovering devices no longer powered on. BlueZ 5.x
 internal cache keeps discovering them
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there,
             I'm developing a system with BLE Devices on linux,
running Bluez 5.47. Correct me if i'm wrong, but a BLE Discovery of
the devices is mandatory in order to BlueZ to create the Device1 on
DBUS, dynamically as stated in the porting guide.

Otherwise if i try to connect directly to the mac address i get an
error on the Connect method since the Device1 object does not exist on
the DBUS tree.

If i do the discovery, everything works just fine up to that point, i
discover the devices, i connected to them, read their characteristics.

The thing is, my users might remove the device from the system, and
power off the device at all. So no more advertisement of that device
is done.

Nevertheless, if i they run a BLE Discovery again, it seems the BlueZ
cache will keep finding that device that is no longer powered on, so
it gets added back to my system.

I think it's the cache in /var/lib/bluetooth/[local_device_mac]/XX:XX:XX:XX

Also, one thing i don't understand is what is this statement refering
to in the porting guide "Once the discovery stops, devices neither
connected to or paired will be automatically removed by bluetoothd
within three minutes". What gets removed and from where?

Is there any workaround to this? Why is BlueZ giving devices that are
no longer advertising in the air as found when running a BLE
Discovery?

Thank you.

Warm regards,
Alan
