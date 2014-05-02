Return-Path: <cyrus@holtmann.org>
Message-ID: <1399056781.24457.6.camel@SejoLaptop>
Subject: Problems running the tests in BlueZ 5.18
From: Sejo Ruiz <sejoruiz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 02 May 2014 20:53:01 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.
This is the first mail that I write to this mailing list, so I'm not
sure how this works exactly. I need to develop an application with a
bluetooth dongle that makes use of the thermometer profile. The thing is
that, after succesfully pair and connect with the device, whenever I try
to run the test-therometer file, I obtain the following error:

dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod:
Method "RegisterWatcher" with signature "s" on interface
"org.bluez.ThermometerManager1" doesn't exist

I have also tested the test-heartrate, and I obtain something similar:

dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod:
Method "RegisterWatcher" with signature "s" on interface
"org.bluez.HeartRateManager1" doesn't exist

I have succesfully tested the dongle with bluetoothctl, so I can discard
hardware compatibilities issues.
I'd like to know if I'm missing something while running the tests. If
you need more data, like some configuration files or logs, you can ask
for it and i'll provide it ASAP.
Thank you very much for your help.

