Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [RFC PATCH 0/2] auto-pairing plugin
Date: Fri, 20 Jan 2012 17:59:55 -0800
Message-Id: <1327111197-11446-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A few core changes here to support retrying of connections without
losing the original connection request, temporary D-Bus device object
or Agent information - and plugin callbacks for when bonding is
complete and cancelled.

This lets us implement an auto-pair plugin that tries the PIN 0000 for
commonly dumb devices, and retries using the Agent when that PIN fails.
For added cutesyness we save the blacklist we use to avoid repeatedly
sending 0000, so if there really are any devices out there with
different default PINs we can learn about them over time.

Net effect - another thing done in the UI Agent moved into bluetoothd
where it belongs.

*** BLURB HERE ***

Scott James Remnant (2):
  plugin: add bonding complete and cancel callbacks with optional retry
  autopair: add autopair plugin

 Makefile.am        |    5 +
 acinclude.m4       |    6 ++
 plugins/autopair.c |  209 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.c      |    2 +-
 src/device.c       |   86 +++++++++++++++++++++
 src/device.h       |   12 +++
 6 files changed, 319 insertions(+), 1 deletions(-)
 create mode 100644 plugins/autopair.c

-- 
1.7.7.3

