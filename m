Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 0/8] Android PAN fixes
Date: Thu,  6 Feb 2014 16:28:34 +0100
Message-Id: <1391700522-9036-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V3:
 - fixed not bringing bridge if down
 - add forward_delay with ioctl patch
 - other minor bugfixes

V2:
This is based on patch from Ravi (sent 23.01.2013). Changes include
patch split and some bugfixes.

Ravi kumar Veeramally (1):
  android/pan: Fix bnep interface name

Szymon Janc (7):
  profiles/network: Use interface name passed to bnep_connadd
  profiles/network: Allow to pass interface name to bnep_new
  android/pan: Move functions up to avoid forward declarations
  android/pan: Fix unregistering NAP bridge
  android/pan: Use ioctl instead of sysfs for setting forward delay
  android/pan: Pass error in nap_remove_bridge
  android/pan: Bring bridge interface down before removing it

 android/pan.c                 | 205 ++++++++++++++++++++++++++----------------
 profiles/network/bnep.c       |  10 ++-
 profiles/network/bnep.h       |   3 +-
 profiles/network/connection.c |   6 +-
 profiles/network/server.c     |   4 +
 5 files changed, 146 insertions(+), 82 deletions(-)

-- 
1.8.3.2

