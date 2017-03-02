Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2190B102-4AAC-499B-A4E7-1FE0435F7C7B@gmail.com>
References: <0FD5C3A6-1C8B-482C-BC83-36DB5ED94551@gmail.com> <2190B102-4AAC-499B-A4E7-1FE0435F7C7B@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Mar 2017 10:01:33 +0200
Message-ID: <CABBYNZKJrCsi=nJXcLZhFbntCXPSBJVPe_cx3XqFYWBE7nJcwA@mail.gmail.com>
Subject: Re: Allow non-root user to access BLE DBus interface (systemd)
To: Travis Griggs <travisgriggs@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis,

On Wed, Mar 1, 2017 at 7:27 PM, Travis Griggs <travisgriggs@gmail.com> wrot=
e:
>
>> On Mar 1, 2017, at 8:35 AM, Travis Griggs <travisgriggs@gmail.com> wrote=
:
>>
>> This is not directly bluez/ble related, but rather derived from their us=
e. I=E2=80=99ve been prototyping my BLE peripheral behavior running as root=
. Now I=E2=80=99m hardening things and partitioning the BLE app to a non-ro=
ot user. My service now errors out with the following:
>>
>> dbus.exceptions.DBusException: org.freedesktop.DBus.Error.AccessDenied: =
Rejected send message, 2 matched rule
>> s; type=3D"method_call", sender=3D":1.6797" (uid=3D107 pid=3D17300 comm=
=3D"/usr/bin/python3 -u /opt/pilot/bleMainloop ") interface=3D"org.freedesk=
top.DBus.Objec
>> tManager" member=3D"GetManagedObjects" error name=3D"(unset)" requested_=
reply=3D"0" destination=3D":1.2" (uid=3D0 pid=3D1373 comm=3D"/usr/lib/bluet=
ooth/bluetoothd
>> -d -E --noplugin=3D* =E2=80=9C)

These interfaces have never been blocked, in fact that how
bluetoothctl access BlueZ so you probably have something wrong with
your configuration.

>> I see that there=E2=80=99s a bluetooth.conf in /etc/dbus-1/system.d. Do =
I need to tune something in this file to allow my app to still use the BLE =
DBus services? Any examples or pointers would be appreciated.
>>
>> (sorry if this ended up a repeat post)
>
> The same question in another forum if you want to earn Stack points:
>
> http://unix.stackexchange.com/questions/348441/how-to-allow-non-root-syst=
emd-service-to-use-dbus-for-ble-operation--
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
