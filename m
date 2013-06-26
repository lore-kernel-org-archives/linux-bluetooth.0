Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 0/5] sco: Integrate SCO socket option in user space.
Date: Wed, 26 Jun 2013 19:32:07 +0200
Message-Id: <1372267932-10965-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is the required patches for taking advantage of SCO voice setting from
userspace. This RFC add a sco-tester inspired from l2cap-tester that uses hci_vhci to
test SCO

Regards,
Fred

Frédéric Dalleau (5):
  lib: SCO voice setting support header
  btio: Add option for SCO voice setting
  btiotest: Add option for SCO voice setting
  scotest: Add option for SCO voice setting
  sco-tester: Initial sco tester implementation

 Makefile.tools     |   12 +-
 btio/btio.c        |   18 +-
 btio/btio.h        |    1 +
 emulator/btdev.c   |   30 +++
 lib/bluetooth.h    |    8 +
 tools/btiotest.c   |   18 +-
 tools/sco-tester.c |  560 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/scotest.c    |   40 +++-
 8 files changed, 675 insertions(+), 12 deletions(-)
 create mode 100644 tools/sco-tester.c

-- 
1.7.9.5

