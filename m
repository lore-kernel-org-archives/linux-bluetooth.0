Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v5 0/6] Refactor bnep code and implement pan methods
Date: Fri, 29 Nov 2013 16:20:39 +0200
Message-Id: <1385734845-9725-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v5: Renamed strcut network_peer to pan_device as per Luiz comments.

v4: Fixed Luiz comments (discussed in irc). Merge patch 1 and 2.
    Pass fd in bnep_connect instead of GIOChannel.

v3: Fixed Anderson and Luiz comments and solved rebased conflicts.

v2: Refactored profiles/network/common.* as per Johan's comments
    (renaming common.c|h to bnep.c|h and moving bnep related code to
     bnep.c ro reduce redundancy in profiles/netowrk/connection.c and
     android/pan.c)

v1: This patch set supports PANU role with a minor fix in android. Added
    CAP_NET_RAW capability for bnep services. Creates bnep connection and
    up the inreface on connect call and free the device on disconnect call.
    Interface name(bnepX) will be notified on control state cb. Android
    environment will create IP address with dhcp calls.

Ravi kumar Veeramally (6):
  profiles/network: Refactor bnep connection setup functionality
  profiles/network: Rename common.c|h to bnep.c|h
  android/pan: Implement pan connect method in daemon
  android/pan: Implement pan disconnect method in daemon
  android/pan: Implement the get local role method in daemon
  android: Add reasons for adding capabilites to process

 Makefile.plugins                      |   2 +-
 android/Android.mk                    |   2 +
 android/Makefile.am                   |   3 +-
 android/main.c                        |   3 +
 android/pan.c                         | 253 ++++++++++++++++++++++++++++++++--
 profiles/network/{common.c => bnep.c} | 197 +++++++++++++++++++++++++-
 profiles/network/{common.h => bnep.h} |   5 +
 profiles/network/connection.c         | 174 ++---------------------
 profiles/network/manager.c            |   2 +-
 profiles/network/server.c             |   5 +-
 10 files changed, 468 insertions(+), 178 deletions(-)
 rename profiles/network/{common.c => bnep.c} (58%)
 rename profiles/network/{common.h => bnep.h} (87%)

-- 
1.8.3.2

