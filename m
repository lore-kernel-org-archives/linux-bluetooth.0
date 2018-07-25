Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ v2 0/7] Add BREDR PHYs in PHY configuration commands
Date: Wed, 25 Jul 2018 15:51:19 +0530
Message-Id: <1532514086-14790-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This also has mgmt-tester patches for 5.0 implementation

v2-> Fixed -Werror=unused-const-variable build error

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
 tools/mgmt-tester.c | 2085 ++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 2015 insertions(+), 119 deletions(-)

-- 
2.7.4

