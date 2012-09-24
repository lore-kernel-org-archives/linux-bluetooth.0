Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 24 Sep 2012 08:55:05 -0400
Message-ID: <CAKON4OwW4_4KoseeQqa4_JW5nY0UCLdSAZzU36RrOAtuiA151g@mail.gmail.com>
Subject: LE thermometer on Ubuntu 12.10
From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ubuntu 12.10 has 4.101 and kernel 3.5. I'm trying to get the sample
CC2540 thermometer application from TI working.  The 4.101 package
build has --enable-thermometer set.

I can see my TI device under dbus. It shows the expect four services
and sixteen characteristics.
I have EnableGatt = true in /etc/bluetooth/main.conf

The test script, test-thermometer, is looking for
org.bluez.Thermometer which isn't there. Using d-feet to browse dbus
confirms that it is not there.

Is this profile plugin not registered somehow? How can I query the LE
profiles supported by my Bluez installation?

-- 
Jon Smirl
jonsmirl@gmail.com
