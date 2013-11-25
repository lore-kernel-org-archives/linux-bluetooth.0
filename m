Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 0/7] Socket HAL part2
Date: Mon, 25 Nov 2013 13:22:50 +0200
Message-Id: <1385378577-20503-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

These are fixes and some missing functionality for Socket HAL.

Andrei Emeltchenko (7):
  android/socket: Check that create_record function exist
  android/socket: Use default sec_level for listen
  android/socket: Add error printing possible close() failure
  android/socket: Use security level for connect
  android/socket: Keep server iochannel reference
  android/socket: Handle Android events for server socket
  android/socket: Check create_rfsock returns valid structure

 android/socket.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 16 deletions(-)

-- 
1.8.3.2

