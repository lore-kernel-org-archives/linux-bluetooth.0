Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 3 Sep 2015 09:45:46 +1000
Message-ID: <CAPcThSFf8r5y+zhrbK9m-srjLx_GUCL43RLzLsh1nD752NZ8HQ@mail.gmail.com>
Subject: How to stop device creation process properly?
From: Qingtao Cao <qingtao.cao.au@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear community,

I am using bluez-4.101 for Ubuntu 15.04 (vivid), I have successfully
come up with a C program to pair remote bluetooth device smoothly by
referencing test/agent.c.

When I use my program to pair with a keyboard, the DisplayPasskey
messages are sent by bluetoothd during pairing process, the problem I
run into is after I deliberately type in wrong passkeys on the
keyboard to make the first pairing failed, the next pairing attempt
won't be treated in the same manner by bluez. In particular, Release
message is sent directly without any DisplayPasskey messages sent at
all.

When I check local adapter's properties, sometimes (just sometimes) I
could find an object path created for the keyboard device, despite the
pairing failed (7C:1E:52:2E:5B:8A is its bdaddr):


$ dbus-send --system --print-reply --dest=org.bluez $BTADAPTER
org.bluez.Adapter.GetProperties
method return sender=:1.2 -> dest=:1.181 reply_serial=2
   array [
      ......
      dict entry(
         string "Devices"
         variant             array [
               object path "/org/bluez/961/hci1/dev_1C_48_F9_AD_19_EE"
               object path "/org/bluez/961/hci1/dev_7C_1E_52_2E_5B_8A"
            ]
      )
      dict entry(
         string "UUIDs"
         variant             array [
        ......
            ]
      )
   ]


Whereas the linkkeys file for sure doesn't contain an entry for it due
to incorrect passkey

Moreover, I also tried to delete such object path that may be created
during the unsuccessful pairing attempt, bluez says that "Device
creation in progress":

$ dbus-send --system --print-reply --dest=org.bluez $BTADAPTER
org.bluez.Adapter.RemoveDevice
objpath:/org/bluez/961/hci1/dev_7C_1E_52_2E_5B_8A
Error org.bluez.Error.DoesNotExist: Device creation in progress

Last but not least, after pairing finishes I will always verify the
result by trying to get the Paired property on relevant
org.bluez.Device interface of the paired device. If relevant object
path doesn't exist or Paired == false, I also send local adapter the
CancelDeviceCreation message to cancel any potentially unfinished
creation process. However, unfortunately, it won't make the second
pairing request being treated normally and still just the Release
message is sent by bluez.

So, my questions are:

1. why a object path is created, despite the fact that the pairing is failed?

2. why bluez will only send Release message but skipping
DisplayPasskey for subsequent pairing request?

3. how to get rid of the object path and bail out the previously
failed pairing situation so as to re-pair successfully?

Many thanks for any comment and advice!

Cheers,
Harry
