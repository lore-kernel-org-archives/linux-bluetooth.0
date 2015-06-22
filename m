Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2015 18:59:50 -0500
Message-ID: <CABKPALo_wHz4LifYPH7vmHabJ50fKmYRvF5VWzBQh=TVWEFXeQ@mail.gmail.com>
Subject: SeviceData PropertiesChanged
From: Neil Martin <neil@vnp.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I’ve just installed 5.31 and started looking at the new advertising
data that's been added to Device1.  I'm seeing odd behavior for
ServiceData.  I live within range of a large number of bluetooth
devices and for one of them, I'm getting PropertiesChanged signals for
ServiceData that get fired multiple times each minute. Each time the
dictionary contains another entry for the same key and all the data
entries are identical.  Here are the first two signals from
dbus-monitor:


signal sender=:1.0 -> dest=(null destination) serial=43
path=/org/bluez/hci0/dev_C2_A9_8A_AE_A5_28;
interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
   string "org.bluez.Device1"
   array [
      dict entry(
         string "ServiceData"
         variant             array [
               dict entry(
                  string "180a"
                  variant                      array of bytes [
                        02 37 28 a5 ae 8a a9 c2 5a 00 00 00 03 13 00 02
                     ]
               )
               dict entry(
                  string "180a"
                  variant                      array of bytes [
                        02 37 28 a5 ae 8a a9 c2 5a 00 00 00 03 13 00 02
                     ]
               )
            ]
      )
   ]
   array [
   ]


signal sender=:1.0 -> dest=(null destination) serial=50
path=/org/bluez/hci0/dev_C2_A9_8A_AE_A5_28;
interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
   string "org.bluez.Device1"
   array [
      dict entry(
         string "ServiceData"
         variant             array [
               dict entry(
                  string "180a"
                  variant                      array of bytes [
                        02 37 28 a5 ae 8a a9 c2 5a 00 00 00 03 13 00 02
                     ]
               )
               dict entry(
                  string "180a"
                  variant                      array of bytes [
                        02 37 28 a5 ae 8a a9 c2 5a 00 00 00 03 13 00 02
                     ]
               )
               dict entry(
                  string "180a"
                  variant                      array of bytes [
                        02 37 28 a5 ae 8a a9 c2 5a 00 00 00 03 13 00 02
                     ]
               )
            ]
      )
   ]
   array [
   ]

These signals keep coming and every time there is one more “dict
entry”.  Can anyone explain what I’m seeing?

Neil
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
