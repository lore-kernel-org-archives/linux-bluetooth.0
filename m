Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 0/5] EWS: extended window size and extended control field support
Date: Thu,  1 Sep 2011 17:45:05 +0300
Message-Id: <1314888310-5337-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Draft patches applied to my previous EFS patches. Please comment.

Adds support for extended window size option (EWS) and extended control
field. Code partly based on Atheros patches sent a year ago and Qualcomm
code git://codeaurora.org/kernel/msm.git.

To decode EWS option and extended control field please apply patch to hcidump
which I sent to linux-bluetooth.

Changes:
	*v1: rebase and using l2cap_chan flag for ext control

Andrei Emeltchenko (5):
  Bluetooth: EWS: extended window size option support
  Bluetooth: l2cap extended control field support
  Bluetooth: EWS: support extended seq numbers
  Bluetooth: remove magic numbers in l2cap
  Bluetooth: prevent unneeded fragmentation in l2cap

 include/net/bluetooth/l2cap.h |  304 +++++++++++++++++++++++----
 net/bluetooth/l2cap_core.c    |  474 +++++++++++++++++++++++++----------------
 net/bluetooth/l2cap_sock.c    |   11 +-
 3 files changed, 554 insertions(+), 235 deletions(-)

-- 
1.7.4.1

