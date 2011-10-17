Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 0/4] last chunks of EWS patch
Date: Mon, 17 Oct 2011 12:19:55 +0300
Message-Id: <1318843199-18232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	v4->v5: change __get_ctrl_size => __ctrl_size

Andrei Emeltchenko (4):
  Bluetooth: EWS: handling different Control fields
  Bluetooth: EWS: support extended seq numbers
  Bluetooth: EWS: remove magic numbers in l2cap
  Bluetooth: EWS: fix max_pdu calculation

 include/net/bluetooth/bluetooth.h |    2 +-
 include/net/bluetooth/l2cap.h     |   45 +++++++
 net/bluetooth/l2cap_core.c        |  246 ++++++++++++++++++++-----------------
 3 files changed, 181 insertions(+), 112 deletions(-)

-- 
1.7.4.1

