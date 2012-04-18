Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Bastien Nocera <hadess@hadess.net>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH BlueZ v2 0/3] Current status of playstation-peripheral plugin
Date: Wed, 18 Apr 2012 11:38:08 +0200
Message-Id: <1334741891-11869-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a short summary about Playstation peripherals and their pairing
mechanism, to recap the current status of the playstation-peripheral plugin,
propose a working solution and discuss possible better ones.

>From now on in this message I sometime call a Playstation peripheral
simply a "device".

Bastien, please check if I am forgetting anything :)

WHAT we need the plugin to do:

  - When a device is connected via USB:
    + Fetch the (default) adapter bdaddr (from BlueZ) and store it into
      the device
    + Fetch the device bdaddr (from the device via USB/HID) and make the
      device _trusted_ by the adapter (is "trusted" the correct term
      here? Or maybe this is more like a "static association"? Are the
      term "trusted" and "associated" in bluetooth context defined
      anywhere?)

  - When the device is connected via BT:
    + Nothing! It should work automatically.

  - Set LEDs when possible.

WHY we need that:

  Playstation peripherals require/support USB cable pairing.

  It is required in the sense that devices will talk only to adapters
  they know.

  It is supported in the sense that this mechanism is optional on _some_
  devices like the PS3 Keypad.

  On the PS3 these cable paired devices can be used via BT without
  further association steps once they have been connected
  _at_least_once_ via USB to a certain host (with a certain BT adapter
  that is), we would like to have the same behavior with BlueZ.

The current HOW:

  We have the parameters (uuid, sdp record) to make the device "trusted"
  all hardcoded in the plugin and we create the BlueZ files under
  /var/lib/bluetooth/<adapter_bdaddr> using blues functions every time
  a device is connected via USB.
  
  NOTE: I don't know if we can make BlueZ pull those parameters from the
  device itself somehow when the device connects via BT _the_first_time_

  It has been suggested that this plugin is kept _external_ for three
  reasons:
    - it is not worth making bluetoothd bigger for a plugin used by very
      few people
    - avoid linking bluetoothd to libudev, which is needed by the plugin
    - external plugins offer a finer packaging granularity (if the user
      need this plugin it just have to install the .so provided by
      a package prepared by distributors and restart bluetoothd, no need
      to recompile)

  But _external_ plugins can only use symbols exported as global in
  src/bluetooth.ver, which currently are:

    btd_*;
    g_dbus_*;
    info;
    error;
    debug;

  So to avoid exporting more global symbols, for now I introduced two
  new btd_* calls to do what I though I needed.

  NOTE: the new functions were three in a first iteration but I managed
  to remove one of them.

The three patches below show the current status.

The first two are prerequisites needed if we want to keep the plugin
_external_, the third patch is the plugin itself.

If you have any suggestion about how the development should proceed from
here on I'd like to hear from you.

Thanks,
   Antonio

Antonio Ospite (3):
  manager: add a btd_manager_get_default_adapter_address_str() call
  device: add a btd_device_set_trusted() call
  Add playstation-peripheral plugin: USB pairing and LEDs settings

 Makefile.am                          |    7 +
 acinclude.m4                         |   10 +
 plugins/playstation-peripheral-hid.c |  263 ++++++++++++++++++++++++
 plugins/playstation-peripheral-hid.h |   10 +
 plugins/playstation-peripheral.c     |  376 ++++++++++++++++++++++++++++++++++
 src/device.c                         |   74 +++++++
 src/device.h                         |    9 +
 src/manager.c                        |   21 ++
 src/manager.h                        |    1 +
 9 files changed, 771 insertions(+)
 create mode 100644 plugins/playstation-peripheral-hid.c
 create mode 100644 plugins/playstation-peripheral-hid.h
 create mode 100644 plugins/playstation-peripheral.c

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
