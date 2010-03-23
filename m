Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 00/19] Patches for eL2CAP
Date: Tue, 23 Mar 2010 16:48:27 -0300
Message-Id: <1269373726-13209-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

In the following e-mails there is a patch set for the Enhanced Retransmission Mode. Part of them are new features implementation and the other part is bug fixes.

Gustavo F. Padovan (19):
      Bluetooth: Implement 'Send IorRRorRNR' event
      Bluetooth: Support case with F bit set under WAIT_F state.
      Bluetooth: Fix memory leak of S-frames into L2CAP
      Bluetooth: Check the minimum {I,S}-frame size into L2CAP
      Bluetooth: Check if SDU size is greater than MTU on L2CAP
      Bluetooth: Fix expected_tx_seq calculation on L2CAP
      Bluetooth: Implement SendAck() Action on ERTM.
      Bluetooth: Move set of P-bit to l2cap_send_sframe()
      Bluetooth: Add Recv RR (P=0)(F=0) for SREJ_SENT state on ERTM
      Bluetooth: Use a l2cap_pinfo struct instead l2cap_pi() macro
      Bluetooth: Fix ACL MTU issue
      Bluetooth: Split l2cap_data_channel_sframe()
      Bluetooth: Handle all cases of receipt of RNR-frames into L2CAP
      Bluetooth: Group the ack of I-frames into l2cap_data_channel_rrframe()
      Bluetooth: Remove duplicate use of __get_reqseq() macro on L2CAP
      Bluetooth: Finish implementation for Rec RR (P=1) on ERTM
      Bluetooth: Ignore I-frames with a duplicated txSeq
      Bluetooth: Add timer to Acknowledge I-frames
      Bluetooth: Move specific Basic Mode code to the right place


 include/net/bluetooth/l2cap.h |   24 ++-
 net/bluetooth/l2cap.c         |  382 +++++++++++++++++++++++++++++------------
 2 files changed, 286 insertions(+), 120 deletions(-)
