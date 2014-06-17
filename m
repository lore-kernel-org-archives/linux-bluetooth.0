Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 0/4] Initiates L2CAP Control Channel
Date: Tue, 17 Jun 2014 13:16:20 +0300
Message-Id: <1403000184-1759-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v3: Fixed Szymon's comments(minor ones).

v2: Fixed Szymon's comments (provided utility to convert
  wrong HAL channel type defines, minor issues).

v1: Patchset is initial implementaion for MCL connection. It can
  be tested with PTS, register application in source or sink role
  and run source or sink L2CAP control channel tests. Initiate
  channel connection from haltest, only MCAP MCL gets connected.

SINK
-----------
hl register_application bluez-android Bluez  bluez-hdp health-device-profile 1 BTHL_MDEP_ROLE_SINK 4100 BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter

hl connect_channel 1 00:1b:dc:05:b5:54 0

SOURCE
-----------
hl register_application bluez-android Bluez  bluez-hdp health-device-profile 1 BTHL_MDEP_ROLE_SOURCE 4100 BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter

hl connect_channel 1 00:1b:dc:05:b5:54 0

Ravi kumar Veeramally (4):
  profiles/health/hdp: Fix memory leak in SDP record preparation
  anrdoid/health: Fix wrong channel type defines
  android/health: Initial connect channel implementation
  android/health: Notify channel connection status

 android/health.c           | 451 ++++++++++++++++++++++++++++++++++++++++++++-
 profiles/health/hdp_util.c |   2 +
 2 files changed, 450 insertions(+), 3 deletions(-)

-- 
1.9.1

