Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/5] Android PAN fixes
Date: Wed,  5 Feb 2014 17:00:29 +0100
Message-Id: <1391616034-23312-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is based on patch from Ravi (sent 23.01.2013). Changes include
patch split and some bugfixes.

BR
Szymon Janc

Ravi kumar Veeramally (1):
  android/pan: Fix bnep interface name

Szymon Janc (4):
  profiles/network: Use interface name passed to bnep_connadd
  profiles/network: Allow to pass interface name to bnep_new
  android/pan: Move functions up to avoid forward declarations
  android/pan: Fix unregistering NAP bridge

 android/pan.c                 | 174 ++++++++++++++++++++++++------------------
 profiles/network/bnep.c       |  10 ++-
 profiles/network/bnep.h       |   3 +-
 profiles/network/connection.c |   6 +-
 profiles/network/server.c     |   4 +
 5 files changed, 116 insertions(+), 81 deletions(-)

-- 
1.8.3.2

