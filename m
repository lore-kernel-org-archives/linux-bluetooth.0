Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC_v2 0/6] HDP initial implementaion
Date: Tue, 10 Jun 2014 16:21:57 +0300
Message-Id: <1402406523-2832-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: Fixed comments by szymon and fixed issues while sebastian
testing with PTS.

v1: patchset is initial implementaion for HDP at daemon side.
Cacheing application data and prepare SDP record based on MDEPs
configuration and notify app state.

Ravi kumar Veeramally (6):
  android/hal-ipc-txt: Update Health MDEP command parameter
  android/health: Fix MDEP data type is 2 octets
  android/health: Cache health application data on app register call
  android/health: Perform clean up on app unregister call
  android/health: Add HDP SDP record
  android/health: Notify application registration status

 android/hal-ipc-api.txt |   5 +-
 android/hal-msg.h       |   2 +-
 android/health.c        | 712 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 707 insertions(+), 12 deletions(-)

-- 
1.8.3.2

