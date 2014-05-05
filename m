Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
From: d.eriksson@me.com
Subject: BLE Passive scan & Bonding quest (dbus vs mgmt-api vs plugins)
Message-id: <6FFA5235-4897-4AF9-AF0D-10258F2E056B@me.com>
Date: Tue, 06 May 2014 01:00:24 +0200
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm on Kernel v3.13 & BlueZ 5.18 and been testing around to find the cleanest approach for a fully automatic discovery and headless pairing/bonding of BLE peripherals (in my case HOGP / HID).

Basically, today a "scan and pair (bond)" could today be done using either "bluetoothctl", "hcitool", "dbus/python-agents", "C plugins", or the "C Management API". (please correct me if I'm wrong here).

As we have many many options to achieve this, I'd like some guidance on how to re-use as much mechanisms that already exists in BlueZ and/or kernel/user-space, preferably involving as few building blocks as possible.


In short, I continuously need to run a passive scan for LE-devices only and bond to specific hid-devices based on suitable vendor info in the advertise data or the device information service.

I'm sharing the radio with a wifi using co-ex so "BT-classic" must be off and I assume active scan will eat too much air-time.
Once paired (or bonded as SIG and the IC-manuf. calls it), it should be a persistent and identifiable /dev/input device 

Any existing bluez or linux ways to do this I'd prefer to re-use, like utilising 'udev rules', bluetoothd patches or configs to optimise for LE-only and in general keep things light as I want to run the discovery/scan at all times. I'm ok with pure C or mix with shell and python, whatever works best and would be considered bluez future-proof.


I'd greatly appreciate some input and advice here.


best /david

