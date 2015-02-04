Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/9] client: Add support for GATT API
Date: Wed,  4 Feb 2015 17:33:10 +0200
Message-Id: <1423063999-15734-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds basic support for GATT API, the main idea is that one can
navigate into the attributes and read and write values to them.

Im sending as RFC to figure if this is the way forward and if the
command are good enough, there are a couple of things missing and it
might be a good idea to have command categories/subparses.

Luiz Augusto von Dentz (9):
  client: Add support for GattService1
  client: Add support for GattCharacteristic1
  client: Add support for GattDescriptor1
  client: Make commands relative to device
  client: Add command list-attributes
  client: Add command select-attribute
  client/display: Add rl_hexdump
  client: Add read command
  client: Add write command

 Makefile.tools                           |   1 +
 client/display.c                         |  41 +++
 client/display.h                         |   1 +
 client/gatt.c                            | 460 +++++++++++++++++++++++++++++++
 tools/parser/ericsson.c => client/gatt.h |  39 +--
 client/main.c                            | 286 ++++++++++++++-----
 6 files changed, 735 insertions(+), 93 deletions(-)
 create mode 100644 client/gatt.c
 copy tools/parser/ericsson.c => client/gatt.h (56%)

-- 
2.1.0

