Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 00/14] IPC sanity checks
Date: Wed, 6 Nov 2013 15:09:16 +0100
Message-ID: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Following patches are implementing verification of correctness of messages
received over android IPC. The idea for keeping those checks in single
place is that messages passed are quite similar in structure and can
be group into 4 categories. This will also limit possible exit points both
in daemon and HAL as IPC error should trigger disconnection and shutdown.

Another benefit would be that every new command/event implemented will first
needs to have check implemented limiting possible problems with missing
message verification.

Checks are ensuring that message format is correct and don't verify content
of message (which is for command/event handler). Only service id and opcode
sanity is check in common place.

Some addition ideas for future:
 - if exit due to IPC would return specific code, there could be 'unit' or
   stress tests that would verify IPC behaviour with valid and invalid data
 - we could have sort of assert when sending data over ipc to quickly detect
   problems in new code
 - provide hexdump function for dumping offending ipc message for easier
   debugging

Comments are welcome.

Szymon Janc (14):
  android: Add HAL IPC commands sanity check
  android: Use IPC command sanity checks
  android: Add HAL IPC message response sanity checks
  android/hal: Use IPC command responses sanity checks
  android: Add HAL IPC events sanity check
  android/hal: Use IPC notifications sanity checks
  android: Remove not needed HAL_MINIMUM_EVENT define
  android: Remove not needed buf len from Core service functions
  android: Remove not needed buf len from Bluetooth service functions
  android: Remove not needed buf len from Hidhost service functions
  android: Remove not needed buf len from Socket service functions
  android/hal: Remove not neede buf len from bluetooth HAL
  android/hal: Remove not neede buf len from hidhost HAL
  android/hal: Remove not neede buf len from av HAL

 android/Android.mk      |   2 +
 android/Makefile.am     |   6 +-
 android/adapter.c       |  35 +++---
 android/adapter.h       |   3 +-
 android/hal-av.c        |   2 +-
 android/hal-bluetooth.c |  35 ++----
 android/hal-hidhost.c   |   2 +-
 android/hal-ipc.c       |  32 ++---
 android/hal-msg-check.c | 327 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h       |   9 +-
 android/hal.h           |   6 +-
 android/hid.c           |  62 +++------
 android/hid.h           |   2 +-
 android/ipc.c           |   1 +
 android/main.c          |  30 ++---
 android/socket.c        |   3 +-
 android/socket.h        |   3 +-
 17 files changed, 416 insertions(+), 144 deletions(-)
 create mode 100644 android/hal-msg-check.c

-- 
1.8.4.2

