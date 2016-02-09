Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Feb 2016 22:03:56 +0100
Message-ID: <CAAMmcSSVJ_mgKjhOWO5Y_Y0FhBRefT+bFshf3hcg2Wtoe5K-qg@mail.gmail.com>
Subject: GATT server
From: =?UTF-8?Q?Mikl=C3=B3s_Fazekas?= <mfazekas@szemafor.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I'm trying to develop a GATT server with bluez on a raspberry to
communicate with iOS via BLE.

I've managed to get one working with bluez 5.28 based on
plugins/gatt-example.c (gatt_service_add). But i have some weird
issues when sending more 70 bytes in a packet to iOS devices - not
always but sometimes.

So i try to upgrade bluez to investigate on the latest version. My
understanding is that while the plugins/gatt_service_add is still in
5.37 repo, and they compile fine, they are now depreacted, and dbus is
the replacement.

I'm a dbus newby. I configured/running with experimental. Moreover
python example (../test/example-gatt-server) seems to work fine. But
running C example (tools/gatt-service) gives me this error:

   RegisterService: Method "RegisterService" with signature "oa{sv}"
on interface "org.bluez.GattManager1" doesn't exist

But my limited dbus fu on python showed this signature for the method.
Does the example tools/gatt-service works? Can anyone give me pointer
to figure out the RegisterService issue above?

Thanks,
Miklós


http://permalink.gmane.org/gmane.linux.bluez.kernel/55510
Linux raspberrypi 4.1.13-v7+


When running the python example:

sudo ../test/example-gatt-server
GetManagedObjects
GetManagedObjects
GetManagedObjects
GATT service registered
GATT service registered
GATT service registered


And in bluetoothd log i see services registered:

Feb 09 20:44:13 raspberrypi bluetoothd[353]:
src/gatt-database.c:client_ready_cb() GATT service registered:
/org/bluez/example/service2

sudo dbus-monitor --system

signal sender=org.freedesktop.DBus -> dest=:1.19 serial=2
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameAcquired
   string ":1.19"
signal sender=org.freedesktop.DBus -> dest=(null destination)
serial=54 path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameOwnerChanged
   string ":1.20"
   string ""
   string ":1.20"
signal sender=:1.2 -> dest=(null destination) serial=297
path=/org/bluez/hci0; interface=org.freedesktop.DBus.Properties;
member=PropertiesChanged
   string "org.bluez.Adapter1"
   array [
      dict entry(
         string "UUIDs"
         variant             array [
               string "00001801-0000-1000-8000-00805f9b34fb"
               string "00001200-0000-1000-8000-00805f9b34fb"
               string "00001800-0000-1000-8000-00805f9b34fb"
               string "0000180d-0000-1000-8000-00805f9b34fb"
            ]
      )
   ]
   array [
   ]

For the C program i see this in dbus monitor:

signal sender=org.freedesktop.DBus -> dest=:1.22 serial=2
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameAcquired

   string ":1.22"

signal sender=org.freedesktop.DBus -> dest=(null destination)
serial=59 path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameOwnerChanged

   string ":1.23"

   string ""

   string ":1.23"

signal sender=:1.23 -> dest=(null destination) serial=6 path=/;
interface=org.freedesktop.DBus.ObjectManager; member=InterfacesAdded

   object path "/service1"
   array [
      dict entry(
         string "org.freedesktop.DBus.Introspectable"
         array [
         ]
      )

      dict entry(
         string "org.bluez.GattService1"
         array [
            dict entry(
               string "UUID"
               variant                   string
"00001802-0000-1000-8000-00805f9b34fb"
            )
         ]
      )

      dict entry(
         string "org.freedesktop.DBus.Properties"
         array [
         ]
      )
   ]

signal sender=:1.23 -> dest=(null destination) serial=7 path=/;
interface=org.freedesktop.DBus.ObjectManager; member=InterfacesAdded
   object path "/service1/characteristic1"
   array [
      dict entry(
         string "org.freedesktop.DBus.Introspectable"
         array [
         ]
      )
      dict entry(
         string "org.bluez.GattCharacteristic1"
         array [
            dict entry(
               string "UUID"
               variant                   string
"00002a06-0000-1000-8000-00805f9b34fb"
            )
            dict entry(
               string "Value"
               variant                   array of bytes [
                     00
                  ]
            )
            dict entry(
               string "Flags"
               variant                   array [
                     string "write-without-response"
                  ]
            )
         ]
      )

      dict entry(
         string "org.freedesktop.DBus.Properties"
         array [
         ]
      )
   ]

signal sender=:1.23 -> dest=(null destination) serial=8 path=/;
interface=org.freedesktop.DBus.ObjectManager; member=InterfacesAdded

   object path "/service1/characteristic1/descriptor2"
   array [
      dict entry(
         string "org.freedesktop.DBus.Introspectable"
         array [
         ]
      )

      dict entry(
         string "org.bluez.GattDescriptor1"
         array [
            dict entry(
               string "UUID"
               variant                   string
"8260c653-1a54-426b-9e36-e84c238bc669"
            )

            dict entry(
               string "Value"
               variant                   array [
                  ]
            )
         ]
      )
      dict entry(
         string "org.freedesktop.DBus.Properties"
         array [
         ]
      )
 ]
