Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 0/2] Bug fixes for RFCOMM and L2CAP
Date: Tue,  6 Dec 2011 16:23:25 -0800
Message-Id: <1323217407-2490-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here are two bug fixes for 
git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth.git

The first is a pretty obvious fix where an RFCOMM disconnect timer
needs to be cancelled when the disconnect happens earlier.  It's not
clear why the reference counting logic breaks down if this timer is
not cancelled, but it's definitely more correct to cancel the timer.

The L2CAP fix came up due to a buggy PTS test, which was not sending
the L2CAP RFC option in an ERTM config response.  This was causing
access to uninitialized data.

Mat Martineau (2):
  Bluetooth: Clear RFCOMM session timer when disconnecting last channel
  Bluetooth: Prevent uninitialized data access in L2CAP configuration

 net/bluetooth/l2cap_core.c  |   16 +++++++++++++++-
 net/bluetooth/rfcomm/core.c |    1 +
 2 files changed, 16 insertions(+), 1 deletions(-)

-- 
1.7.8

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
