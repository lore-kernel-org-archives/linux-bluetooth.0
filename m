Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 0/2] Add support to pan and socket in haltest
Date: Wed, 23 Oct 2013 10:34:56 +0200
Message-ID: <1382517298-28093-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

- Add calls to methods of socket and pan

Jerzy Kasenberg (2):
  android: Add calls to socket methods in haltest
  android: Add calls to pan methods to haltest

 Makefile.android         |    4 +
 android/Android.mk       |    2 +
 android/client/haltest.c |    2 +
 android/client/if-bt.c   |    4 +-
 android/client/if-main.h |    4 +
 android/client/if-pan.c  |  209 +++++++++++++++++++++++++++++
 android/client/if-sock.c |  334 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 557 insertions(+), 2 deletions(-)
 create mode 100644 android/client/if-pan.c
 create mode 100644 android/client/if-sock.c

-- 
1.7.9.5

