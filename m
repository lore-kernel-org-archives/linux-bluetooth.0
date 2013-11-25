Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 0/4] Adds pan connect disconnect and get role methods
Date: Mon, 25 Nov 2013 15:49:25 +0200
Message-Id: <1385387369-3015-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set supports PANU role with a minor fix in android. Added
CAP_NET_RAW capability for bnep services. Creates bnep connection and
up the inreface on connect call and free the device on disconnect call.
Interface name(bnepX) will be notified on control state cb. Android
environment will create IP address with dhcp calls.

Ravi kumar Veeramally (4):
  android: Add CAP_NET_RAW capability
  android/pan: Implement pan connect method in daemon
  android/pan: Implement pan disconnect method in daemon
  android/pan: Implement the get local role method in daemon

 android/Android.mk  |   2 +
 android/Makefile.am |   3 +-
 android/main.c      |   1 +
 android/pan.c       | 340 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 336 insertions(+), 10 deletions(-)

-- 
1.8.3.2

