Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v6 0/6] sco: SCO socket option for voice_setting
Date: Tue, 16 Apr 2013 17:28:57 +0200
Message-Id: <1366126143-28545-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v6 fixes style issues

v5 changes interface to SOL_BLUETOOTH, BT_VOICE.
Rework fallback mechanism.
Add S3, S2, S1 settings.

This is the patch version 4 of the socket option for enabling transparent SCO.
As requested by Marcel, this is now a 16-bit voice_setting.
0x0000 is the value corresponding to current behavior.
0x0003 is the value to use for enabling transparent data.
It is easy to allow all possible values from Bluetooth core spec, but I guess
results can be unexpected...
Should we filter allowed values in setsockopt ?

Let me know what you think.
Regards,
Fred

Frédéric Dalleau (6):
  Bluetooth: Move and rename hci_conn_accept
  Bluetooth: Add bluetooth socket voice option
  Bluetooth: Use hci_connect_sco directly
  Bluetooth: Use voice setting in incoming SCO connection
  Bluetooth: Parameters for outgoing SCO connections
  Bluetooth: Fallback transparent SCO from T2 to T1

 include/net/bluetooth/bluetooth.h |    8 ++++
 include/net/bluetooth/hci_core.h  |    5 +-
 include/net/bluetooth/sco.h       |    1 +
 net/bluetooth/hci_conn.c          |   45 ++++++++++++++----
 net/bluetooth/hci_event.c         |   39 +---------------
 net/bluetooth/sco.c               |   92 +++++++++++++++++++++++++++++++++++--
 6 files changed, 138 insertions(+), 52 deletions(-)

-- 
1.7.9.5

