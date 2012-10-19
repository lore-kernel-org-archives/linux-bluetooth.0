Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org,
	andrei.emeltchenko.news@gmail.com
Subject: [PATCHv4 00/18] L2CAP signaling for AMP channel create/move
Date: Fri, 19 Oct 2012 14:33:51 -0700
Message-Id: <1350682449-24818-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Here are the changes that process commands on the L2CAP signaling
channel for setting up AMP channels.  There's still a lot of
integration to do as other AMP functionality is implemented.  I've
marked places that require this integration with "Placeholder"
comments (look for that string).

Changes:
  * PATCHv4 - More acks, several code organization fixups to patch 10.
              send_move_chan_* helper functions are now more helpful.
  * PATCHv3 - Dropped patch 17, fixed style issues in 5, 7, and 9.
              Split up a large function in patch 10.
  * PATCHv2 - Fixed formatting and style issues, added acks
  * PATCHv1 - Rebased after AMP physical link patch set, incorporated
              mailing list feedback.
  * RFCv1 - Finished commit messages, fixed formatting/style issues
  * RFCv0 - Initial post

Mat Martineau (18):
  Bluetooth: Add new l2cap_chan struct members for high speed channels
  Bluetooth: Add L2CAP create channel request handling
  Bluetooth: Remove unnecessary intermediate function
  Bluetooth: Lookup channel structure based on DCID
  Bluetooth: Channel move request handling
  Bluetooth: Add new ERTM receive states for channel move
  Bluetooth: Add move channel confirm handling
  Bluetooth: Add state to hci_chan
  Bluetooth: Move channel response
  Bluetooth: Add logical link confirm
  Bluetooth: Add move confirm response handling
  Bluetooth: Handle physical link completion
  Bluetooth: Flag ACL frames as complete for AMP controllers
  Bluetooth: Do not send data during channel move
  Bluetooth: Configure appropriate timeouts for AMP controllers
  Bluetooth: Ignore BR/EDR packet size constraints when fragmenting for
    AMP
  Bluetooth: Do not retransmit data during a channel move
  Bluetooth: Start channel move when socket option is changed

 include/net/bluetooth/hci_core.h |   1 +
 include/net/bluetooth/l2cap.h    |  32 ++
 net/bluetooth/hci_conn.c         |   1 +
 net/bluetooth/l2cap_core.c       | 960 ++++++++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c       |   5 +
 5 files changed, 943 insertions(+), 56 deletions(-)

-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
