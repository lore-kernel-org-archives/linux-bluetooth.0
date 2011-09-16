Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/5] EWS: extended window size and extended control field support
Date: Fri, 16 Sep 2011 16:39:34 +0300
Message-Id: <1316180379-31607-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds support for extended window size option (EWS) and extended control
field. Code partly based on Atheros patches sent a year ago by Haijun Liu
http://marc.info/?a=128277503500005&r=1&w=2
and Qualcomm code git://codeaurora.org/kernel/msm.git.

To decode EWS option and extended control field please apply patch to hcidump
which I sent to linux-bluetooth.

Changes:
	* RFCv1: rebase and using l2cap_chan flag for ext control
	* PATCHv1: small fix for tx_seq u8->u16
	* PATCHv2: use enable_hs instead of disable_extwindow,
		code style fixes, fix pdu calculation and remove magic
		numbers.

Andrei Emeltchenko (5):
  Bluetooth: EWS: extended window size option support
  Bluetooth: EWS: l2cap extended control field support
  Bluetooth: EWS: support extended seq numbers
  Bluetooth: EWS: remove magic numbers in l2cap
  Bluetooth: EWS: fix max_pdu calculation

 include/net/bluetooth/bluetooth.h |    2 +-
 include/net/bluetooth/l2cap.h     |  295 ++++++++++++++++++++----
 net/bluetooth/l2cap_core.c        |  461 ++++++++++++++++++++++---------------
 net/bluetooth/l2cap_sock.c        |   10 +-
 4 files changed, 532 insertions(+), 236 deletions(-)

-- 
1.7.4.1

