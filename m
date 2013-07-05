Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC v2 0/6] sco: Integrate SCO socket option in user space.
Date: Fri,  5 Jul 2013 17:46:41 +0200
Message-Id: <1373039207-20959-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is the required patches for taking advantage of SCO voice setting from
userspace.

RFC v2:
btio option is now called BT_IO_OPT_VOICE as per Luiz suggestion.
Last patch include additional test in sco-tester for outgoing 1.1 connection,
this include a change to hciemu (hciemu_get_features) to access feature array
from btdev to get/set features.

RFC v1:
add a sco-tester that uses hci_vhci to test SCO.

Regards,
Fred

Frédéric Dalleau (6):
  lib: SCO voice setting support header
  btio: Add option for SCO voice setting
  btiotest: Add option for SCO voice setting
  scotest: Add option for SCO voice setting
  sco-tester: Initial sco tester implementation
  sco-tester: Test BT_VOICE option with 1.1 adapter

 Makefile.tools      |   12 +-
 btio/btio.c         |   18 +-
 btio/btio.h         |    1 +
 emulator/btdev.c    |   57 +++++
 emulator/btdev.h    |    1 +
 lib/bluetooth.h     |    8 +
 src/shared/hciemu.c |    8 +
 src/shared/hciemu.h |    1 +
 tools/btiotest.c    |   20 +-
 tools/sco-tester.c  |  605 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/scotest.c     |   40 +++-
 11 files changed, 759 insertions(+), 12 deletions(-)
 create mode 100644 tools/sco-tester.c

-- 
1.7.9.5

