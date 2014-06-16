Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/4] Intiates L2CAP Control Channel
Date: Mon, 16 Jun 2014 20:51:10 +0300
Message-Id: <1402941074-14407-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patchset is initial implementaion for MCL connection. It can
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
  profiles/health/hdp: Fix memory leak in SDP record preparati     Sdp
    record preparation part is copied to android/health.c from    
    profiles/health/hdp_utils.c. Memory leak is noticed while    
    testing. Memory summay is from android daemon, but code snippet    
    is same. It is already fixed in android/health.c while submitting   
     android related patches.
  anrdoid/hal-health: Fix wrong channel type defines
  android/health: Initial connect channel implementation
  android/health: Notify channel connection status

 android/hal-health.c       |  13 +-
 android/hal-msg.h          |   6 +-
 android/health.c           | 434 ++++++++++++++++++++++++++++++++++++++++++++-
 profiles/health/hdp_util.c |   2 +
 4 files changed, 449 insertions(+), 6 deletions(-)

-- 
1.9.1

