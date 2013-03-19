Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 0/6] sco: SCO socket option for voice_setting
Date: Tue, 19 Mar 2013 19:04:09 +0100
Message-Id: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

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
  Bluetooth: Add SCO socket voice_setting option
  Bluetooth: Use hci_connect_sco directly
  Bluetooth: Use voice_setting in incoming SCO connection
  Bluetooth: Parameters for outgoing SCO connections
  Bluetooth: Fallback transparent SCO from T2 to T1

 include/net/bluetooth/hci_core.h |    5 +-
 include/net/bluetooth/sco.h      |    2 +
 net/bluetooth/hci_conn.c         |   36 +++++++++----
 net/bluetooth/hci_event.c        |   39 +-------------
 net/bluetooth/sco.c              |  106 ++++++++++++++++++++++++++++++++++++--
 5 files changed, 137 insertions(+), 51 deletions(-)

-- 
1.7.9.5

