Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/6] HDP initial implementaion
Date: Thu, 12 Jun 2014 16:10:12 +0300
Message-Id: <1402578618-31484-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v1: Fixed comments from szymon.

RFC_v2: Fixed comments by szymon and fixed issues while sebastian
testing with PTS.

RFC_v1: patchset is initial implementaion for HDP at daemon side.
Cacheing application data and prepare SDP record based on MDEPs
configuration and notify app state.

Ravi kumar Veeramally (6):
  android/hal-health: Add channel state event handler
  android/health: Cache health application data on app register call
  android/health: Perform clean up on app unregister call
  android/health: Add HDP SDP record
  android/health: Notify application registration status
  profile/health: Free sdp list after adding it to record

 android/hal-health.c       |  14 +
 android/health.c           | 699 ++++++++++++++++++++++++++++++++++++++++++++-
 profiles/health/hdp_util.c |   2 +
 3 files changed, 706 insertions(+), 9 deletions(-)

-- 
1.9.1

