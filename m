Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 00/16] Socket HAL
Date: Mon, 18 Nov 2013 10:26:03 +0200
Message-Id: <1384763179-2218-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is initial code implementing socket HAL. OPP currently works with send/receive files. Probaly
other profiles works as well, not tested yet.

Changes:
	* v3: Fixed coding style with write/send between file descriptors.
	* v2: Following Marcel comments changed way copying between file descriptors works, added SDP record
	for OPP and now it is possible to send files through GUI. Merged one patch with structures with actual user.
	* v1: Rebased and use static src address, hal_fd removed from structure and closed after sent to framework,
	added connect calls and SDP parsing, added cleanup_rfcomm function, minor fixes.
	* RFC Initial

TODO:
	* Add SDP record for PBAP and other profiles
	* Use splice() (requires bionic change first)

For tracking rfcomm sockets I use structure rfslot which has following
fields:
 - real_sock - real RFCOMM socket
 - fd - fd to communicate with Android framework

create_rfslot sets hal_fd which is fd passed to Android framework with CMSG

Andrei Emeltchenko (16):
  android/hal-sock: Add debug flag printing
  android/socket: Use static local adapter address
  android/socket: Add connect signal to socket
  android/socket: Define structs and implement listen
  android/socket: Implement socket accepted event
  android/socket: Implement Android RFCOMM stack events
  android/socket: Implement RFCOMM events
  android/socket: Implement accept signal over Android fd
  android/socket: Write channel to Android fd
  android/socket: Implement socket connect HAL method
  android/socket: Parse SDP response and connect
  android/socket: Implement HAL connect call
  android/socket: Send RFCOMM channel to framework
  android/socket: Send connect signal on connect
  android/socket: Close file descriptor after sending
  android/socket: Add SDP record for OPP profile

 android/hal-msg.h  |    2 +
 android/hal-sock.c |    8 +-
 android/socket.c   |  605 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 android/socket.h   |    7 +
 4 files changed, 614 insertions(+), 8 deletions(-)

-- 
1.7.10.4

