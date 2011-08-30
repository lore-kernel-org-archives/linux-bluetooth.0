Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 0/5] extended window size and extended control field support
Date: Tue, 30 Aug 2011 10:18:36 +0300
Message-Id: <1314688721-16742-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

First draft patches applied to my previous EFS patches. Please comment.

Adds support for extended window size option (EWS) and extended control
field. Code partly based on Atheros patches sent a year ago and Qualcomm
code git://codeaurora.org/kernel/msm.git.

To decode EWS option and extended control field please apply patch to hcidump
which I sent to linux-bluetooth.

Andrei Emeltchenko (5):
  Bluetooth: extended window size option support
  Bluetooth: l2cap extended control field support
  Bluetooth: EWS: support extended seq numbers
  Bluetooth: remove magic numbers in l2cap
  Bluetooth: prevent unneeded fragmentation in l2cap

 include/net/bluetooth/l2cap.h |  304 ++++++++++++++++++++++----
 net/bluetooth/l2cap_core.c    |  481 +++++++++++++++++++++++++----------------
 net/bluetooth/l2cap_sock.c    |   11 +-
 3 files changed, 562 insertions(+), 234 deletions(-)

-- 
1.7.4.1

