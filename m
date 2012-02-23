Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	marcel@holtmann.org, luiz.dentz@gmail.com, ulisses@profusion.mobi,
	andrei.emeltchenko.news@gmail.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [RFC 0/2] New L2CAP ERTM state machine
Date: Thu, 23 Feb 2012 12:37:47 -0800
Message-Id: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here's an update for the ERTM state machine patch. I've made the
changes that were suggested earlier this month, and separated the
header changes and l2cap_core changes.

The first patch is a reasonable size for mailing list discussion, but
the second is too large.  In place of the second patch I'm providing a
link to the change.  Let me know if I should just try to send the
large patch anyway.

You can pull these changes from:
git://codeaurora.org/quic/bluetooth/bluetooth-next.git

Tag name: mathewm-2012-02-23-ertm


Mat Martineau (2):
  Bluetooth: Header changes for ERTM state machine replacement
  Bluetooth: L2CAP ERTM state machine replacement

 include/net/bluetooth/bluetooth.h |   14 +-
 include/net/bluetooth/l2cap.h     |  260 +---
 net/bluetooth/l2cap_core.c        | 2771 +++++++++++++++++++++++++------------
 3 files changed, 1954 insertions(+), 1091 deletions(-)

-- 
1.7.9

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
