Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v1 00/10] Extedned Adv, Scan, Connection and PHY support
Date: Thu, 12 Apr 2018 16:50:51 +0530
Message-Id: <1523532061-17192-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds new mgmt APIs for Get / Set PHY contiguration,
Set PHY in Advertising, added mgmt-tester for the new commands,
and also added btmgmt and monitor changes for the new commands
and events

Jaganath Kanakkassery (10):
  doc/mgmt-api: Add support for Set Phy Configuration command
  doc/mgmt-api: Add advertising phys support to flags
  monitor: Add support PHY management commands and event
  btmgmt: Add PHY configuration get/set commands
  monitor: Add support for Secondary PHY flags in Add Advertising
  btmgmt: Add support for setting PHY in add-adv
  mgmt-tester: Add extended advertising test cases
  mgmt-tester: Add PHY Configuration test cases
  mgmt-tester: Add tests for extended scanning and device found
  mgmt-tester: Add support ext create connection and enh conn complete

 doc/mgmt-api.txt    |  106 +++
 emulator/btdev.c    |  459 ++++++++++-
 emulator/btdev.h    |    1 +
 emulator/bthost.c   |   99 +++
 emulator/bthost.h   |    7 +
 emulator/hciemu.c   |    3 +
 emulator/hciemu.h   |    1 +
 lib/mgmt.h          |   36 +
 monitor/bt.h        |    1 +
 monitor/packet.c    |   68 ++
 tools/btmgmt.c      |  145 +++-
 tools/mgmt-tester.c | 2253 ++++++++++++++++++++++++++++++++++++++++++++++++---
 12 files changed, 3074 insertions(+), 105 deletions(-)
 mode change 100644 => 100755 tools/btmgmt.c

-- 
2.7.4

