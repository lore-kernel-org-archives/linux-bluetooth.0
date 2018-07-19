Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ v1 0/7] Add BREDR PHYs in PHY configuration commands
Date: Thu, 19 Jul 2018 16:54:00 +0530
Message-Id: <1531999447-3479-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This also has mgmt-tester patches for 5.0 implementation

Jaganath Kanakkassery (7):
  monitor: Add BREDR PHYs in PHY configuration commands
  emulator: Add BREDR 2M & 3M, 3 & 5 Slot packet type support
  mgmt-tester: Add extended advertising test cases
  mgmt-tester: Add PHY Configuration test cases
  mgmt-tester: Add tests for extended scanning and device found
  mgmt-tester: Add support ext create connection and enh conn complete
  mgmt-tester: Update Supported_settings to reflect PHY_CONFIGURATION

 emulator/btdev.c    |   10 +
 monitor/packet.c    |   39 +-
 tools/mgmt-tester.c | 2268 ++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 2200 insertions(+), 117 deletions(-)

-- 
2.7.4
