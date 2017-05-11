Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jonah Petri <jonah@sense.com>
Content-Type: text/plain; charset=utf-8
Subject: Detecting GATT connections over bus
Message-Id: <23EE3325-275B-437E-9A1E-2AE5B4ADEA4B@sense.com>
Date: Thu, 11 May 2017 15:13:58 -0400
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am writing a BTLE GATT peripheral using Bluez5 5.45 on Linux 4.1.15 =
and a bcm43xx chip.  I=E2=80=99m trying to use the DBus GATT and =
LEAdvertising interfaces.  I need to detect LE host connection and =
disconnection.

I tried registering a dbus message match for PropertiesChanged on =
org.bluez.Device1, and watching Connected switch on and off, but that is =
not reliable, and seems to only happen when bluetoothd wants to resolve =
services on the connecting host.  In particular, I definitely see cases =
where:

1) Initially, all devices listed in ManagedObjects are =E2=80=9CConnected"=
 =3D=3D false
2) btmon reveals a subsequent "LE Connection Complete=E2=80=9D event
3) GATT transactions are initiated by the remote host and received by my =
application via DBus
4) No "Connected =3D true=E2=80=9D PropertiesChanged message is ever =
received by my application

This leads me to believe that the =E2=80=9CConnected =3D true=E2=80=9D =
transition occurs on some other event.  I do see it sometimes, but it =
doesn=E2=80=99t seems to correlate to a LE connection.

What can I do to tell when a new host connects to my GATT peripheral?

Many thanks for any help,
Jonah=
