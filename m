Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 00/16] EWS: extended window size and extended control field support
Date: Tue, 11 Oct 2011 13:37:40 +0300
Message-Id: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
	* PATCHv3: major rebase and split to smaller logical chunks, taking
		comments from upstream.

Andrei Emeltchenko (16):
  Bluetooth: clean up spaces in L2CAP header
  Bluetooth: EWS: extended window size option support
  Bluetooth: EWS: adds ext control field bit mask
  Bluetooth: EWS: rewrite handling Supervisory (S) bits
  Bluetooth: EWS: rewrite handling SAR bits
  Bluetooth: EWS: rewrite reqseq calculation
  Bluetooth: EWS: rewrite L2CAP ERTM txseq calculation
  Bluetooth: EWS: rewrite check frame type function
  Bluetooth: EWS: rewrite handling FINAL (F) bit
  Bluetooth: EWS: rewrite handling POLL (P) bit
  Bluetooth: EWS: handling different Control fields
  Bluetooth: EWS: recalculate L2CAP header size
  Bluetooth: EWS: support extended seq numbers
  Bluetooth: EWS: define L2CAP header sizes
  Bluetooth: EWS: remove magic numbers in l2cap
  Bluetooth: EWS: fix max_pdu calculation

 include/net/bluetooth/bluetooth.h |    2 +-
 include/net/bluetooth/l2cap.h     |  301 ++++++++++++++++++++----
 net/bluetooth/l2cap_core.c        |  478 ++++++++++++++++++++++---------------
 net/bluetooth/l2cap_sock.c        |    8 +-
 4 files changed, 543 insertions(+), 246 deletions(-)

-- 
1.7.4.1

