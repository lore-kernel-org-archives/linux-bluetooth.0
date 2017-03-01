Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Allow non-root user to access BLE DBus interface (systemd)
Date: Wed, 1 Mar 2017 09:27:41 -0800
References: <0FD5C3A6-1C8B-482C-BC83-36DB5ED94551@gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <0FD5C3A6-1C8B-482C-BC83-36DB5ED94551@gmail.com>
Message-Id: <2190B102-4AAC-499B-A4E7-1FE0435F7C7B@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Mar 1, 2017, at 8:35 AM, Travis Griggs <travisgriggs@gmail.com> =
wrote:
>=20
> This is not directly bluez/ble related, but rather derived from their =
use. I=E2=80=99ve been prototyping my BLE peripheral behavior running as =
root. Now I=E2=80=99m hardening things and partitioning the BLE app to a =
non-root user. My service now errors out with the following:
>=20
> dbus.exceptions.DBusException: =
org.freedesktop.DBus.Error.AccessDenied: Rejected send message, 2 =
matched rule
> s; type=3D"method_call", sender=3D":1.6797" (uid=3D107 pid=3D17300 =
comm=3D"/usr/bin/python3 -u /opt/pilot/bleMainloop ") =
interface=3D"org.freedesktop.DBus.Objec
> tManager" member=3D"GetManagedObjects" error name=3D"(unset)" =
requested_reply=3D"0" destination=3D":1.2" (uid=3D0 pid=3D1373 =
comm=3D"/usr/lib/bluetooth/bluetoothd
> -d -E --noplugin=3D* =E2=80=9C)
>=20
> I see that there=E2=80=99s a bluetooth.conf in /etc/dbus-1/system.d. =
Do I need to tune something in this file to allow my app to still use =
the BLE DBus services? Any examples or pointers would be appreciated.
>=20
> (sorry if this ended up a repeat post)

The same question in another forum if you want to earn Stack points:=20

=
http://unix.stackexchange.com/questions/348441/how-to-allow-non-root-syste=
md-service-to-use-dbus-for-ble-operation=
