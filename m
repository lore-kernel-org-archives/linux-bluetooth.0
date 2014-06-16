Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 0/4] Intiates L2CAP Control Channel
Date: Tue, 17 Jun 2014 01:02:46 +0300
Message-Id: <1402956170-18356-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: Fixed Szymon's comments (provided utility to convert
  wrong HAL channel type defines, minor issues).

v1: Patchset is initial implementaion for MCL connection. It can
  be tested with PTS, register application in source or sink role
  and run source or sink L2CAP control channel tests. Initiate
  channel connection from haltest, only MCAP MCL gets connected.

Ravi kumar Veeramally (4):
  profiles/health/hdp: Fix memory leak in SDP record preparati     Sdp
    record preparation part is copied to android/health.c from    
    profiles/health/hdp_utils.c. Memory leak is noticed while    
    testing. Memory summay is from android daemon, but code snippet    
    is same. It is already fixed in android/health.c while submitting   
     android related patches.
  anrdoid/health: Fix wrong channel type defines
  android/health: Initial connect channel implementation
  android/health: Notify channel connection status

 android/health.c           | 451 ++++++++++++++++++++++++++++++++++++++++++++-
 profiles/health/hdp_util.c |   2 +
 2 files changed, 450 insertions(+), 3 deletions(-)

-- 
1.9.1

