Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 6 Sep 2015 17:23:15 +0300
Message-ID: <CAMib2GZpa=FgsNKXThWnNZ=m=nQgLJj8j1bYd8v12vb1dwOLNg@mail.gmail.com>
Subject: iOS 8 can't discover device
From: Kyle Shneider <shneiderkyle@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello again.

I'm testing bluez 5.33 on raspberry pi. After successfully launching
bluetoothd, powering hci-device up and setting it 'Discoverable' (done
through DBus API) iPad mini can't see it. In other way shitty android
4.1.1 tablet finds raspberry in a moment.
Have i missed something?
Did anyone have successful experience of pairing apple devices and
latest versions of bluez?
BTW ble adapter: cambridge silicon radio.

-- 
Kyle Shneider
