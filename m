Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 29 Sep 2012 22:28:18 +0200
Message-ID: <CAGXs5wX2N7P5=_ZwPPUw-kUxGjhpMB2xyfWHmHOUM99XggvQ2Q@mail.gmail.com>
Subject: scan fails
From: Kevin Wilson <wkevils@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I have fedora 17.
When I try:
hciconfig hci0 up
I get:
Can't init device hci0: Connection timed out (110)

lsusb  DOES recognize the USB BT
lsusb
....
Bus 004 Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)
