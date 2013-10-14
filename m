Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 0/5] Stack independent BT HAL test tool
Date: Mon, 14 Oct 2013 11:59:49 +0200
Message-ID: <1381744794-17994-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This tool is for testing Android HAL interfaces from command line.
Due to lack of readline on Android simple equivalent is hand coded.
This tool can be used with bluedroid stack so no glib dependency.

Tool source code is in folder hal_client, please comment if it should be
somewhere else.

Comments welcome.

Best regards
Jerzy Kasenberg

Jerzy Kasenberg (5):
  android: Add haltest skeleton
  android: Add line editing to haltest
  android: Add history to line editor in haltest
  android: Add text conversion helpers to haltest
  android: Add calls to adapter methods in haltest

 android/Android.mk               |   21 ++
 android/hal_client/haltest.c     |  167 ++++++++++
 android/hal_client/history.c     |  104 +++++++
 android/hal_client/history.h     |   27 ++
 android/hal_client/if_bt.c       |  637 ++++++++++++++++++++++++++++++++++++++
 android/hal_client/if_main.h     |  105 +++++++
 android/hal_client/pollhandler.c |  129 ++++++++
 android/hal_client/pollhandler.h |   32 ++
 android/hal_client/terminal.c    |  540 ++++++++++++++++++++++++++++++++
 android/hal_client/terminal.h    |   65 ++++
 android/hal_client/textconv.c    |  211 +++++++++++++
 android/hal_client/textconv.h    |  119 +++++++
 12 files changed, 2157 insertions(+)
 create mode 100644 android/hal_client/haltest.c
 create mode 100644 android/hal_client/history.c
 create mode 100644 android/hal_client/history.h
 create mode 100644 android/hal_client/if_bt.c
 create mode 100644 android/hal_client/if_main.h
 create mode 100644 android/hal_client/pollhandler.c
 create mode 100644 android/hal_client/pollhandler.h
 create mode 100644 android/hal_client/terminal.c
 create mode 100644 android/hal_client/terminal.h
 create mode 100644 android/hal_client/textconv.c
 create mode 100644 android/hal_client/textconv.h

-- 
1.7.9.5

