Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 0/3] Tab completion for haltest tool
Date: Fri, 18 Oct 2013 15:15:57 +0200
Message-ID: <1382102160-21532-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset add tab completion to haltest so using this tool
will be much easier.

It allows to build for andriod 4.3 and for host with autotools.

Jerzy Kasenberg (3):
  android: Add tab completion to haltest
  android: Fix error in draw line in haltest tool
  android: Add completion for adapter to haltest

 Makefile.android               |    2 +
 android/Android.mk             |    1 +
 android/client/haltest.c       |   11 +-
 android/client/if-bt.c         |  331 ++++++++++++++++++++++++++++++++++------
 android/client/if-main.h       |   44 +++++-
 android/client/tabcompletion.c |  313 +++++++++++++++++++++++++++++++++++++
 android/client/terminal.c      |    4 +-
 android/client/textconv.c      |   21 +++
 android/client/textconv.h      |    4 +
 9 files changed, 673 insertions(+), 58 deletions(-)
 create mode 100644 android/client/tabcompletion.c

-- 
1.7.9.5

