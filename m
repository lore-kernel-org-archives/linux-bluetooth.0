Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 19 Mar 2013 01:07:44 +0100
Message-ID: <CANq1E4TMGGwiz-kGGCqGOn+A-D-msiTAb8L4Yf6kkMwrzOnn_g@mail.gmail.com>
Subject: Device selection during inquiry
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I have a bunch of proprietary Bluetooth devices (Nintendo Wii related)
and I have problems trying to replace them with a BlueZ based device
so I can reverse-engineer different parts of them. The setup is:

A Bluetooth Host searches for target devices via standard inquiry (at
least I think so). The devices can be placed into discoverable mode
for 20s via a "sync" button. Once they are found, a baseband
connection is created by the host and the devices are paired via a
simple BT-address related PIN.

I can easily replace the host with a BlueZ host and connect to the
devices via a normal inquiry and then open the baseband connection.
However, I haven't succeeded in replacing the target devices with a
BlueZ host. I simply cannot trick the proprietary host into connecting
to my device. In fact, "hcidump" doesn't give me anything while the
host is performing the inquiry. I couldn't even figure out the
BT-address of the host.

My conclusion is, that the host does a device-selection based on
information that it can gather via a BT inquiry. Hence, it rejects my
fake-device prior to opening an ACL connection. However, I need some
help to identify what kind of information this might be?

I tried setting the following to the same values as on a sample target device:
  - BT Address
  - device-class
  - inquiry-mode
  - device-name
However, that didn't change anything.

Are there any other values that I should play with which might be used
by the host to identify possible target devices? I guess it cannot be
SDP related as this would require a baseband connection. Also note
that the devices were manifactured pre-2006 so considering development
time they are probably <=BT-2.0.

The devices do not report EIR information, but only basic inquiry+RSSI.

Any hints are welcome! Does it make sense to test with/without PSCAN,
interlaced modes, different MTUs, different timeouts, different iscan
parameters, and so on?

I have 4 working target devices with BT chips from Broadcom or CSR, see below.

Thanks!
David



Information on one of the target devices:

$ hcitool inq
  00:1E:35:3B:7E:6D       clock offset: 0x0aa5    class: 0x002504

$ hcitool info 00:1E:35:3B:7E:6D
Requesting information ...
        BD Address:  00:1E:35:3B:7E:6D
        Device Name: Nintendo RVL-CNT-01
        LMP Version: 1.2 (0x2) LMP Subversion: 0x229
        Manufacturer: Broadcom Corporation (15)
        Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <sniff mode> <RSSI> <power control> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <AFH cap. slave>

Another target device:

$ hcitool info 34:AF:2C:18:AC:99
Requesting information ...
        BD Address:  34:AF:2C:18:AC:99
        Device Name: Nintendo RVL-CNT-01-UC
        LMP Version: 2.0 (0x3) LMP Subversion: 0x1d8d
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <sniff mode> <RSSI> <power control> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <AFH cap. slave>
