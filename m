Return-Path: <cyrus@holtmann.org>
From: Jon Nordby <jon@sqhead.com>
Content-Type: text/plain; charset=windows-1252
Subject: Detecting presence and connecting headset when not in pairing mode
Message-Id: <63DE85F1-67DB-4FF4-94FF-0DEE1EC710FC@sqhead.com>
Date: Mon, 28 Apr 2014 22:37:35 +0200
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I’m using BlueZ 4.98 with Ubuntu 12.04 on an embedded device.
When I power up a BT headset* (A2DP) in pairing mode, the DBus signal DeviceFound is emitted on /org/bluez/PID/hci0
But, when I power it up in normal modus, I do not see any signals firing on DBus. However, if I use “bt-audio -c MAC” it connects successfully.

How am I supposed to programatically detect that the headset is present and automatically establish a connection with it?

* Testing with a Sony DR-BT200 right now.

--
Jon Nordby - jon@sqhead.com
Software Engineer - Squarehead Technology A/S