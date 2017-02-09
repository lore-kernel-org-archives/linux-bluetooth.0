Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bridger Maxwell <bridger.maxwell@gmail.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Scanning for advertising packets more often
Message-Id: <508E30B7-76A0-4589-8D2D-5C736695E4C4@gmail.com>
Date: Wed, 8 Feb 2017 21:09:44 -0500
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I=E2=80=99m trying to make a Bluetooth LE peripheral that will work =
without pairing. Instead, multiple receivers can listen for events by =
listening for changes in the advertising packet. I=E2=80=99ve got the =
peripheral configured to broadcast every 100ms, but the receiver running =
Bluez only gets updates about once per second.

Is there a way to configure Bluez to get advertising packets scanned =
more often? I=E2=80=99d also like to turn off any duplicate filtering.

Additionally, the peripheral broadcasts two types of advertising =
packets. One type is from the builtin firmware and I don=E2=80=99t care =
about. The other type is my custom advertising packet. Both of these =
have the same MAC address. I believe Bluez is filtering duplicates from =
the same address within each 1 second window. I am getting a random =
sampling of either the firmware advertising packet or my custom =
advertising packet once per second.

I=E2=80=99m using Pybluez[ble] to use Bluez. This is the scratch script =
I have running so far: =
https://gist.github.com/bridger/83fc2e9c60fd07d925b0bec80c47acab I tried =
using LE_SET_SCAN_PARAMETERS to change the scan interval and window but =
this didn=E2=80=99t seem to have an effect.

If this is a bad idea, let me know. I liked the simplicity of not =
pairing but maybe I=E2=80=99m headed in the wrong direction.

- Bridger Maxwell=
