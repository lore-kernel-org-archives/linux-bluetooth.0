Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: James Baker <j.baker@outlook.com>
Date: Wed, 7 Aug 2013 15:21:23 +0100
Message-ID: <CAGoJ=AsiXm7=-0rK2Wm6k+DY85wDoM2WN-eCT8qFpm+sy2B62w@mail.gmail.com>
Subject: using the DBus profiles in BlueZ 5
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm using the DBus api in order to attempt to communicating with a Ble
device. This device can masquerade as (among others) a heart rate
monitor or a health thermometer. I'm trying to get BlueZ to detect
this device as being either a heart rate monitor or a health
thermometer (depending on which is flashed).

What I've done (beyond compile 5.7 with the experimental additions):
Set systemd to launch with the argument -E in order to enable
experimental profiles (as mentioned in
https://gitorious.org/~moreira/bluez-le-docs/moreira-bluez-le-docs/blobs/master/bluez-le-howto.tex)

Launched d-feet and navigated to org.bluez. Found hci0, enabled
discovery. Waited to discover the correct device. Connected to the
device.
No heartrate information has been presented, and it is seemingly not
present in the whole of the object tree.

Executing /test/test-heartrate results in an error such as
org.freedesktop.DBus.Error.UnknownMethod "RegsterWatcher" with
signature "s" on interface "org.bluez.HeartRateManager" doesn't exist.

Does anyone know of anything I've missed? I've been reading the docs
and they imply the service should have been registered when I
connected.

The device is definitely exposing itself as a heart rate monitor; I've
checked with the Bluetooth SIG assigned numbers.

James
