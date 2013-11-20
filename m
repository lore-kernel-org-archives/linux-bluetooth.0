Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 00/19] Socket HAL
Date: Wed, 20 Nov 2013 12:24:18 +0200
Message-Id: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is initial code implementing socket HAL. OPP currently works with send/receive files. Probaly
other profiles works as well, not tested yet.

Changes:
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

Andrei Emeltchenko (19):
  android/socket: Add get RFCOMM default channel
  android/socket: Handling rfcomm sockets
  android/socket: Implement listen on RFCOMM socket
  android/socket: Implement socket accepted event
  android/socket: Implement Android RFCOMM stack events
  android/socket: Implement RFCOMM events
  android/socket: Send accept signal to Android framework
  android/socket: Notify channel to Android framework
  android/socket: Implement socket connect HAL method
  android/socket: Parse SDP response and connect
  android/socket: Implement HAL connect call
  android/socket: Send RFCOMM channel to framework
  android/socket: Send connect signal to Android framework
  android/socket: Close file descriptor after sending
  android/socket: Add SDP record for OPP profile
  android/socket: Add MAS uuid to profile table
  android/socket: Add SPP uuid to profile table
  android/socket: Add PBAP SDP record
  android/socket: Add SPP SDP record

 android/socket.c |  797 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 793 insertions(+), 4 deletions(-)

-- 
1.7.10.4

