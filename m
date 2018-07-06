Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ 0/8] Add BREDR PHYs in PHY configuration commands
Date: Fri,  6 Jul 2018 16:57:57 +0530
Message-Id: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This also has mgmt-tester patches for 5.0 implementation

Jaganath Kanakkassery (8):
  monitor: Fix 2-DH5 packet type print
  btmgmt: Add BREDR PHYs in PHY Configuration commands
  monitor: Add BREDR PHYs in PHY configuration commands
  emulator: Add BREDR 2M & 3M, 3 & 5 Slot packet type support
  mgmt-tester: Add extended advertising test cases
  mgmt-tester: Add PHY Configuration test cases
  mgmt-tester: Add tests for extended scanning and device found
  mgmt-tester: Add support ext create connection and enh conn complete

 emulator/btdev.c    |   10 +
 lib/mgmt.h          |   32 +-
 monitor/packet.c    |   41 +-
 tools/btmgmt.c      |   62 +-
 tools/mgmt-tester.c | 2255 ++++++++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 2248 insertions(+), 152 deletions(-)

-- 
2.7.4
