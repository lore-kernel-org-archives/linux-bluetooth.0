Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH v2 0/5] Stack independent BT HAL test tool
Date: Tue, 15 Oct 2013 15:13:15 +0200
Message-ID: <1381842800-3554-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2:
 - license changed to apache
 - source folder changed to hal-client (underscore to dash)
v1:
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
 android/hal-client/haltest.c     |  161 ++++++++++
 android/hal-client/history.c     |   98 ++++++
 android/hal-client/history.h     |   21 ++
 android/hal-client/if_bt.c       |  631 ++++++++++++++++++++++++++++++++++++++
 android/hal-client/if_main.h     |   99 ++++++
 android/hal-client/pollhandler.c |  123 ++++++++
 android/hal-client/pollhandler.h |   26 ++
 android/hal-client/terminal.c    |  534 ++++++++++++++++++++++++++++++++
 android/hal-client/terminal.h    |   59 ++++
 android/hal-client/textconv.c    |  205 +++++++++++++
 android/hal-client/textconv.h    |  113 +++++++
 12 files changed, 2091 insertions(+)
 create mode 100644 android/hal-client/haltest.c
 create mode 100644 android/hal-client/history.c
 create mode 100644 android/hal-client/history.h
 create mode 100644 android/hal-client/if_bt.c
 create mode 100644 android/hal-client/if_main.h
 create mode 100644 android/hal-client/pollhandler.c
 create mode 100644 android/hal-client/pollhandler.h
 create mode 100644 android/hal-client/terminal.c
 create mode 100644 android/hal-client/terminal.h
 create mode 100644 android/hal-client/textconv.c
 create mode 100644 android/hal-client/textconv.h

-- 
1.7.9.5

