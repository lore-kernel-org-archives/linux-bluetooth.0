Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv9 00/21] Socket HAL
Date: Mon, 25 Nov 2013 15:08:36 +0200
Message-Id: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is initial code implementing socket HAL. OPP currently works with send/receive files. Probaly
other profiles works as well, not tested yet.

Changes:
	* v9: Merged this serie and RFC, two patches merged.
	* v8: Fixes Szymon's comment: added missing L2CAP Protocol ID in SDP Protocol Descriptor
	List, fixes getting channel number.
	* v7: Rebase and fixing missing unref. All needed SDP records for supported profiles are created.
	Support listen() with specified channel like in bluedroid.
	* v6: Use watch_id to remove source and general cleanup
	* v5: Changed uuid_to_chan table to profile table keeping information about profile like: channel, create_record,
	svc_hint and sec_level.
	* v4: Changed name rfslot -> rfsock following Johan's comment and other cosmetic changes, fixed one bug in SDP
	record, use NULL instead of 0 for sdp functions.
	* v3: Fixed coding style with write/send between file descriptors.
	* v2: Following Marcel comments changed way copying between file descriptors works, added SDP record
	for OPP and now it is possible to send files through GUI. Merged one patch with structures with actual user.
	* v1: Rebased and use static src address, hal_fd removed from structure and closed after sent to framework,
	added connect calls and SDP parsing, added cleanup_rfcomm function, minor fixes.
	* RFC Initial

TODO:
	* Use sec_level / check what to do with Android supplied security flags.
	* Use splice() (requires bionic change first)

For tracking rfcomm sockets I use structure rfslot which has following
fields:
 - real_sock - real RFCOMM socket
 - fd - fd to communicate with Android framework

create_rfslot sets hal_fd which is fd passed to Android framework with CMSG

Andrei Emeltchenko (21):
  android/socket: Parse SDP response and connect
  android/socket: Implement HAL connect call
  android/socket: Send RFCOMM channel to framework
  android/socket: Send connect signal to Android framework
  android/socket: Close file descriptor after sending
  android/socket: Add general service create/remove function
  android/socket: Add OPP SDP record
  android/socket: Add MAS uuid to profile table
  android/socket: Add SPP uuid to profile table
  android/socket: Add PBAP SDP record
  android/socket: Add SPP SDP record
  android/socket: Support listen() with supplied chan number
  android/hal-sock: Print bdaddr on connect
  android/socket: Refactor socket send_fd function
  android/hal-utils: Fix possible NULL pointer dereference
  android/socket: Use default sec_level for listen
  android/socket: Add error printing possible close() failure
  android/socket: Use security level for connect
  android/socket: Keep server iochannel reference
  android/socket: Handle Android events for server socket
  android/socket: Check create_rfsock returns valid structure

 android/hal-sock.c  |   4 +-
 android/hal-utils.c |   6 +
 android/socket.c    | 527 +++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 514 insertions(+), 23 deletions(-)

-- 
1.8.3.2

