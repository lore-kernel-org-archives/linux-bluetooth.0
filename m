Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/4] Socket optimization
Date: Tue,  3 Dec 2013 17:51:09 +0200
Message-Id: <1386085873-21715-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

These patches add socket optimization wrt to buffer size.

Andrei Emeltchenko (4):
  android/socket: Cleanup sockets on unregister
  android/socket Use 64K buffer for socket handling
  android/socket: Use heap instead of stack
  android/socket: Setup socket buffer sizes

 android/socket.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

-- 
1.8.3.2

