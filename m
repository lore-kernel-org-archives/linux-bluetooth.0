Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?utf-8?Q?T=C3=B5nis_Tiganik?= <ttiganik@gmail.com>
Content-Type: text/plain; charset=us-ascii
Subject: No Connected=false event on iPhone app kill.
Message-Id: <4590C4C4-A8DB-4318-97E9-9489E1E00257@gmail.com>
Date: Thu, 10 Mar 2016 12:43:42 +0200
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

We have an iPhone app that is acting as a peripheral and bluez connects to it.

We do not receive properties changed signal from dbus that you would expect on device disconnection (Device.Connected = false) if we kill the iPhone app. We know the iPhone disconnects from bluez because the bluetooth icon goes from black to grey on the iPhone. We receive the connected=false signal if we turn the bluetooth off on the iPhone(keep the app alive) - in that case everything works correctly.

What is weird is that we receive object-removed signal for all of the bluez dbus stack, even for instance /org/bluez and /org/bluez/hci0. org.bluez also disappears from d-feet.

After this if we open the iPhone app and start broadcasting again, the bluez app does not work. If we restart the bluez app everything works as before.

Do you have any idea why we do not receive connected = false signal if we kill our connected iPhone app?

Why does the bluez lose its dbus interface if we kill our connected iPhone app?

