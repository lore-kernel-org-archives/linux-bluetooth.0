Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 0/4] Add handsfree interface methods to haltest
Date: Mon, 28 Oct 2013 12:38:59 +0100
Message-ID: <1382960343-10765-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patchset handsfree interface is available in haltest.

Jerzy Kasenberg (4):
  android/client: Add skeleton for handsfree calls
  android/client: Add code for handsfree callbacks
  android/client: Add code for handsfree methods
  android/client: Add completion for hf methods

 Makefile.android         |    2 +
 android/Android.mk       |    1 +
 android/client/haltest.c |    1 +
 android/client/if-bt.c   |    2 +-
 android/client/if-hf.c   |  784 ++++++++++++++++++++++++++++++++++++++++++++++
 android/client/if-main.h |    2 +
 6 files changed, 791 insertions(+), 1 deletion(-)
 create mode 100644 android/client/if-hf.c

-- 
1.7.9.5

