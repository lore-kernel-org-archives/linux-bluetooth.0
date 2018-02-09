Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 0/3] mgmt-tested: Advertising while connected testcases
Date: Fri,  9 Feb 2018 18:26:24 +0100
Message-Id: <20180209172627.20500-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set adds testcases which tests kernel patch:

9e1e9f20ca96 Bluetooth: Add support to advertise when connected
and fix to above:
[PATCH] Bluetooth: Fix incorrect bits for LE states

Not sure if it fits to mgmt-tester. If not let me know where it
should go.  

Łukasz Rymanowski (3):
  emulator: Add initial LE states to btdev and API to set new one
  mgmt-tester: Add test_le_full
  mgmt-tester: Add testcases for advertising while connected

 emulator/btdev.c    |  18 +++
 emulator/btdev.h    |   3 +-
 emulator/hciemu.c   |   8 ++
 emulator/hciemu.h   |   3 +
 tools/mgmt-tester.c | 372 ++++++++++++++++++++++++++++++++++++++++++++--------
 5 files changed, 346 insertions(+), 58 deletions(-)

-- 
2.14.1

