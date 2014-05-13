Return-Path: <cyrus@holtmann.org>
From: Rick Mann <rmann@latencyzero.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_C841F0F0-D678-40C8-A20A-D8C61FA72461"; protocol="application/pgp-signature"; micalg=pgp-sha1
Subject: BLE connection failing
Message-Id: <B473A0F2-765A-47EC-950F-69FAF659504B@latencyzero.com>
Date: Mon, 12 May 2014 17:57:51 -0700
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_C841F0F0-D678-40C8-A20A-D8C61FA72461
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I've gotten a little closer to my goal of creating a BLE peripheral with =
BlueZ.

I run bluetoothd -d -E -n, get some logging, ending with:

> ...
> bluetoothd[676]: ../src/adapter.c:trigger_passive_scanning()=20
> bluetoothd[676]: ../src/adapter.c:new_settings_callback() Settings: =
0x000002d1
> bluetoothd[676]: ../src/adapter.c:settings_changed() Changed settings: =
0x00000010
> bluetoothd[676]: ../src/adapter.c:new_settings_callback() Settings: =
0x000002d3
> bluetoothd[676]: ../src/adapter.c:settings_changed() Changed settings: =
0x00000002
> bluetoothd[676]: ../src/adapter.c:local_name_changed_callback() Name: =
linaro-developer
> bluetoothd[676]: ../src/adapter.c:local_name_changed_callback() Short =
name:=20
> bluetoothd[676]: ../src/adapter.c:local_name_changed_callback() =
Current alias: linaro-developer
> bluetoothd[676]: ../src/attrib-server.c:attrib_db_update() =
handle=3D0x0006

Then I connect from the BLE Tool app on an iPad:

> bluetoothd[676]: ../src/adapter.c:connected_callback() hci0 device =
7D:F1:8F:C5:9D:14 connected eir_len 0
> bluetoothd[676]: ../src/device.c:device_create() dst 7D:F1:8F:C5:9D:14
> bluetoothd[676]: ../src/device.c:device_new() address =
7D:F1:8F:C5:9D:14
> bluetoothd[676]: ../src/device.c:device_new() Creating device =
/org/bluez/hci0/dev_7D_F1_8F_C5_9D_14
> bluetoothd[676]: ../src/device.c:btd_device_set_temporary() temporary =
1
> bluetoothd[676]: ../src/adapter.c:adapter_connect_list_remove() device =
/org/bluez/hci0/dev_7D_F1_8F_C5_9D_14 is not on the list, ignoring
> bluetoothd[676]: ../src/attrib-server.c:connect_event()=20
> bluetoothd[676]: ../src/device.c:device_create() dst 7D:F1:8F:C5:9D:14
> bluetoothd[676]: ../src/device.c:device_new() address =
7D:F1:8F:C5:9D:14
> bluetoothd[676]: ../src/device.c:device_new() Creating device =
/org/bluez/hci0/dev_7D_F1_8F_C5_9D_14
> bluetoothd[676]: Unable to register device interface for =
7D:F1:8F:C5:9D:14
> bluetoothd[676]: ../src/device.c:device_free() 0x156a20
> bluetoothd[676]: ../src/adapter.c:dev_disconnected() Device =
7D:F1:8F:C5:9D:14 disconnected, reason 2
> bluetoothd[676]: ../src/adapter.c:adapter_remove_connection()=20
> bluetoothd[676]: ../src/adapter.c:adapter_remove_connection() Removing =
temporary device /org/bluez/hci0/dev_7D_F1_8F_C5_9D_14
> bluetoothd[676]: ../src/device.c:device_remove() Removing device =
/org/bluez/hci0/dev_7D_F1_8F_C5_9D_14
> bluetoothd[676]: ../src/device.c:btd_device_unref() Freeing device =
/org/bluez/hci0/dev_7D_F1_8F_C5_9D_14
> bluetoothd[676]: ../src/device.c:device_free() 0x156d58
> bluetoothd[676]: ../src/adapter.c:bonding_attempt_complete() hci0 =
bdaddr 7D:F1:8F:C5:9D:14 type 2 status 0xe
> bluetoothd[676]: ../src/adapter.c:resume_discovery()=20

At this point, advertising is turned off and I can't re-connect until I =
turn it back on, after which the process just repeats.

Any idea why I can't make that connection? What does "Unable to register =
device interface for 7D:F1:8F:C5:9D:14" mean?

Thanks!

--=20
Rick




--Apple-Mail=_C841F0F0-D678-40C8-A20A-D8C61FA72461
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlNxbg8ACgkQBzBA/9aDmJs8mQCdFi323PCvmZVlL/74K+f8jQze
7CkAmgIG3vtj4aJx5cro5neEiAEhbNt+
=SJJg
-----END PGP SIGNATURE-----

--Apple-Mail=_C841F0F0-D678-40C8-A20A-D8C61FA72461--
