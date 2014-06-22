Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 0/6] Initial implementation for MCAP data channel
Date: Sun, 22 Jun 2014 14:58:55 +0300
Message-Id: <1403438341-14321-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v3: Fixed Szymon's comments.

v2: Few cleanups and support for streaming data channel.

v1: Patchset implements initial MCAP MDL creation and connection. On
    successful MDL (reliable) connection fd will be passed to HAL.

PTS tests:

TC_SRC_CC_BV_03_C:

hl register_application bluez-android Bluez  bluez-hdp health-device-profile 1 BTHL_MDEP_ROLE_SOURCE 4100 BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter

hl connect_channel 1 00:1b:dc:05:b5:54 0

TC_SRC_CC_BV_07_C:

hl register_application bluez-android Bluez  bluez-hdp health-device-profile 2 BTHL_MDEP_ROLE_SOURCE 4100 BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter  BTHL_MDEP_ROLE_SOURCE 4100 BTHL_CHANNEL_TYPE_STREAMING pulse-oximeter

hl connect_channel 1 00:1b:dc:05:b5:54 0
hl connect_channel 1 00:1b:dc:05:b5:54 1


TC_SNK_CC_BV_04_C:
TC_SNK_HCT_BV_01_I:

hl register_application bluez-android Bluez  bluez-hdp health-device-profile 1 BTHL_MDEP_ROLE_SINK 4100 BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter

hl connect_channel 1 00:1b:dc:05:b5:54 0


TC_SNK_CC_BV_08_C:

hl register_application bluez-android Bluez  bluez-hdp health-device-profile 2 BTHL_MDEP_ROLE_SINK 4100 BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter  BTHL_MDEP_ROLE_SINK 4100 BTHL_CHANNEL_TYPE_STREAMING pulse-oximeter

hl connect_channel 1 00:1b:dc:05:b5:54 0
hl connect_channel 1 00:1b:dc:05:b5:54 1


Ravi kumar Veeramally (6):
  android/health: Check if device and channel already exists or not
  android/health: Cache remote mdep id on channel connect request
  android/health: Notify channel status on channel destroy call
  android/health: Create and connect MDL
  android/health: Implement mcap_mdl_deleted_cb
  anrdroid/client/health: Cache fd and close on channel disconnection

 android/client/if-hl.c |   9 ++
 android/health.c       | 415 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 376 insertions(+), 48 deletions(-)

-- 
1.9.1

