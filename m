Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org
Subject: Pull request: Fixes for the Enhanced Retransmission Mode
Date: Sat,  5 Jun 2010 04:50:04 -0300
Message-Id: <1275724218-29453-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:

  Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-testing.git for-upstream

Gustavo F. Padovan (13):
      Bluetooth: Remove max_tx and tx_window modules paramenter from L2CAP
      Bluetooth: Remove L2CAP Extended Features from Kconfig
      Bluetooth: Fix drop of packets with invalid req_seq/tx_seq
      Bluetooth: Check skb_clone return to avoid NULL dereference
      Bluetooth: Fix ERTM vars increment
      Bluetooth: Check packet FCS earlier
      Bluetooth: Only check SAR bits if frame is I-frame
      Bluetooth: Stop ack_timer if ERTM enters in Local Busy or SREJ_SENT
      Bluetooth: Fix ERTM channel shutdown
      Bluetooth: Fix crash when sending frames after connection is closed
      Bluetooth: Fix handle of received P-bit
      Bluetooth: Fix l2cap_ertm_send() behavior
      Bluetooth: Fix missing retransmission action with RR(P=1)

João Paulo Rechi Vita (1):
      Bluetooth: Fix SREJ_QUEUE corruption

 net/bluetooth/Kconfig |   13 ----
 net/bluetooth/l2cap.c |  156 +++++++++++++++++++++++++++++++------------------
 2 files changed, 99 insertions(+), 70 deletions(-)
