Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC 0/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
Date: Fri, 18 Jul 2014 23:06:47 -0700
Message-Id: <1405750008-7652-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the upcoming beta release of Chrome OS (which uses BlueZ as its Bluetooth
stack) we have implemented the chrome.bluetoothLowEnergy JavaScript API for
Chrome browser applications
(https://developer.chrome.com/apps/bluetoothLowEnergy). For Chrome OS, we wrote
an implementation of the proposed GATT D-Bus API for bluetoothd, during which we
ran into some issues with the current proposal and changed things up a bit.

This set includes one patch that proposes changes for the currently
unimplemented GATT D-Bus API for desktop bluetoothd. The following changes are
proposed:

 * The addition of the following new properties:

   - org.bluez.GattService1: "Primary", "Device", "Characteristics"
   - org.bluez.GattCharacteristic1: "Notifying", "Descriptors"

   While all characteristic and descriptor objects become available via
   ObjectManager as soon as they get discovered, the "Characteristics" and
   "Descriptors" properties of service and characteristic objects do not get set
   until all characteristics and descriptors of a service have been discovered.
   This is used to let applications know that discovery of a service is complete
   and that the service is ready to interact with.

 * Removal of the "Permissions" property from org.bluez.GattDescriptor1.

 * Removal of the "Value" property from org.bluez.GattCharacteristic1 and
   GattDescriptor1. The introduction of the following asynchronous methods and
   signals:

   - ReadValue method, which always reads the value of a characteristic or
     descriptor from the remote device and returns the result asynchronously.
     This removes the problems of the org.freedesktop.DBus.Properties.Get
     method when the value is implemented as a property:

     -- The Get and GetAll methods are synchronous. This causes problems when a
        round-trip is required to obtain the value from the remote device.
     -- The ambiguity involved in the role of Get/GetAll when a characteristic
        doesn't support reads. Some characteristics are only writable and some
        make their values known via notifications and not reads.

   - WriteValue method, which is used to write the value of a characteristic or
     descriptor.

   - ValueUpdated signal, emitted when a characteristic notification or
     indication is received.

  * Addition of the StartNotify and StopNotify methods to
    org.bluez.GattCharacteristic1. This allows multiple applications to enable
    notifications from a characteristic without interfering with each other and
    applications are not permitted to directly write to the "Client
    Characteristic Configuration" descriptor.


Arman Uguray (1):
  doc/gatt-api: New API properties and methods for the GATT D-Bus API.

 doc/gatt-api.txt | 118 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 104 insertions(+), 14 deletions(-)

-- 
2.0.0.526.g5318336

