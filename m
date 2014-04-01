Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 1 Apr 2014 16:28:21 -0700
Message-ID: <CAHZ1yCkNddT6MxBkRz0dNdXGn+MWZECK1L6XTaouRLLkECH5eg@mail.gmail.com>
Subject: BUG: l2cap and rfcomm bind with 0 psm or channel no longer allocate
From: Scott James Remnant <keybuk@google.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Seems to have occurred between 3.10.18 and bluetooth-next/for-upstream

Given:

>>> import dbus
>>> bus = dbus.SystemBus()
>>> bluez = bus.get_object('org.bluez', '/org/bluez')
>>> bluez.RegisterProfile('/profile1', '00002401-0000-1000-8000-00805f9b34fb', { 'Name': 'Test RFCOMM Service', 'Channel': dbus.UInt16(0) }, dbus_interface='org.bluez.ProfileManager1')
>>> bluez.RegisterProfile('/profile2', '00002402-0000-1000-8000-00805f9b34fb', { 'Name': 'Test RFCOMM Service', 'Channel': dbus.UInt16(0) }, dbus_interface='org.bluez.ProfileManager1')

The resulting SDP is:

Service Name: Test RFCOMM Service
Service RecHandle: 0x10006
Service Class ID List:
  UUID 128: 00002401-0000-1000-8000-00805f9b34fb
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 0

Service Name: Test RFCOMM Service
Service RecHandle: 0x10007
Service Class ID List:
  UUID 128: 00002402-0000-1000-8000-00805f9b34fb
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 0

Scott
-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
