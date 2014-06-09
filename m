Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 0/7] HDP initial implementaion
Date: Mon,  9 Jun 2014 17:28:07 +0300
Message-Id: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset is initial implementaion for HDP at daemon side.
Cacheing application data and prepare SDP record based on MDEPs
configuration and notify app state.

Ravi kumar Veeramally (7):
  android/hal-health: Fix passing buf not cmd for passing data
  android/hal-msg: Add application id to mdep config cmd struct
  android/health: Cache health application data on app register call
  android/health: Perform clean up on app unregister call
  android/health: Add HDP SDP record
  android/hal-health: Add app state event handler
  android/health: Notify application registration status

 android/hal-health.c |  16 +-
 android/hal-msg.h    |   1 +
 android/health.c     | 710 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 717 insertions(+), 10 deletions(-)

-- 
1.8.3.2

