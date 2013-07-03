Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 0/6] emulator: add LE advertising and scanning support
Date: Wed,  3 Jul 2013 16:54:50 -0400
Message-Id: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to write discovery tests for LE, we need some implementation
on emulator side.
This patch series basically reports virtual devices in adv mode for
devices in scan mode.

This new series was reorganized by merging some commits and removing
others not related to discovery tests. Note that this is just a first
set, based on a RFC sent a while ago by Bruna Moreira. Future patches
will build on these patches.

Jefferson Delfes (6):
  emulator: Store LE advertising data length in btdev
  emulator: Implement basic LE set adv enable command
  emulator: Store LE scan state of virtual controller
  emulator: Disallow LE set scan params command when scan is enabled
  emulator: Dummy LE set advertising parameters
  emulator: Implement LE advertising report

 emulator/btdev.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 monitor/bt.h     |  13 +++++++
 2 files changed, 113 insertions(+), 2 deletions(-)

-- 
1.8.3.2

