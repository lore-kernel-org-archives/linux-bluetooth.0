Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 18 Aug 2011 10:53:52 -0700
Message-ID: <CA+GuLwdbSoT-iZg9EjTbxidr+fEE-KU8qgOZAyr_h05Gq9Xrgg@mail.gmail.com>
Subject: need help with bluez pairing/connecting device
From: Ram Bhamidipaty <rambham@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am writing some new software that talks to bluez-4.96.

I have some how gotten a device into a weird state. When I make
a dbus call to org.bluez.Adapter.GetProperties
I see my target device in the list:

       dict entry(
         string "Devices"
         variant             array [
               object path "/org/bluez/8090/hci0/dev_00_22_48_85_50_1D"
            ]
      )


When a device is listed here - what does it mean? I am guessing that
at this point the pairing process is over. Or does it mean something else?

However the device is not yet connected. So I next try to connect:

dbus-send --system --type=method_call --print-reply --dest=org.bluez
/org/bluez/8090/hci0/dev_00_22_48_85_50_1D org.bluez.Input.Connect

This fails with a cryptic:

Error org.bluez.Error.Failed: Host is down (112)

Any help is appreciated.
-Ram
