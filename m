Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 00/10] Refactoring bnep code to reduce redundancy
Date: Wed, 11 Dec 2013 12:13:35 +0200
Message-Id: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set contains refactoring of bnep functionality, minor
fixes in android/pan and adding PAN profile NAP sdp record to
android.

Ravi kumar Veeramally (10):
  bnep: Rename bnep_kill_connection to bnep_conndel
  bnep: Rename send ctrl_rsp and make it global
  bnep: Move bnep related calls to bnep.h|c
  profiles/network/server: Delete function which does nothing
  profiles/network: Move pan sdp record function bnep and make it global
  android/pan: Remove channel unref which causing disconnection
  android/pan: Fix missing cleanup calls
  android/pan: Fix minor white space
  android/pan: Free connected pan devices on profile unregister call
  android/pan: Add PAN NAP sdp record fo server role

 android/pan.c                 |  40 +++++++-
 profiles/network/bnep.c       | 209 ++++++++++++++++++++++++++++++++++++++++-
 profiles/network/bnep.h       |  10 +-
 profiles/network/connection.c |   2 +-
 profiles/network/manager.c    |   2 -
 profiles/network/server.c     | 213 +-----------------------------------------
 profiles/network/server.h     |   1 -
 7 files changed, 256 insertions(+), 221 deletions(-)

-- 
1.8.3.2

