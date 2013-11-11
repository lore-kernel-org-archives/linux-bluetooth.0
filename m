Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 0/9] Socket HAL
Date: Mon, 11 Nov 2013 14:37:09 +0200
Message-Id: <1384173438-21708-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is initial code implementing socket HAL. Receiving files
through OPP currently working somehow.

For tracking rfcomm sockets I use structure rfslot which has following
fields:
 - real_sock - real RFCOMM socket
 - fd - fd to communicate with Android framework
 - hal_fd - fd passed to Android framework with CMSG

Andrei Emeltchenko (9):
  android/hal-sock: Add debug flag printing
  android: Avoid unneeded includes
  android/ahl-sock: Add connect signal to socket
  android/hal-sock: Initial listen handle
  android/hal-sock: Implement socket accepted event
  android/hal-sock: Implement Android RFCOMM stack events
  android/hal-sock: Implement RFCOMM events
  android/hal-sock: Implement accept signal over Android fd
  android/hal-sock: Write channel to Android fd

 android/adapter.h  |    2 +
 android/hal-msg.h  |    2 +
 android/hal-sock.c |    8 +-
 android/hidhost.c  |    1 -
 android/socket.c   |  264 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 android/socket.h   |    7 ++
 6 files changed, 277 insertions(+), 7 deletions(-)

-- 
1.7.10.4

