Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 4 Sep 2015 18:05:56 +0600
Message-ID: <CACjvaw=OrVRqQG37j6gh7Pap7sksqonNhauBrHxTK720T-Uk-g@mail.gmail.com>
Subject: DBus WriteValue is failing for bluez 5.31 with kernel 4.1+
From: Nazmul Alam <fadedreamz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I am unable to write to atrribute value to a characteristics exposed
via dbus on the new 4.1 kernel.

Before upgrading to kernel 4.1 the same application can write
attribute value to the characteristics via dbus without any issue.

Following is the log collected from bluetoothd -

org.freedesktop.DBus.Error.AccessDenied: Rejected send message, 1
matched rules; type="method_call", sender=":1.24" (uid=0 pid=4112
comm="bluez-5.31/src/bluetoothd -ndE ")
interface="org.bluez.GattCharacteristic1" member="WriteValue" error
name="(unset)" requested_reply="0" destination=":1.25" (uid=0 pid=4114
comm="./test ")

Any suggestions?
Thanks in advance.
