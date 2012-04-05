Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, marcel@holtmann.org, hadess@hadess.net,
	Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv3 0/4] Support bonding callsbacks and retrying bondings
Date: Thu,  5 Apr 2012 15:40:49 -0700
Message-Id: <1333665653-30266-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Rationale: in many pairing scenarios, it's desirable to be automatically
provide a PIN (either generated or fixed) for a device and only involve
the user if that PIN is rejected by the host.

Both GNOME Bluetooth and Android handle this inside their Agent which
means each deployment has to implement its own code to do the same
thing. These patches allow this behavior to be common by moving it into
BlueZ.

This patch set adds plugin support for a callback called when bonding
of a device successfully completes, fails, or is cancelled. In the
success and failure cases, the callback may return TRUE to cause the
bonding to be retried after a short backoff period.

Backoff drops the ACL connection and reopens again later, this is not
only cleaner to implement in the bluetoothd code itself, but matches
the behavior of both Android (which implements this in its Agent) and
OS X, so is more likely to be compatible with devices out there even
though we could theoretically hold the ACL link open.

btsnoop of OS X performing PIN generation and falling back to PIN can
be seen here: 

http://chromium-os.googlecode.com/issues/attachment?aid=280220006001&
 name=BT+Motorola+Wireless+Keyboard.cfa&
 token=SA_vDEsF87_CU-BcqJ1C8bWd6Zk%3A1333665473760

Scott James Remnant (4):
  Add support for retrying a bonding
  plugin: Add bonding callback support for plugins
  bonding: retry if callback returns TRUE
  bonding: call plugin callback on cancellation

 src/adapter.c |    2 +-
 src/device.c  |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |    9 ++++++
 3 files changed, 99 insertions(+), 1 deletions(-)

-- 
1.7.7.3

