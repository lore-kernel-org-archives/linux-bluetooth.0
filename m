Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org,
	ulisses@profusion.mobi
Cc: pkrystad@codeaurora.org
Subject: [PATCH 00/25] ERTM state machine changes, part 3
Date: Thu, 17 May 2012 20:53:30 -0700
Message-Id: <1337313235-26535-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This completes the switch to the new ERTM state machine.  The patch set 
needs to be merged all at once, since ERTM will only work with all of 
the changes applied.

There was no way to replace the state machine incrementally, since this 
is switching ERTM to a whole different design everything needs to be 
swapped out at once.  I checked with Marcel on this approach in advance.

We're running PTS on this code this week, I will let the list know about 
the test results.

Mat Martineau (25):
  Bluetooth: Change default state of ERTM disable flag
  Bluetooth: Add a new L2CAP ERTM transmit state machine.
  Bluetooth: Refactor l2cap_streaming_send
  Bluetooth: Refactor l2cap_ertm_send
  Bluetooth: Refactor l2cap_send_sframe
  Bluetooth: Consolidate common receive code for ERTM and streaming
    mode
  Bluetooth: Add streaming mode receive and incoming packet classifier
  Bluetooth: Remove receive code that has been superceded
  Bluetooth: Refactor l2cap_send_ack
  Bluetooth: Use the transmit state machine for busy state changes
  Bluetooth: Update l2cap_send_i_or_rr_or_rnr to fit the spec better
  Bluetooth: Add the ERTM receive state machine
  Bluetooth: Add implementation for retransmitting all unacked frames
  Bluetooth: Send SREJ frames when packets go missing
  Bluetooth: Reassemble all available data when retransmissions
    succeed.
  Bluetooth: Handle SREJ requests to resend unacked frames
  Bluetooth: Handle incoming REJ frames
  Bluetooth: Use new header structures in l2cap_send_rr_or_rnr
  Bluetooth: Check rules when setting retransmit or monitor timers
  Bluetooth: Use the ERTM transmit state machine from timeout handlers
  Bluetooth: Simplify the ERTM ack timeout
  Bluetooth: Remove unneccesary inline
  Bluetooth: Set txwin values for streaming mode
  Bluetooth: Remove unused ERTM control field macros
  Bluetooth: Enable ERTM by default

 include/net/bluetooth/l2cap.h |  180 ----
 net/bluetooth/l2cap_core.c    | 1977 ++++++++++++++++++++++++++---------------
 2 files changed, 1262 insertions(+), 895 deletions(-)

-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
