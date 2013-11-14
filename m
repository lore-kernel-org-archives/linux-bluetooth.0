Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 00/16] Socket HAL
Date: Thu, 14 Nov 2013 17:11:39 +0200
Message-Id: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is initial code implementing socket HAL. Receiving files
through OPP currently works.

Changes:
	* v1: Rebased and use static src address, hal_fd removed from structure and closed after sent to framework,
	added connect calls and SDP parsing, added cleanup_rfcomm function, minor fixes.
	* RFC Initial

For tracking rfcomm sockets I use structure rfslot which has following
fields:
 - real_sock - real RFCOMM socket
 - fd - fd to communicate with Android framework
 - hal_fd - fd passed to Android framework with CMSG

Andrei Emeltchenko (16):
  android/hal-sock: Add debug flag printing
  android/hal-sock: Use static local adapter address
  android/hal-sock: Add connect signal to socket
  android/hal-sock: Define structures for socket HAL
  android/hal-sock: Initial listen handle
  android/hal-sock: Implement socket accepted event
  android/hal-sock: Implement Android RFCOMM stack events
  android/hal-sock: Implement RFCOMM events
  android/hal-sock: Implement accept signal over Android fd
  android/hal-sock: Write channel to Android fd
  android/hal-sock: Implement socket connect HAL method
  android/hal-sock: Parse SDP response and connect
  android/hal-sock: Implement HAL connect call
  android/hal-sock: Send RFCOMM channel to framework
  android/hal-sock: Send connect signal on connect
  android/hal-sock: Close file descriptor after sending

 android/hal-msg.h  |    2 +
 android/hal-sock.c |    8 +-
 android/socket.c   |  496 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 android/socket.h   |    7 +
 4 files changed, 505 insertions(+), 8 deletions(-)

-- 
1.7.10.4

