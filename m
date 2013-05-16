Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v7 0/8] sco: SCO socket option for voice_setting
Date: Thu, 16 May 2013 19:33:57 +0200
Message-Id: <1368725646-4593-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v7 changes defaults to BT_VOICE_CVSD
Remove mask parameter to sco_conn_defer_accept, it was always 0
check the bits for air codec instead of use constants.
Add S3, S2, S1, D1, D0 settings.
The controller default is now only used to initialize the controller or fill
in the missing information in case of using the old Add_SCO command

v6 fixes style issues

v5 changes interface to SOL_BLUETOOTH, BT_VOICE.
Rework fallback mechanism.

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

Frédéric Dalleau (8):
  Bluetooth: Use hci_connect_sco directly
  Bluetooth: Remove unused mask parameter in sco_conn_defer_accept
  Bluetooth: Add bluetooth socket voice option
  Bluetooth: Constants and macro declaration for SCO airmode
  Bluetooth: Use voice setting in incoming SCO connection
  Bluetooth: Parameters for outgoing SCO connections
  Bluetooth: Fallback transparent SCO from T2 to T1
  Bluetooth: Add support for fallback between CVSD recommended settings

 include/net/bluetooth/bluetooth.h |    8 +++++
 include/net/bluetooth/hci_core.h  |    9 +++++
 include/net/bluetooth/sco.h       |    1 +
 net/bluetooth/hci_conn.c          |   56 +++++++++++++++++++++++------
 net/bluetooth/hci_event.c         |    3 +-
 net/bluetooth/sco.c               |   70 ++++++++++++++++++++++++++++++-------
 6 files changed, 123 insertions(+), 24 deletions(-)

-- 
1.7.9.5

