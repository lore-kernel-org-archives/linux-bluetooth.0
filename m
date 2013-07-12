Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v9 0/9] sco: SCO socket option for voice_setting
Date: Fri, 12 Jul 2013 18:05:34 +0200
Message-Id: <1373645143-7494-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v9 is mostly cosmetics. Introduces LMP_TRANSPARENT bit in patch 8/8.


v8 declares BT_VOICE_CVSD_16BIT
Merge T*, S* and D* patches in one
The last patch returns -ECONNABORTED when trying to setup a transparent data
connection if eSCO is not supported.

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


Frédéric Dalleau (9):
  Bluetooth: Use hci_connect_sco directly
  Bluetooth: Remove unused mask parameter in sco_conn_defer_accept
  Bluetooth: Add bluetooth socket voice option
  Bluetooth: Constants declaration for SCO airmode
  Bluetooth: Use voice setting in defered SCO connection request
  Bluetooth: Parameters for outgoing SCO connections
  Bluetooth: Constants and macro declaration for transparent data
  Bluetooth: Prevent transparent SCO on older devices
  Bluetooth: SCO connection fallback

 include/net/bluetooth/bluetooth.h |    8 ++++
 include/net/bluetooth/hci.h       |    1 +
 include/net/bluetooth/hci_core.h  |    9 +++++
 include/net/bluetooth/sco.h       |    1 +
 net/bluetooth/hci_conn.c          |   55 +++++++++++++++++++++-----
 net/bluetooth/hci_event.c         |    3 +-
 net/bluetooth/sco.c               |   77 ++++++++++++++++++++++++++++++-------
 7 files changed, 130 insertions(+), 24 deletions(-)

-- 
1.7.9.5

