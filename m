Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 25 Jun 2015 11:12:20 -0700
Message-ID: <CAPyD+=CwiwARGqT-tKomaJ+o9O6tAiMJ25TiqxFuT2DDS+VKxQ@mail.gmail.com>
Subject: Unreliable LE advertisement registration through BlueZ advertising API
From: "Othman, Ossama" <ossama.othman@intel.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to leverage the LE advertising API in BlueZ 5.31 but
advertisement registration sometimes fails with an Invalid Parameters
error:

Jun 24 21:56:06 orion bluetoothd[21940]:
src/advertising.c:register_advertisement() RegisterAdvertisement
Jun 24 21:56:06 orion bluetoothd[21940]:
src/advertising.c:advertisement_create() Adding proxy for
/org/iotivity/gatt/advertisement0
Jun 24 21:56:06 orion bluetoothd[21940]:
src/advertising.c:register_advertisement() Registered advertisement at
path /org/iotivity/gatt/advertisement0
Jun 24 21:56:06 orion bluetoothd[21940]:
src/advertising.c:parse_advertising_service_uuids() Adding
ServiceUUID: ADE3D529-C784-4F63-A987-EB69F70EE816
Jun 24 21:56:06 orion bluetoothd[21940]:
src/advertising.c:refresh_advertisement() Refreshing advertisement:
/org/iotivity/gatt/advertisement0
Jun 24 21:56:06 orion bluetoothd[21940]: Failed to add advertisement:
Invalid Parameters (0x0d)

It looks like my LEAdvertisement1 object itself is fine since BlueZ
doesn't complain about it. There are times when registration succeeds,
as well.

Adding an advertisement with the same data through the btmgmt tool
will fail in the same way if I provide a bogus instance ID:

[mgmt]# add-adv -c -g -u ADE3D529-C784-4F63-A987-EB69F70EE816 0
Add Advertising failed with status 0x0d (Invalid Parameters)

but is fine if I provide a suitable instance ID:

[mgmt]# add-adv -c -g -u ADE3D529-C784-4F63-A987-EB69F70EE816 1
Instance added: 1

As a sanity check I ran test/example-advertisement but it fails for
other reasons:

$ ./example-advertisement
Failed to register advertisement: org.bluez.Error.Failed: Failed to
parse advertisement

The log output
Jun 25 11:04:43 void-dev bluetoothd[758]:
src/advertising.c:register_advertisement()
RegisterAdvertisement
Jun 25 11:04:43 void-dev bluetoothd[758]:
src/advertising.c:advertisement_create() Adding proxy for
/org/bluez/example/advertisement0
Jun 25 11:04:43 void-dev bluetoothd[758]:
src/advertising.c:register_advertisement() Registered advertisement at
path /org/bluez/example/advertisement0
Jun 25 11:04:43 void-dev dbus[793]: [system] Rejected send message, 1
matched rules; type="method_call", sender=":1.2" (uid=0 pid=758
comm="/usr/libexec/bluetooth/bluetoothd --experimental -")
interface="org.freedesktop.DBus.Properties" member="GetAll" error
name="(unset)" requested_reply="0" destination=":1.222" (uid=1000
pid=13905 comm="/usr/bin/python ./example-advertisement ")
Jun 25 11:04:43 void-dev bluetoothd[758]: Failed to read "Type"
property of advertisement

Any ideas on what could be causing the intermittent advertisement
registration failures when using the BlueZ D-Bus advertising API?

Thanks,
-Ossama
