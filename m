Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH BLUEZ 0/4] Modify Health profile signals for ObjectManager
Date: Mon, 20 Jul 2015 00:31:07 +0900
Message-Id: <1437319871-3004-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

Since BlueZ has ObjectManager interface, ChannelConnected and ChannelDeleted
Signals of HealthDevice interface was not available. ObjectManager reports the
HealthChannel D-Bus interface when g_dbus_emit_signal function is called,
and generates "InterfaceAdded" signal. But ChannelConnected and ChannelDeleted
Siganls was not generated. If health-api document contains these signals,
application or service using Bluez Dbus API will get the unexpected result.

If we just remove g_dbus_emit_signal for ChannelConnected and ChannelDeleted,
InterfaceAdded signal will not sent. Because InterfaceAdded signal is pending
before sending a dbus signal. These patches include new property in HealthChannel
interfacem, and this PropertiesChanged signal can be used to replace the previous
ChannelConnected and ChannelDeleted signals.

Connected signal:

signal sender=:1.140 -> dest=(null destination) serial=280 path=/; interface=org.freedesktop.DBus.ObjectManager; member=InterfacesAdded
   object path "/org/bluez/hci0/dev_00_09_1F_80_3B_76/chan65279"
   array [
      dict entry(
         string "org.freedesktop.DBus.Introspectable"
         array [
         ]
      )
      dict entry(
         string "org.bluez.HealthChannel1"
         array [
            dict entry(
               string "Device"
               variant                   object path "/org/bluez/hci0/dev_00_09_1F_80_3B_76"
            )
            dict entry(
               string "Application"
               variant                   object path "/org/bluez/health_app_2"
            )
            dict entry(
               string "Type"
               variant                   string "reliable"
            )
            dict entry(
               string "Connected"
               variant                   boolean false
            )
         ]
      )
      dict entry(
         string "org.freedesktop.DBus.Properties"
         array [
         ]
      )
   ]
signal sender=:1.140 -> dest=(null destination) serial=281 path=/org/bluez/hci0/dev_00_09_1F_80_3B_76/chan65279; interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
   string "org.bluez.HealthChannel1"
   array [
      dict entry(
         string "Connected"
         variant             boolean true
      )
   ]
   array [
   ]
signal sender=:1.140 -> dest=(null destination) serial=282 path=/org/bluez/hci0/dev_00_09_1F_80_3B_76; interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
   string "org.bluez.HealthDevice1"
   array [
      dict entry(
         string "MainChannel"
         variant             object path "/org/bluez/hci0/dev_00_09_1F_80_3B_76/chan65279"
      )
   ]
   array [
   ]


Disconnected signal:

signal sender=:1.50 -> dest=(null destination) serial=284 path=/org/bluez/hci0/dev_00_09_1F_80_3B_76/chan65279; interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
   string "org.bluez.HealthChannel1"
   array [
      dict entry(
         string "Connected"
         variant             boolean false
      )
   ]
   array [
   ]
signal sender=:1.50 -> dest=(null destination) serial=285 path=/; interface=org.freedesktop.DBus.ObjectManager; member=InterfacesRemoved
   object path "/org/bluez/hci0/dev_00_09_1F_80_3B_76/chan65279"
   array [
      string "org.freedesktop.DBus.Properties"
      string "org.freedesktop.DBus.Introspectable"
      string "org.bluez.HealthChannel1"
   ]


Dohyun Pyun (4):
  doc/health-api: Add Connected property to HealthChannel
  profiles/health: Implement connected property in HealthChannel
  doc/health-api: Remove ChannelConnected and ChannelDeleted signals
  profiles/health: Remove HealthDevice signals

 doc/health-api.txt          |  19 +++-----
 profiles/health/hdp.c       | 108 ++++++++++++++++++++++++++++----------------
 profiles/health/hdp_types.h |   1 +
 3 files changed, 75 insertions(+), 53 deletions(-)

-- 
1.8.1.2

