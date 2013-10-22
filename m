Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 0/3] android: add support for hidhost to haltest
Date: Tue, 22 Oct 2013 13:02:24 +0200
Message-ID: <1382439747-13864-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

- adds support for hidhost
- adds tab completion for hidhost
- adds help for hidhost
- magic number to #define change for buffer sizes

Jerzy Kasenberg (3):
  android: Add definition of buffer sizes to haltest
  android: Add calls to hidhost interface to haltest
  android: Add help to hidhost in haltest

 Makefile.android          |    2 +
 android/Android.mk        |    1 +
 android/client/haltest.c  |    1 +
 android/client/if-bt.c    |   10 +-
 android/client/if-hh.c    |  431 +++++++++++++++++++++++++++++++++++++++++++++
 android/client/if-main.h  |    2 +
 android/client/textconv.c |    2 +-
 android/client/textconv.h |    2 +
 8 files changed, 445 insertions(+), 6 deletions(-)
 create mode 100644 android/client/if-hh.c

-- 
1.7.9.5

