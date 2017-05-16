Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Krasi Georgiev <krasi.root@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Some pointers how to use  GattProfile1
Message-Id: <059FF3E6-1D59-44D7-A9D3-1428FA5DDE66@gmail.com>
Date: Tue, 16 May 2017 14:21:54 +0300
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all

Can you give me a quick example with a pseudo code (or using qdbus) for  =
workflow steps how to setup an auto connect to a device that supports =
given UUID service (0000180f-0000-1000-8000-00805f9b34fb - Battery =
Service)

=46rom what I understand all I need to do is send a call to the sytembus =
to register the hci0 adapter to auto connect

org.bluez.ProfileManager1.RegisterProfile , /org/bluez/Test (ObjPath), =
"00001802-0000-1000-8000-00805f9b34fb=E2=80=9D (service UUID)

and if the discovery finds a device with such service it should auto =
connect right ?


I am not sure what is the ObjPath parameter for and when i introspect I =
don=E2=80=99t even see the /org/bluez/GattProfile1

I am using bluez Version 5.45 on a Raspberry Pi zero
Linux 4.4.50+   armv6l


I tried making the call using with gdbus, but couldn=E2=80=99t figure =
out how to structure the  osa{sv}=20
also tried dbus-send , but the tool doesn=E2=80=99t seem to support this =
structures as well

I would really appreciate some pointers.=
