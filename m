Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 0/6] HDP initial implementaion
Date: Mon, 16 Jun 2014 18:01:34 +0300
Message-Id: <1402930900-24209-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: Fixed comments from Szymon (optimized cache patch,
    split notify patch, other issues).
v1: Fixed comments from szymon.

RFC_v2: Fixed comments by szymon and fixed issues while sebastian
testing with PTS.

RFC_v1: patchset is initial implementaion for HDP at daemon side.
Cacheing application data and prepare SDP record based on MDEPs
configuration and notify app state.

Ravi kumar Veeramally (6):
  android/health: Cache health application data on app register call
  android/health: Perform clean up on app unregister call
  android/health: Add HDP SDP record
  android/health: Notify application registration status
  android/health: Notify application deregistration status
  profile/health: Free sdp list after adding it to record

 android/health.c           | 717 ++++++++++++++++++++++++++++++++++++++++++++-
 profiles/health/hdp_util.c |   2 +
 2 files changed, 711 insertions(+), 8 deletions(-)

-- 
1.9.1

