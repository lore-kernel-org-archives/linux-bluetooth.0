Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Krasi Georgiev <krasi.root@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: How to use  GattProfile1
Message-Id: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com>
Date: Tue, 16 May 2017 14:42:47 +0300
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
out how to structure the  osa{sv} paramters
also tried dbus-send , but the tool doesn=E2=80=99t seem to support this =
structures (no nesting)


I am using golang godbus bindings and the call gets executed without an =
error , but the bluetooth adapter doesn=E2=80=99t auto connect


here is the gist
=
https://gist.githubusercontent.com/krasi-georgiev/56f88cd18893578fa83c328f=
038479d6/raw/25f11f2fd7b55d82590732fa8f253febda623645/main.go

go get github.com/godbus/dbus
wget =
https://gist.githubusercontent.com/krasi-georgiev/56f88cd18893578fa83c328f=
038479d6/raw/25f11f2fd7b55d82590732fa8f253febda623645/main.go
go run main.go


I would really appreciate some useful info.
Thanks=
