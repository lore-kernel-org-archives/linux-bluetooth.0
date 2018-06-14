Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ v3 00/11] Extended Adv, Scan, Connection and PHY support
Date: Thu, 14 Jun 2018 17:51:13 +0530
Message-Id: <1528978884-3882-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds new mgmt APIs for Get / Set PHY contiguration,
Set PHY in Advertising, added mgmt-tester for the new commands,
and also added btmgmt and monitor changes for the new commands
and events

v2: Made emulator changes onto a seperate patch
v3: Applied Luiz's comments and fixed whitespace error

Jaganath Kanakkassery (11):
  doc/mgmt-api: Add support for Set Phy Configuration command
  doc/mgmt-api: Add advertising phys support to flags
  monitor: Add support PHY management commands and event
  btmgmt: Add PHY configuration get/set commands
  monitor: Add support for Secondary PHY flags in Add Advertising
  btmgmt: Add support for setting PHY in add-adv
  emulator: Add 5.0 feature support
  mgmt-tester: Add extended advertising test cases
  mgmt-tester: Add PHY Configuration test cases
  mgmt-tester: Add tests for extended scanning and device found
  mgmt-tester: Add support ext create connection and enh conn complete

 doc/mgmt-api.txt    |  106 +++
 emulator/btdev.c    |  448 +++++++++-
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
 12 files changed, 3063 insertions(+), 105 deletions(-)
 mode change 100644 => 100755 tools/btmgmt.c

-- 
2.7.4

