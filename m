Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 19 Dec 2016 17:41:30 +0000
From: Dario Teixeira <dario.teixeira@nleyten.com>
To: linux-bluetooth@vger.kernel.org
Subject: Data exchange between two bluetooth devices
Message-ID: <af00d3e489c2ea42ad03636143e3cb36@nleyten.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm new to Bluetooth programming, and I have some basic questions
about the best approach to implement a fairly simple scenario.
I have a small embedded device running Linux, and which supports
Bluetooth 4.0.  I'm also developing a mobile app that needs to
exchange some data with the embedded device.  The data consists
of only a few JSON-encoded objects and is small in volume. The
communication must happen bidirectionally, though.

Those are pretty much the requirements.  Now the questions:

a) On the embedded side, do I need to program a small daemon using
    the DBUS-based Bluez API, or can I set up a special device and
    read/write to it as if it were a character device?

b) The old interface [1] has been deprecated, right?  (It's my
    understanding that only the new DBUS-based API should be used.)

c) Is Bluetooth Classic or Bluetooth Low Energy better for this
    scenario? (I've read that BLE can dispense with pairing.)

Thanks in advance for your time!
Best regards,
Dario Teixeira

[1] https://people.csail.mit.edu/albert/bluez-intro/

