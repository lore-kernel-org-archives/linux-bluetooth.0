Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [RFC PATCH 0/3] Generate PIN for keyboards inside bluetoothd
Date: Fri, 20 Jan 2012 15:05:41 -0800
Message-Id: <1327100744-28782-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here's a first pass of handling the HID profile recommendation for
pairing keyboards inside bluetoothd, rather than expecting the UI
Agent to deal with it.

This requires agents implement a new DisplayPinCode method, since
the existing DisplayPasskey method expects a numeric and PIN Codes
are UTF-8 strings.

As well as general type-stricty-ness, the method allows the UI to
distinguish between a Bluetooth 2.0 keyboard (ie. all of them) and
future Bluetooth 2.1 keyboards implementing SSP (for which there may
be keypress notification). UIs might want to display them slightly
differently (OS X does, and UI developers tend to just copy that).

That said, the PINs generated here are 6-digit 0-padded numerics
since that's probably less confusing for users and there are
Bluetooth numeric keypads out there that can't do non-numerics.

Scott James Remnant (3):
  lib: add header of device class constants
  agent: add DisplayPinCode method
  Implement HID profile recommendation for keyboards

 Makefile.am       |    2 +-
 doc/agent-api.txt |   12 +++++
 lib/bt_ids.h      |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/agent.c       |   27 +++++++++++
 src/agent.h       |    2 +
 src/device.c      |   24 ++++++---
 src/device.h      |    5 +-
 src/event.c       |   32 +++++++++++--
 test/simple-agent |    5 ++
 9 files changed, 226 insertions(+), 16 deletions(-)
 create mode 100644 lib/bt_ids.h

-- 
1.7.7.3

